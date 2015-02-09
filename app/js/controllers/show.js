'use strict';

siteManagerControllers.controller('ShowController', [ '$scope', 'site', 'Site', function($scope, site, Site){
    $scope.site = site;

    $scope.start = function(site){
        var s = new Site();
        s.$start({name: site.name}).then(function(data) {
            $scope.site = data.site
        })
    };

    $scope.stop = function(site){
        var s = new Site();
        s.$stop({name: site.name}).then(function(data) {
            $scope.site = data.site
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
