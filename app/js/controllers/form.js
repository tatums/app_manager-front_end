'use strict';

siteManagerControllers.controller('FormController', [ '$scope', 'Site', function($scope, Site){

    this.submit = function(formData, validity){
        if (validity) {
            var s = new Site();
            s.$save({name: formData.siteName}).then(function(data) {
                $scope.sites.push( data.site );
            })
        }
    }

}]);
