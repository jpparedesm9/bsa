(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);
    app.service("clientviewer.clienteViewerExternalService", function ($q, $http) {
        var service = {};

        /*
         * Service used to prepare all the information external for a specific customer
         * and insert into tables that will be shown later in the VCC.
         */
		 
		service.getExceptionByClientId = function (customerCode) {
            var d = $q.defer();
            $http({
				url: "${contextPath}/resources/cobis/web/clientviewer/external/ClientExternalService/queryClientException/" + customerCode,                
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		service.getCustomerVisitsByClientId = function (customerCode) {
            var d = $q.defer();
            $http({
				url: "${contextPath}/resources/cobis/web/clientviewer/external/ClientExternalService/queryCustomerVisits/" + customerCode,                
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