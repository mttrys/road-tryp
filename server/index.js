const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const models = require('../database/models/models.js');
const Trips = models.Trip;

const app = express();

const ADDRESS = '127.0.0.1';
const PORT = 3000;

app.use(express.static(path.join(__dirname, '../client/dist')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.get('/users', (req, res) => {
  console.log('GET /users endpoint pinged.');
  models.Users.fetch().then( (users) => {
    res.status(200).send(users);
  })
    .catch( (err) => {
      console.log('ERROR GETting Users collection: ', err);
      res.status(404).send(err);
    });
});


// app.get('/trips', (req, res) => {
//   console.log('GET /trips endpoint pinged.');
//   models.Trips.fetch()
//     .then( (trips) => {
//       res.status(200).send(trips);
//     })
    // .catch( (err) => {
    //   console.log('ERROR GETting Trips collection: ', err);
    //   res.status(404).send(err);
    // });
// });

app.post('/user', (req, res) => {
  let user = req.body;
  console.log('POSTing user data: ', user);
  new models.User(user).save()
    .then( (user) => {
      res.status(201).send(user);
    })
    .catch( (err) => {
      console.log('ERROR POSTing User model: ', err);
      res.status(400).send(err);
    });
});

app.post('/trip', (req, res) => {
  let trip = req.body;
  console.log('POSTing trip data: ', trip);
  new models.Trip(trip).save()
    .then( (trip) => {
      res.status(201).send(trip);
    })
    .catch( (err) => {
      console.log('ERROR POSTing Trip model: ', err);
      res.status(400).send(err);
    });
});

//ALL REST ENDPOINTS SHOULD START WITH /api/<YOUR PATH>
//AND BE ABOVE THE FOLLOWING: app.get('/*'...)
app.get('/trips', (req, res) => {
  Trips.query((qb) => {
    // qb.innerJoin('Users', 'Users.id', '=', 'Trips.driver_id');
    qb.where({
      departure_city: req.query.depart,
      arrival_city: req.query.arrive,
    });
  })
  .fetch()
  .then((trips) => {
    console.log(trips)
    res.status(200).send(JSON.stringify(trips));
  })
  .catch( (err) => {
    console.log('ERROR GETting Trips collection: ', err);
    res.status(404).send(err);
  });
});

app.get('/*', (req, res) => {
  res.sendFile(path.join(__dirname + '/../client/dist/index.html'));
});
app.listen(PORT, ADDRESS, () => {
  console.log('Toad Tryp server listening on port 3000.');
});
