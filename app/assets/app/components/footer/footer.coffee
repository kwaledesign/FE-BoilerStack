"use strict"

angular

  .module( "archetype.directives")

  .directive( "archetypeFooter", ->
    restrict: "E"
    replace: true
    controller: "archetypeFooterController"
    controllerAs: "footer"
    bindToController: true
    templateUrl: "footer.html"
  )

  .controller( "archetypeFooterController", ->

    footer = @

    footer.year = new Date().getFullYear()

    return
  )
