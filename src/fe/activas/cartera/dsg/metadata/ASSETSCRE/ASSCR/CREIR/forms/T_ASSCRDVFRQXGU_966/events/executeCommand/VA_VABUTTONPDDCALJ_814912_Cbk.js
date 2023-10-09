//Start signature to Callback event to VA_VABUTTONPDDCALJ_814912
task.executeCommandCallback.VA_VABUTTONPDDCALJ_814912 = function (entities, executeCommandCallbackEventArgs) {
    //here your code


    if (entities.QuestionValidation.corretValidation === 'S') {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_RESPUESTT_28632', '', 3000, false);
        console.log('Se verifico con sin exito si es S');

        // Se envía la información a la página padre.
        var result = { codigoCliente: entities.LoginCallCenter.idCliente,
                       nameClient: customerName};
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
    }


    if (entities.QuestionValidation.msmValidation != '--') {
        var msnValidation = entities.QuestionValidation.msmValidation;
        executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError(msnValidation + '', true);
        //executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess(msnValidation, '', 20000, false);
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_54056', filtro);

    }

};