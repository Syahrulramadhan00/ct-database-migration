require('dotenv').config();
const { Client } = require('pg');
const path = require('path');

const client = new Client({
    connectionString: process.env.DATABASE_URL,
});

// Define prioritized seeding order
const seeders = [
    'invoiceStatusesSeeder.js',
    'deliveryStatusesSeeder.js',
    'usersSeeder.js',
    'clientsSeeder.js',
    'productsSeeder.js',
    'invoicesSeeder.js',
    'salesSeeder.js',
    'purchasesSeeder.js',
    'receiptsSeeder.js',
    'receiptInvoicesSeeder.js',
];

async function runSeeders() {
    try {
        await client.connect();
        console.log('Connected to database');

        for (const file of seeders) {
            try {
                console.log(`Running ${file}...`);
                const seeder = require(path.join(__dirname, 'seeders', file));
                await seeder.seed(client);
                console.log(`${file} completed.`);
            } catch (error) {
                console.error(`Error in ${file}:`, error);
                throw error; // Stop execution on failure
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