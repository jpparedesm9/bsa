<!-- Designer Generator v 5.0.0.1515 - release SPR 2015-15 07/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.taskexecutivebonusrisk;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: ExecutiveBonusHeaderRisk
    //ExecutiveBonusHeaderRisk.startDate (DateField) View: ViewExecutiveBonusRisk
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWEUTEBSK0005_TATA551 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = true;
    };

	task.changeCallback.VA_IEWEUTEBSK0005_TATA551 = function(entities, changedCallbackEventArgs) {
		var viewState = changedCallbackEventArgs.commons.api.viewState;
		var grid = changedCallbackEventArgs.commons.api.grid;
		grid.disabledColumn('QV_ECTIB5101_92', 'agencyName');
		grid.disabledColumn('QV_ECTIB5101_92', 'Regional');
		if(entities.ExecutiveBonusHeaderRisk.processDate <= entities.ExecutiveBonusHeaderRisk.startDate){
			grid.enabledColumn('QV_ECTIB5101_92', 'AdditionalRiskPercentage');
			grid.enabledColumn('QV_ECTIB5101_92', 'GestionRiskPercentage');
			grid.enabledColumn('QV_ECTIB5101_92', 'OperationalRiskPercentage');
			viewState.enable('CM_EENSS78SVE49');
			viewState.show('CM_EENSS78SVE49');
		}else{
			grid.disabledColumn('QV_ECTIB5101_92', 'AdditionalRiskPercentage');
			grid.disabledColumn('QV_ECTIB5101_92', 'GestionRiskPercentage');
			grid.disabledColumn('QV_ECTIB5101_92', 'OperationalRiskPercentage');
			viewState.disable('CM_EENSS78SVE49');
			viewState.hide('CM_EENSS78SVE49');
		}
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Save (Button)
    task.executeCommand.CM_EENSS78SVE49 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: TaskRiskParameterizationExecutiveBonuses
    task.initData.VC_EENSS78_KRZXU_304 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = true;
		entities.ExecutiveBonusHeaderRisk.login = cobis.userContext.getValue(cobis.constant.USER_NAME);
    };

	task.initDataCallback.VC_EENSS78_KRZXU_304 = function(entities, initDataCallbackEventArgs) {
        initDataCallbackEventArgs.commons.execServer = false;
    };

	//Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: TaskRiskParameterizationExecutiveBonuses
    task.render = function(entities, renderEventArgs) {
		var viewState = renderEventArgs.commons.api.viewState;
		viewState.disable('CM_EENSS78SVE49');
		viewState.hide('CM_EENSS78SVE49');
	}
}());