// (Button) 
    task.executeCommand.CM_TREFINAN_9NC = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var msgResourceID = "";
        var hasError = false;
        
        if (entities.RefinanceLoanFilter.additionalValue == null) 
            entities.RefinanceLoanFilter.additionalValue = 0;
            
        if (entities.RefinanceLoans._data.length == 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_NOEXISTRI_36661";
        }
        
        if (!hasError && (entities.RefinanceLoanFilter.operationType == null || entities.RefinanceLoanFilter.operationType == '')) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_ELCAMPOOR_72789";
        }
        
        if (!hasError && entities.RefinanceLoanFilter.totalRefinance <= 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_ELSALDOAU_44947";
        }
        
        if (!hasError && entities.RefinanceLoanFilter.additionalValue  < 0) {
            hasError = true;
            msgResourceID = "ASSTS.MSG_ASSTS_PAYMENTSA_18739";
        }
        
        if (entities.RefinanceLoanFilter.additionalValue  > 0) {
            if (!hasError && (entities.RefinanceLoanFilter.addicionalPayMethod == null || entities.RefinanceLoanFilter.addicionalPayMethod == '')) {
                hasError = true;
                msgResourceID = "ASSTS.MSG_ASSTS_ELCAMPOLR_45229";
            }
            
            if (entities.RefinanceLoanFilter.addicionalPayMethod == 'NC_BCO_MN' || entities.RefinanceLoanFilter.addicionalPayMethod == 'NCAH'){
               if ( entities.RefinanceLoanFilter.account == null || entities.RefinanceLoanFilter.account == '' ){
                  hasError = true;
                  msgResourceID = "ASSTS.MSG_ASSTS_ELCAMPOLR_45230";   
               }               
            }
        }
                
        
        if (hasError) {           
            executeCommandEventArgs.commons.messageHandler.showMessagesError(msgResourceID,true);
        }else{
           executeCommandEventArgs.commons.execServer = true;
        }
    };