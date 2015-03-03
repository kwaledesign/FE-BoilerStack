"use strict"

angular

  .module( "archetype.directives" )

  .directive( "ocnSection", ->
    restrict: "E"
    replace: true
    transclude: true
    scope:
      section: "="
      selectedSection: "="
    templateUrl: "ocn-section.html"
  )
