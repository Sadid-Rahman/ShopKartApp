var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const cors = require('cors');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var categoriesRouter = require('./routes/categories');
var wishlistRouter = require('./routes/wishlist');
var LoginSignupRouter = require('./routes/login_signup');
var DashboardRouter = require('./routes/dashboard');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.json());
const corsOptions = {
  origin: 'http://localhost:39985', // dynamically reflect request origin
  methods: ["GET","POST","PUT","DELETE","OPTIONS"],
  allowedHeaders: ["Content-Type","Authorization"],
};

app.use(cors(corsOptions));
app.options("*", cors(corsOptions));
app.use('/uploads', express.static('uploads'));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/categories', categoriesRouter);
app.use('/wishlist',wishlistRouter)
app.use('/loginSignup',LoginSignupRouter);
app.use('/dashboard',DashboardRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler

module.exports = app;
