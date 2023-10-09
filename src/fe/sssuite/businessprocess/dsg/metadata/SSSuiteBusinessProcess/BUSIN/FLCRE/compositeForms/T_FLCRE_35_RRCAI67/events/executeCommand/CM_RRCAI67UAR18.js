// (Button) Guardar
    task.executeCommand.CM_RRCAI67UAR18 = function(entities, executeCommandEventArgs) {
        var operation = "U";
        entities.generalData.isNew = true;
        if (task.validateBeforeSave(entities, executeCommandEventArgs, operation)) {            
            executeCommandEventArgs.commons.execServer = true;
        } else {
            executeCommandEventArgs.commons.execServer = false;
        }
        
    };