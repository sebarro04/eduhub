const path = require('path');

const express = require('express');

//const root_dir = require('../util/path');

const router = express.Router();

router.get('/files/modify-file', (req, res, next) => {
    res.render('modify-file');
});

router.put('/files/modify-file', (req, res, next) => {
    res.redirect('/files')
})

exports.routes = router