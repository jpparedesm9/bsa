//Entity: Category
    //Category.Sign (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_SIGN784 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.calculateValor(entities.Category);
        
    };