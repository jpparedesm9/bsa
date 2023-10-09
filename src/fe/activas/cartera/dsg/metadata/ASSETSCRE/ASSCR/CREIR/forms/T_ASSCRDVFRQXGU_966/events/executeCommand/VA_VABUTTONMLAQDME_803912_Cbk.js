//Start signature to Callback event to VA_VABUTTONMLAQDME_803912
task.executeCommandCallback.VA_VABUTTONMLAQDME_803912 = function (entities, executeCommandCallbackEventArgs) {

    clienteId = entities.LoginCallCenter.idCliente;

    if (executeCommandCallbackEventArgs.succes == false) {
        clienteId = 0;
        executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONPDDCALJ_814912');

    }
    if (executeCommandCallbackEventArgs.succes == true) {
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONPDDCALJ_814912');


    }

    if (clienteId != null) {
        filtro = {
            clientCode: clienteId
        };


        // Se envia el filtro dentro al refrescar el grid
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_54056', filtro);
        //executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_54056');

    }




};
