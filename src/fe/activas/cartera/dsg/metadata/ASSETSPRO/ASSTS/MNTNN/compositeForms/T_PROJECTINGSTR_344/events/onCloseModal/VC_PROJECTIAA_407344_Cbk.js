//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: OtherCharges
    task.onCloseModalEventCallback = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };