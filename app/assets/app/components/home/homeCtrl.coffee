angular.module('routerApp', [ 'routerRoutes' ]).controller('mainController', ->
  vm = this
  # create a bigMessage variable to display in our view
  vm.bigMessage = 'A smooth sea never made a skilled sailor.'
  return
).controller('homeController', ->
  vm = this
  vm.message = 'This is the home page!'
  return
)