//Entity: CategoryReadjustment
    //CategoryReadjustment.Spread (TextInputBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1904_SPED624 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.calculateValor(entities.CategoryReadjustment);        
    };