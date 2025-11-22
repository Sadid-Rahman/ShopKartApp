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
router.post('/', upload.single('image'), function(req, res) {
    const { username, email, password, id } = req.body;

    if (!username || !email || !password || !id) {
        return res.status(400).json({ error: "Missing required fields" });
    }
    // If no new file uploaded, keep old avatar
    const avatar = req.file ? req.file.filename : null;

    // Build query dynamically
    let updateQuery = `
        UPDATE users 
        SET name = ?, email = ?, password = ?
    `;

    let params = [username, email, password];

    if (avatar) {
        updateQuery += `, img_src = ?`;
        params.push(avatar);
    }

    updateQuery += ` WHERE id = ?`;
    params.push(id);

    db.query(updateQuery, params, (err, result) => {
        if (err) {
            console.error("Error updating user:", err);
            return res.status(500).json({ error: "Database error" });
        }

        return res.json({
            message: "Profile updated successfully",
            user: { id, username, email, avatar }
        });
    });
});



module.exports = router;