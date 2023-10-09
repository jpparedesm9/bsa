(function () {
   'use strict';
   var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);
   app.service("clientviewer.queryClientViewerService", function ($q, $http) {
      var service = {};
      /*
       *  Service used to get complete information of defined Customer.
       */
      service.queryCustomer = function (customerCode) {
         var d = $q.defer();
         $http({
            url: "${contextPath}/resources/cobis/web/clientviewer/CustomerService/getCustomer/"+customerCode,            		
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
       * Service used to get detail group by group code.
       */
      service.queryGroupDetail = function (economicGroupCode, type) {
          var d = $q.defer();
          $http({
             url: "${contextPath}/resources/cobis/web/clientviewer/CustomerService/getGroupDetail/"+economicGroupCode+"/"+type,            		
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
        * Service used to get complete information for companies
        */
       service.queryLegalCustomer = function (customerCode) {
           var d = $q.defer();
           $http({
              url: "${contextPath}/resources/cobis/web/CustomerCommons/getLegalCustomer/"+customerCode,            		
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
         *  Service used to get customer type by the Client code.
         */        
        service.queryCustomerType = function (customerCode) {
            var d = $q.defer();
            $http({
               url: "${contextPath}/resources/cobis/web/CustomerCommons/getCustomerType/"+customerCode,            		
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
          *  Service used to get Max Debt.
          */        
         service.getMaxDebtRequest = function (customerCode,groupCode) {
             var d = $q.defer();
             $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/MaxDebtService/queryMaxDebt/" + customerCode + "/" + groupCode,            		
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
          *  Service used to get the details of the products associated to a specific customer.
          */
         service.queryProductsByClientId = function (customerCode, documentId, spid) {
             var d = $q.defer();
             $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/ProductsService/queryProductsByClientId/" + customerCode + "/" +documentId+ "/"+ spid,
                method: "PUT",
                data: ""
             }).success(function (data, status, headers, config) {
                d.resolve(data);
             }).error(function (data, status, headers, config) {
                d.reject(null);
             });
             return d.promise;
          };
		  
		  
		 service.queryGroupMembers = function (code) {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/CustomerCommons/getGroupMembers/"+code,
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
         * Service used to get dtos dinamics
         */
        service.getAllServicesAdministrator = function () {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getConfigurationServicesVCC",
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
         * Service used to get dtos dinamics
         */
        service.getAllProductAdministratorDefault = function () {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getAllProductAdministratorDefaultVCC",
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		
		service.getManagementContentSectionRoleByRol = function () {
            var d = $q.defer();
            $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getManagementContentSectionRoleByRoleVCC",
                method: "PUT",
                data: ""
            }).success(function (data, status, headers, config) {
                d.resolve(data);
            }).error(function (data, status, headers, config) {
                d.reject(null);
            });
            return d.promise;
        };
		
		service.queryHistoryProductsByClientId = function (customerCode, spid) {
            var d = $q.defer();
             $http({
                url: "${contextPath}/resources/cobis/web/clientviewer/ProductsService/queryHistoryProductsByClientId/" + customerCode + "/" + spid,
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