const pool = require('../config/db');

class Pharmacy {
  static async create({ user_id, pharmacy_name, license_number, address, address_lat, address_lng, delivery_range_km }) {
    const result = await pool.query(
      `INSERT INTO pharmacies (user_id, pharmacy_name, license_number, address, address_lat, address_lng, delivery_range_km) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [user_id, pharmacy_name, license_number, address, address_lat, address_lng, delivery_range_km]
    );
    return result.rows[0];
  }

  static async findNearby(lat, lng, radius = 10) {
    const result = await pool.query(
      `SELECT p.*, u.phone, (6371 * acos(cos(radians($1)) * cos(radians(address_lat)) * cos(radians(address_lng) - radians($2)) + sin(radians($1)) * sin(radians(address_lat)))) AS distance FROM pharmacies p JOIN users u ON p.user_id = u.id HAVING distance < $3 ORDER BY distance LIMIT 20`,
      [lat, lng, radius]
    );
    return result.rows;
  }

  static async listOrders(pharmacy_id) {
    const result = await pool.query('SELECT * FROM orders WHERE pharmacy_id = $1 ORDER BY created_at DESC', [pharmacy_id]);
    return result.rows;
  }
}

module.exports = Pharmacy;
