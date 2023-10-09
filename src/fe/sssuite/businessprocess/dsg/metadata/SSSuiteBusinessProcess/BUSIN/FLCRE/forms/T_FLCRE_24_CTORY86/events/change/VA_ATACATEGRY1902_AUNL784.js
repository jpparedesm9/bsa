//Entity: Category
    //Category.AmounToApply (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_AUNL784 = function( entities, changedEventArgs ) {
		var nuevoValueAplicar=changedEventArgs.newValue;
		//task.cleanFields(entities);
		var viewState=changedEventArgs.commons.api.viewState;
	     changedEventArgs.commons.execServer = true;
         changedEventArgs.commons.api.vc.serverParameters.Category = true;	
        
    };