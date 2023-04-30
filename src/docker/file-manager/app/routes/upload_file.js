const path = require('path');
const express = require('express');

const router = express.Router();

router.get('/files/upload-file', (req, res, next) => {
    res.render('upload-file');
});

router.post('/files/upload-file', (req, res, next) => {
    res.redirect('/files')
})

exports.routes = router