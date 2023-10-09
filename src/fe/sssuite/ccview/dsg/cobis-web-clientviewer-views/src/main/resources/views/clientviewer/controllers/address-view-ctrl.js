(function () {
    'use strict';

    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);

    app.controller("clientviewer.addressController", ['$scope', '$rootScope', '$filter', 'clientviewer.addressService',

      function ($scope, $rootScope, $filter, addressService) {
		  		 
    		$rootScope.spid = 0;
    		var searchCustomer = {};
			$scope.initDataDir = function () {		
				$rootScope.isNaturalPersonTab=false;
				$rootScope.isCorporationTab=false;
				$rootScope.isEconomicGroupTab=false;
				$rootScope.isEcGroupNecessaryTab=true;
				$rootScope.isMaximunDebtsTab=false;			
                $scope.queryClientDirections();
                $scope.queryClientContact();
            };
		
			
			$rootScope.isNaturalPersonTab=false;
			$rootScope.isCorporationTab=false;
			$rootScope.isEconomicGroupTab=false;
			$rootScope.isEcGroupNecessaryTab=false;
			$rootScope.isMaximunDebtsTab=false;  		
            

			$scope.personalDataClick = function()
			{
				$rootScope.isNaturalPersonTab=true;
				$rootScope.isCorporationTab=false;
				$rootScope.isEconomicGroupTab=false;
				$rootScope.isEcGroupNecessaryTab=false;
				$rootScope.isMaximunDebtsTab=false;
				
			}
			$scope.corporationDataClick = function()
			{
				$rootScope.isNaturalPersonTab=false;
				$rootScope.isCorporationTab=true;
				$rootScope.isEconomicGroupTab=false;
				$rootScope.isEcGroupNecessaryTab=false;
				$rootScope.isMaximunDebtsTab=false;
				
			}
			$scope.economicGroupClick = function()
			{
				$rootScope.isNaturalPersonTab=false;
				$rootScope.isCorporationTab=false;
				$rootScope.isEconomicGroupTab=true;
				$rootScope.isEcGroupNecessaryTab=false;
				$rootScope.isMaximunDebtsTab=false;
				
			}
		  
			$scope.maximunDebtsClick = function()
			{
				$rootScope.isNaturalPersonTab=false;
				$rootScope.isCorporationTab=false;
				$rootScope.isEconomicGroupTab=false;
				$rootScope.isEcGroupNecessaryTab=false;
				$rootScope.isMaximunDebtsTab=true;
				
			}
					
			 $scope.addressColumns = [
              {
                  field: "addressId",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_NO'),
                  width: "20px"
              },
              {
                  field: "isMainAddress",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_PRINCIPAL')
              },
              {
                  field: "type",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DIRECTION')
              },
              {
                  field: "description",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_DIRECTION_DESCRIPTION')
              },
              {
                  field: "country",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_COUNTRY_NAME')
              },
              {
                  field: "department",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_DEPARTMENT')
              },
              {
                  field: "province",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_PROVINCE')
              },
              {
                  field: "city",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_TOWN_SHIP_NAME')
				  
              },
              {
                  field: "street",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_STREET')
              }
              ];  					
  					
  			 $scope.emailsColumns = [
              {
                  field: "addressId",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_NO')
              },
              {
                  field: "description",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_DIRECTION_DESCRIPTION')
              },
              {
                  field: "type",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DIRECTION')
              }];
  			 
  			  $scope.contactColumns = [
              {
                 field: "name",
                 title: $filter('translate')('COMMONS.HEADERS.HDR_NAME')
              },
              {
                 field: "address",
                 title: $filter('translate')('COMMONS.HEADERS.HDR_DIRECTION_DESCRIPTION')
              },
              {
                 field: "phone",
                 title: $filter('translate')('COMMONS.HEADERS.HDR_PHONE')
              },
              {
                 field: "email",
                 title: $filter('translate')('COMMONS.HEADERS.HDR_EMAIL')
              }];
  			  
  			 $scope.phoneColumns= [
              {
            	  field: "value", 
            	  title: $filter('translate')('COMMONS.HEADERS.HDR_NUMBER'),
            	  width: "150px"
              },
              {
            	  field: "typePhone", 
            	  title: $filter('translate')('COMMONS.HEADERS.HDR_PHONETYPE'),
            	  width: "100px"
              }];
  			 
  			 
  			$scope.actividadColumns = [
               {
                  field: "activity",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_ECONOMIC_ACTIVITY')
               },
               {
                  field: "sector",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_SECTOR_ACTIVITY')
               },
               {
                  field: "subSector",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_SUB_SECTOR_ACTIVITY')
               },
               {
                  field: "main",
                  title: $filter('translate')('COMMONS.HEADERS.HDR_MAIN_SECTOR')
               }];
			
            $scope.queryClientDirections = function () {
                searchCustomer = {                        
                		customerId: ""
                     }
                searchCustomer.customerId=$scope.customerCode;
                
                var serviceResponse = addressService.queryAddress(searchCustomer);
              
                serviceResponse.then(function (data) {
						$rootScope.seriesDirections = [];
                        $rootScope.seriesEmails = [];
                        for (var i = 0; i < data.length; i++) {
                           if (data[i].typeCode != "CE") {
                                $rootScope.seriesDirections.push(data[i]);
                            } else {
                                $rootScope.seriesEmails.push(data[i]);
                            }
                        }

						$scope.isVisibleDirections = ($rootScope.seriesDirections != null && $rootScope.seriesDirections.length > 0);
						$scope.isVisibleEmails = ($rootScope.seriesEmails != null && $rootScope.seriesEmails.length > 0);
                    }
                 );
            }
            
            $scope.queryClientContact = function () {                              
                searchCustomer = {                        
                		customerId: ""
                     }
                searchCustomer.customerId=$scope.customerCode;
                
                var serviceResponse = addressService.queryContact(searchCustomer);
              
                serviceResponse.then(function (data) {
                		$rootScope.seriesContact = [];
                        for (var i = 0; i < data.length; i++) {                         
                        	$rootScope.seriesContact.push(data[i]);                           
                        }              

                        $scope.isVisibleContact = ($rootScope.seriesContact != null && $rootScope.seriesContact.length > 0);

                    }
                 );

            }
       
       $scope.queryClientPhones = function (dataItem) {
            
           searchCustomer = {                        
        		customerID: "",
        		addressId:""
                }
           searchCustomer.customerID=$scope.customerCode;
           searchCustomer.addressId= dataItem.addressId;
           
           var serviceResponse = addressService.queryPhones(searchCustomer);
         
           serviceResponse.then(function (data) {
        	   	   $rootScope.seriesPhones = []; 
                   for (var i = 0; i < data.length; i++) {                         
                	   $rootScope.seriesPhones.push(data[i]);                           
                   }                                     
           		   $scope.isVisiblePhones = ($rootScope.seriesPhones != null && $rootScope.seriesPhones.length > 0);

               }
            );
       }	  
			
      }]);

}());