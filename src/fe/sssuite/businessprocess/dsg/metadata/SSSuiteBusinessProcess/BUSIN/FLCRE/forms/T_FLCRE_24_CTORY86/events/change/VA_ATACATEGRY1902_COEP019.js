//Entity: Category
    //Category.Concept (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_COEP019 = function( entities, changedEventArgs ) {
		 changedEventArgs.commons.execServer = true;
         changedEventArgs.commons.api.vc.serverParameters.Category = true;
		 changedEventArgs.commons.api.vc.serverParameters.CategoryReadjustment = true;
		 changedEventArgs.commons.api.vc.serverParameters.PaymentPlanHeader = true;
        
    };