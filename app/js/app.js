'use strict';
var siteManagerApp = angular.module('siteManagerApp', [ 'ngRoute', 'siteManagerControllers', 'siteManagerServices' ]);
var siteManagerControllers = angular.module('siteManagerControllers', []);
var siteManagerServices = angular.module('siteManagerServices', ['ngResource']);

siteManagerApp.config(function($routeProvider, $locationProvider) {

    $routeProvider
        .when('/', {
            templateUrl: 'templates/index.html',
            controller: 'IndexController',
            resolve: {
                sites: function($q, Site) {
                    var deferred = $q.defer();
                    Site.query().$promise.then(function(data){
                        deferred.resolve(data)
                    });
                    return deferred.promise;
                }
            }
        })
    .otherwise({
        redirectTo: '/'
    });
});

