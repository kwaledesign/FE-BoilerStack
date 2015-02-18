"use strict"

angular

  .module( "archetype.directives" )

  # animated NavIcon directive
  .directive( "archetypeNavIcon", ->
    restrict: "E"
    replace: true
    controller: "archetypeNavIconController"
    controllerAs: "icon"
    bindToController: true
    templateUrl: "nav-icon.html"
  )

  .controller( "archetypeNavIconController", ($rootScope, EVENTS) ->
    icon = @
    icon.isActive = false
    icon.toggle = (event) ->
      # Prevent click from reaching document
      event.stopPropagation()
      # Toggle nav
      $rootScope.$emit(EVENTS.TOGGLE_OCN, !icon.isActive)

    # Listen for nav toggle
    $rootScope.$on(EVENTS.TOGGLE_OCN, (event, active) ->
      icon.isActive = active
    )
  )
