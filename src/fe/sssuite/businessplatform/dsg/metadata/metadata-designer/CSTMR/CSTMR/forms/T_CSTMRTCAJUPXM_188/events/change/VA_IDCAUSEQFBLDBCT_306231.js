//Entity: TransferRequest
    //TransferRequest.idCause (ComboBox) View: TransferRequestForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IDCAUSEQFBLDBCT_306231 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
        if (entities.TransferRequest.idCause === "7")
            changedEventArgs.commons.api.viewState.show('VA_DESCRIPTIONCSAA_539231');
        else
            changedEventArgs.commons.api.viewState.hide('VA_DESCRIPTIONCSAA_539231');
        
    };