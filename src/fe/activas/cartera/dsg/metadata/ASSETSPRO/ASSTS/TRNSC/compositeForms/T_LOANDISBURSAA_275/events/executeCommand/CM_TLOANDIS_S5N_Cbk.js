//Start signature to callBack event to CM_TLOANDIS_S5N
    task.executeCommandCallback.CM_TLOANDIS_S5N = function(entities, executeCommandEventArgs) {
        //here your code
        if(executeCommandEventArgs.success){
        
         executeCommandEventArgs.commons.api.vc.viewState.CM_TLOANDIS_S5N.disabled = true;
         //executeCommandEventArgs.commons.api.vc.viewState.CEQV_201QV_5973_48889_606.disabled = false;
         
         //executeCommandEventArgs.commons.api.vc.closeDialog();
         //var subModuleId = "CMMNS",
         //taskId = "T_LOANSEARCHSWA_959",
         //vcId = "VC_LOANSEARHC_144959",
         //parameters = '',
         //label="BÃºsqueda de PrÃ©stamos";
         //ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);        
      }
    };