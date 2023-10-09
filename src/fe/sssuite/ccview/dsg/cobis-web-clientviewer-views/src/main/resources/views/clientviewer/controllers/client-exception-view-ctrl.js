(function () {
    'use strict';

    

    app.controller("clientviewer.clientExceptionController", ['$scope', '$rootScope', '$filter', 'clientviewer.clienteViewerExternalService',

      function ($scope, $rootScope, $filter, clienteViewerExternalService) {
		  	
			
			$scope.exceptionDataSource = [];
			$scope.exceptionDataSourceDetail = [];
			
			$scope.datasourceException = function() { 
				return {
							columns:[{field: "tramite",title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT')},
									 {field: "numBanco",title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION')},
									 {field: "operation",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_PRODUCT')}
							]
                        };
			}
			$scope.datasourceDetailException = function() { 
				return {
							columns:[{field: "rule",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RULE')},
									 {field: "ruleName",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_RULE_NAME'), width:"80px"},
									 {field: "autorizationDate",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_FECHA_AUT'), type: 'datetime', format: '{0:dd-MMM-yyyy}', width: "100px"},
									 {field: "autorizante",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AUTORIZANT'), width:"80px"},
									 {field: "funtionaryName",title: $filter('translate')('COMMONS.HEADERS.HDR_NAME')},
									 {field: "autorizateDetail",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AUTORIZ')},
									 {field: "observation",title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OBSERVACION')}
							]
                        };
			}
						
			
			$scope.datasourceExceptionDetail = function(dataItem) { 
				return $scope['dataSourceDetail' + dataItem.tramite];
			}
			$scope.getDataClientException = function(){
			 var response = clienteViewerExternalService.getExceptionByClientId($scope.customerCodeLocal);
			 response.then(function (data) {
				$scope.exceptionDataSource = [];
				$scope.exceptionDataSourceDetail = data.data.returnClientExceptionResponse;
				
				for (var i = 0; i < data.data.returnClientExceptionResponse.length; i++)
				{
					var insert = true;
					for (var j = 0; j < $scope.exceptionDataSource.length; j++)
					{
						if ($scope.exceptionDataSource[j].tramite == data.data.returnClientExceptionResponse[i].tramite)
						{
							insert = false;
							break;
						}
					}
					if (insert)
					{
						$scope.exceptionDataSource.push(data.data.returnClientExceptionResponse[i]);
					}
				}
				
				for (var i = 0; i < $scope.exceptionDataSource.length; i++)
				{
					$scope['dataSourceDetail' + $scope.exceptionDataSource[i].tramite] = [];
					for (var j = 0; j < $scope.exceptionDataSourceDetail.length; j++)
					{
						if ($scope.exceptionDataSourceDetail[j].tramite == $scope.exceptionDataSource[i].tramite)
							{
							$scope.exceptionDataSourceDetail[j].autorizationDate = $filter('date')(new Date( parseInt($scope.exceptionDataSourceDetail[j].autorizationDate.substring($scope.exceptionDataSourceDetail[j].autorizationDate.indexOf("(") + 1,$scope.exceptionDataSourceDetail[j].autorizationDate.indexOf(")")))),"dd/MM/yyyy")
							
								$scope['dataSourceDetail' + $scope.exceptionDataSource[i].tramite].push($scope.exceptionDataSourceDetail[j]);
							}
					}
				}
				
			});
			 
			}
      }]);

}());