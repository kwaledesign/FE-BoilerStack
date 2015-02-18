"use strict"

angular

  .module( "archetype.directives" )

  .directive( "archetypeSiteHeader", ->
    restrict: "E"
    replace: true
    controller: "archetypeSiteHeaderController"
    controllerAs: "header"
    bindToController: true
    templateUrl: "site-header.html"
  )

  .controller( "archetypeSiteHeaderController", ->

    header = @

  )
