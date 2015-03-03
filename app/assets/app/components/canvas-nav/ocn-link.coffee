"use strict"

angular

  .module( "archetype.directives" )

  .directive( "ocnLink", ->
    restrict: "E"
    replace: true
    scope:
      tabs: "="
    templateUrl: "ocn-link.html"
  )
