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

