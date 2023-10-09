//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: QueryDocuments
task.initData.VC_DOCUMENTSS_852411 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    //initDataEventArgs.commons.api.grid.hideColumn('QV_5385_46042','cmdEdition');
	
	var filtro = {
		processInstance: initDataEventArgs.commons.api.parentVc.customDialogParameters.processInstance,
		groupId: initDataEventArgs.commons.api.parentVc.customDialogParameters.groupId,
		cycle: initDataEventArgs.commons.api.parentVc.customDialogParameters.cycle,
		loan: initDataEventArgs.commons.api.parentVc.customDialogParameters.loan
	}
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMETN_5385', filtro);
    initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMETD_9888', filtro);
    initDataEventArgs.commons.api.grid.hideColumn('QV_5385_46042', 'file');

};