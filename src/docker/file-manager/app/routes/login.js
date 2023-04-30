const path = require('path');
const express = require('express');

const router = express.Router();

router.get('/', (req, res, next) => {
    res.render('login', {
        page_title: 'Inicio de sesión',
        path: '/',
        forms_css: true,
        tables_css: false
    });
});

router.post('/', (req, res, next) => {
    res.redirect('/files')
});

exports.routes = router