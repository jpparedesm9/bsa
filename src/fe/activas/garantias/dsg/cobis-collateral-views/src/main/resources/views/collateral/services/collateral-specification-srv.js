(function () {
    'use strict';
    var app = cobis.createModule("collateral", [cobis.modules.CONTAINER]);
    app.service("collateral.collateralSpecificationServices", function ($q, $http) {
        var service = {};
        /*
         *  Service used to get complete information of defined Customer.
         */
        service.getCollateralItems = function (collateralType) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/collateral/collateralServicesManager/getCollateralItems/" + collateralType,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };


        service.getSearchedCollateralItems = function (collateralId, branchOffice, collateralType) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/collateral/collateralServicesManager/getSearchedCollateralItems/" + collateralId + "/" + branchOffice + "/" + collateralType,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        service.getComposedCollateral = function (externalCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/collateral/collateralServicesManager/getComposedCollateral/" + externalCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		
		service.insertOrUpdateCollateralItems = function (collateralItem) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/collateral/collateralServicesManager/insertOrUpdateCollateralItems/",
                method: "PUT",
                data: collateralItem
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		service.deleteCollateralItems = function(collateralId, collateralType, sequential, branchOffice){
		var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/collateral/collateralServicesManager/deleteCollateralItems/"+collateralId +"/"+ collateralType+"/"+ sequential+"/"+ branchOffice,
				method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
		
		}
		
        return service;

    });

}());