(function () {
	'use strict';
	var app = cobis.createModule(cobis.modules.CUSTOMER, [cobis.modules.CONTAINER]);
	app.service("customer.queryCustomersService", function ($q, $http) {
		var service = {};
		service.queryGroup = function (searchCustomer) {
			var d = $q.defer();
			$http({
				url: "${contextPath}/resources/cobis/web/CustomerCommons/getGroup",
				method: "PUT",
				data: searchCustomer
         }).success(function (data, status, headers, config) {            
				d.resolve(data);
         }).error(function (data, status, headers, config) {            
				d.reject(null);
			});
			return d.promise;
		};

		service.queryGroupsByParameters = function (searchCustomer) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/CustomerCommons/getGroupsByParameters",
                method: "PUT",
                data: searchCustomer
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
        
		service.queryClientByParameters = function (searchCustomer) {
			var d = $q.defer();
			$http({
				url: "${contextPath}/resources/cobis/web/CustomerCommons/getCustomersByParameters",
				method: "PUT",
				data: searchCustomer
         }).success(function (data, status, headers, config) {            
				d.resolve(data);
         }).error(function (data, status, headers, config) {            
				d.reject(null);
			});
			return d.promise;
		};

        service.queryClientByAutoCompleteText = function (searchCustomer) {
			var d = $q.defer();
			$http({
				url: "${contextPath}/resources/cobis/web/CustomerCommons/getCustomersByAutoCompleteText",
				method: "PUT",
				data: searchCustomer
         }).success(function (data, status, headers, config) {            
				d.resolve(data);
         }).error(function (data, status, headers, config) {            
				d.reject(null);
			});
			return d.promise;
		};


        service.checkColumnExist = function (database, table, column) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/CustomerCommons/checkColumnExist/" + database + "/" + table + "/" + column,
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