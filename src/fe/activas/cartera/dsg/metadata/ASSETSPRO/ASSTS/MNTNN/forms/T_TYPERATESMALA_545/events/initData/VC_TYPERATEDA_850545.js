//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TypeRatesModal
    task.initData.VC_TYPERATEDA_850545 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        if (entities.TypeRates.ratePit == null || entities.TypeRates.ratePit == '')
            entities.TypeRates.ratePit = 'N';
        
        if (entities.TypeRates.clase == null || entities.TypeRates.clase == '')
            entities.TypeRates.clase = 'F';
    };