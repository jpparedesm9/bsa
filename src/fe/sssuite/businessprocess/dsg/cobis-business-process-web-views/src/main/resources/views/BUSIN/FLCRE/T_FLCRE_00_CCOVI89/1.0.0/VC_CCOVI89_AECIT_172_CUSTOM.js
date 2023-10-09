<!-- Designer Generator v 5.0.0.1519 - release SPR 2015-19 02/10/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tasksearcheconomicactivity;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.[Control Sin Nombre] (Button) View: SearchEconomicActivityView
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_SEOOICIIIW1004_0000044 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var filter = {
                 sector: entities.economicActivityFilter.economicSector,
                 subsector: entities.economicActivityFilter.economicSubSector,
                 actividadEconomica: entities.economicActivityFilter.economicActivity,
                 subactividadEconomica:entities.economicActivityFilter.economicSubActivity,
                 AclaracionFIE:entities.economicActivityFilter.clarificationFie
            };
        executeCommandEventArgs.commons.api.grid.refresh('QV_ECONC3050_94', filter);
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Buscar (Button) 
    task.executeCommand.CM_CCOVI89USA97 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
		 var classFilter = entities.economicActivityFilter;
		 if (classFilter.clarificationFie === null && classFilter.economicActivity === null && classFilter.economicSector === null && classFilter.economicSubActivity === null && classFilter.economicSubSector === null){
			executeCommandEventArgs.commons.messageHandler.showMessagesError("Ingrese o seleccione por lo menos un valor para la busqueda");
			
		 }else{		 
			var filter = {
					 sector: entities.economicActivityFilter.economicSector,
					 subsector: entities.economicActivityFilter.economicSubSector,
					 actividadEconomica: entities.economicActivityFilter.economicActivity,
					 subactividadEconomica:entities.economicActivityFilter.economicSubActivity,
					 AclaracionFIE:entities.economicActivityFilter.clarificationFie
				};
			executeCommandEventArgs.commons.api.grid.refresh('QV_ECONC3050_94', filter);
		}
    };

    //**********************************************************
    //  Eventos de QUERY
    //**********************************************************    
    //QueryEconomicActivity  Entity: economicActivity 
    task.executeQuery.Q_ECONCATI_3050 = function(executeQueryEventArgs) {
        //executeQueryEventArgs.commons.execServer = false;
        executeQueryEventArgs.commons.api.grid.setAppendRecordsParams('QV_ECONC3050_94',['codeSubActivity'],executeQueryEventArgs);
        console.log('Query Economic');
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //selectEcActivity QueryView: GridEconomicActivity
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_ECONC3050_94 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
		var api = gridRowSelectingEventArgs.commons.api;
        var grid = api.grid,
            selectedRows = grid.getSelectedRows("QV_ECONC3050_94"),
            actividadEconomicaSeleccionada;
        var result = {
            actividadEconomicaSeleccionada: selectedRows[0]
        };
        if(selectedRows.length > 0){
            api.vc.closeModal(result);
        }
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: FormSearchEconomicActivity 
    task.initData.VC_CCOVI89_AECIT_172 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
		var grid = initDataEventArgs.commons.api.grid;
		grid.hideColumn('QV_ECONC3050_94','codeSubActivity');
		grid.hideColumn('QV_ECONC3050_94','codeSector');
		grid.hideColumn('QV_ECONC3050_94','codeSubsector');
		grid.hideColumn('QV_ECONC3050_94','codeEconomicActivity');
		grid.title('QV_ECONC3050_94', 'sector', 'BUSIN.DLB_BUSIN_SECOEOMIC_22874');
		grid.title('QV_ECONC3050_94', 'subSector', 'BUSIN.DLB_BUSIN_SSECOEOMO_44400');
		grid.title('QV_ECONC3050_94', 'economicActivity', 'BUSIN.DLB_BUSIN_TIVDECOIA_60481');
		grid.title('QV_ECONC3050_94', 'ecSubActivity', 'BUSIN.DLB_BUSIN_CIIADCMIC_02730');
		grid.title('QV_ECONC3050_94', 'clarificationFIE', 'BUSIN.DLB_BUSIN_ALARACIFI_82775');
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: FormSearchEconomicActivity 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
    };

}());