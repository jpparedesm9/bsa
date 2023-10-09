//Entity: EntidadInfo
    //EntidadInfo.sector (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_SETO998 = function(entities, changedEventArgs) {
        //SMO validar el if no existe en el servidor
		if (changedEventArgs.newValue !== undefined && changedEventArgs.newValue != entities.EntidadInfo.sector){
		entities.EntidadInfo.destinoEconomico="";
		entities.EntidadInfo.destinoFinanciero="";
		entities.EntidadInfo.otroDestino="";
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.serverParameters.EntidadInfo = true;
        changedEventArgs.commons.serverParameters.generalData = true;
		}
    };