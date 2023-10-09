(function () {
    'use strict';
    var app = cobis.createModule("businessprocess", ['kendo.directives']);

    app.service("busin.businServices", function ($q, $http) {
		
    	var service = {};
		
		service.GetAllWarrantiesTypes = function(warrantyType){
			var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/busin/WarrantiesManager/getAllWarrantiesTypes/"+ warrantyType,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);				
            });
            return d.promise;
        };
		
		service.GetWarrantyType = function(warrantyType){
			var d = $q.defer();
            $http({
                url: "/CTSProxy/services/resources/cobis/web/busin/WarrantiesManager/getWarrantyType/"+ warrantyType,
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