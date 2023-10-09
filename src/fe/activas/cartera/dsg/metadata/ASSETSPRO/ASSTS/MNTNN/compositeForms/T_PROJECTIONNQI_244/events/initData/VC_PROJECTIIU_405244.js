//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ProjectionQuotaFormMain
    task.initData.VC_PROJECTIIU_405244 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
    var api = initDataEventArgs.commons.api;
    var parameters = api.navigation.getCustomDialogParameters();
    entities.LoanInstancia = parameters.parameters.loanInstancia;
        
    };