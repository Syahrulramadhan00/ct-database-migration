const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding sales...');

    // Define the date range (January 1, 2025, to July 31, 2025)
    const startDate = new Date(2025, 0, 1); // January is month 0 in JavaScript
    const endDate = new Date(2025, 6, 31); // July is month 6 in JavaScript

    // Number of records to generate
    const totalRecords = 35; // 5 records per month * 7 months

    // Number of months
    const numMonths = 7;

    for (let month = 0; month < numMonths; month++) {
        const monthStart = new Date(2025, month, 1); // Start of the month
        const monthEnd = new Date(2025, month + 1, 0); // End of the month

        // Generate 5 records for this month
        for (let i = 0; i < 5; i++) {
            const invoiceId = faker.number.int({ min: 1, max: 10 });
            const productId = faker.number.int({ min: 1, max: 10 });
            const quantity = faker.number.int({ min: 1, max: 100 });
            const price = faker.number.int({ min: 10, max: 1000 }) * 100;
            const notSentCount = faker.number.int({ min: 0, max: 10 });
            const sendStatus = faker.datatype.boolean();

            // Generate a random date within the current month
            const createdAt = faker.date.between({ from: monthStart, to: monthEnd });

            await client.query(
                `INSERT INTO sales (invoice_id, product_id, quantity, price, not_sent_count, send_status, created_at) 
                 VALUES ($1, $2, $3, $4, $5, $6, $7)`,
                [invoiceId, productId, quantity, price, notSentCount, sendStatus, createdAt]
            );
        }
    }

    console.log('Sales seeding complete!');
}

module.exports = { seed };