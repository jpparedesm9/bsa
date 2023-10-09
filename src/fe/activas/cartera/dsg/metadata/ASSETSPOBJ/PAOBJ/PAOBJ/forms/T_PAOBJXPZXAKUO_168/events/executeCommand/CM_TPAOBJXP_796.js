// (Button) 
    task.executeCommand.CM_TPAOBJXP_796 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var index = cobis.container.tabs.getCurrentTabIndex();
        cobis.container.tabs.removeTab(index);
    };