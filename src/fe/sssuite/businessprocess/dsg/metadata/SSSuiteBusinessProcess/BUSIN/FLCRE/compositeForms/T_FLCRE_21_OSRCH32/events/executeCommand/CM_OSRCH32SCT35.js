//select (Button)
    task.executeCommand.CM_OSRCH32SCT35 = function(entities, executeCommandEventArgs) {
    	
    	executeCommandEventArgs.commons.execServer = false;

    	//Entidades Temporales
    	entities.Operations ={};
    	entities.GeneralParameters = {};
    	entities.SelectedOperations = [];
    	entities.Debtors = [];
    	
    	executeCommandEventArgs.commons.serverParameters.Debtors = true;
    	executeCommandEventArgs.commons.serverParameters.Operations = true;
    	executeCommandEventArgs.commons.serverParameters.GeneralParameters = true;
    	executeCommandEventArgs.commons.serverParameters.SelectedOperations = true;
    	
    	//Recupero parametros desde la vc padre
		var customDialogParameters = executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters();
		if (customDialogParameters!=null) {
			entities.Operations =  customDialogParameters.operations;
			entities.GeneralParameters = customDialogParameters.generalParameters;
		}
    	
    	//Recupero las filas seleccionadas del grid y las almaceno en la entidad temporal
    	var rows = executeCommandEventArgs.commons.api.grid.getSelectedRows('QV_ITRIC1523_25');
    	if (rows!=null && rows.length>0) {
			for(var j = 0; j < rows.length; j++){
				rows[j].checkRule = false;
				entities.SelectedOperations.push(rows[j]);
			}
			executeCommandEventArgs.commons.execServer = true;
		}else {
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ELCNEUNAR_05370',null,5000);
		}
    };