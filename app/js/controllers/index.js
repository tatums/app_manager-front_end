'use strict';

siteManagerControllers.controller('IndexController', [ '$scope', 'sites', 'Site', function($scope, sites, Site) {

    $scope.sites = sites;
    $scope.start = function(site){
        var index = $scope.sites.indexOf(site)
        var s = new Site();
        s.$start({name: site.name}).then(function(data) {
            $scope.sites[index] = data.site
        })
    };

    $scope.stop = function(site){
        var index = $scope.sites.indexOf(site)
        var s = new Site();
        s.$stop({name: site.name}).then(function(data) {
            $scope.sites[index] = data.site
        })
    };

    $scope.panelClass = function(site){
        if (site.status == "UP") {
            return 'panel panel-success';
        }else {
            return 'panel panel-danger';
        };
    }

    $scope.hostname = function(){
        return window.location.hostname;
    }

}]);
