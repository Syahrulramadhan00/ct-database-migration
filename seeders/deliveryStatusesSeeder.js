async function seed(client) {
    console.log('Seeding delivery_statuses...');

    const statuses = ['initialized', 'processed', 'done'];

    for (const status of statuses) {
        await client.query(`INSERT INTO delivery_statuses (name) VALUES ($1)`, [status]);
    }

    console.log('Delivery statuses seeding complete!');
}

module.exports = { seed };
