//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TDetailPenalization
    task.initData.VC_ETLLN40_LENTI_976 = function (entities, initDataEventArgs){
        var api = initDataEventArgs.commons.api;
		var rowData = api.vc.rowData;
		entities.HeaderPunishment.ApplicationNumber = rowData.Operation;
    };