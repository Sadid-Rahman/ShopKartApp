var express = require('express');
var router = express.Router();
const db = require('../db');
const multer = require("multer");

// SAVE IMAGE TO /uploads/
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, "uploads/"),
  filename: (req, file, cb) => cb(null, Date.now() + "-" + file.originalname)
});

const upload = multer({ storage });

/* GET home page. */
router.post('/login', function(req, res, next) {
    const {email, password } = req.body;

    const selectQuery = 'SELECT * FROM users WHERE email = ? AND password = ?';

    db.query(selectQuery, [email,  password], (err, results) => {
        if (err) {
            console.error("Error fetching user:", err);
            return res.status(500).json({ error: "Database error" });
        }

        if (results.length > 0) {
            const user = results[0];
            res.json({
                message: "Login successful",
                user: { 
                    id: user.id,
                    username: user.name,
                    email: user.email,
                    avatar: user.img_src
                }
            });
        } else {
            res.status(401).json({ error: "Invalid email or password" });
        }
    });
});

router.post('/signup', upload.single('image'), function(req, res) {
    const { username, email, password } = req.body;

    console.log("New User:");
    console.log("Username:", username);
    console.log("Email:", email);
    console.log("Password:", password);
    console.log("Image:", req.file ? req.file.filename : "No image");

    const insertQuery = 'INSERT INTO users (name, email, password, img_src) VALUES (?, ?, ?, ?)';

    db.query(insertQuery, [username, email, password, req.file ? req.file.filename : null], (err, result) => {
        if (err) {
            console.error("Error inserting user:", err);
            return res.status(500).json({ error: "Database error" });
        }
    });

    res.json({
        message: "Signup successful",
        user: { 
            username, 
            email, 
            avatar: req.file?.filename || null 
        }
    });
});

module.exports = router;
