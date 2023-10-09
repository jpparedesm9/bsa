//MobileQuery Entity: 
task.executeQuery.Q_MOBILEVP_5973 = function (executeQueryEventArgs) {

    if ((executeQueryEventArgs.parameters.imei == null || executeQueryEventArgs.parameters.imei == "") && (executeQueryEventArgs.parameters.official == null || executeQueryEventArgs.parameters.official == "")) {
        executeQueryEventArgs.commons.messageHandler.showTranslateMessagesError('MBILE.MSG_MBILE_NOSEHAILD_62966');        
        executeQueryEventArgs.commons.execServer = false;
    } else {
        executeQueryEventArgs.commons.execServer = true;
    }

};