(function () {
    'use strict';
    
    app.service("collateral.collateralService", function ($q, $http) {
        var service = {};

        /*
         * Service used to prepare all the information for a specific customer
         * and insert into tables that will be shown later in the VCC.
         */
        service.searchCollateral = function (guaranteeId) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/collateral/collateralServicesManager/searchCollateral/" + guaranteeId ,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        return service;

    });

}());