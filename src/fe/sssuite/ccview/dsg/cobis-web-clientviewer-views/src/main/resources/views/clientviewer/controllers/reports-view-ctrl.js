(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);

    app.controller("clientviewer.reportController", ['$scope',
   '$rootScope', '$filter', '$location',

      function ($scope, $rootScope, $filter, $location) {


            $('#pdfRadio').click(function () {
                cobis.container.tabs.openNewTab("ctsConsole","${contextPath}/cobis/report/client?customerCode=" + $rootScope.customerCodeReport + "&spid=" + $rootScope.spidReport + "&exportTo=PDF" ,"RPT_VCC");
            });
          
          $('#rtfRadio').click(function () {
                var hrefServlet = "${contextPath}/cobis/report/client?customerCode=" + $rootScope.customerCodeReport + "&spid=" + $rootScope.spidReport + "&exportTo=RTF";
                $(location).attr("href", hrefServlet);

            });
          
          $('#excelRadio').click(function () {
                var hrefServlet = "${contextPath}/cobis/report/client?customerCode=" + $rootScope.customerCodeReport + "&spid=" + $rootScope.spidReport + "&exportTo=EXCEL";
                $(location).attr("href", hrefServlet);

            });
          

   }]);
}());