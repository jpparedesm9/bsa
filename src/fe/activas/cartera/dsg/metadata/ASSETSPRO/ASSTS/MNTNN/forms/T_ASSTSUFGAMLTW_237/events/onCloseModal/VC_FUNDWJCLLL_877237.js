//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: Fund
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        var grid = onCloseModalEventArgs.commons.api.grid;
        grid.refresh('QV_8975_37395'); 
    };