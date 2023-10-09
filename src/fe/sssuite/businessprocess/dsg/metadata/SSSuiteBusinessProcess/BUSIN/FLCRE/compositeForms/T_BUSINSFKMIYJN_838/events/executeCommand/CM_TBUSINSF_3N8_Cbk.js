// (Button) 
    task.executeCommandCallback.CM_TBUSINSF_3N8 = function(entities, executeCommandCallbackEventArgs) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        
        var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
        if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
        
        
        
        
    };