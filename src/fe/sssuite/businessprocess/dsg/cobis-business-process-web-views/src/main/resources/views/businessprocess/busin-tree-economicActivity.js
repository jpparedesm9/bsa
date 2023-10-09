(function () {
    'use strict';
	
	var app = cobis.createModule("businessprocess", ["oc.lazyLoad","businessprocess", 'ui.bootstrap', "designerModule", "ngResource"],['DSGNR', "businessprocess"]);

    app.config(function ($routeProvider, $ocLazyLoadProvider) {
        $routeProvider.when("/businessprocess", {
            templateUrl: "${contextPath}/cobis/web/views/economicActivity/templates/busin-tree-economicActivity-tpl.html"
        }).otherwise({
            redirectTo: "/economicActivity"
        });
    });
    
}());