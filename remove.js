require('dotenv').config();
const { Client } = require('pg');
const readline = require('readline');

const client = new Client({
    connectionString: process.env.DATABASE_URL,
});

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const tables = [
    'receipt_invoices',
    'receipts',
    'delivery_products',
    'delivery_orders',
    'delivery_statuses',
    'sales',
    'invoices',
    'invoice_statuses',
    'clients',
    'purchases',
    'products',
    'schema_migrations',
    'users',
    'suppliers'
];

async function dropTables() {
    try {
        await client.connect();
        console.log('Connected to database');

        for (const table of tables) {
            console.log(`Dropping table: ${table}...`);
            await client.query(`DROP TABLE IF EXISTS ${table} CASCADE;`);
            console.log(`Table ${table} dropped.`);
        }
        
        console.log('All tables dropped successfully.');
    } catch (error) {
        console.error('Error dropping tables:', error);
    } finally {
        await client.end();
        rl.close();
    }
}

rl.question('Are you sure you want to drop all tables? This action is irreversible! (y/n): ', (answer) => {
    if (answer.toLowerCase() === 'y') {
        dropTables();
    } else {
        console.log('Operation canceled.');
        rl.close();
    }
});
