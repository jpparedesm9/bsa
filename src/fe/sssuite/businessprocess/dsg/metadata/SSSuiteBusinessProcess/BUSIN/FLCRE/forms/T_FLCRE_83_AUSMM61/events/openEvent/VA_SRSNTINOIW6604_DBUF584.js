//Entity: DisbursementIncome
    //DisbursementIncome.DisbursementForm (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_SRSNTINOIW6604_DBUF584 = function( textInputButtonEventArgs ) {
        if(textInputButtonEventArgs.model.DisbursementIncome.Currency != undefined || textInputButtonEventArgs.model.DisbursementIncome.Currency != null){
   var nav = textInputButtonEventArgs.commons.api.navigation;
   nav.customDialogParameters = {
    currency: textInputButtonEventArgs.model.DisbursementIncome.Currency
   }
   nav.address = {
      moduleId: 'BUSIN',
      subModuleId: 'FLCRE',
      taskId: 'T_FLCRE_53_TKCSO26',
      taskVersion: '1.0.0',
      viewContainerId: 'VC_TKCSO26_CRNTO_867'
   }
   nav.modalProperties = {
    size: "lg"
   }
  }else{
   textInputButtonEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LETCRENCY_55231');
  }
        
    };