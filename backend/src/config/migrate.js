const fs = require('fs');
const path = require('path');
const pool = require('./db');

async function migrate() {
  const schemaPath = path.join(__dirname, '../../migrations/schema.sql');
  const schema = fs.readFileSync(schemaPath, 'utf8');

  try {
    await pool.query(schema);
    console.log('Migration completed successfully');
  } catch (err) {
    console.error('Migration failed:', err);
  } finally {
    pool.end();
  }
}

migrate();
