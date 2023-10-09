//"TaskId": "T_BSSNSKNPPLXIB_479"
var openFindCustomer = function (eventArgs) {
    var nav = eventArgs.commons.api.navigation;
    nav.label = cobis.translate('BSSNS.LBL_BSSNS_BSQUEDASL_68505');
    nav.customAddress = {
        id: "findCustomer",
        url: "/customer/templates/find-customers-tpl.html",
        module: "customer",
        useMinification: false
    };
    nav.scripts = {
        module: cobis.modules.CUSTOMER,
        files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.customDialogParameters = {
    };
    nav.openCustomModalWindow('findCustomer');

};

var callManualForm = function (eventArgs, customerId, groupId) {
    var nav = eventArgs.commons.api.navigation;
	var task = eventArgs.commons.api.vc.parentVc.model.InboxContainerPage.Task;
	var processInstance = eventArgs.commons.api.vc.parentVc.model.Task.processInstanceIdentifier;
    nav.customAddress = {
        id: "GeneralBusinessInformation",
        url: "/BSSNS/manual/GeneralBusinessInformation.html",
        module: "customer",
        useMinification: false
    };
    nav.scripts = {
        module: cobis.modules.CUSTOMER,
        files: ['/BSSNS/manual/controller/controler.js', '/BSSNS/manual/directives/PrincipalDirective.js', '/BSSNS/manual/services/business-customer-srv.js']
    };
    nav.customDialogParameters = {
        customerId: customerId,
        taskHeader: (angular.isDefined(nav.customDialogParameters.taskHeader) && nav.customDialogParameters.taskHeader !== null) ? taskHeader : {},
		task:		task,
		processInstance:processInstance
    };
    nav.registerCustomView(groupId);
}