//Entity: GeneralParameterLoan
    //GeneralParameterLoan.especialReadjustment (RadioButtonList) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control. 
    task.executeLabelCommand.VA_VWPAYMENLA2632_ERSE615 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
        task.setMessage(executeLabelCommandEventArgs,'BUSIN.DLB_BUSIN_DARJUSTEA_98748');
        
    };