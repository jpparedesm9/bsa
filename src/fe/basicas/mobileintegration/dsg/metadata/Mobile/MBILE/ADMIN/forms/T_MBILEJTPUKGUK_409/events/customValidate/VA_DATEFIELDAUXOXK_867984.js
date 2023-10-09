//Entity: SyncFilter
    //SyncFilter.dateEntry (DateField) View: SyncManagementForm
    
    task.customValidate.VA_DATEFIELDAUXOXK_867984 = function(  entities, customValidateEventArgs ) {

    customValidateEventArgs.commons.execServer = false;
        
        if(entities.SyncFilter.dateEntry != null){
            if(entities.SyncFilter.dateEntry.getTime() > processDate.getTime()){
                customValidateEventArgs.isValid = false;
                customValidateEventArgs.errorMessage='MBILE.MSG_MBILE_LAFECHAEL_47318';
            }
        }
        
    };