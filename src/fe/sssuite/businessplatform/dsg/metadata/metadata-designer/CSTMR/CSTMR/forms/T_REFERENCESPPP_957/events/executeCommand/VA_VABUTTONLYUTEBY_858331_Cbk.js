//Start signature to Callback event to VA_VABUTTONLYUTEBY_858331
task.executeCommandCallback.VA_VABUTTONLYUTEBY_858331 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if(executeCommandCallbackEventArgs.success){
        var catalogs=executeCommandCallbackEventArgs.commons.api.vc.catalogs;
        entities.References.relationship=task.findValueInCatalog(entities.References.relationship,
                            catalogs.VA_RELATIONSHIPOYM_385331.data());
        
        executeCommandCallbackEventArgs.commons.api.vc.closeModal({
            resultArgs: {
                index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandCallbackEventArgs.commons.api.vc.mode,
                data: entities.References
            }});
        
        if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Insert){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
        
        }else if(executeCommandCallbackEventArgs.commons.api.vc.mode===executeCommandCallbackEventArgs.commons.constants.mode.Update){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
        }
    }
    
    
};