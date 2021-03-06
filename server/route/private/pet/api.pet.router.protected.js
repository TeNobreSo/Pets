const express = require('express');
const {ApiPetCtrl} = require('../../../controllers');
const router = new express.Router();

router.post('/pet/create', ApiPetCtrl.create);
router.get('/pet/all', ApiPetCtrl.getAll);
router.delete('/pet/delete', ApiPetCtrl.delete);


module.exports = router;
