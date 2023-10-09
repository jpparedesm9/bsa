// (Button) 
//CallBack .saveBtn (Button) View: warrantiesCreation 
    task.executeCommandCallback.VA_ARANSCATIO0717_0000605 = function( entities, executeCommandCallback ) {
        executeCommandCallback.commons.api.vc.parentVc.model.Save = new Date();
        updateWarranty = false;
        var vc=executeCommandCallback.commons.api.vc;
        if (executeCommandCallback.success) {
            executeCommandCallback.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625', '', 2000, false);
            var viewState = executeCommandCallback.commons.api.viewState;
            if (entities.WarrantyGeneral.code != null) {
                BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_CODE053']);
                BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_EXTE434']);
            }
            $("#NAVIGATIONBUTTONBAR").css("visibility", "visible");
            executeCommandCallback.commons.api.vc.parentVc.viewState.SAVEBUTTON.disabled = true;

            if (entities.WarrantyGeneral.warrantyType == 'GARGPE') {
                task.addPersonalWarrantyList(executeCommandCallback, updateWarranty);
            } else {
                task.addOtherWarrantyList(executeCommandCallback, updateWarranty);
            }
            executeCommandCallback.commons.api.vc.parentVc.model.ClosePage = new Date();
            //Set del campo HiddenInCompleted para poder continuar la tarea
            executeCommandCallback.commons.api.parentVc.parentVc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
            
            if(vc.parentVc!=null && vc.parentVc.parentVc!=null && vc.parentVc.parentVc.parentVc!=null && vc.parentVc.parentVc.parentVc.modificacionesLinea){
                vc.parentVc.parentVc.parentVc.addWarranty(entities);
            }

        }
        
    };