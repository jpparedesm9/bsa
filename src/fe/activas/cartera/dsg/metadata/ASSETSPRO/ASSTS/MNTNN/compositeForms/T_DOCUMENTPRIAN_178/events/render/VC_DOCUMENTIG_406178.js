//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: DocumentPrintingMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_DOCUMENTIG_406178","VC_IYLYXGBWSN_401178",entities, renderEventArgs); 
    };