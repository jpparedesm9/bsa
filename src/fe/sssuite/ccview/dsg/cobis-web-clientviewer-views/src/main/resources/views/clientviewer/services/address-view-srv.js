(function () {
   'use strict';
   var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);
   app.service("clientviewer.addressService", function ($q, $http) {
      var service = {};
      /*
       *  Service used to get complete information of defined Customer.
       */
      service.queryAddress = function (searchCustomer) {
          
          var d = $q.defer(); 
         $http({
            //url: "${contextPath}/resources/cobis/web/CustomerCommons/getCustomerAddresses/"+customer,            		
        	url: "${contextPath}/resources/cobis/web/AddressTxService/executeGetAddress",
            method: "PUT",
            data: searchCustomer
         }).success(function (data, status, headers, config) {   
             
            d.resolve(data);
         }).error(function (data, status, headers, config) {     
             
            d.reject(null);
         });
         return d.promise;
      };
      
      service.queryContact = function (searchCustomer) {
          
          var d = $q.defer(); 
         $http({            
        	url: "${contextPath}/resources/cobis/web/ContactTxService/executeGetContact",
            method: "PUT",
            data: searchCustomer
         }).success(function (data, status, headers, config) {   
             
            d.resolve(data);
         }).error(function (data, status, headers, config) {     
             
            d.reject(null);
         });
         return d.promise;
      };
      
      service.queryPhones = function (searchCustomer) {          
          var d = $q.defer(); 
         $http({            
        	url: "${contextPath}/resources/cobis/web/PhoneTxService/executeGetPhoneAddress",
            method: "PUT",
            data: searchCustomer
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