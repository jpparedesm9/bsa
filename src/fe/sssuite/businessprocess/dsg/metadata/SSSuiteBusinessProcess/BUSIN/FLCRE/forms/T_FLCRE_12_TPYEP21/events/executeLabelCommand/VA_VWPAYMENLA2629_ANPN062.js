//Entity: GeneralParameterLoan
    //GeneralParameterLoan.acceptsAdditionalPayments (RadioButtonList) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control.
    task.executeLabelCommand.VA_VWPAYMENLA2629_ANPN062 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
        task.setMessage(executeLabelCommandEventArgs, 'BUSIN.DLB_BUSIN_UAGSDINAS_79800');
    };