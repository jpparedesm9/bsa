//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PaymentModeForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
         entities.PaymentForm.clientFullName = entities.Loan.clientID +" - "+ entities.Loan.clientName;
         entities.PaymentForm.clientId = entities.Loan.clientID;
         
         entities.PaymentForm.currencyId = entities.Loan.codCurrency;
         entities.PaymentForm.payFormCategory = ""; 
    };