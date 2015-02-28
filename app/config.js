// DATABASE SETUP
//
// set the port for the app
// connect to local database
// mongoose.connect('mongodb://kwaledesign:jada3836@ds047591.mongolab.com:47591/db_archetype');
// set jwt secret

module.exports = {
  'port': process.env.PORT || 8080,
  'database':   'secret': 'localhost:27017/db_archetype',
  'secret': 'mysecretstringnoonewilleverguesseventhoughitsingithub'
}

