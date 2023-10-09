// (Button) 
task.executeCommand.CM_TADDRESS_C49 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    if (executeCommandEventArgs.commons.api.parentVc.model != null && executeCommandEventArgs.commons.api.parentVc.model != undefined && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
        executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
    
    if (section != null) {
       var response = {
           operation: "U",
           section: section,
           clientId: entities.CustomerTmp.code
       };
       executeCommandEventArgs.commons.api.vc.parentVc.responseEvent(response);
    }
};