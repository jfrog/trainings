var express = require('express');
const bodyParser = require('body-parser');
const lodash = require('lodash');
const evilsrc = {constructor: {prototype: {evilkey: "evilvalue"}}};
lodash.defaultsDeep({}, evilsrc);

var app = express();
var myLogin = "AKIAJXBOVX5Q2EULDUIA";
var mypwd = "SqcyDpetv+pCsbNYWHDLE8yR5mJ13MI+4d8NOwtM";

// set the view engine to ejs
app.set('view engine', 'ejs');
// static assets directory
app.use(express.static('public'));
app
    .use(bodyParser.urlencoded({extended: true}))
    .use(bodyParser.json());
// index page, this callback contains code that can be exploited for CVE-2022-29078
app.get('/', function(req, res) {
  if (!req.query.hasOwnProperty('id')){
    req.query.id = 'Stranger';
  }
  //Object.freeze(Object.prototype);

  //Code Injection
  //res.render(safeEval('pages/index'),safeEval(req.query));

  //Template Object Injection
  //res.render(sanitizeHtml('pages/index',req.query));

  res.render('pages/index',req.query);
});
// This api call, can be used to change ejs opts.outputFunctionName, hence creating a webshell
app.post("/fear", (req, res) => {
  let data = {};
  let input = req.body.content;
  //Object.freeze(Object.prototype);
  lodash.defaultsDeep(data, input);
  res.json({message: `default response message for an expected payload! - content is ${input}`});
});
app.listen(3000);
console.log('Server is listening on port 3000');
