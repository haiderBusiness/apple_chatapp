const db = require('../config/db');

exports.getAllUsers = (callback) => {
  db.query('SELECT * FROM users', callback);
};

exports.createUser = (name, callback) => {
  db.query('INSERT INTO users (name) VALUES (?)', [name], callback);
};