'use strict';

angular.module('ngArchetypeApp')
  .controller('offCanvasNavCtrl', function () {
    var nav = this;
    nav.active = false;

    nav.toggleNav = function () {
      if(nav.active) {
        return nav.active = false; 
      } else {
        return nav.active = true;
      }
    }

    //$window.resize(function() {
      // hide navigation if 
      //nav.active = false;
    //});

  });




