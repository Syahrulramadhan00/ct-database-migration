const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding invoices...');

    // Define the date range (January 1, 2025, to July 31, 2025)
    const startDate = new Date(2025, 0, 1); // January is month 0 in JavaScript
    const endDate = new Date(2025, 6, 31); // July is month 6 in JavaScript

    // Number of records to generate
    const totalRecords = 50; // Adjust this to your desired total number of records

    // Minimum number of records per month
    const minRecordsPerMonth = 5;

    // Number of months
    const numMonths = 7;

    // Calculate the remaining records after ensuring the minimum per month
    const remainingRecords = totalRecords - (minRecordsPerMonth * numMonths);

    try {
        // Ensure invoice_statuses and clients tables have enough records
        const invoiceStatuses = await client.query('SELECT id FROM invoice_statuses;');
        const clients = await client.query('SELECT id FROM clients;');

        if (invoiceStatuses.rows.length < 8) {
            throw new Error('Not enough invoice statuses in the database. Ensure at least 8 records exist.');
        }
        if (clients.rows.length < 10) {
            throw new Error('Not enough clients in the database. Ensure at least 10 records exist.');
        }

        for (let month = 0; month < numMonths; month++) {
            const monthStart = new Date(2025, month, 1); // Start of the month
            const monthEnd = new Date(2025, month + 1, 0); // End of the month

            // Generate at least 5 records for this month
            for (let i = 0; i < minRecordsPerMonth; i++) {
                const invoiceStatusId = faker.helpers.arrayElement(invoiceStatuses.rows).id;
                const clientId = faker.helpers.arrayElement(clients.rows).id;
                const invoiceCode = faker.string.alphanumeric(10);
                const description = faker.lorem.sentence();
                const paymentMethod = faker.helpers.arrayElement(['Cash', 'Credit Card', 'Bank Transfer']);
                const poCode = faker.string.alphanumeric(8);
                const seller = faker.person.fullName();
                const platformNumber = faker.string.alphanumeric(5);
                const platform = faker.helpers.arrayElement(['Shopee', 'Tokopedia', 'Lazada']);
                const platformDescription = faker.lorem.sentence();
                const tax = faker.number.int({ min: 1, max: 200 }) * 100;
                const discount = faker.number.int({ min: 0, max: 80 });
                const paymentTerm = faker.number.int({ min: 7, max: 30 });
                const note = faker.lorem.sentence();
                const facturePath = faker.system.filePath();
                const isTaxable = faker.datatype.boolean();
                const poPath = faker.system.filePath();
                const createdAt = new Date();
                const updatedAt = new Date();
                const projectName = faker.commerce.productName();
                const totalPrice = faker.number.int({ min: 10000, max: 1000000 }) * 100;

                // Generate a random date within the current month
                const date = faker.date.between({ from: monthStart, to: monthEnd });

                await client.query(
                    `INSERT INTO invoices (
                        invoice_status_id, client_id, invoice_code, description, payment_method, po_code, 
                        seller, platform_number, platform, platform_description, tax, discount, payment_term, 
                        note, facture_path, is_taxable, po_path, created_at, updated_at, project_name, 
                        total_price, date
                    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)`,
                    [
                        invoiceStatusId, clientId, invoiceCode, description, paymentMethod, poCode,
                        seller, platformNumber, platform, platformDescription, tax, discount, paymentTerm,
                        note, facturePath, isTaxable, poPath, createdAt, updatedAt, projectName,
                        totalPrice, date
                    ]
                );
            }
        }

        // Distribute the remaining records randomly across the months
        for (let i = 0; i < remainingRecords; i++) {
            const randomMonth = faker.number.int({ min: 0, max: numMonths - 1 }); // Random month index (0 to 6)
            const monthStart = new Date(2025, randomMonth, 1); // Start of the random month
            const monthEnd = new Date(2025, randomMonth + 1, 0); // End of the random month

            const invoiceStatusId = faker.helpers.arrayElement(invoiceStatuses.rows).id;
            const clientId = faker.helpers.arrayElement(clients.rows).id;
            const invoiceCode = faker.number.int({ min: 1000000000, max: 9999999999 }).toString();
            const description = faker.lorem.sentence();
            const paymentMethod = faker.helpers.arrayElement(['Cash', 'Credit Card', 'Bank Transfer']);
            const poCode = faker.string.alphanumeric(8);
            const seller = faker.person.fullName();
            const platformNumber = faker.string.alphanumeric(5);
            const platform = faker.helpers.arrayElement(['Shopee', 'Tokopedia', 'Lazada']);
            const platformDescription = faker.lorem.sentence();
            const tax = faker.number.int({ min: 1, max: 200 }) * 100;
            const discount = faker.number.int({ min: 0, max: 500000 }) * 100;
            const paymentTerm = faker.number.int({ min: 7, max: 30 });
            const note = faker.lorem.sentence();
            const facturePath = faker.system.filePath();
            const isTaxable = faker.datatype.boolean();
            const poPath = faker.system.filePath();
            const createdAt = new Date();
            const updatedAt = new Date();
            const projectName = faker.commerce.productName();
            const totalPrice = faker.number.int({ min: 10000, max: 1000000 }) * 100;

            // Generate a random date within the random month
            const date = faker.date.between({ from: monthStart, to: monthEnd });

            await client.query(
                `INSERT INTO invoices (
                    invoice_status_id, client_id, invoice_code, description, payment_method, po_code, 
                    seller, platform_number, platform, platform_description, tax, discount, payment_term, 
                    note, facture_path, is_taxable, po_path, created_at, updated_at, project_name, 
                    total_price, date
                ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)`,
                [
                    invoiceStatusId, clientId, invoiceCode, description, paymentMethod, poCode,
                    seller, platformNumber, platform, platformDescription, tax, discount, paymentTerm,
                    note, facturePath, isTaxable, poPath, createdAt, updatedAt, projectName,
                    totalPrice, date
                ]
            );
        }

        console.log('Invoices seeding complete!');
    } catch (error) {
        console.error('Error seeding invoices:', error);
        throw error;
    }
}

module.exports = { seed };