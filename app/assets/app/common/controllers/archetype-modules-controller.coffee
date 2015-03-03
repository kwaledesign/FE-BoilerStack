'use strict'

angular.module('ngArchetypeApp')
	.controller 'ArchetypeModel', ($scope) ->
		$scope.modules = getArchetypeModules
	return


