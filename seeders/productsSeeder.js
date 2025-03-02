const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding products...');

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
            const name = faker.commerce.productName();
            const stock = faker.number.int({ min: 0, max: 500 }); // Generates a random stock between 0-500

            // Generate a random date within the current month
            const created_at = faker.date.between({ from: monthStart, to: monthEnd });
            const updated_at = new Date(); // Updated at remains the current timestamp
            const deleted_at = null; // Initially, products are not deleted

            await client.query(
                `INSERT INTO products (name, stock, created_at, updated_at, deleted_at)
                 VALUES ($1, $2, $3, $4, $5)`,
                [name, stock, created_at, updated_at, deleted_at]
            );
        }
    }

    console.log('Product seeding complete!');
}

module.exports = { seed };