//Start signature to callBack event to CM_TTYPERAT_R0N
    task.executeCommandCallback.CM_TTYPERAT_R0N = function(entities, executeCommandEventArgs) {
        //here your code
        var aceptButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(aceptButton);
    };