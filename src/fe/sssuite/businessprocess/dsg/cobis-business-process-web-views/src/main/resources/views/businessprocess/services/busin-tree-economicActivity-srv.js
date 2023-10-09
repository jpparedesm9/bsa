(function () {
    'use strict';
    var app = cobis.createModule("businessprocess", ['kendo.directives']);

    app.service("busin.businServices", function ($q, $http) {
		
    	var service = {};
		
		service.GetAllEconomicActivityTypes = function(economicActivity){
			var d = $q.defer();
			$http({
				url: "/CTSProxy/services/resources/cobis/web/busin/EconomicActivityManager/getAllEconomicActivityTypes/"+ economicActivity,
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