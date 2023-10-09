//Entity: SyncFilter
    //SyncFilter. (Button) View: SyncManagementForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONOORWXZG_436984 = function(  entities, executeCommandEventArgs ) {
        
        executeCommandEventArgs.commons.execServer = true;
        
        if((entities.SyncFilter.user === "") || (entities.SyncFilter.user === null)){
            if((entities.SyncFilter.dateSync === "") || (entities.SyncFilter.dateSync === null)){
                if((entities.SyncFilter.state === "") || (entities.SyncFilter.state === null)){
                    if((entities.SyncFilter.dateEntry === "") || (entities.SyncFilter.dateEntry === null)){
                        executeCommandEventArgs.commons.messageHandler.showMessagesError('MBILE.MSG_MBILE_PORFAVOEE_79439', true);
                        executeCommandEventArgs.commons.execServer = false;
                        executeCommandEventArgs.commons.api.grid.removeAllRows('Sync');
                    }
                }
            }
        }
        
        //executeCommandEventArgs.commons.serverParameters.SyncFilter = true;
    };