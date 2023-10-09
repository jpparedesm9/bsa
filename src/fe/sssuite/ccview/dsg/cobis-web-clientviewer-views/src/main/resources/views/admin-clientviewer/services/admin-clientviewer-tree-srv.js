(function () {
    'use strict';

    app.service("adminclientviewer.treeServices", function ($q, $http) {
		
    	var service = {};
		
		service.getAllProductAdministratorDefaultDinamicByType = function(typeClient,typeClientParent){
			var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getAllProductAdministratorDefaultDinamicByType/" + typeClient+"/"+ typeClientParent,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
        
		service.getProductAdministratorDefaultDinamicByParent = function(parent){
			var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getProductAdministratorDefaultDinamicByParent/" + parent,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
        
        
        service.deleteDefaultProductAdministratorById = function(code) {
			var d = $q.defer();
            $http({
            	url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/deleteDefaultProductAdministratorById/" + code,
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