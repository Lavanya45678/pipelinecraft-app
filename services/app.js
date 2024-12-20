const express = require('express');
const app = express();
const PORT = 4000;

// Debug log to confirm the app starts
console.log('App is starting...');

// Route for '/'
app.get('/', (req, res) => {
    console.log('Received a GET request on /');
    res.send('WELCOME TOVPIPELINECRAFT-APP API!');
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
