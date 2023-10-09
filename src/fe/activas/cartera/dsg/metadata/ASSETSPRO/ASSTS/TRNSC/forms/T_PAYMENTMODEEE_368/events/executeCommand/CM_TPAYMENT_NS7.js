// (Button) 
    task.executeCommand.CM_TPAYMENT_NS7 = function(entities, executeCommandEventArgs) {
        var cm = executeCommandEventArgs.commons;
      if(cm.api.vc.viewState.Spacer1695.visible == false){
         entities.PaymentForm.economicDestination = null;
      }
        executeCommandEventArgs.commons.execServer = true;
    };