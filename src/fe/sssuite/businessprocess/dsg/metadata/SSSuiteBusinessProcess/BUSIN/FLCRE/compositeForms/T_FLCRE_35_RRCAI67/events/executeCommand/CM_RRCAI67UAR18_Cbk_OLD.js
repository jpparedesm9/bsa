   /* task.executeCommandCallback.CM_RRCAI67UAR18 = function (entities, executeCommandCallbackEventArgs) {
        updateWarranty = true;
        var typeWarranty = entities.WarrantyGeneral.warrantyType;
        if (executeCommandCallbackEventArgs.success) {
            if (typeWarranty == 'GARGPE') {
                var dataWarranty = task.addPersonalWarrantyList(executeCommandCallbackEventArgs, updateWarranty);
            } else {
                var dataWarranty = task.addOtherWarrantyList(executeCommandCallbackEventArgs, updateWarranty);
            }
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.vc.closeModal(dataWarranty);
        }
    };*/