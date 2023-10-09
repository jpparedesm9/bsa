// (Button) 
    task.executeCommand.CM_ANTTS25CAC75 = function (entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var nav = executeCommandEventArgs.commons.api.navigation;
        nav.closeModal({});

    };