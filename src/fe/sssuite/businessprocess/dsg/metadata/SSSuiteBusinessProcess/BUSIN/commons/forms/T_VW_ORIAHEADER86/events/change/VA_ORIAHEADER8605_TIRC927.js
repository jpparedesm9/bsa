//Entity: EntidadInfo
    //EntidadInfo.tipoProducto (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_TIRC927 = function(entities, changedEventArgs) {
    	
    	changedEventArgs.commons.serverParameters.EntidadInfo = true;
    	changedEventArgs.commons.serverParameters.OriginalHeader = true;
    	changedEventArgs.commons.serverParameters.generalData = true;
    
		// Reinicio los valores del combo
		entities.OriginalHeader.CurrencyRequested="0";
		entities.EntidadInfo.destinoEconomico="";
		entities.EntidadInfo.destinoFinanciero="";
		entities.EntidadInfo.sector="";
    	
		changedEventArgs.commons.execServer = true;

    };