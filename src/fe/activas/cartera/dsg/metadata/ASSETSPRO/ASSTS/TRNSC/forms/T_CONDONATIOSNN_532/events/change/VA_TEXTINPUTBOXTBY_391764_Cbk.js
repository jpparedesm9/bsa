//Entity: CondonationDetail
    //CondonationDetail.percentage (TextInputBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.VA_TEXTINPUTBOXTBY_391764 = function(  entities, changedEventArgs ) {
        var selectedRow = changeCallbackEventArgs.commons.api.vc.grids.QV_7324_98967.selectedRow;
        
        selectedRow.set('valueToCondone', entities.ServerParameter.amount);
    };