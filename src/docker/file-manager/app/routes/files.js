const path = require('path');
const express = require('express');
var HTMLParser = require('node-html-parser');

var root = HTMLParser.parse('<ul id="list"><li>Hello World</li></ul>');

//const root_dir = require('../util/path');

const router = express.Router();

let latest_files = [{name: 'xd', creation_datetime: '2023-01-01 13:00:00', last_modified_datetime: null, description: 'test'}]

router.get('/files', (req, res, next) => {
    res.render('files', {
        files: latest_files,
        page_title: 'Archivos',
        path: '/files',
        has_files: latest_files.length > 0,
        forms_css: false,
        tables_css: true
    });
});

module.exports = router;