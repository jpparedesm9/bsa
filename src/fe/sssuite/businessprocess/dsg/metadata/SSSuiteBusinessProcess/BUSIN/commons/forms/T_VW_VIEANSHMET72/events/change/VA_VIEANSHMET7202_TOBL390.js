//Entity: HeaderPunishment
    //HeaderPunishment.Trouble (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VIEANSHMET7202_TOBL390 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.ValidateImpossibilityDescription(entities, changedEventArgs);
    };