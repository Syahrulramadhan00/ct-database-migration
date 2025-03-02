const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding receipt_invoices...');

    for (let i = 0; i < 10; i++) {
        const receiptId = faker.number.int({ min: 1, max: 10 });
        const invoiceId = faker.number.int({ min: 1, max: 10 });

        await client.query(
            `INSERT INTO receipt_invoices (receipt_id, invoice_id) 
             VALUES ($1, $2)`,
            [receiptId, invoiceId]
        );
    }

    console.log('Receipt invoices seeding complete!');
}

module.exports = { seed };
