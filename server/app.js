const express = require('express')
const app = express()

app.listen(8080, () => {
  console.log("サーバー起動中:");
  console.log("http://localhost:8080");
});

app.get('/echo', (req, res)=> {
  res.json({ message : req.query.message });
});


