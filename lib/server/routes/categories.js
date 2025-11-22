var express = require('express');
var router = express.Router();

/* GET categories page. */
router.get('/', async (req, res) => {
  try {
    const response = await fetch('https://api.escuelajs.co/api/v1/categories');
    const data = await response.json();
    res.json(data); // send JSON
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});

router.get('/products', async (req, res) => {
  try {
    const response = await fetch('https://api.escuelajs.co/api/v1/products');
    const data = await response.json();
    res.json(data); // send JSON
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});

module.exports = router;
