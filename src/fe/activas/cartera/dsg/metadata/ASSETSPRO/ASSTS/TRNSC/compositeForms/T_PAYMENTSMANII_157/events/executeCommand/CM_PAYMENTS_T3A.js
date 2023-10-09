// (Button) 
    task.executeCommand.CM_PAYMENTS_T3A = function(entities, executeCommandEventArgs) {
        var hasError = false;
        var msgResourceID = "";
        var condonationValue = 0.0;
        var valuesCount = 0;
        
        if (entities.Payment.value == null) 
            entities.Payment.value = 0;
        
        if (entities.Payment.retention == null)
            entities.Payment.retention = 0;
        
        if (entities.PaymentMethod.category == null)
            entities.PaymentMethod.category = "";
        
        for (var i = 0; i < entities.CondonationDetail._data.length; i++) {
            condonationValue = condonationValue + entities.CondonationDetail._data[i].valueToCondone ;
        }
        
        valuesCount = valuesCount + (entities.Payment.value > 0 ? 1 : 0);
        valuesCount = valuesCount + (condonationValue > 0 ? 1 : 0);
        valuesCount = valuesCount + (entities.LeftOverPayment.value > 0 ? 1 : 0);
        
        if (valuesCount > 1 ) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_CONDONACI_18738"; 
        }
        
        if (!hasError && entities.Payment.value <= 0 && condonationValue <= 0 && entities.LeftOverPayment.value <= 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18739"; 
        }
        
        if (!hasError && entities.Payment.value < 0 && entities.Payment.entireFee != 'S') {
            hasError = true;
            msgResourceID = "MSG_ASSTS_PAYMENTSA_18744";
        }
        
        if (!hasError && entities.Payment.date == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18740"; 
        }
        
        if (!hasError && entities.Payment.value && entities.Payment.currencyType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18741"; 
        }
        
        if (!hasError && entities.LeftOverPayment.value > 0 && entities.LeftOverPayment.currencyType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18748"; 
        }
        
        if (!hasError && entities.Payment.value > 0 && entities.Payment.paymentType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18742";
        }
        
        if (!hasError && entities.LeftOverPayment.value > 0 && entities.LeftOverPayment.paymentType == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18747";
        }
        
        if(!hasError && entities.PaymentMethod.category.substring(0,2) == "CH" && entities.Payment.bank == null) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18745";
        }
        
        if(!hasError && entities.PaymentMethod.category.substring(0,2) == "CH" && (entities.Payment.numCheck == null || entities.Payment.numCheck == "")) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18746";
        }
        
        if (!hasError && (entities.Payment.reference == null || entities.Payment.reference == "") && (entities.Payment.value > 0 || entities.Payment.entireFee == 'S')) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18743"; 
        }
        
        if (!hasError && (entities.LeftOverPayment.reference == null || entities.LeftOverPayment.reference == "") && entities.LeftOverPayment.value > 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18749"; 
        }
        
       if (entities.Payment.finePrepayment > 0){
          if (entities.Payment.value >= entities.Payment.amount && entities.Payment.value != entities.Payment.amountPrepayment) {
              hasError = true;
              msgResourceID = "ASSTS.MSG_ASSTS_ERRORELRL_73200"; 
          }
          if (entities.Payment.value == entities.Payment.amountPrepayment){
               entities.Loan.newStatus = 'S';
          }else{
               entities.Loan.newStatus = 'N';
          }
        }      
        
        if (!hasError) {
            var quotationValue = 0.0;
            quotationValue = task.getQuotation(entities.QuotationCurrency, entities.Payment.operationCurrencyType)
            entities.Payment.quotationValue = quotationValue
            
            quotationValue = 0.0;
            quotationValue = task.getQuotation(entities.QuotationCurrency, entities.Payment.currencyType)
            entities.Payment.payQuotationValue = quotationValue
            
            quotationValue = 0.0;
            quotationValue = task.getQuotation(entities.QuotationCurrency, entities.LeftOverPayment.currencyType)
            entities.LeftOverPayment.leftoverQuotationValue = quotationValue;
            
        }
        
        if (hasError) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
            executeCommandEventArgs.commons.execServer = false;
        } else {
            //executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.execServer = true;
        }
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };