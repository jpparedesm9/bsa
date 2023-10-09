    //Start signature to callBack event to VC_ITCII49_TNYFM_899
    task.initDataCallback.VC_ITCII49_TNYFM_899 = function (entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        if (parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.NoHeader) { //en el caso que venga generico

        } else {
            task.loadTaskHeader(entities, initDataEventArgs);
        }
        task.validatePrints(entities, initDataEventArgs);
    };
