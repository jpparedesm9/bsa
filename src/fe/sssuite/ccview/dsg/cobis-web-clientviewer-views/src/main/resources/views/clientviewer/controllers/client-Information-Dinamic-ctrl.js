(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER, cobis.modules.CUSTOMER, 'ui.bootstrap']);

    app.controller("clientviewer.clientInformationDinamic", ['$scope',
   '$rootScope', '$filter', '$modal', '$routeParams',
    function ($scope, $rootScope, $filter, $modal, $routeParams) {
            
		$scope.initData = function () {
		};
            

    }]);
}());