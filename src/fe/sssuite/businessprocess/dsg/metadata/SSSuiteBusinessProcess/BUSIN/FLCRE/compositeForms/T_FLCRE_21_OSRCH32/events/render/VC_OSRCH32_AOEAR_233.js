//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: OperationSearch
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
        var columns = ['IdOperation', 'RefinancingOption', 'IsBase', 'oficialOperation','Rate','InternalCustomerClassification','Payment','CreditType'];
		BUSIN.API.GRID.hideColumns('QV_ITRIC1523_25', columns, renderEventArgs.commons.api);
		
   	 	var columns = ['OperationBank','CurrencyOperation','Balance','LocalCurrencyBalance','OriginalAmount','LocalCurrencyAmount','CreditType','InternalCustomerClassification',
    	            'DateGranting','IdOperation','RefinancingOption','IsBase','Rate','ExpirationDate','State','TypeOperation'];
    	BUSIN.API.GRID.addColumnsStyle('QV_ITRIC1523_25', 'Grid-Column-Header',renderEventArgs.commons.api,columns);
    	
    	//Se define el tamaño de la columna
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'OperationBank', 110);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'CurrencyOperation', 100);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'Balance', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'LocalCurrencyBalance', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'OriginalAmount', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'LocalCurrencyAmount', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'CreditType', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'InternalCustomerClassification', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'DateGranting', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'IdOperation', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'RefinancingOption', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'IsBase', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'Rate', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'ExpirationDate', 90);
    	renderEventArgs.commons.api.grid.resizeGridColumn('QV_ITRIC1523_25', 'State', 90);
    	
    };