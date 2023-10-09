// (Button) Guardar
    task.executeCommand.CM_CRNTO32ARA57 = function(entities, executeCommandEventArgs) {
        if(task.validateBeforeSave(entities, executeCommandEventArgs)){
            entities.WarrantyPoliciy.isNew = entities.generalData.isNew;
            var insurance = entities.WarrantyPoliciy.insurance;
            entities.WarrantyPoliciy.insuranceDescription = executeCommandEventArgs.commons.api.viewState.selectedText('VA_WARNTYPOIY7706_NSNE946', insurance);
            
            executeCommandEventArgs.commons.execServer = true;    
        }else {
            executeCommandEventArgs.commons.execServer = false;
        }
    };