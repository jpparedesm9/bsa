(function () {
    'use strict';

     app.service("adminclientviewer.clientViewerService", function ($q, $http) {
      
	  var service = {};    

      service.queryConfigurationVCC = function (rol) {
          
         var d = $q.defer(); 
         $http({
            url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/queryConfigurationVCC",            		
            method: "PUT",
            data: rol
         }).success(function (data, status, headers, config) {   
             
            d.resolve(data);
         }).error(function (data, status, headers, config) {     
             
            d.reject(null);
         });
         return d.promise;
      };
      
      service.defaultConfigurationVCC = function () {
          
          var d = $q.defer(); 
          $http({
             url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/defaultConfigurationVCC",            		
             method: "PUT",
             data: ""
          }).success(function (data, status, headers, config) {   
              
             d.resolve(data);
          }).error(function (data, status, headers, config) {     
              
             d.reject(null);
          });
          return d.promise;
       };
      
      service.getAllRoleAssociatesVCC = function () {
          
          var d = $q.defer(); 
          $http({
             url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getAllRoleAssociatesVCC",            		
             method: "PUT",
             data: ""
          }).success(function (data, status, headers, config) {   
              
             d.resolve(data);
          }).error(function (data, status, headers, config) {     
              
             d.reject(null);
          });
          return d.promise;
       };
      
      service.getAllRoleConfigurationVCC = function () {
          
          var d = $q.defer(); 
          $http({
             url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/getAllRoleConfigurationVCC",            		
             method: "PUT",
             data: ""
          }).success(function (data, status, headers, config) {   
              
             d.resolve(data);
          }).error(function (data, status, headers, config) {     
              
             d.reject(null);
          });
          return d.promise;
       };
      
      service.updateConfigurationVCC =  function (selectedItem) {
         try{
	         var inProductAdmin = {
	        		 'idProduct': selectedItem.idProduct,
	        		 'idRole': selectedItem.idRole,
	        		 'visible': selectedItem.visibleProduct,
	        		 'encrypted': selectedItem.encryptedProduct
	         };
	         var d = $q.defer(); 
	         $http({
	            url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/updateConfigurationVCC",            		
	            method: "PUT",
	            data: inProductAdmin
	         }).success(function (data, status, headers, config) {   
	             
	            d.resolve(data);
	         }).error(function (data, status, headers, config) {     
	             
	            d.reject(null);
	         });
         }catch(ex)
         {
            alert(ex);
         }
         
         return d.promise;
      };
      
      service.insertConfigurationVCC =  function (idRol, nameRol) {
          try{
 	         var d = $q.defer(); 
 	         $http({
 	            url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/insertConfigurationVCC/"+ idRol + "/" + nameRol,            		
 	            method: "PUT",
 	            data: ""
 	         }).success(function (data, status, headers, config) {   
 	             
 	            d.resolve(data);
 	         }).error(function (data, status, headers, config) {     
 	             
 	            d.reject(null);
 	         });
          }catch(ex)
          {
             alert(ex);
          }
          
          return d.promise;
       };
       
       service.deleteConfigurationVCC =  function (idRol) {
           try{
  	         var d = $q.defer(); 
  	         $http({
  	            url: "${contextPath}/resources/cobis/web/clientviewer/AdministrationService/deleteConfigurationVCC/",            		
  	            method: "PUT",
  	            data: idRol
  	         }).success(function (data, status, headers, config) {   
  	             
  	            d.resolve(data);
  	         }).error(function (data, status, headers, config) {     
  	             
  	            d.reject(null);
  	         });
           }catch(ex)
           {
              alert(ex);
           }
           
           return d.promise;
        };
     
      return service;
   });
}());