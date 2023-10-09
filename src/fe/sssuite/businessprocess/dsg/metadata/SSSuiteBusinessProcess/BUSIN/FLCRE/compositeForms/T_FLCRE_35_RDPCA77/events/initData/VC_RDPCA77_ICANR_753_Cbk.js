    //Start signature to callBack event to VC_RDPCA77_ICANR_753
    task.initDataCallback.VC_RDPCA77_ICANR_753 = function (entities, initDataEventArgs) {
        task.loadTaskHeader(entities, initDataEventArgs);
        initDataEventArgs.commons.execServer = false;
        // initDataEventArgs.commons.serverParameters.entityName = true;
    };
