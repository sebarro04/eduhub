const path = require('path');

const express = require('express');

//const root_dir = require('../util/path');

const router = express.Router();

router.get('/files/history', (req, res, next) => {
    res.render('file-history');
});

module.exports = router;