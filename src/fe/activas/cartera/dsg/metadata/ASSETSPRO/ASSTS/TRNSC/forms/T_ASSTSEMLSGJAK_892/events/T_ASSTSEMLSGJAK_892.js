    task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            groupCode = args.commons.api.vc.dialogParameters.CodeReceive,
            groupName = args.commons.api.vc.dialogParameters.name,
            isGroup = 'S';
        args.model.GroupPaymentFilter.group = groupCode;
    };

    task.executeCommand.customComand = function (entities, args) {
        if (entities.GroupPayment.data().length > 0) {
            if (hasExpiredQuotas(entities.GroupPayment.data())) {
                args.commons.execServer = false;
				args.commons.api.viewState.hide('G_GROUPPAYMY_137946');
                args.commons.messageHandler.showMessagesInformation("ASSTS.LBL_ASSTS_ELGRUPOVC_74474", true);
            } else {
                args.commons.api.viewState.show('G_GROUPPAYMY_137946');
                args.commons.execServer = true;
            }
        } else {
            args.commons.api.viewState.hide('G_GROUPPAYMY_137946');
            args.commons.execServer = false;
        }
    };

    function getMaxValueAmountAllowed(entities) {
        if (entities.GroupPaymenInfo.totalAmount <= entities.GroupPaymenInfo.collateralBalance) {
            return entities.GroupPaymenInfo.totalAmount;
        }
        return entities.GroupPaymenInfo.collateralBalance;
    };

    function hasExpiredQuotas(dataGroupPayment) {
        var numberElementWithhasExpiredQuotas = 0;

        dataGroupPayment.forEach(function (groupPayment) {
            if (groupPayment.expiredQuotas === 0) {
                numberElementWithhasExpiredQuotas++;
            }
        });

        if (numberElementWithhasExpiredQuotas === dataGroupPayment.length) {
            return true;
        }
        return false;

    };