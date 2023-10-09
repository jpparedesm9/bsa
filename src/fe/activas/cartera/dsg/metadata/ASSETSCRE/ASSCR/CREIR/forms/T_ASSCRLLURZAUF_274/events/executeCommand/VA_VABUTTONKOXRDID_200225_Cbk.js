//Start signature to Callback event to VA_VABUTTONKOXRDID_200225
task.executeCommandCallback.VA_VABUTTONKOXRDID_200225 = function (entities, executeCommandCallbackEventArgs) {
    //here your code}

    console.log(codClienteReset);

    if (executeCommandCallbackEventArgs.success == true) {

        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_RESETEOAF_14457', '', 3000, false);
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONKOXRDID_200225');


    } else {
        console.log("ingreso si hay error")
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONKOXRDID_200225');
    }







};
