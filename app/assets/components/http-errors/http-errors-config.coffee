"use strict"

angular

  .module( "archetype.httpErrors" )

  .config( ($stateProvider) ->

    $stateProvider

      # Root
      .state("archetype.errors",
        url: "^/errors"
        abstract: true
        template: "<div ui-view></div>"
      )

      # 404 Error
      .state("archetype.errors.404",
        url: "/404"
        templateUrl: "404.html"
        data:
          pageTitle: "http_errors.error_404.page_title"
      )

      # 500 Error
      .state( "archetype.errors.500",
        url: "/500"
        templateUrl: "500.html"
        data:
          pageTitle: "http_errors.error_500.page_title"
      )

  )