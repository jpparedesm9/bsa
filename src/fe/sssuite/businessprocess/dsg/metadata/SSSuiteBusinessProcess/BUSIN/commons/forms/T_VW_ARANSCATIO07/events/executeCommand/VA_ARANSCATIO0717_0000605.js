// (Button) 
//.saveBtn (Button) View: warrantiesCreation
    task.executeCommand.VA_ARANSCATIO0717_0000605 = function( entities, executeCommandEventArgs ) {
        var operation = "I";
            entities.generalData.isNew = true;
            if (task.validateBeforeSave(entities, executeCommandEventArgs, operation)) {                
                executeCommandEventArgs.commons.execServer = true;
            } else {
                executeCommandEventArgs.commons.execServer = false;            
            }
    };