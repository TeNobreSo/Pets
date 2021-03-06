const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const hbs = require('hbs');
const path = require('path');
const helmet = require('helmet');

const db = require('./db');
const {ErrorModel} = require('./models');
const validateToken = require('./middleware/validate-token');
const app = express();

// ROUTE
const {
  apiPetRouterProtected,
  apiPersonRouterProtected,
  apiVaccineRouterProtected,
  userRouterUnprotected,
  userRouterProtected,
} = require('./route');


app.use(
    cors({
      allowedHeaders: ['sessionId', 'Content-Type', 'master-token'],
      exposedHeaders: ['sessionId'],
      origin: '*',
      methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
      preflightContinue: false,
    }),
);
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static('public'));
app.use(helmet());

// VIEWS
app.set('views', path.join(__dirname, 'views'));
hbs.registerPartials(path.join(__dirname, 'views/partials'));
app.set('view engine', 'hbs');


// DB
db.on('error', console.error.bind(console, 'MongoDB connection error:'));

app.get('/', (req, res) => {
  res.render('index');
});


app.use('/', userRouterUnprotected);
app.use('/api', apiPetRouterProtected);
app.use('/api', apiPersonRouterProtected);
app.use('/api', apiVaccineRouterProtected);
app.use('/', userRouterProtected);
// app.use('/admin', errorRouterUnprotected);

// Error Handler
app.use(async (error, req, res, next) => {
  res.locals.message = error.message;
  res.locals.error = req.app.get('env') === 'development' ? error : {};
  res.status(error.status || 500);

  const err = error;
  err.error = JSON.stringify(err.errors);
  await ErrorModel.create(err);

  res.render('error');
});

app.set('PORT', process.env.PORT || 3000);
app.listen(app.get('PORT'), () =>
  console.log(`Server running on port ${app.get('PORT')}`),
);
