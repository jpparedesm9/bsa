//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ApplyClause
    task.render = function (entities, renderEventArgs){
         renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_APPLYCLASS_521533","VC_ZFLEAUPGRQ_436533",entities, renderEventArgs); 
                 
        ASSETS.Amortization.showTableAmortization(entities, renderEventArgs);
        
        ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
        ASSETS.Amortization.resizeGrid("QV_8237_80795");
        
    };