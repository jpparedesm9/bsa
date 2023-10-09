//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments.CustomerId (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_SHCTRATNIW7705_SMID298 = function( textInputButtonEventArgs ) {
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
										//"/customer/services/find-program-srv.js",
										"/customer/controllers/find-customers-ctrl.js"]
		}];
		
		nav.customDialogParameters = {
		};
        
    };