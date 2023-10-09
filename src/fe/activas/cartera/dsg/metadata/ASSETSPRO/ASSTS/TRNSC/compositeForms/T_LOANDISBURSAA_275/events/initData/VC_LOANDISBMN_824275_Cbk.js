//Start signature to callBack event to VC_LOANDISBMN_824275
    task.initDataCallback.VC_LOANDISBMN_824275 = function(entities, initDataEventArgs) {
        //here your code
        var cmm = initDataEventArgs.commons;
      if(entities.LoanInstancia.errorValidation == true){
         cmm.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_PRSTAMOYS_82498')+entities.Loan.status,true);
      }
      if(!initDataEventArgs.success || entities.LoanInstancia.errorValidation == true){         
         cmm.api.vc.closeDialog();
         var subModuleId = "CMMNS",
         taskId = "T_LOANSEARCHSWA_959",
         vcId = "VC_LOANSEARHC_144959",
         parameters = '',
         label="BÃºsqueda de PrÃ©stamos";
         ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, initDataEventArgs, parameters);        
      }
     
    };