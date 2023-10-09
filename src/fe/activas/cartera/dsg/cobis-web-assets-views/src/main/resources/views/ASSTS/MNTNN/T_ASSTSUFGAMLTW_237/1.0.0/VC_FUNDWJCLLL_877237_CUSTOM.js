/* variables locales de T_ASSTSUFGAMLTW_237*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.fund;
    

    //"TaskId": "T_ASSTSUFGAMLTW_237"


    //FundQuery Entity: 
    task.executeQuery.Q_FUNDQJFL_8975 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: Fund
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        var grid = onCloseModalEventArgs.commons.api.grid;
        grid.refresh('QV_8975_37395'); 
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: Fund
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.grid.refresh("QV_8975_37395",{param:{}});	
        
    };



}));