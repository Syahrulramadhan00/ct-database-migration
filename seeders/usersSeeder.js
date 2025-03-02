const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding users...');

    for (let i = 0; i < 10; i++) {
        const name = faker.person.fullName();
        const email = faker.internet.email();
        const password = faker.internet.password();
        const is_verified = faker.datatype.boolean();
        const otp_code = faker.string.numeric(5); // Generates a 5-digit OTP
        const created_at = new Date();
        const updated_at = new Date();

        await client.query(
            `INSERT INTO users (name, email, password, is_verified, otp_code, created_at, updated_at)
             VALUES ($1, $2, $3, $4, $5, $6, $7)`,
            [name, email, password, is_verified, otp_code, created_at, updated_at]
        );
    }

    console.log('User seeding complete!');
}

module.exports = { seed };
