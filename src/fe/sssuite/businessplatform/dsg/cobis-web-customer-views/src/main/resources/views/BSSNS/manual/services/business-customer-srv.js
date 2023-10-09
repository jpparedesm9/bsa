(function() {
  "use strict";

  var app = cobis.createModule(cobis.modules.CUSTOMER, [
    cobis.modules.CONTAINER
  ]);

  app.service("customer.queryBussinesCustomer", function($q, $http) {
    var service = {};

    service.queryCustomer = function(customerCode, stage, processInstance) {
      var d = $q.defer();
      $http({
        url:
          "${contextPath}/resources/cobis/web/customerbusiness/formBusiness/"+customerCode+"/"+processInstance+"/"+stage,
        method: "GET",
        data: ""
      })
        .success(function(data, status, headers, config) {
          d.resolve(data);
        })
        .error(function(data, status, headers, config) {
          d.reject(data);
        });
      return d.promise;
    };

    service.saveCustomer = function(responseData) {
      var d = $q.defer();
      $http({
        url:
          "${contextPath}/resources/cobis/web/customerbusiness/formBusiness/",
        method: "PUT",
        data: responseData
      })
        .success(function(data, status, headers, config) {
          d.resolve(data);
        })
        .error(function(data, status, headers, config) {
          d.reject(data);
        });
      return d.promise;
    };

    return service;
  });
})();
