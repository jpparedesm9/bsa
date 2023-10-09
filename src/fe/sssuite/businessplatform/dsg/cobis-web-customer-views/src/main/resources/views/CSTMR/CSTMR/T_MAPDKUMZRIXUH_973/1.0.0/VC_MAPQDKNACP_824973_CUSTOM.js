/* variables locales de T_MAPDKUMZRIXUH_973*/
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

    
        var task = designerEvents.api.mapform;
    

    //"TaskId": "T_MAPDKUMZRIXUH_973"


    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: MapForm
    task.initData.VC_MAPQDKNACP_824973 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var nav = initDataEventArgs.commons.api.navigation;
        nav.customAddress = {
            id: "upload",
            url: "/CSTMR/CSTMR/T_MAPDKUMZRIXUH_973/1.0.0/consumo.html",
            useMinification: false
        };
        nav.registerCustomView('G_MAPJMEXDHW_492945');
    };



}));