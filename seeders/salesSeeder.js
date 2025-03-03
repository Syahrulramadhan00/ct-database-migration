const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding sales...');

    // Fetch available product IDs
    const result = await client.query(`SELECT id FROM products`);
    const productIds = result.rows.map(row => row.id);

    if (productIds.length === 0) {
        throw new Error("No products found! Check productsSeeder.js.");
    }

    // Define the date range (January 1, 2025, to July 31, 2025)
    const numMonths = 7;

    for (let month = 0; month < numMonths; month++) {
        const monthStart = new Date(2025, month, 1);
        const monthEnd = new Date(2025, month + 1, 0);

        // Generate 5 records for this month
        for (let i = 0; i < 5; i++) {
            const invoiceId = faker.number.int({ min: 1, max: 10 });
            const productId = faker.helpers.arrayElement(productIds); // Pick a valid product_id
            const quantity = faker.number.int({ min: 1, max: 100 });
            const price = faker.number.int({ min: 10, max: 1000 }) * 100;
            const notSentCount = faker.number.int({ min: 0, max: 10 });
            const sendStatus = faker.datatype.boolean();
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
