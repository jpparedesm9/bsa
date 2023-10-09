//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: LeftoverPaymentsModal
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if (onCloseModalEventArgs.closedViewContainerId == "VC_BANKACCOTT_940944") {
            if (typeof onCloseModalEventArgs.result.account != "undefined") {
                entities.LeftOverPayment.reference = onCloseModalEventArgs.result.account.trimRight();
                entities.LeftOverPayment.note = onCloseModalEventArgs.result.accountName.trimRight();
            }
        }
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
    };