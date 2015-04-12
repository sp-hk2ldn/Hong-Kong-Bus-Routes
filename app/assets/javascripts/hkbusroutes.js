var App;

App = angular.module('hkBusRoutes', ['ngRoute', 'templates', 'leaflet-directive', 'ui.bootstrap']);

App.config([
  '$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/', {
      templateUrl: "index.html"
    });
  return $locationProvider.html5Mode(true);
  }
]);

App.controller("SimpleMapController", [ '$scope', function($scope) {
  angular.extend($scope, {
    defaults: {
      scrollWheelZoom: false
    }
  });
}]);

App.controller("BusRoutesController", [
  "$scope", "$http", "$timeout", function($scope, $http, $timeout) {
    $scope.routes = [];
    $scope.loadRoutes = function() {};
    $http.get("/routes").success(function(data) {
      console.log(data);
    return $scope.routes = data;
  }).error(function(data) {
    return console.log("Error getting routes");
  });
  return $scope.loadRoutes();
  }
]);

App.controller("CenterController", [ '$scope', function($scope) {
    angular.extend($scope, {
        center: {
            lat: 40.095,
            lng: -3.823,
            zoom: 4
        },
        defaults: {
            scrollWheelZoom: false
        }
    });
}]);