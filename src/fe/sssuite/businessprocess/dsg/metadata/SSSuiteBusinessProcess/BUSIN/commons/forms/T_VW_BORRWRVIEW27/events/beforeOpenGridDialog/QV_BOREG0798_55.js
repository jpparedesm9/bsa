//beforeOpenGridDialog QueryView: Borrowers
        //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente.
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { // BeforeViewCreationCl
																									// QueryView:
																									// Borrowers
        //beforeOpenGridDialogEventArgs.commons.execServer = true;
        //SMO Cambio en grupales
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };