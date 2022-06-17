const express = require('express');
const router = express.Router();
const ctrlCars = require('../controllers/cars');

// cars
router
  .route('/cars')
  .post(ctrlCars.webhook);
  

module.exports = router;
