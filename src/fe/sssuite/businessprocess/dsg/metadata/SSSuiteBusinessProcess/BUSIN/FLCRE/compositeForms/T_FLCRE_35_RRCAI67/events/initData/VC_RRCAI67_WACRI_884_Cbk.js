//Callback guardar (actualizar)
task.initDataCallback.VC_RRCAI67_WACRI_884 = function (entities, initDataCallbackEventArgs) {
        var viewState = initDataCallbackEventArgs.commons.api.viewState;
        var api = initDataCallbackEventArgs.commons.api;
        var wPrincipal = true;
        var isUpdate = api.parentVc.customDialogParameters.isNew == true ? false : true;
        if (isUpdate) {
            var customDialogParameters = api.parentVc.parentVc.customDialogParameters;
			if(entities.WarrantyGeneral.status != 'P'){
				viewState.disable('VA_ARANSCATIO0709_MONY430', true);
			}else{
				viewState.enable('VA_ARANSCATIO0709_MONY430', true);
			}
        } else {
            var customDialogParameters = api.parentVc.parentVc.parentVc.customDialogParameters;
            var data = {
                CustomerId: customDialogParameters.model.Task.clientId,
                Customer: customDialogParameters.model.Task.clientName,
                OfficerId: entities.CustomerSearch.data()[0].OfficerId,
                Officer: customDialogParameters.model.Task.nameDestination,
                Principal: wPrincipal
            };
            initDataCallbackEventArgs.commons.api.grid.updateRow('CustomerSearch', 0, data);
        }

        if (entities.WarrantyGeneral.initialValue == 0 && "S" == entities.WarrantyGeneral.mandatoryDocument) {
            api.viewState.enableValidation('VA_ARANSCATIO0709_OEBE980', VisualValidationTypeEnum.Required);
        }
        if (entities.WarrantyGeneral.documentNumber == 0) {
            entities.WarrantyGeneral.documentNumber = "";
        }
        if (entities.WarrantyLocation.storeKeeper == 0) {
            entities.WarrantyLocation.storeKeeper = "";
        }
        task.showFieldsVerified(entities, viewState);
        task.renderAditionalData(entities, customDialogParameters, initDataCallbackEventArgs);
    };