//Entity: GuaranteeSearchCriteria
    //GuaranteeSearchCriteria.Customer (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_WRRNTSEACH8505_CUOM537 = function(textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;

		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CTMESERCH_53064');
		nav.customAddress = {
						id: "findCustomer",
						url: "customer/templates/find-customers-tpl.html"
		};
		nav.modalProperties = {
						size: 'lg'
		};
		nav.scripts = [{
						module: cobis.modules.CUSTOMER,
						files: ["/customer/services/find-customers-srv.js",
										"/customer/controllers/find-customers-ctrl.js"]
		}];
		nav.customDialogParameters = {
		}; 
    };