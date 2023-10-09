//gridBeforeEnterInLineRow QueryView: Borrowers
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { // BeforeEnterLine
																												// QueryView:
																												// Borrowers
        var parentParameters = gridABeforeEnterInLineRowEventArgs.commons.api.parentVc.customDialogParameters;
		//Habilitar el campo rol para permitir seleccionar el deudor principal de la operacion
		if (entities.generalData.enableDebtorRole && ( parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation ||
		    parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration)){
			gridABeforeEnterInLineRowEventArgs.commons.api.grid.enabledColumn('QV_BOREG0798_55', 'Role');
		} else {
			gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Role');
		}
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        FLCRE.VARIABLES.Debtor.Role = gridABeforeEnterInLineRowEventArgs.rowData.Role;
        var deleteNewRow =false;
        if (gridABeforeEnterInLineRowEventArgs.rowData.CustomerCode == 0){
        	FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{},deleteNewRow);
        }
    };