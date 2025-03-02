require('dotenv').config();
const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const client = new Client({
    connectionString: process.env.DATABASE_URL,
});

async function truncateAllTables() {
    try {
        // Get a list of all tables in the database
        const res = await client.query(`
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = 'public'
              AND table_type = 'BASE TABLE';
        `);

        const tables = res.rows.map(row => row.table_name);

        // Truncate each table
        for (const table of tables) {
            await client.query(`TRUNCATE TABLE ${table} RESTART IDENTITY CASCADE;`);
            console.log(`Truncated table: ${table}`);
        }

        console.log('All tables truncated.');
    } catch (error) {
        console.error('Error truncating tables:', error);
        throw error;
    }
}

async function runSeeders() {
    try {
        await client.connect();
        console.log('Connected to database');

        // Step 1: Truncate all tables
        await truncateAllTables();

        // Step 2: Run seeders
        const seedersDir = path.join(__dirname, 'seeders');
        const files = fs.readdirSync(seedersDir).filter(file => file.endsWith('.js'));

        let failedSeeders = [];

        // First attempt: Run all seeders and collect failed ones
        for (const file of files) {
            try {
                console.log(`Running ${file}...`);
                const seeder = require(path.join(seedersDir, file));
                await seeder.seed(client);
                console.log(`${file} completed.`);
            } catch (error) {
                console.error(`Error in ${file}, deferring to retry later.`);
                failedSeeders.push(file);
            }
        }

        // Second attempt: Retry failed seeders
        if (failedSeeders.length > 0) {
            console.log(`Retrying ${failedSeeders.length} failed seeders...`);

            for (const file of failedSeeders) {
                try {
                    console.log(`Retrying ${file}...`);
                    const seeder = require(path.join(seedersDir, file));
                    await seeder.seed(client);
                    console.log(`${file} completed on retry.`);
                } catch (error) {
                    console.error(`Final failure in ${file}:`, error);
                }
            }
        }

        console.log('Seeding process completed.');
    } catch (error) {
        console.error('Error running seeders:', error);
    } finally {
        await client.end();
    }
}

runSeeders();