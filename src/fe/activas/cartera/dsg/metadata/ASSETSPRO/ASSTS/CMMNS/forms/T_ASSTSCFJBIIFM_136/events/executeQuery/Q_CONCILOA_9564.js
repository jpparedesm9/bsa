//ConciliationSearchQuery Entity: 
task.executeQuery.Q_CONCILOA_9564 = function (executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = false;
    executeQueryEventArgs.parameters.customerCode = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode;
    if (executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode == null) {
        executeQueryEventArgs.parameters.customerType = null;
    } else if (typeof executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode == 'string' && executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerCode.trim() == "") {
        executeQueryEventArgs.parameters.customerType = null;
    } else {
        executeQueryEventArgs.parameters.customerType = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.customerType;
    }
    executeQueryEventArgs.parameters.amount = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.amount;
    executeQueryEventArgs.parameters.dateFrom = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.dateFrom;
    executeQueryEventArgs.parameters.type = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.type;
    executeQueryEventArgs.parameters.notConciliationReason = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.notConciliationReason;
    executeQueryEventArgs.parameters.conciliationStatus = executeQueryEventArgs.commons.api.vc.model.ConciliationSearchFilter.conciliationStatus;
};