App = angular.module('hkBusRoutes', ['ngRoute', 'templates']);

App.config([ '$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider
    .when('/',
      templateUrl: "index.html"
    )

  $locationProvider.html5Mode(true)
])