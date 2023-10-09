(function () {
    'use strict';
    var app = cobis.createModule("assetsUpload", [cobis.modules.CONTAINER]);
    app.service("assetsUpload.assetsUploadFileServices", function ($q, $http) {
        var service = {};
		
		service.getPaymentOperatorStructure = function (operatorId) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/assets/assetsServicesManager/getPaymentOperatorStructure/" + operatorId,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		service.insertFileinTemp = function (paymentRequest) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/assets/assetsServicesManager/insertFileinTemp/",
                method: "PUT",
                data: paymentRequest
            }).success(function (data, status, headers, config) {
			    d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		service.uploadFile = function (sequential) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/assets/assetsServicesManager/uploadFile/" + sequential,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
		        d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		service.getCatalogs = function (table) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/assets/assetsServicesManager/getCatalogs/" + table,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
		        d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
        	
		service.deleteTemporary = function () {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/assets/assetsServicesManager/deleteTemporary/",
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