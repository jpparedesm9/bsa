(function () {
    'use strict';
    //var app = cobis.createModule(cobis.modules.ADMCLIENTVIEWER, [cobis.modules.CONTAINER, 'ui.bootstrap']);
	var app = cobis.createModule(cobis.modules.ADMCLIENTVIEWER, ["oc.lazyLoad",cobis.modules.ADMCLIENTVIEWER, 'ui.bootstrap', "designerModule", "ngResource"],['DSGNR', cobis.modules.ADMCLIENTVIEWER]);
    
    app.config(function ($routeProvider) {
        $routeProvider.when("/adminclientviewer", {	
            templateUrl: "${contextPath}/cobis/web/views/admin-clientviewer/templates/admin-client-viewer-tpl.html"	
        }).when("/agregarRol", {
            templateUrl: "${contextPath}/cobis/web/views/admin-clientviewer/templates/add-rol-tpl.html"
        }).otherwise({
            redirectTo: "/adminclientviewer"	
        });
    });
}());