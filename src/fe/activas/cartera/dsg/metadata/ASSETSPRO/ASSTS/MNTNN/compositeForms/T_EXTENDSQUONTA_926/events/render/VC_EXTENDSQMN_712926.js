//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ExtendsQuotaFormMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle ("VC_EXTENDSQMN_712926", "VC_DFZRKBDHHZ_908926", entities, renderEventArgs);
    	 
        
    };