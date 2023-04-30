const path = require('path');
const express = require('express');
const body_parser = require('body-parser');
const express_hbs = require('express-handlebars');

const login_route = require('./routes/login')
const files_route = require('./routes/files')
const file_history_route = require('./routes/file_history')
const upload_file_route = require('./routes/upload_file')
const modify_file_route = require('./routes/modify_file')

const app = express();

app.engine('.hbs', express_hbs.engine({ extname: '.hbs', defaultLayout: 'main'}));
app.set('view engine', 'hbs');
app.set('views', 'views');

app.use(body_parser.urlencoded({extended: false}));
app.use(express.static(path.join(__dirname, 'public')));

app.use(login_route.routes);
app.use(files_route);
app.use(file_history_route);
app.use(upload_file_route.routes);
app.use(modify_file_route.routes);

app.listen(3000, () => {
    console.log('App is running in port 3000')
});