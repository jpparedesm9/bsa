//Start signature to Callback event to VA_4212YIFTVBCOPPD_140216
task.changeCallback.VA_4212YIFTVBCOPPD_140216 = function(entities, changeCallbackEventArgs) {
//here your code
    if(changeCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().difference >=
         entities.LoanAdditionalInformation.amountToCancel){
         changeCallbackEventArgs.commons.api.vc.viewState.VA_VASIMPLELABELLL_582216.label = 
         cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152') + ": " +
         kendo.toString(entities.LoanAdditionalInformation.amountToCancel, 'c') + " " +
         entities.Loan.currencyName + " " +
         cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924') + ': ' +
         entities.LoanAdditionalInformation.quotation;
      }else{
         changeCallbackEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate('ASSTS.MSG_ASSTS_VALORDEEA_97215'));
         entities.PaymentForm.currencyId = changeEventArgs.oldValue;
         changeCallbackEventArgs.commons.execServer = true;
      }
};