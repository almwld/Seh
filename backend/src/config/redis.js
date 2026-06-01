const redis = require('redis');

let client;

async function connectRedis() {
  console.log('⚠️ Skipping Redis connection for local test environment');
  return;
  try {
    client = redis.createClient({
      url: process.env.REDIS_URL || 'redis://localhost:6379'
    });
    client.on('error', (err) => console.log('Redis Client Error', err));
    await client.connect();
    console.log('✅ Redis connected');
  } catch (error) {
    console.log('⚠️ Redis not available, continuing without cache');
  }
}

function getClient() {
  return client;
}

module.exports = { connectRedis, getClient };
