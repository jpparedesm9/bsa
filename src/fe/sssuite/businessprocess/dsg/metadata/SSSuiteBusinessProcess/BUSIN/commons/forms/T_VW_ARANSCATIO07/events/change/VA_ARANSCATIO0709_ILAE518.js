//Entity: WarrantyGeneral
    //WarrantyGeneral.initialValue (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0709_ILAE518 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        var api = changedEventArgs.commons.api;
        api.vc.model.WarrantyGeneral.currentValue = api.vc.model.WarrantyGeneral.initialValue;
    };