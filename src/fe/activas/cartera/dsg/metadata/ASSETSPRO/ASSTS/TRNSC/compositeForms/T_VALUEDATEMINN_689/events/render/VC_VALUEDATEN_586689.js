//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ValueDateMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_VALUEDATEN_586689","VC_DNIIMAEAVR_174689",entities, renderEventArgs);
    };