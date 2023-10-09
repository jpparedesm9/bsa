//Entity: CustomerReference
    //CustomerReference.Result (CheckBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_USTMRENCVW3903_0000448 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
         changedEventArgs.commons.api.vc.serverParameters.CustomerReference = true;
    };