//Start signature to Callback event to VC_RRCAI67_WACRI_884
task.onCloseModalEventCallbak = function (entities, onCloseModalCallbackEventArgs) {
    if (onCloseModalCallbackEventArgs.success) {
        var api = onCloseModalCallbackEventArgs.commons.api;
        var rows = entities.CustomerSearch.data();
        var rowsSharedEntities = entities.SharedEntityWarranty.data();
        var viewState = onCloseModalCallbackEventArgs.commons.api.viewState;

        onCloseModalCallbackEventArgs.commons.execServer = false;

        onCloseModalCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_QRYLI5474_83', 'CEQV_201_QV_QRYLI5474_83_514');
        onCloseModalCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_QRYLI5474_83', 'create');
        onCloseModalCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_6063_45257', 'create');

        if (entities.SharedWarrantyInfo.shared == 'N') {
            api.viewState.hide('G_SHAREDWATN_707230');
        } else if (entities.SharedWarrantyInfo.shared == 'S' && rowsSharedEntities != null && rowsSharedEntities != undefined && rowsSharedEntities.length > 0) {
            api.viewState.show('G_SHAREDWATN_707230');
        }
        if (api.parentVc != undefined) {
            api.parentVc.setContainerView(entities.WarrantyGeneral.externalCode);
        }

        for (var i = 0; i < rows.length; i++) {
            onCloseModalCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_QRYLI5474_83', rows[i], 'edit');
            onCloseModalCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_QRYLI5474_83', rows[i], 'delete');
        }

        for (var i = 0; i < rowsSharedEntities.length; i++) {
            onCloseModalCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_6063_45257', rowsSharedEntities[i], 'edit');
            onCloseModalCallbackEventArgs.commons.api.grid.hideGridRowCommand('QV_6063_45257', rowsSharedEntities[i], 'delete');
        }

    }
};