// (Button) 
    task.executeCommand.CM_TLOANREF_1NA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var subModuleId = "TRNSC",
        taskId = "T_LOANDISBURSAA_275",
        vcId = "VC_LOANDISBMN_824275",
        parameters = {loanInstancia : entities.LoanInstancia},
        label="Desembolso";
        ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId,label, executeCommandEventArgs, parameters);
        return true;
    };