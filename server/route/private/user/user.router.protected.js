const express = require('express');
const {UserCtrl} = require('../../../controllers');
const router = new express.Router();

router.post('/user', UserCtrl.insertUser);

module.exports = router;