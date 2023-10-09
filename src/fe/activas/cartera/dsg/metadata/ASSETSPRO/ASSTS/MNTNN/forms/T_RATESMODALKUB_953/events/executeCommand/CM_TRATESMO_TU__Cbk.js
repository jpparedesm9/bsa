//Start signature to callBack event to CM_TRATESMO_TU_
    task.executeCommandCallback.CM_TRATESMO_TU_ = function(entities, executeCommandEventArgs) {
        //here your code
        var aceptButton = true;
        executeCommandEventArgs.commons.api.navigation.closeModal(aceptButton);
    };