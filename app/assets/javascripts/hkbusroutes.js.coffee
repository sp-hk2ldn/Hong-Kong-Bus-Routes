App = angular.module('hkBusRoutes', ['ngRoute', 'templates']);

App.config([ '$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider
    .when('/',
      templateUrl: "index.html"
    )

  $locationProvider.html5Mode(true)
])

App.controller("BusRoutesController", ["$scope", "$http", "$timeout", ($scope, $http, $timeout) ->

  $scope.routes = []

  $scope.loadRoutes = ->
  $http.get("api.hkbusroutes.dev/routes")
      .success (data) ->
        console.log data
        $scope.routes = data
      .error (data) ->
        console.log "Error grabbing routes"



  $scope.loadRoutes()
])
