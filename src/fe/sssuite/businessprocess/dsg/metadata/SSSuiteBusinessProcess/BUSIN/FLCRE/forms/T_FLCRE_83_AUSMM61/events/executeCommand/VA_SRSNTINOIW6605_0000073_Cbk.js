//Start signature to Callback event to VA_SRSNTINOIW6605_0000073
task.executeCommandCallback.VA_SRSNTINOIW6605_0000073 = function(entities, executeCommandEventArgs) {
//here your code
    
    if(executeCommandEventArgs.success != false){
   var api = executeCommandEventArgs.commons.api;
   var newBalanceOperation = (api.parentVc.model.LoanHeader.BalanceOperation - Math.round(entities.DisbursementIncome.CurrentBalance*100)/100);
   if( (newBalanceOperation<0) && ((newBalanceOperation*-1)-task.maxErrorRound ) ){ //SI ES NEGATIVO SE REDONDEA A '0' CERO 
    newBalanceOperation=0;
   }
   api.parentVc.model.LoanHeader.BalanceOperation = newBalanceOperation;
   
   
   var disburmentIncomeForm =entities.DisbursementIncome.DisbursementForm.split("/");
   var prueba= {DisbursementForm: disburmentIncomeForm[0],
       Currency: entities.DisbursementIncome.Currency,
       DisbursementValue: entities.DisbursementIncome.DisbursementValue,
       ValueMl: entities.DisbursementIncome.ValueMl,
       PriceQuote: entities.DisbursementIncome.Quotation,
       DisbursementFormId: entities.DisbursementIncome.Sequential,
       AmountMOP: entities.DisbursementIncome.CurrentBalance,
       Sequential: entities.DisbursementIncome.Sequential,
       DisbursementId: entities.DisbursementIncome.DisbursementId};
   var detail = api.vc.rowData;
   //PARA DESTRUIR MANUALMENTE EL SCOPE Y EVITAR QUE SE EJECUTE VARIAS VECES EL EVENTO CHANGE
   var scope = angular.element($('#QV_TSRSE1342_26 tr.k-detail-row td.k-detail-cell > div')).scope();
   if (angular.isDefined(scope)) {
    scope.$destroy();
   };
   detail.set('DisbursementForm', prueba.DisbursementForm );
   detail.set('Currency', prueba.Currency );
   detail.set('DisbursementValue', prueba.DisbursementValue );
   detail.set('ValueMl', prueba.ValueMl );
   detail.set('PriceQuote', prueba.PriceQuote );
   detail.set('DisbursementFormId', prueba.DisbursementFormId );
   detail.set('AmountMOP', prueba.AmountMOP );
   detail.set('sequential', prueba.Sequential );
   detail.set('DisbursementId', prueba.DisbursementId );
  }
};