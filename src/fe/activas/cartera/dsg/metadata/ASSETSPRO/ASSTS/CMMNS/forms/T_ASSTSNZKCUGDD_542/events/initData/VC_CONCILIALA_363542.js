//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ConciliationManualSearchForm
    task.initData.VC_CONCILIALA_363542 = function (entities, initDataEventArgs){
        
        initDataEventArgs.commons.execServer = true;
        
        initDataEventArgs.commons.api.viewState.format('VA_CUSTOMCODEETRCB_211547', '######',0);
        initDataEventArgs.commons.api.viewState.format('VA_GRIDROWCOMMMAND_129547', '######',0);
        
        entities.ConciliationManualSearchFilter.correspondent = 'SANTANDER'; //Santander por defecto
        entities.ConciliationManualSearchFilter.type = 'TO'; //Tipo de Pago Conciliación: Todos por defecto
        entities.ConciliationManualSearchFilter.notConciliationReason = 'C'; //Razon por la que No Concilia: Huerfano Cobis por defecto
        entities.ConciliationManualSearchFilter.conciliate = 'N'; //Estado de Conciliación: No Conciliado por defecto
        entities.ConciliationManualSearchFilter.paymentState = 'T'; //Estado de Pago en COBIS Conciliación: Todos por defecto
        
    };