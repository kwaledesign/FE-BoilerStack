angular.module('ngArchetype.models.archetype', [])
  .service 'ArchetypeModel', ->
    model = this
    modules = [ {
      'name': 'Archetype-c-button'
      'github': 'https://archetype-css.github.com/Archetype-c-button'
      'travisci': ''
      'travisbadge': ''
      'gemnasium': ''
      'codepen': ''
    } ]

  model.getArchetypeModules = ->
    modules

  return