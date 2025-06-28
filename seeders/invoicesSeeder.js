const { faker } = require('@faker-js/faker');

async function seed(client) {
    console.log('Seeding invoices...');

    const startDate = new Date(2025, 0, 1); // Jan 1, 2025
    const endDate = new Date(2025, 6, 31); // July 31, 2025
    const totalRecords = 50;
    const minRecordsPerMonth = 5;
    const numMonths = 7;
    const remainingRecords = totalRecords - (minRecordsPerMonth * numMonths);
    const projectCode = 'CTE276';
    const yearSuffix = '25';

    try {
        const invoiceStatuses = await client.query('SELECT id FROM invoice_statuses;');
        const clients = await client.query('SELECT id FROM clients;');

        if (invoiceStatuses.rows.length < 8) {
            throw new Error('Not enough invoice statuses in the database. Ensure at least 8 records exist.');
        }
        if (clients.rows.length < 10) {
            throw new Error('Not enough clients in the database. Ensure at least 10 records exist.');
        }

        const generateInvoiceCode = () => {
            const randomNumber = faker.number.int({ min: 100000, max: 999999 });
            const cityCode = faker.helpers.arrayElement(['SBY', 'JKT', 'BDG', 'MLG', 'BPN']);
            return `${randomNumber}/V/${projectCode}/${cityCode}/${yearSuffix}`;
        };

        const insertInvoice = async (date) => {
            const invoiceStatusId = faker.helpers.arrayElement(invoiceStatuses.rows).id;
            const clientId = faker.helpers.arrayElement(clients.rows).id;
            const invoiceCode = generateInvoiceCode();
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
        };

        // Seed minimum records per month
        for (let month = 0; month < numMonths; month++) {
            const monthStart = new Date(2025, month, 1);
            const monthEnd = new Date(2025, month + 1, 0);
            for (let i = 0; i < minRecordsPerMonth; i++) {
                const date = faker.date.between({ from: monthStart, to: monthEnd });
                await insertInvoice(date);
            }
        }

        // Seed remaining records randomly across months
        for (let i = 0; i < remainingRecords; i++) {
            const randomMonth = faker.number.int({ min: 0, max: numMonths - 1 });
            const monthStart = new Date(2025, randomMonth, 1);
            const monthEnd = new Date(2025, randomMonth + 1, 0);
            const date = faker.date.between({ from: monthStart, to: monthEnd });
            await insertInvoice(date);
        }

        console.log('Invoices seeding complete!');
    } catch (error) {
        console.error('Error seeding invoices:', error);
        throw error;
    }
}

module.exports = { seed };
