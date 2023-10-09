//Entity: PaymentPlan
    //PaymentPlan.tableType (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VWPAYMENLA2605_BLYE585 = function( entities, changedEventArgs ) {
		isFirstTime = false;
		changedEventArgs.commons.execServer = false;
		task.setTipoTabla(entities.PaymentPlan, changedEventArgs, entities);
        
    };