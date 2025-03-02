const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding receipts...');

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
            const number = faker.number.int({ min: 1000, max: 9999 });
            const photo = faker.image.url();

            // Generate a random date within the current month
            const createdAt = faker.date.between({ from: monthStart, to: monthEnd });

            const clientId = faker.number.int({ min: 1, max: 10 });
            const status = faker.number.int({ min: 1, max: 3 });

            await client.query(
                `INSERT INTO receipts (number, photo, created_at, client_id, status) 
                 VALUES ($1, $2, $3, $4, $5)`,
                [number, photo, createdAt, clientId, status]
            );
        }
    }

    console.log('Receipts seeding complete!');
}

module.exports = { seed };