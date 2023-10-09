//Entity: PaymentPlanHeader
//PaymentPlanHeader.dispersionDate (DateField) View: TPaymentPlan
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_DISPERSIONDATTT_417A26 = function (entities, changedEventArgs) {

    changedEventArgs.commons.execServer = false;

    entities.PaymentPlanHeader.initialDate = entities.PaymentPlanHeader.dispersionDate

    var fechaProceso = entities.PaymentPlanHeader.initialDate;
    var fechaDispersionR = entities.PaymentPlanHeader.dispersionDate;


    if (passInitDataCallback) {
        console.log("Fecha dispercion: " + fechaDispersionR);
        console.log("Fecha validacion: " + fechaValidacion);
        console.log("Fecha proceso: " + fechaProceso);


        if (fechaDispersionR !== undefined) {
            fechaDispersionR.setHours(0, 0, 0, 0);
        }
        if (fechaProceso !== undefined) {
            fechaProceso.setHours(0, 0, 0, 0);
        }
        if (fechaValidacion !== undefined) {
            fechaValidacion.setHours(0, 0, 0, 0);
        }

        if (fechaDispersionR > fechaValidacion) {

            changedEventArgs.commons.messageHandler.showTranslateMessagesError("La fecha de dispersi&oacuten sobrepasa el l&iacutemite establecido", null, 4000, false);


        } else {
            if (fechaDispersionR < fechaProceso) {

                changedEventArgs.commons.messageHandler.showTranslateMessagesError("La fecha de dispersi&oacuten es menor que la fecha de proceso", null, 4000, false);


            } else if (fechaDispersionR === null || fechaDispersionR === undefined) {
                changedEventArgs.commons.messageHandler.showTranslateMessagesError("Fecha de dispersi&oacuten requerida", null, 4000, false);

            } else {
                entities.PaymentPlanHeader.dispersionDate = fechaDispersionR;
            }
        }
        passInitDataCallback = false;

    }

};