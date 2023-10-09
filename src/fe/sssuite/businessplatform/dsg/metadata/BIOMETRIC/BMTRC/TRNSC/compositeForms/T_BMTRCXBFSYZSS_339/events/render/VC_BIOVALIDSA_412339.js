//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: BioValidationComposite
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;            
        var api = renderEventArgs.commons.api;
        
        if (entities.Credit.productType == 'REVOLVENTE'){
            api.grid.hideColumn ('QV_6806_82610', 'role');    
        }
        
    };