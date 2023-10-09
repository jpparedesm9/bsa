//Entity: Mobile
    //Mobile. (Button) View: MobilePopUpForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONODIGQRB_255864 = function(  entities, executeCommandCallbackEventArgs ) {

        executeCommandCallbackEventArgs.commons.execServer = false;
        var nav = executeCommandCallbackEventArgs.commons.api.navigation;
        var catalogs=executeCommandCallbackEventArgs.commons.api.vc.catalogs;
        
        entities.Mobile.typeDescription=task.findValueInCatalog(entities.Mobile.type,
                            catalogs.VA_TEXTINPUTBOXMYG_290864.data());
        entities.Mobile.officialDescription=task.findValueInCatalog(entities.Mobile.official,
                            catalogs.VA_TEXTINPUTBOXJOU_670864.data());
							
        if(entities.Mobile.officialDescription===null || entities.Mobile.officialDescription===""||entities.Mobile.officialDescription==='null'){
            entities.Mobile.officialDescription = 'NO EXISTE OFICIAL';
        }
		
        entities.Mobile.deviceStatusDescription=task.findValueInCatalog(entities.Mobile.deviceStatus,
                            catalogs.VA_DEVICESTATUSGNK_898864.data());
        
        if(executeCommandCallbackEventArgs.success){
        
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                data: entities.Mobile
            }});
        
        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Insert){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Registro creado exitosamente','', 2000,false);
        
        }else if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('Registro actualizado exitosamente','', 2000,false);
        }
    }
        
    };