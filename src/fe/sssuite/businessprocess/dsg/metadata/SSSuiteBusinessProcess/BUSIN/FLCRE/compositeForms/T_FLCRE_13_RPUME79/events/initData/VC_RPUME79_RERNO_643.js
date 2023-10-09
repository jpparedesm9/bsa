//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RePrintDocument
    task.initData.VC_RPUME79_RERNO_643 = function (entities, initDataEventArgs){
        var ctrs=['VA_SHCTRATNIW7705_AMTI124'], viewState = initDataEventArgs.commons.api.viewState; 
		BUSIN.API.hide(viewState,ctrs);	
		initDataEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'Official');         
		initDataEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'Selection');         
		initDataEventArgs.commons.api.grid.hideColumn('QV_ERPLI1480_97', 'OfficialName');         
		initDataEventArgs.commons.execServer = false;
        
    };