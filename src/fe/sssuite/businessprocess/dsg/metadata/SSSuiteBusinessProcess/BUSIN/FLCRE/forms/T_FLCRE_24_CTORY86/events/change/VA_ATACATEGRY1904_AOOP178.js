//Entity: CategoryReadjustment
    //CategoryReadjustment.AmountToApply (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1904_AOOP178 = function( entities, changedEventArgs ) {
         changedEventArgs.commons.execServer = true;
		 changedEventArgs.commons.serverParameters.Category = true;
         changedEventArgs.commons.serverParameters.CategoryReadjustment = true;        
    };