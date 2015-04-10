var App = angular.module('hkBusRoutes', ['ngRoute']);

App.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider.when('/', {
        templateUrl: "index.html"
    });
    return $locationProvider.html5Mode(true)
}]);