const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.json());

// In-memory "database" for orders
let orders = [
  { id: 1, customer: 'Alice', item: 'Pizza', status: 'Delivered' },
  { id: 2, customer: 'Bob', item: 'Burger', status: 'Pending' }
];

// Get all orders
app.get('/orders', (req, res) => {
  res.json(orders);
});

// Get a specific order by ID
app.get('/orders/:id', (req, res) => {
  const orderId = parseInt(req.params.id);
  const order = orders.find(o => o.id === orderId);
  if (order) {
    res.json(order);
  } else {
    res.status(404).json({ message: 'Order not found' });
  }
});

// Create a new order
app.post('/orders', (req, res) => {
  const { customer, item, status } = req.body;
  const newOrder = { id: orders.length + 1, customer, item, status };
  orders.push(newOrder);
  res.status(201).json(newOrder);
});

// Update an existing order by ID
app.put('/orders/:id', (req, res) => {
  const orderId = parseInt(req.params.id);
  const { customer, item, status } = req.body;
  let order = orders.find(o => o.id === orderId);

  if (order) {
    order.customer = customer || order.customer;
    order.item = item || order.item;
    order.status = status || order.status;
    res.json(order);
  } else {
    res.status(404).json({ message: 'Order not found' });
  }
});

// Delete an order by ID
app.delete('/orders/:id', (req, res) => {
  const orderId = parseInt(req.params.id);
  const index = orders.findIndex(o => o.id === orderId);

  if (index !== -1) {
    orders.splice(index, 1);
    res.status(204).send();
  } else {
    res.status(404).json({ message: 'Order not found' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
