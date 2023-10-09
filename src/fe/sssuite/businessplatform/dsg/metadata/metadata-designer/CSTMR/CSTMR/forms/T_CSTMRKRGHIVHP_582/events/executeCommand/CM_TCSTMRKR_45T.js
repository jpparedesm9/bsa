// (Button) 
    task.executeCommand.CM_TCSTMRKR_45T = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        entities.ReferenceReq.purchaseAmount = 0;
        task.cleanFields(entities,executeCommandEventArgs);
        var controls = ['VA_5608FDSMYIVCMKB_809945'];
        LATFO.UTILS.disableFields(executeCommandEventArgs, controls, false);
    };