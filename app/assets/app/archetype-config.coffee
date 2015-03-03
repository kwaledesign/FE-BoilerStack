"use strict"

angular

  .module( "archetype" )

  .config( ($httpProvider, $urlRouterProvider, $stateProvider, $compileProvider, PATHS, archetype) ->

    #
    # archetype root state
    $stateProvider
      .state( "archetype", {
        abstract: true,
        url: "^/",
        templateUrl: "archetype.html",
        controller: "archetype.controller as archetype",
      })

    #
    # Routes
    $urlRouterProvider
      .when("","/")
      .when("/", PATHS.START_PAGE)
      .when("/styleguide", PATHS.START_PAGE)
      .when("/docs", "/docs/index")
      .otherwise("/errors/404")


    #
    # Delay digest cycle when multiple async calls made to improve performance
    $httpProvider.useApplyAsync(true)
  )

###
# inject ngRoute for all our routing needs
angular.module('routerRoutes', [ 'ngRoute' ]).config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when('/',
      templateUrl: 'views/pages/home.html'
      controller: 'homeController'
      controllerAs: 'home')
    .when('/about',
      templateUrl: 'views/pages/about.html'
      controller: 'aboutController'
      controllerAs: 'about')
    .when('/contact',
      templateUrl: 'views/pages/contact.html'
      controller: 'contactController'
      controllerAs: 'contact')
  $locationProvider.html5Mode true
  return
###
