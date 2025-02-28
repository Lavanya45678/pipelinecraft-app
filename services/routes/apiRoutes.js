const express = require('express');
const router = express.Router();
const apiController = require('../api/apiController');

router.get('/', apiController.getData);

module.exports = router;

