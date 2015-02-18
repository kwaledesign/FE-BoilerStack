"use strict"

angular.module( "templates", [])

angular

  .module( "archetype", [

    #
    # Third party modules
    "templates",

    #
    # Shared Resources
    "archetype.constants",
    "archetype.filters",
    "archetype.directives",
    "archetype.services",

    #
    # archetype Modules
    "archetypeDirectives",

    #
    # archetype Modules
    "archetype.styleguide",
    #"archetype.docs",
    #"archetype.components",
    #"archetype.patternlibrary",

    #
    # Angular addOn Modules
    "ngAnimate",
    "ngTouch"

  ])
