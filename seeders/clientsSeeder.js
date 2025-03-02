const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding clients...');

    for (let i = 0; i < 10; i++) {
        const name = faker.company.name();
        const place = faker.location.city();
        const description = faker.lorem.sentence();
        const telephone = faker.phone.number(); 

        await client.query(
            `INSERT INTO clients (name, place, description, telephone) 
             VALUES ($1, $2, $3, $4)`,
            [name, place, description, telephone]
        );
    }

    console.log('Client seeding complete!');
}

module.exports = { seed };
