//Entity: DisbursementDetail
    //DisbursementDetail. (Button) View: TaskDisbursementIncome
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONIWKBMNP_334W66 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = true;
        entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
        entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;
         entities.PaymentSelection.creditType=task.creditType;
    
        //executeCommandEventArgs.commons.serverParameters.DisbursementDetail = true;
    };