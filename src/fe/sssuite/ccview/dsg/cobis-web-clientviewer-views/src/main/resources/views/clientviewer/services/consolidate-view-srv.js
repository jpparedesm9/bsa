(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);
    app.service("clientviewer.consolidatePositionService", function ($q, $http) {
        var service = {};

        /*
         * Service used to prepare all the information for a specific customer
         * and insert into tables that will be shown later in the VCC.
         */
        service.prepareProductsData = function (customerCode, groupCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/ProductsService/prepareProductsData/" + customerCode + "/" + groupCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        /*
         *  Service use to get information of consolidate position by customer id
         */
        service.queryConsolidatedPosition = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/ClientService/queryConsolidatedPosition/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        /*
         *  Service use to get information of the Products Sale
         */
        service.queryAllProductsSale = function (searchProductsSale) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/BankingProductManager/getBankinProductsRulesFiltered/",
                method: "PUT",
                data: searchProductsSale
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        /*
         *  Service use to get the defined list of currencies for Products Sale
         */
        service.queryAllCurrenciesProductsSale = function () {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/CatalogManager/getAllCurrencies",
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        /*
         *  Service use to get information of the Products Sale
         */
        service.queryBankingProductBasicInformation = function (bankingProductId) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/BankingProductManager/getBankingProductBasicInformationById/" + bankingProductId,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };



        service.searchScoreCustomer = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/IScoreServices/searchScoreCustomer/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };


		service.searchPunctuationCustomer = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/IScoreServices/searchPunctuationCustomer/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };


        service.getRateByClientId = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/RateService/getRateByClientId/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };


        service.getAsfiByClientId = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/RateService/getAsfiByClientId/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };


        service.getInfoCredByClientId = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/RateService/getInfoCredByClientId/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };


        service.getPortfolioRateByClientId = function (customerCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/RateService/getPortfolioRateByClientId/" + customerCode,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        /*
         * Service used to prepare all the information for a specific customer
         * and insert into tables that will be shown later in the VCC.
         */
        service.createProcessInstance = function (processInstance) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/ISalesProduct/startProcessInstance/",
                method: "PUT",
                data: processInstance
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };

        /*
         * Service used to get GetBankinProductsApprovedStructure
         */
        service.getBankinProductsApprovedStructure = function () {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/BankingProductManager/getBankinProductsApprovedStructure/",
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		 /*
         * Service used to get getOperationGuarrantees
         */
		service.getOperationGuarrantees = function (url, code) {
            var d = $q.defer();
            $http({
				url: "${contextPath}/resources/cobis/web/" + url + "/" + code,
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {

                d.reject(null);
            });
            return d.promise;
        };

		service.getWebServiceExecutor = function (url, code) {
            var d = $q.defer();
            $http({
				url: "${contextPath}/resources/cobis/web/" + url,
                method: "PUT",
                data: code
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {

                d.reject(null);
            });
            return d.promise;
        };

		/*
         * Service used to prepare all the information for a specific customer
         * and insert into tables that will be shown later in the VCC.
         */
        service.prepareProductsDataHistory  = function (customerCode, groupCode) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/ProductsService/prepareProductsDataHistory/" + customerCode + "/" + groupCode,
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