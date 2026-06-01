require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const http = require('http');
const { Server } = require('socket.io');
const { connectDB } = require('./config/db');
const { connectRedis } = require('./config/redis');

// Routes
const authRoutes = require('./routes/auth.routes');
const userRoutes = require('./routes/user.routes');
const doctorRoutes = require('./routes/doctor.routes');
const consultationRoutes = require('./routes/consultation.routes');
const prescriptionRoutes = require('./routes/prescription.routes');
const orderRoutes = require('./routes/order.routes');
const aiRoutes = require('./routes/ai.routes');
const paymentRoutes = require('./routes/payment.routes');
const notificationRoutes = require('./routes/notification.routes');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// WebSocket للاستشارات الفورية
io.on('connection', (socket) => {
  console.log('🔌 User connected:', socket.id);
  
  socket.on('join_consultation', (roomId) => {
    socket.join(roomId);
    console.log(`👨‍⚕️ Joined room: ${roomId}`);
  });

  socket.on('send_message', (data) => {
    io.to(data.roomId).emit('receive_message', data);
  });

  socket.on('typing', (data) => {
    socket.to(data.roomId).emit('user_typing', data);
  });

  socket.on('disconnect', () => {
    console.log('🔌 User disconnected:', socket.id);
  });
});

// Make io accessible to routes
app.set('io', io);

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/doctors', doctorRoutes);
app.use('/api/consultations', consultationRoutes);
app.use('/api/prescriptions', prescriptionRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/ai', aiRoutes);
app.use('/api/payments', paymentRoutes);
app.use('/api/notifications', notificationRoutes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'Sehatak Backend', version: '1.0.0' });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error', message: err.message });
});

const PORT = process.env.PORT || 3000;

async function start() {
  try {
    await connectDB().catch(err => console.error('❌ Database connection failed, but continuing...'));
    await connectRedis().catch(err => console.error('❌ Redis connection failed, but continuing...'));
    server.listen(PORT, () => {
      console.log(`🚀 Sehatak Backend running on port ${PORT}`);
      console.log(`📡 WebSocket ready`);
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    // process.exit(1);
  }
}

start();

module.exports = app;
