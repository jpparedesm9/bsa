//gridCommand (Button) QueryView: GridRefinancingOperations
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_ITRIC1523_63_992 = function(entities, gridExecuteCommandEventArgs) {
    	var parentParameters = gridExecuteCommandEventArgs.commons.api.parentVc.customDialogParameters;
    	// Formo los objetos para enviar por parametro
    	var debtor = {};
    	var generalParameters = {};
    	var operations = [];
        
    	//Debtor
        for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
			if (entities.DebtorGeneral.data()[i].Role == 'D') {
				debtor = entities.DebtorGeneral.data()[i];
			}
		}
        
        //Operaciones
        for (var i = 0; i < entities.RefinancingOperations.data().length; i++) {
        	operations.push(entities.RefinancingOperations.data()[i]);
		}
        
        //Parametros Generales para evaluar la regla
        var task = gridExecuteCommandEventArgs.commons.api.parentVc.model.Task;
        generalParameters ={acronymRule : "VALPORREN",
        					idInstanceProcess : task.processInstanceIdentifier,
        					idAsigActividad : task.cobisAssignAct,
							enableSearchClients : entities.generalData.enableSearchClients,
							tramite: ((parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Reestructuration)? FLCRE.CONSTANTS.RequestName.Reestructuration:"")
							}
        
        // Abro modal
        var nav = FLCRE.API.getApiNavigation(gridExecuteCommandEventArgs,'T_FLCRE_21_OSRCH32','VC_OSRCH32_AOEAR_233');
        nav.label = cobis.translate('BUSIN.DLB_BUSIN_BQEEERCIE_19389');
        nav.modalProperties = { size: 'lg' };
        nav.queryParameters = { mode: gridExecuteCommandEventArgs.commons.constants.mode.Insert };
        nav.customDialogParameters = { operations: operations, debtor: debtor, generalParameters : generalParameters};       
        nav.openModalWindow(gridExecuteCommandEventArgs.commons.controlId);
        
        gridExecuteCommandEventArgs.commons.execServer = false;
        
    };