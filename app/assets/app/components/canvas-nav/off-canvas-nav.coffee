"use strict"

angular

  .module( "archetype.directives" )

  # off-canvas nav directive
  .directive( "archetypeOffCanvasNav", ($rootScope, $document, EVENTS) ->
    restrict: "E"
    replace: true
    controller: "archetypeOffCanvasNavController"
    controllerAs: "nav"
    bindToController: true
    templateUrl: "off-canvas-nav.html"
    link: (scope, elem, attr, ctrl) ->
      
      # clicks inside ocn do nothing
      elem.bind('click', (e) ->
        e.stopPropagation()
        return
      )

      # clicks inside document, but outside ocn collaps nav
      $document.bind( 'click', (e) ->
        scope.$apply( ->
          $rootScope.$emit(EVENTS.TOGGLE_OCN, false)
        )
        return
      )

      # clicks on links inside ocn collapse nav
      elem.bind( 'click', (e) ->
        if angular.element( e.target ).hasClass( 'ocn-link' )
          scope.$apply( ->
            $rootScope.$emit(EVENTS.TOGGLE_OCN, false)
          )
        return
      )

      return
  )

  .controller( "archetypeOffCanvasNavController", ($rootScope, $state, EVENTS, NAV_SECTIONS) ->

    nav = @

    nav.state = $state

    nav.sections = NAV_SECTIONS

    nav.isActive = false
    $rootScope.$on(EVENTS.TOGGLE_OCN, (event, active) ->
      nav.isActive = active
    )

    # Handle section selection
    nav.selectedSection = $state.$current.name.split('.')[1]
    $rootScope.$on( "$stateChangeSuccess", (evt, toState, toParams, fromState, fromParams) ->
      nav.selectedSection = toState.name.split('.')[1]
    )
  )

  .constant( "NAV_SECTIONS",
    [
      {
        # Manage
        "key": "manage"
        "label": "manage.label"
        "icon": "cogwheel"
        "links":
          [
            {
              "state": "archetype.manage.facilities"
              "url": "#/manage/facilities"
              "key": "facilities.label"
            },{
              "state": "archetype.manage.facilityGroups"
              "url": "#/manage/facility_groups"
              "key": "facility_groups.label"
            },{
              "state": "archetype.manage.users"
              "url": "#/manage/team"
              "key": "users.label"
            },{
              "state": "archetype.manage.mds"
              "url": "#/manage/mds"
              "key": "mds.label"
            },{
              "state": "archetype.manage.residents"
              "url": "#/manage/residents"
              "key": "residents.label"
            },{
              "state": "archetype.manage.residentGroups"
              "url": "#/manage/resident_groups"
              "key": "resident_groups.label"
            }
          ]
      },{
        # Assess
        "key": "assess"
        "label": "assess.label"
        "icon": "pen"
        "links":
          [
            {
              "state": "archetype.assess.toDo"
              "url": "#/assess/to_do"
              "key": "to_do.label"
            },{
              "state": "archetype.assess.census"
              "url": "#/assess/census"
              "key": "census.label"
            },{
              "state": "archetype.assess.admission"
              "url": "#/assess/admission"
              "key": "admission.label"
            },{
              "state": "archetype.assess.discharge"
              "url": "#/assess/discharge"
              "key": "discharge.label"
            },{
              "state": "archetype.assess.mandatory"
              "url": "#/assess/mandatory"
              "key": "mandatory.label"
            },{
              "state": "archetype.assess.stage2"
              "url": "#/assess/stage_2"
              "key": "stage_2.label"
            },{
              "state": "archetype.assess.completed"
              "url": "#/assess/completed"
              "key": "completed.label"
            }
          ]
      },{
        # Analyze
        "key": "analyze"
        "label": "analyze.label"
        "icon": "charts"
        "links":
          [
            {
              "state": "archetype.analyze.one"
              "url": "#/analyze/one"
              "key": "one.label"
            },{
              "state": "archetype.analyze.two"
              "url": "#/analyze/two"
              "key": "two.label"
            },{
              "state": "archetype.analyze.three"
              "url": "#/analyze/three"
              "key": "three.label"
            }
          ]
      },{
        # Improve
        "key": "improve"
        "label": "improve.label"
        "icon": "wrench"
        "links":
          [
            {
              "state": "archetype.improve.one"
              "url": "#/improve/one"
              "key": "one.label"
            },{
              "state": "archetype.improve.two"
              "url": "#/improve/two"
              "key": "two.label"
            },{
              "state": "archetype.improve.three"
              "url": "#/improve/three"
              "key": "three.label"
            }
          ]
      }
    ])
