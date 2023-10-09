//Entity: GeneralParameterLoan
    //GeneralParameterLoan.exchangeRate (RadioButtonList) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acciÃ³n a ejecutar de un label de un input control. 
    task.executeLabelCommand.VA_VWPAYMENLA2631_HNGE222 = function( entities, executeLabelCommandEventArgs ) {
       executeLabelCommandEventArgs.commons.execServer = false;
        task.setMessage(executeLabelCommandEventArgs,'BUSIN.DLB_BUSIN_DARJUSTEA_98748');
        
    };