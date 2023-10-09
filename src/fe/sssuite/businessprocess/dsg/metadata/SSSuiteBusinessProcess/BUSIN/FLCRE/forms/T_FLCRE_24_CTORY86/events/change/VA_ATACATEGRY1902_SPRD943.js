//Entity: Category
    //Category.Spread (TextInputBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_SPRD943 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;		
		task.calculateValor(entities.Category);
        
    };