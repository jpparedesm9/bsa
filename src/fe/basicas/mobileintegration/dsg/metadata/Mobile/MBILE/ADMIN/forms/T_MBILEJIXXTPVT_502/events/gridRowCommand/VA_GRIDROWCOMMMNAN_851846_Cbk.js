//Entity: Mobile
    //Mobile. (Button) View: MobileManagementForm
    
    task.gridRowCommandCallback.VA_GRIDROWCOMMMNAN_851846 = function(  entities, gridRowCommandCallbackEventArgs ) {

    gridRowCommandCallbackEventArgs.commons.execServer = false;
    
        if (gridRowCommandCallbackEventArgs.success) {
            gridRowCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('MBILE.MSG_MBILE_SEHAGUALT_30818', '', 2000, false);
        }
        
    };