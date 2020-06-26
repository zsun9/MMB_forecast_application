const express = require('express');
const mongoose = require('mongoose');
const session = require('express-session');
const passport = require('passport');
const bcrypt = require('bcryptjs');
const path = require('path');

// Init application
const app = express();

// User model
const UserSchema = new mongoose.Schema({
  name: {type: String, required: true},
  email: {type: String, required: true},
  password: {type: String, required: true},
  date: {type: Date, default: Date.now}
});
const User = mongoose.model('User', UserSchema);

// Passport Config
const LocalStrategy = require('passport-local').Strategy;
passport.use(
  new LocalStrategy({ usernameField: 'name'}, (name, password, done) => {
    // Match User
    User.findOne({ name: name })
      .then(user => {
        if (!user) {return done(null, false)}
        // Match plain text password with hashed password
        bcrypt.compare(password, user.password, (err, isMatch) => {
          if (err) throw err;

          if (isMatch) {
            return done(null, user);
          } else {
            return done(null, false);
          }
        });
      })
      .catch(err => console.log(err));
  })
);

// Serialize and deserialize
passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser((id, done) => {
  User.findById(id, (err, user) => {
    done(err, user);
  });
});

// Connect to Mongo DB
const db = 'mongodb+srv://zsun:.1e1e1E.@cluster-juf5f.mongodb.net/<dbname>?retryWrites=true&w=majority';

mongoose.connect(db, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected ...'))
  .catch(err => console.log(err));

// Bodyparser
app.use(express.urlencoded({ extended: false }));

// Express session
app.use(
  session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
  })
);

// Passport middleware
app.use(passport.initialize());
app.use(passport.session());

// Authentification
let ensureAuthenticated = function (req, res, next) {
  if (req.isAuthenticated()) {return next();}
  res.redirect('/login');
};

// Public routes
app.get(`/`, (req, res) => res.sendFile(path.join(__dirname, `index_login.html`)));
for (let publicPage of ['login']) {
  app.get(`/${publicPage}`, (req, res) => res.sendFile(path.join(__dirname, `${publicPage}.html`)));
}

for (let publicFolder of ['css', 'js', 'common']) {
  app.use(`/${publicFolder}`, express.static(path.join(__dirname, `${publicFolder}`)));
}

// Private routes
for (let privatePage of ['index', 'about', 'forecast', 'rmse', 'variable']) {
  app.get(`/${privatePage}`, ensureAuthenticated, (req, res) => res.sendFile(path.join(__dirname, `${privatePage}.html`)));
}

for (let privateFolder of ['src']) {
  app.use(`/${privateFolder}`, ensureAuthenticated, express.static(path.join(__dirname, `${privateFolder}`)));
}

// Login
app.post('/login', (req, res, next) => {
  passport.authenticate('local', {
    successRedirect: '/forecast',
    failureRedirect: '/login',
  })(req, res, next);
});

// Logout
app.get('/logout', (req, res) => {
  req.logout();
  res.redirect('/');
});

// Listen
const PORT = process.env.PORT || 5000;
app.listen(PORT, console.log(`Server running on port ${PORT}`));