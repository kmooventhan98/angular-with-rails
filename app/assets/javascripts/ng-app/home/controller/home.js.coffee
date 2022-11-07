app = angular.module("sampleAdminCompany", [
    "ngResource"
    "ngAnimate"
    "ui.router"
    "templates"
])

app.controller("CompanyCtr", ["$scope", "$resource", "$http", "$location", "$stateParams", "$state","$filter", "$timeout","$interval", "$window", ($scope, $resource, $http, $location, $stateParams, $state,  $filter, $timeout, $interval, $window) -> ])