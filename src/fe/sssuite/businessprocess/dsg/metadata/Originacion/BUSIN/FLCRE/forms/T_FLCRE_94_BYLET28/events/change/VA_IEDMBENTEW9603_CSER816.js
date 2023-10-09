//Entity: CustomerSearch
    //CustomerSearch.Customer (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEDMBENTEW9603_CSER816 = function(entities, changedEventArgs) {
		var data=changedEventArgs.commons.api.vc.customDialogParameters.customerSearch;
        var customerCode= changedEventArgs.newValue;
		for(var i =0; i<data.length;i++){
			if(data[i].Customer.trim()==customerCode.trim()){
				entities.CustomerSearch=data[i];
			}			
		}
		changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.serverParameters.CustomerSearch = true;
        changedEventArgs.commons.serverParameters.WarrantyGeneral = true;
    };