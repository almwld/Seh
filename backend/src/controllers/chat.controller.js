const { pool } = require('../config/db');

async function sendMessage(req, res) {
  try {
    const { consultation_id, content } = req.body;
    const result = await pool.query(
      'INSERT INTO messages (consultation_id, sender_id, content) VALUES ($1, $2, $3) RETURNING *',
      [consultation_id, req.user.id, content]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

async function getMessages(req, res) {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'SELECT * FROM messages WHERE consultation_id = $1 ORDER BY sent_at ASC',
      [id]
    );
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

async function markAsRead(req, res) {
  try {
    const { id } = req.params;
    await pool.query('UPDATE messages SET is_read = true WHERE consultation_id = $1 AND sender_id != $2', [id, req.user.id]);
    res.json({ message: 'تم تحديث حالة الرسائل' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

module.exports = { sendMessage, getMessages, markAsRead };
