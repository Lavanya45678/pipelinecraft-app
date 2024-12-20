 
const express = require('express');
const router = express.Router();

// Example route
router.get('/', (req, res) => {
    res.json({ message: 'Welcome to PIPELINECRAFT_APP API!' });
});

module.exports = router;
