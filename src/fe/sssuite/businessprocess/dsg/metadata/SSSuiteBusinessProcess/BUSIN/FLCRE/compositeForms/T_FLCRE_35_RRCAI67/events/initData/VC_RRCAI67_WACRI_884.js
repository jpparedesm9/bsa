//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: warrantiesCreation
    task.initData.VC_RRCAI67_WACRI_884 = function (entities, initDataEventArgs){
        var viewState = initDataEventArgs.commons.api.viewState;
        var api = initDataEventArgs.commons.api;
        var params = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
        // Entidades Temporal
        entities.generalData = {};
        entities.generalData.isNew = true;

        loadStoreKeeper = 0;
        api.viewState.hide('GR_ARANSCATIO07_17');
        if (api.parentVc.customDialogParameters.isNew == true) { //modo Insert
            //Acciones sobre la barra de botones de la tarea
            api.viewState.hide('CM_RRCAI67UAR18');
            api.viewState.hide('CM_RRCAI67NLA20');
            api.viewState.disable('VC_RRCAI67_GUPOB_764', true);
            //Acciones sobre la barra de navegación

            $("#NAVIGATIONBUTTONBAR").css("visibility", "visible");
            api.vc.parentVc.viewState.SAVEBUTTON.visible = true;
            api.vc.parentVc.viewState.SAVEBUTTON.disabled = false;
            api.vc.parentVc.viewState.FINISHBUTTON.visible = true;
            api.vc.parentVc.viewState.FINISHBUTTON.disabled = false;
            //Acciones sobre la barra de botones de navegación
            api.vc.parentVc.executeSave_T_FLCRE_35_RRCAI67 = function () {
                api.vc.executeCommand('VA_ARANSCATIO0717_0000605', 'saveBtn', undefined, false, false, '', false);
            }

            var isNew = params.isNew == undefined ? false : params.isNew;

            if (isNew) {
                var viewState = initDataEventArgs.commons.api.viewState;
                task.validatePersonalWarranty(params.typeGuaranteeData.typeOfGuarantee, viewState);
                task.validateDPFWarranty(params.typeGuaranteeData.typeOfGuarantee, viewState);
                //task.validateHipWarranty(params.typeGuaranteeData.superiorType, viewState);
                task.setGeneralData(entities, params, viewState, initDataEventArgs);
                task.setSituationData(entities, params, viewState);
                task.hideSituationFields(entities, viewState);                
                initDataEventArgs.commons.execServer = false;
            } else {                
                initDataEventArgs.commons.execServer = false;

            }
            if (initDataEventArgs.commons.api.parentVc.parentVc != undefined && (initDataEventArgs.commons.api.parentVc.parentVc.parentVc.id == "inbox" || initDataEventArgs.commons.api.parentVc.parentVc.parentVc.id == 'inboxWizardVC')) {
                entities.WarrantyGeneral.tramitNumber = api.parentVc.parentVc.parentVc.customDialogParameters.model.Task.ownerIdentifier;
                initDataEventArgs.commons.execServer = true;
            }
        } else if (api.parentVc.customDialogParameters.isNew == undefined) { //modo Update        
            task.validatePersonalWarranty(api.parentVc.customDialogParameters.currentRow.Type, viewState);
            task.validateDPFWarranty(api.parentVc.customDialogParameters.currentRow.Type, viewState);
            //task.validateHipWarranty(params.typeGuaranteeData.superiorType, viewState);//params.typeGuaranteeData  -> undefined.....
            task.hideSituationFields(entities, viewState);
            entities.WarrantyGeneral.warrantyType = api.parentVc.customDialogParameters.currentRow.Type;
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_CODE053']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_EXTE434']);
            if (initDataEventArgs.commons.api.parentVc != undefined && (initDataEventArgs.commons.api.parentVc.parentVc.id == "inbox" || initDataEventArgs.commons.api.parentVc.parentVc.id == 'inboxWizardVC')) {
                entities.WarrantyGeneral.tramitNumber = api.parentVc.parentVc.customDialogParameters.model.Task.ownerIdentifier;
                initDataEventArgs.commons.execServer = true;
            }
            entities.generalData.isNew = false;
        }
        entities.WarrantyGeneral.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;        
    };