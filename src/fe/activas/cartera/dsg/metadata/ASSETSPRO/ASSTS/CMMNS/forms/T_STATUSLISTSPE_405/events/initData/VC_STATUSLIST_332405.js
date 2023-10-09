//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: StatusListForm
    task.initData.VC_STATUSLIST_332405 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var model=initDataEventArgs.commons.api.vc.model;
        model.Loan=initDataEventArgs.commons.api.parentVc.model.Loan;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };