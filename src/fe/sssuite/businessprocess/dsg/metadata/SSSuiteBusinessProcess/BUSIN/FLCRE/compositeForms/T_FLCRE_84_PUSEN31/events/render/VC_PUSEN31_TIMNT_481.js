//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: TPunishmentPlan
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
		var viewState = renderEventArgs.commons.api.viewState;
		var grid = renderEventArgs.commons.api.grid;
		var ds = renderEventArgs.commons.api.vc.model['PersonalGuarantor'];
		var dsData = ds.data();
        
        task.MODE=parentParameters.Task.urlParams.MODE;
		task.EtapaTramite = parentParameters.Task.urlParams.ETAPA;
		for (var i = 0; i < dsData.length; i ++) {
			var dsRow = dsData[i];
			grid.hideGridRowCommand('QV_PESAU2317_81', dsRow, 'delete');
			grid.hideGridRowCommand('QV_PESAU2317_81', dsRow, 'edit');
		}
		renderEventArgs.commons.api.grid.hideColumn('QV_PESAU2317_81','GuarantorPrimarySecondary');
		renderEventArgs.commons.api.grid.hideColumn('QV_PESAU2317_81','Type');
				
		renderEventArgs.commons.api.grid.hideColumn('QV_BOREG0798_55','TypeDocumentId');
		//renderEventArgs.commons.api.grid.hideColumn('QV_BOREG0798_55','Qualification');
		
		renderEventArgs.commons.api.viewState.hide('CM_PUSEN31RIN94');				
		task.showButtons(renderEventArgs);
		//******************************************/
		viewState.enable('VA_VIEANSHMET7202_AUOA601');		
		//********Modo		
		//Consulta
		if(task.MODE==FLCRE.CONSTANTS.Mode.Query){//en el caso de que la tarea se utilice con todos los campos deshabilitados			
			var ctrsToDisable = ['GR_VIEANSHMET72_02','GR_VIEANSHMET72_03','GR_VIEANSHMET72_04',//grupos de datos generales 
			'VC_PUSEN31_GOOMB_570','VC_PUSEN31_GSIOE_966','VC_PUSEN31_OSMBR_895'];//secciones monto/saldo, deudores, garantias
			BUSIN.API.disable(viewState,ctrsToDisable);
			var dsMonto = renderEventArgs.commons.api.vc.model['Amount'];
			var dsDataMonto = dsMonto.data();				
		}
		//********Etapas
		//Ingreso
		if(task.EtapaTramite==FLCRE.CONSTANTS.Stage.IngresoDeDatos){
			var ctrsToHide=['GR_VIEANSHMET72_04'];//grupo recomendacion
			BUSIN.API.hide(viewState,ctrsToHide);
		}
		//Verificacion
		if(task.EtapaTramite==FLCRE.CONSTANTS.Stage.RevisedRecommendation){
			var ctrsToDisable = ['GR_VIEANSHMET72_02','GR_VIEANSHMET72_03',//grupos de datos generales 
			'VC_PUSEN31_GOOMB_570','VC_PUSEN31_GSIOE_966','VC_PUSEN31_OSMBR_895'];//secciones monto/saldo, deudores, garantias
			BUSIN.API.disable(viewState,ctrsToDisable);			
			var ctrsToShow=['GR_VIEANSHMET72_04'];//grupo recomendacion
			BUSIN.API.show(viewState,ctrsToShow);
		}
        if(task.EtapaTramite==FLCRE.CONSTANTS.Stage.Massive//carga masiva, envio a pantalla modal
		){
			var elem=document.getElementById("VC_PUSEN31_TIMNT_481");
			elem.setAttribute("class","cb-view-container cb-without-margins cb-group-layout ng-scope container-fluid");			
		}
		//********Tramite				
		
		//QUITA BOTONES DEL GRID DE DUDORES
		grid.hideToolBarButton('QV_BOREG0798_55', 'create');
		grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');

        // Doble linea en cabecera de grillas
        var headerTitleAmount = ['Concept', 'AgreedAmount', 'AmountPaid', 'BalanceCutoffDate', 'BalanceDate'];
        BUSIN.API.GRID.addColumnsStyle('QV_UERMO1513_46', 'Grid-Column-Header', renderEventArgs.commons.api, headerTitleAmount);

        var headerTitleBorrowers = ['CustomerCode', 'CustomerName', 'Role', 'Identification', 'Qualification'];
        BUSIN.API.GRID.addColumnsStyle('QV_BOREG0798_55', 'Grid-Column-Header', renderEventArgs.commons.api, headerTitleBorrowers);

        var aux = $("#QV_BOREG0798_55").data("kendoGrid");
        aux.hideColumn(8); //TODO: Esperar entrega de designer para ocultar columna de botones, en este caso se oculta con el id de la columna        
    };