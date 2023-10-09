(function () {
	'use strict';
	var app = cobis.createModule(cobis.modules.CUSTOMER, [cobis.modules.CONTAINER, "designerModule"]);

	app.config(function ($routeProvider) {
		$routeProvider.when("/find-customers", {
			templateUrl: "${contextPath}/cobis/web/views/customer/templates/find-customers-tpl.html"
		}).otherwise({
			redirectTo: "/find-customers"
		});
	});
}());