//Evento validateTransaction : Permite validar los datos antes de cerrar la ventana modal / Permite validar los datos de una tarea antes de enviarlos a persistir
    //ViewContainer: ProspectComposite
    task.validateTransaction.VC_PROSPECTMI_213684 = function (entities, executeEventArgs){
               renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSRXH_631566', true);
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSLJO_139566', true);
   
        
    };