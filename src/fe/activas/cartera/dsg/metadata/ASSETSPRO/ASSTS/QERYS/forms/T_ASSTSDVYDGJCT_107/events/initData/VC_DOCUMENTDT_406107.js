//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: QueryDocumentsGridDetail
task.initData.VC_DOCUMENTDT_406107 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    //initDataEventArgs.commons.api.grid.hideColumn('QV_2153_73215','cmdEdition');
	
	var filtro = {
		processInstance: initDataEventArgs.commons.api.vc.rowData.processInstance,
		customerId: initDataEventArgs.commons.api.vc.rowData.clientId
	}
	initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_SCANNEEE_2153', filtro);
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMEAL_3671', filtro);
	
    initDataEventArgs.commons.api.grid.hideColumn('QV_2153_73215', 'file');

};