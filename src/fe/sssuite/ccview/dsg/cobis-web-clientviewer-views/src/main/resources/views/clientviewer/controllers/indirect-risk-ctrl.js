(function () {
   'use strict';
   var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);
   
   app.controller("clientviewer.indirectRiskController", ['$scope',
   '$rootScope', '$filter',
      function ($scope, $rootScope, $filter) {
	   		$rootScope.spid = 0;
			
		   var currentindirectRisk=$rootScope.productsIndirectPortfolio;
		   //var currentindirectRisk=$scope.indirectRisk;
	       for(var i in currentindirectRisk){
	           var dateChange = new Date(currentindirectRisk[i].date_apt); 
	           currentindirectRisk[i].date_apt=dateChange.toLocaleDateString();
	           var dateChange = new Date(currentindirectRisk[i].date_vto);
	           currentindirectRisk[i].date_vto=dateChange.toLocaleDateString();
	       }
	     
	       $scope.indirectRisk = new kendo.data.DataSource({
	    	   	data: $rootScope.productsIndirectPortfolio,
        		schema: {
        			model: {
        				fields: {
        					clientName: {
        						type: "string"
        					},
        					type_op_desc: {
        						type: "string"
        					},
        					operation: {
        						type: "string"
        					},
        					date_apt: {
        						type: "datetime"
        					},
        					date_vto: {
        						type: "datetime"
        					},
        					money_desc: {
        						type: "string"
        					},
        					amount_orig: {
        						type: "number"
        					},
        					balance_due: {
        						type: "number"
        					},
        					capital_balance: {
        						type: "number"
        					},
        					rate: {
        						type: "string"
        					},
        					state: {
        						type: "string"
        					}
        				}
        			}
        		}
        	});
	       
        	$scope.indirectRiskColumns = [             
        	        { field: "clientName", title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'), width : "130px", hidden:"false" },
        	        { field: "type_op_desc", title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION'), width : "130px"  },
        	        { field: "operation", title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'), width : "130px"  },
        	        { field: "date_apt", title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'), width : "100px"  },
        	        { field: "date_vto", title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'), width : "100px"  },
        	        { field: "money_desc", title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESCRIPTION'), width : "100px"  },
        	        { field: "amount_orig", title: $filter('translate')('COMMONS.HEADERS.HDR_ORIGINAL_AMOUNT'), width : "130px", format:"{0:c}"  },
        	        { field: "balance_due", title: $filter('translate')('COMMONS.HEADERS.HDR_BALANCE_DUE'), width : "130px", format:"{0:c}" },
        	        { field: "capital_balance", title: $filter('translate')('COMMONS.HEADERS.HDR_CAPITAL_BALANCE'), width : "130px", format:"{0:c}" },
        	        { field: "rate", title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'), width : "80px"  },
        	        { field: "state", title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'), width : "100px"  }
        	    ];
        	
         	$scope.isVisibleIndirectRiskDet = ($rootScope.productsIndirectPortfolio != null && 
        									   $rootScope.productsIndirectPortfolio.length > 0);
	
   }]);
}());
