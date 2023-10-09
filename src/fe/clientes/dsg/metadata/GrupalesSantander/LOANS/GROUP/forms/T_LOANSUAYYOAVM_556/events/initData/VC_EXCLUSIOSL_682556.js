//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ExclusionList
    task.initData.VC_EXCLUSIOSL_682556 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.CustomerExclusionList.score= "E";
        //initDataEventArgs.commons.api.viewState.disable('VA_1DMKLRVJHUHQTTF_212111');
        
    };