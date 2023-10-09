//CustomerTransferRequestQuery Entity: 
task.executeQuery.Q_CUSTOMNS_9850 = function (executeQueryEventArgs) {
    executeQueryEventArgs.commons.execServer = false;
    if (executeQueryEventArgs.commons.api.vc.model.CustomerTransferRequest.data().length === 0) {
        executeQueryEventArgs.commons.api.vc.parentVc = {};
    }

    if (executeQueryEventArgs.parameters.officeId != null && executeQueryEventArgs.parameters.officeId != null) {
        executeQueryEventArgs.commons.execServer = true;
        executeQueryEventArgs.commons.api.grid.setAppendRecordsParams('QV_9850_34524', ['customerId'], executeQueryEventArgs);
    }
};