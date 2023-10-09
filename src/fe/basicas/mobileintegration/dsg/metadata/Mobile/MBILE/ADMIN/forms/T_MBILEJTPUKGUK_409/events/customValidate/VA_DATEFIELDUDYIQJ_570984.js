//Entity: SyncFilter
    //SyncFilter.dateSync (DateField) View: SyncManagementForm
    
    task.customValidate.VA_DATEFIELDUDYIQJ_570984 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
        customValidateEventArgs.isValid = true;
        
        if(entities.SyncFilter.dateSync != null){
            if(entities.SyncFilter.dateSync.getTime() > processDate.getTime()){
                customValidateEventArgs.isValid = false;
                customValidateEventArgs.errorMessage='MBILE.MSG_MBILE_LAFECHAAR_64842';
            }
        }
        
    };