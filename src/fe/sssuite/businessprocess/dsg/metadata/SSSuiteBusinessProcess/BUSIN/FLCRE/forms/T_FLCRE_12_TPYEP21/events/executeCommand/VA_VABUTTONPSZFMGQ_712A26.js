//Entity: PaymentPlanHeader
    //PaymentPlanHeader. (Button) View: TPaymentPlan
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONPSZFMGQ_712A26 = function(  entities, executeCommandEventArgs ) {

   executeCommandEventArgs.commons.execServer = true;
    entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.Task.bussinessInformationIntegerOne;
        entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.Task.bussinessInformationIntegerTwo;
         entities.PaymentSelection.creditType=task.creditType;
    
        
    };