//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: PaymentsMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
        var cancelModal = false;

        if (onCloseModalEventArgs.closedViewContainerId == "VC_LEFTOVERPM_168459") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.paymentType != "undefined") {
                entities.LeftOverPayment.paymentType = onCloseModalEventArgs.result.paymentType;
                entities.LeftOverPayment.value = onCloseModalEventArgs.result.value;
                entities.LeftOverPayment.currencyType = onCloseModalEventArgs.result.currencyType;
                entities.LeftOverPayment.reference = onCloseModalEventArgs.result.reference;
                entities.LeftOverPayment.note = onCloseModalEventArgs.result.note;
                entities.LeftOverPayment.leftoverQuotationValue = onCloseModalEventArgs.result.leftoverQuotationValue;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_PRIORITIOM_989489") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.data !== "undefined") {
                entities.Priorities = onCloseModalEventArgs.result.data;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_CONDONATON_778532") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.data !== "undefined") {
                entities.CondonationDetail = onCloseModalEventArgs.result.data;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_NEGOTIATOO_775700") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                cancelModal = onCloseModalEventArgs.result;
            }
            if (!cancelModal && typeof onCloseModalEventArgs.result.paymentType !== "undefined") {
                entities.Negotiation.paymentType = onCloseModalEventArgs.result.paymentType;
                entities.Negotiation.interestType = onCloseModalEventArgs.result.interestType;
                entities.Negotiation.fullFee = onCloseModalEventArgs.result.fullFee;
                entities.Negotiation.additionalPayments = onCloseModalEventArgs.result.additionalPayments;
                entities.Payment.entireFee = onCloseModalEventArgs.result.fullFee ? 'S' : 'N';
                entities.Payment.advance = onCloseModalEventArgs.result.additionalPayments ? 'S' : 'N';
                onCloseModalEventArgs.commons.execServer = true;
            }
        }
        
        if (onCloseModalEventArgs.closedViewContainerId == "VC_BANKACCOTT_940944") {
            if (typeof onCloseModalEventArgs.result.account != "undefined") {
                entities.Payment.reference = onCloseModalEventArgs.result.account.trimRight();
                entities.Payment.note = onCloseModalEventArgs.result.accountName.trimRight();
            }
        }
    };