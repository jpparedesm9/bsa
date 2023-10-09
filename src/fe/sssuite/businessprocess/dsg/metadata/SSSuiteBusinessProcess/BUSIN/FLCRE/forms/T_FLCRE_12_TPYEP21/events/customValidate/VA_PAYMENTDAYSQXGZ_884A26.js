//Entity: PaymentPlanHeader
//PaymentPlanHeader.paymentDay (DateField) View: TPaymentPlan
//Req.194284 Dia de Pago
task.customValidate.VA_PAYMENTDAYSQXGZ_884A26 = function (entities, customValidateEventArgs) {
    customValidateEventArgs.commons.execServer = false;
    customValidateEventArgs.isValid = true

    if (entities.PaymentPlanHeader.paymentDay < processDateTemp) {
        customValidateEventArgs.errorMessage = 'BUSIN.MSG_BUSIN_VERIFICET_47837';
        customValidateEventArgs.isValid = false;
    }
};