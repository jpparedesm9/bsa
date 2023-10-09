// (Button) 
task.executeCommand.CM_TECONOMI_RSP = function(entities, executeCommandEventArgs) {
    var d = new Date();
    /* Seteando valores para campos no usados en Santander */
    entities.EconomicActivity.authorized = 'S';
    entities.EconomicActivity.startdateActivity = '';
    entities.EconomicActivity.startdateActivity = d.getDate();
    entities.EconomicActivity.environment = '';
    entities.EconomicActivity.propertyType = 'N/A';
    entities.EconomicActivity.antiquity = 0;
    entities.EconomicActivity.affiliate = '';
    entities.EconomicActivity.placeAffiliation = '';
    entities.EconomicActivity.affiliate = 'S';
    
    executeCommandEventArgs.commons.execServer = true;
    var dataOk = true;
    dataOk = task.validateEconomicActivityData(entities.EconomicActivity);
    if (!dataOk) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError(msgIDResourse,true);
        executeCommandEventArgs.commons.execServer = false;
    }
    //executeCommandEventArgs.commons.serverParameters.entityName = true;
};