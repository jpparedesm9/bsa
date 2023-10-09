//beforeOpenGridDialog QueryView: QV_2706_18706
    //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente.
    task.beforeOpenGridDialog.QV_2706_18706 = function (entities, beforeOpenGridDialogEventArgs) {
        beforeOpenGridDialogEventArgs.commons.execServer = false;
        
    };