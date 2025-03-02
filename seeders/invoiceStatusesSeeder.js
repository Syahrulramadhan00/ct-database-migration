async function seed(client) {
    console.log('Seeding invoice_statuses...');

    const statuses = [
        'initialized', 'preorder_created', 'finalized', 'sended',
        'faktur_created', 'inserted_into_receipt', 'paid', 'done'
    ];

    for (const status of statuses) {
        await client.query(`INSERT INTO invoice_statuses (name) VALUES ($1)`, [status]);
    }

    console.log('Invoice statuses seeding complete!');
}

module.exports = { seed };
