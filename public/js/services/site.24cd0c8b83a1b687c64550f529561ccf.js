siteManagerServices.factory('Site', [ '$resource', function($resource) {
    return $resource('/api/sites/:name', {}, {
        start: {
            url: '/api/sites/:name/start',
            method: "POST",
            isArray: false
        },
        stop: {
            url: '/api/sites/:name/stop',
            method: "POST",
            isArray: false
        }
    })
}]);
