(function () {
    'use strict';
	
	var app = cobis.createModule("businessprocess", ["oc.lazyLoad","businessprocess", 'ui.bootstrap', "designerModule", "ngResource"],['DSGNR', "businessprocess"]);

    app.config(function ($routeProvider, $ocLazyLoadProvider) {
        $routeProvider.when("/businessprocess", {
            templateUrl: "${contextPath}/cobis/web/views/businessprocess/templates/busin-tree-process-tpl.html"
        }).otherwise({
            redirectTo: "/businessprocess"
        });
    });
    
}());