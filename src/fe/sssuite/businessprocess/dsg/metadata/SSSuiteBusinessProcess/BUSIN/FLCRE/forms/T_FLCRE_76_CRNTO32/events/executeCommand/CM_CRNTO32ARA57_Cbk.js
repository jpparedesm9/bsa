//Start signature to callBack event to CM_CRNTO32ARA57
//Boton Guardar Callback
    task.executeCommandCallback.CM_CRNTO32ARA57 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;

        if (executeCommandEventArgs.success == true) {
            //removemos campo isNew
            if (entities.WarrantyPoliciy.isNew) {
                delete entities.WarrantyPoliciy.isNew;
                executeCommandEventArgs.commons.api.parentApi().grid.addRow("WarrantyPoliciy", entities.WarrantyPoliciy);
            }
            executeCommandEventArgs.commons.api.vc.closeModal(entities.WarrantyPoliciy);
        }
    };