siteManagerServices.factory('Site', [ '$resource', function($resource) {
    return $resource('/api/sites')
}]);
