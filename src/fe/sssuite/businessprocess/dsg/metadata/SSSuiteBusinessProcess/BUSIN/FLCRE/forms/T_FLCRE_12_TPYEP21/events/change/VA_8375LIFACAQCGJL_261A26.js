//Entity: PaymentPlanHeader
    //PaymentPlanHeader.typePayment (RadioButtonList) View: TPaymentPlan
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8375LIFACAQCGJL_261A26 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    task.enableDisabledByTypePayment(entities, changedEventArgs);
        
    };