'use strict';
var siteManagerApp = angular.module('siteManagerApp', [ 'ngRoute', 'siteManagerControllers', 'siteManagerServices' ]);
var siteManagerControllers = angular.module('siteManagerControllers', []);
var siteManagerServices = angular.module('siteManagerServices', ['ngResource']);

siteManagerApp.config( function($routeProvider, $locationProvider) {

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
    .when('/sites/:siteName', {
            templateUrl: 'templates/show.html',
            controller: 'ShowController',
            resolve: {
                site: function($q, Site, $route) {
                    var deferred = $q.defer();
                    Site.get({name: $route.current.params.siteName}).$promise.then(function(data){
                        deferred.resolve(data.site)
                    });
                    return deferred.promise;
                }
            }
        })
    .otherwise({
        redirectTo: '/'
    });
});

