//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: OtherCharges
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        onCloseModalEventArgs.commons.api.grid.refresh("QV_8396_63374",{"instancia":entities.LoanInstancia.idInstancia});
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
    };