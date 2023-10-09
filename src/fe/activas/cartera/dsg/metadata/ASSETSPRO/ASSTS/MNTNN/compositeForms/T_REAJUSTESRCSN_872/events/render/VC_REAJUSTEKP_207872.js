//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: REAJUSTE
    task.render = function (entities, renderEventArgs){
        try {
            ASSETS.Header. setDataStyle ("VC_REAJUSTEKP_207872", "VC_VPRGARGERZ_116872", entities, renderEventArgs);
    	} catch(err) {
            ASSETS.Utils.managerException(err);
        }  
    };