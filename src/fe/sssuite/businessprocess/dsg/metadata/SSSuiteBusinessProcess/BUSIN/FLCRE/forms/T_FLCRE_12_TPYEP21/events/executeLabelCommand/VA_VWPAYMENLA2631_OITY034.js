//Entity: GeneralParameterLoan
    //GeneralParameterLoan.periodicity (TextInputBox) View: VWPaymentPlan
    //Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control.
    task.executeLabelCommand.VA_VWPAYMENLA2631_OITY034 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
		task.setMessage(executeLabelCommandEventArgs,'BUSIN.DLB_BUSIN_ADAEICDAD_95321');
    };