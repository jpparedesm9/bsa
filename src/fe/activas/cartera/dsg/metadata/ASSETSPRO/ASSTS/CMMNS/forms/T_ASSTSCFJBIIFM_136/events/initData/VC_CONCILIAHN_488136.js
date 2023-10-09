//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ConciliationSearchForm
    task.initData.VC_CONCILIAHN_488136 = function (entities, initDataEventArgs){
        cobis.showMessageWindow.loading(true);
        initDataEventArgs.commons.execServer = false;
        entities.ConciliationSearchFilter.customerType = 'P'; //Persona Natural por defecto
        entities.ConciliationSearchFilter.conciliationStatus = 'T';//Estado Conciliación: Todos por defecto
    };