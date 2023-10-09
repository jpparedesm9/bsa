    task.AddCustomerCode = false;

	task.closeModalEvent.findCustomer = function (args) {
		var dialog = args.commons.api.vc.dialogParameters;
		var customer = args.commons.api.vc.model.CustomerSearch;
		customer.CustomerId = dialog.CodeReceive;
		if(dialog.commercialName !== ''){
			customer.Customer = dialog.commercialName;
		}
		else{
			customer.Customer = dialog.name;
		}
	};