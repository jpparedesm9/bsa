//gridRowSelecting QueryView: QV_2890_45043
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelectingCallback.QV_2890_45043 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            var subModuleId = "TRNSC",
            taskId = "T_PAYMENTSMANII_157",
            vcId = "VC_PAYMENTSAN_916157",
            parameters = {loanInstancia : entities.LoanInstancia, screenCall:'refinance'},
            label="Detalle de Pago";

            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, gridRowSelectingEventArgs, parameters);     
        };