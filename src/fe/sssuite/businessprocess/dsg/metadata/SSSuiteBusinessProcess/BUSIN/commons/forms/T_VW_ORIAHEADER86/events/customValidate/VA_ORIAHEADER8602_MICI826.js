//Entity: OriginalHeader
    //OriginalHeader.AmountAprobed (TextInputBox) View: T_HeaderView
    
    task.customValidate.VA_ORIAHEADER8602_MICI826 = function(entities, customValidateEventArgs) {
    	
    	var parentParameters = customValidateEventArgs.commons.api.parentVc.customDialogParameters;
    	customValidateEventArgs.isValid = true;
    	
    	// Valida que la suma de los saldos de las operaciones sean mayores al
		// nuevo valor de la renovacion
    	/*if (parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Renovation) {
        	if (entities.OriginalHeader.AmountAprobed < entities.OriginalHeader.AmountCalculated) {
        		customValidateEventArgs.errorMessage='El valor de renovacion debe ser mayor o igual a ' + entities.OriginalHeader.AmountCalculated;
                customValidateEventArgs.isValid = false;
			}
		}*/
        //SMO modificado en grupales
        if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation) {

        var sumSaldo = 0;

        for (var i = 0; i < entities.RefinancingOperations.data().length; i++) {
            sumSaldo = sumSaldo + entities.RefinancingOperations.data()[i].Balance;
        }
        if (entities.OriginalHeader.AmountAprobed < sumSaldo) {
            customValidateEventArgs.errorMessage = 'El valor de renovacion debe ser mayor o igual a ' + sumSaldo;
            customValidateEventArgs.isValid = false;
        }
    }
        
    };