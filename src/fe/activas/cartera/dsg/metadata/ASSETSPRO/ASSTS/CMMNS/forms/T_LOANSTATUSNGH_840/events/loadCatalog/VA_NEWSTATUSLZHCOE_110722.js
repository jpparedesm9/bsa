//Entity: Loan
    //Loan.newStatus (ComboBox) View: LoanStatusChangeForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_NEWSTATUSLZHCOE_110722 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
		loadCatalogDataEventArgs.commons.api.vc.parentVc.customDialogParameters.otherParam = {OPERATIONTYPEID:loadCatalogDataEventArgs.commons.api.vc.model.Loan.operationTypeID,STATUS:loadCatalogDataEventArgs.commons.api.vc.model.Loan.status}
		
		//loadCatalogDataEventArgs.commons.api.vc.model Object {Entity4: Object}
    };