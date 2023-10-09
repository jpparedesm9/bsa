//Entity: CondonationDetail
    //CondonationDetail.concept (ComboBox) View: CondonationDetailForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.VA_TEXTINPUTBOXVSD_563764 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        selectedRow.set('valueToCondone', entities.ServerParameter.amount);
    };