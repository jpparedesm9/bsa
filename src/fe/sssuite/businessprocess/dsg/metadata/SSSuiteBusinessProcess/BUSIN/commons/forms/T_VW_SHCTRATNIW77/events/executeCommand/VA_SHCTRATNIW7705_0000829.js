//Entity: SearchCriteriaPrintingDocuments
    //SearchCriteriaPrintingDocuments. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_SHCTRATNIW7705_0000829 = function(  entities, executeCommandEventArgs ) {
        // executeCommandEventArgs.commons.execServer = false;
		 executeCommandEventArgs.commons.api.grid.resizeGridColumn('QV_ERPLI1480_97', 'PrincipalDebtor',260);
	//	executeCommandEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'Official'); 
		if( (entities.SearchCriteriaPrintingDocuments.CustomerId != null && entities.SearchCriteriaPrintingDocuments.CustomerId != ""  )|| (entities.SearchCriteriaPrintingDocuments.FlowType != null && entities.SearchCriteriaPrintingDocuments.FlowType != ""  )|| (entities.SearchCriteriaPrintingDocuments.IdApplication != null && entities.SearchCriteriaPrintingDocuments.IdApplication != "" )
			|| (entities.SearchCriteriaPrintingDocuments.alternateCode != null && entities.SearchCriteriaPrintingDocuments.alternateCode != ""  )){
			executeCommandEventArgs.commons.execServer = true;
		}else{		
			executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_YMTNTEREI_83156');
			executeCommandEventArgs.commons.execServer = false;
		}
        executeCommandEventArgs.commons.api.grid.removeAllRows('DocumentProduct');        
    };