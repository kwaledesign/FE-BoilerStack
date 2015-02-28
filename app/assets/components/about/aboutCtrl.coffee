angular.module('routerApp', [ 'routerRoutes' ]).controller('mainController', ->
  vm = this
  # create a bigMessage variable to display in our view
  vm.bigMessage = 'A smooth sea never made a skilled sailor.'
  return
).controller('homeController', ->
  vm = this
  vm.message = 'This is the home page!'
  return
).controller('aboutController', ->
  vm = this
  vm.message = 'Look! I am an about page.'
  return
).controller 'contactController', ->
  vm = this
  vm.message = 'Contact us! JK. This is just a demo.'
  return