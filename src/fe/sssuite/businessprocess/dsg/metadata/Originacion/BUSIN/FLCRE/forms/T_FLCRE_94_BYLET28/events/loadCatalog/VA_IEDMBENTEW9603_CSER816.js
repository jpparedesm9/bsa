//Entity: CustomerSearch
    //CustomerSearch.Customer (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEDMBENTEW9603_CSER816 = function(loadCatalogDataEventArgs) {
        var data=loadCatalogDataEventArgs.commons.api.vc.customDialogParameters.customerSearch;
		var customerCatalog=[];
		for(var i =0; i<data.length;i++){
			customerCatalog[i]= {code:data[i].Customer, value:data[i].Customer};
		}		
		loadCatalogDataEventArgs.commons.execServer = false;
		return customerCatalog;
        //loadCatalogDataEventArgs.commons.serverParameters.CustomerSearch = true;
    };