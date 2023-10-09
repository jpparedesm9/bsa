//Entity: MethodsRetention
    //MethodsRetention.disbursement (ComboBox) View: PaymentMaintenanceModal
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DISBURSEMENTDSI_289701 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        
        var  api = changeEventArgs.commons.api; 
        var desembolso  = entities.MethodsRetention.disbursement;
        var pagos     = entities.MethodsRetention.payment;
        var pagoAutomatico  = entities.MethodsRetention.paymentAut;
        var pagoCaja  = entities.MethodsRetention.paymentATX ;             
        validarCampos(api,desembolso,pagos,pagoAutomatico,pagoCaja);        
    };