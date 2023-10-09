//Entity: Loan
    //Loan. (Button) View: AccountStatusForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONPMSVXME_604859 = function(  entities, executeCommandCallback ) {
        executeCommandCallback.commons.execServer = false;
        if(executeCommandCallback.success){
            executeCommandCallback.commons.api.viewState.enable('CM_TASSTSFI_AS9',true);
            executeCommandCallback.commons.api.viewState.enable('CM_TASSTSFI_S64',true);
        } else {
        	executeCommandCallback.commons.api.grid.removeAllRows('AccountStatus');
        }
    };