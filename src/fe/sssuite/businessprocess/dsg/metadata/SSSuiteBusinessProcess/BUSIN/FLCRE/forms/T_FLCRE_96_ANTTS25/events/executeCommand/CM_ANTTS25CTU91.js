// (Button) 
    task.executeCommand.CM_ANTTS25CTU91 = function (entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;

        // Crear entidades temporales
        entities.OriginalHeaderTmp = executeCommandEventArgs.commons.api.parentVc.customDialogParameters.OriginalHeader;
        entities.DocumentProductTmp = executeCommandEventArgs.commons.api.parentVc.customDialogParameters.DocumentProduct;

        var nav = executeCommandEventArgs.commons.api.navigation;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;

    };