//LoanQuery_3009 Entity: 
    task.executeQuery.Q_LOANDPQM_3009 = function(executeQueryEventArgs){
        var executeServer = true;
    var transactNumber = executeQueryEventArgs.commons.api.vc.model.LoanSearchFilter.numProcedures;
    var clientCode = parseInt(executeQueryEventArgs.commons.api.vc.model.LoanSearchFilter.numIdentification);
    if (transactNumber > 2147483647) {
        executeServer = false;
    } else {
        if (!isNaN(clientCode)) {
            if (clientCode > 2147483647) {
                executeServer = false;
            }
        }
    }
    
    if (queryString.menu == ASSETS.Constants.MENU_DISBUSMNT) {
        executeQueryEventArgs.parameters.isDisbursment = 'S';
    } else {
        executeQueryEventArgs.parameters.isDisbursment = 'N';
    }
     executeQueryEventArgs.parameters.groupSummary = executeQueryEventArgs.commons.api.vc.model.LoanSearchFilter.groupSummary;
    executeQueryEventArgs.parameters.category = queryString.category;
    executeQueryEventArgs.parameters.group = isGroup;
    executeQueryEventArgs.parameters.paymentType = queryString.type;
    executeQueryEventArgs.commons.execServer = executeServer;
};