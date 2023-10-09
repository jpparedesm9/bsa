//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DemographicForm
    task.initData.VC_DEMOGRAPIH_678186 = function (entities, initDataEventArgs){
        // Campos del Cliente
        var client = initDataEventArgs.commons.api.parentVc.model.Task;

        if (client !== 'undefined')
        {
            
        }
            
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };