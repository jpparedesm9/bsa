// (Button) 
    task.executeCommand.CM_TRATESMO_TU_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        
        if (entities.Rates.clase == 'F') {
            if (entities.Rates.referenceValue == '') {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBEIEI_21995",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
            if (entities.Rates.typePoints == '') {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_DEBESELNT_56184",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
            if (entities.Rates.numberDecimals == 0 || entities.Rates.numberDecimals == null) {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBEDVE_50014",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
            if (entities.Rates.signDefault == '' || entities.Rates.signMin == '' || entities.Rates.signMax == '') {
                executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_SEDEBENST_55237",true);
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
        }
        if (entities.Rates.portfolioClass == '') {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_LACLASESE_58190",true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        if (entities.Rates.lockedMin > entities.Rates.lockedMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_VALORMNIA_88442",true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        if (entities.Rates.lockedDefault < entities.Rates.lockedMin || entities.Rates.lockedDefault > entities.Rates.lockedMax) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_VALORESDA_30202",true);
            executeCommandEventArgs.commons.execServer = false;
            return;
        }
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };