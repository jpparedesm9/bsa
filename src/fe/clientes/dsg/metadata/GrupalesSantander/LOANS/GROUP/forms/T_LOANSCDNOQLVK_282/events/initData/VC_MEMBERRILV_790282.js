//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: MemberRiskLevelForm
    task.initData.VC_MEMBERRILV_790282 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var nav = initDataEventArgs.commons.api.navigation;
        openFindCustomer(nav);
        
    };