//Entity: CategoryReadjustment
    //CategoryReadjustment.Sign (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1904_SIGN273 = function( entities, changedEventArgs ) {
         changedEventArgs.commons.execServer = false;
        task.calculateValor(entities.CategoryReadjustment);        
    };