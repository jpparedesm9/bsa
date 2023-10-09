(function () {
    'use strict';
   
    app.controller("clientviewer.customerVisitsController", ['$scope', '$rootScope', '$filter', 'clientviewer.clienteViewerExternalService',

      function ($scope, $rootScope, $filter, clienteViewerExternalService) {
		  				
			$scope.visitsDataSource = [];
			
			$scope.datasourceVisits = function() { 
				return {
							columns:[{field: "funcionario",title: $filter('translate')('COMMONS.HEADERS.HDR_FUNCTIONARY'), width: 150},
									 {field: "operacion",title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'), width: 150},
									 {field: "motivo",title: $filter('translate')('COMMONS.HEADERS.HDR_REASON'), width: 150},
									 {field: "observacion",title: $filter('translate')('COMMONS.HEADERS.HDR_OBSERVATION'), width: 150}
							]
                        };
			}								
						
			$scope.getDataCustomerVisits = function(){
				var response = clienteViewerExternalService.getCustomerVisitsByClientId($scope.customerCodeLocal);
				response.then(function (data) {
				$scope.visitsDataSource = [];				
				for (var i = 0; i < data.length; i++) {                         
                    $scope.visitsDataSource.push(data[i]);                           
                }              
                $scope.isVisibleVisits= ($scope.visitsDataSource != null && $scope.visitsDataSource.length > 0);							
				
			});
			 
			}
      }]);

}());