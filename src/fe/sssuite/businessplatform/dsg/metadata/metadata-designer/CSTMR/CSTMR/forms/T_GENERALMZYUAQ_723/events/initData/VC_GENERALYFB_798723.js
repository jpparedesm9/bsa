//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: GeneralForm
    task.initData.VC_GENERALYFB_798723 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.Person.typePerson ="P"
    };