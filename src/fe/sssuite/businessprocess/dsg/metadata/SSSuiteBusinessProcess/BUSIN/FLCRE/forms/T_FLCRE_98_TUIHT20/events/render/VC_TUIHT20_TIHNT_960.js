//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: [object Object]
    task.render = function (entities, renderEventArgs){
        var viewState =renderEventArgs.commons.api.viewState;
       var ctr = ['Operation','DescriptionClient','Bank','OperationStatus','CapitalBalance','InterestBalance','MoraBalance','OtherBalance','LastPaymentDate','MoraDay','OperationType'];
		BUSIN.API.GRID.addColumnsStyle('QV_URPUH4848_33', 'Grid-Column-Header',renderEventArgs.commons.api,ctr);
        renderEventArgs.commons.execServer = false;
        
        var ctrsToHide = ['CM_TFLCRE_9_98R'];//boton escondido para lanzar evento a callback
		BUSIN.API.hide(viewState,ctrsToHide);
    };