const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding suppliers...');

    for (let i = 0; i < 10; i++) {
        const name = faker.person.fullName();
        const company = faker.company.name();
        const address = faker.location.streetAddress();  // Use streetAddress() instead of location.address()
        const telephone = faker.phone.number();  // Correct method for phone number

        await client.query(
            `INSERT INTO suppliers (name, company, address, telephone) VALUES ($1, $2, $3, $4)`,
            [name, company, address, telephone]
        );
    }

    console.log('Suppliers seeding complete!');
}

module.exports = { seed };
