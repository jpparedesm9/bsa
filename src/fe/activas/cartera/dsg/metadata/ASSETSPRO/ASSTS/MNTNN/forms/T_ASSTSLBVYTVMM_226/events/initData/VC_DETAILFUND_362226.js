//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DetailFund
    task.initData.VC_DETAILFUND_362226 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        var viewState = initDataEventArgs.commons.api.viewState;
        var Fund = entities.Fund;
        if (Fund.fundId!= undefined && Fund.fundId!=0){
            viewState.disable('Spacer1378', true);
            viewState.disable('VA_9399ORKREIOLNBV_331140', true);
        }else{
            Fund.statusCode = 'V';
            viewState.disable('VA_STATUSCODEVOWGL_831140', true);
            
        }
            
    };