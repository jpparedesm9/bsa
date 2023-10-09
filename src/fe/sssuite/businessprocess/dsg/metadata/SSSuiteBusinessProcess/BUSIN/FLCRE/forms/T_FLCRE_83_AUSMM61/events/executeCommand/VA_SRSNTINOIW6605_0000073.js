//Entity: DisbursementDetail
    //DisbursementDetail. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_SRSNTINOIW6605_0000073 = function(  entities, executeCommandEventArgs ) {
       var ds = executeCommandEventArgs.commons.api.vc.model['DisbursementDetail'];
  var flag = 0;
  var dsData = ds.data();

           entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
        entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;
        
          if(task.creditType===FLCRE.CONSTANTS.TypeRequest.GRUPAL){
                 entities.DisbursementIncome.isGroup="S";
              entities.DisbursementIncome.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
            }else if(task.creditType===FLCRE.CONSTANTS.TypeRequest.INTERCICLO){
                entities.DisbursementIncome.isGroup="N";                
            }else{
              
                
            }
        
       
        
        
        entities.DisbursementIncome.operationNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;

        
        
  if (entities.DisbursementIncome.DisbursementForm == null){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FASOAMSBL_03352');
  }else if(entities.DisbursementIncome.Office == null){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FICNOBLIT_56699');
  }else if(disbFormCHeck == 42 && entities.DisbursementIncome.ImpOffice == null){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OIAPROGAO_73803');
  }else if (entities.DisbursementIncome.DisbursementValue == 0){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IBUMALUER_52287');
  }else if (disbFormAHCC === 3 || disbFormAHCC === 4){
   /*if(entities.DisbursementIncome.Account == null){
    executeCommandEventArgs.commons.execServer = false;
    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MENSOORIO_09614');
   }*/
  }else {
   for (var i = 0; i < dsData.length; i ++) {
    if(dsData[i].DisbursementForm == productDisbursement){
     flag = 1;
    }
   }
   if(flag == 1){
    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IUEMEAXSS_85831');
    executeCommandEventArgs.commons.execServer = false;
   }else{
    if((executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.BalanceOperation+task.maxErrorRound) >=  entities.DisbursementIncome.CurrentBalance){
     executeCommandEventArgs.commons.execServer = true;
    }else{
     executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MOAALDRON_83113');
     executeCommandEventArgs.commons.execServer = false;
    }
   }
  }
        
    };