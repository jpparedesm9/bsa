<!-- Designer Generator v 5.0.0.1508 - release SPR 2015-08 30/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.taskdisbursementformexecution;
	var taskHeader = {};

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //LoanHeader.BalanceOperation (TextInputBox) View: DisbursementForms
    /*task.change.VA_DISURMETFR5106_BAIO267 = function(entities, changedEventArgs) {
        // changedEventArgs.commons.execServer = false;
    };*/

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Boton Liquidar (Button)
    task.executeCommand.CM_SIURM23TOR49 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

    task.executeCommandCallback.CM_SIURM23TOR49 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var parentApi = executeCommandEventArgs.commons.api.parentApi();

		//Habilitar boton continuar si se ejecuta la Liquidacion correctamente
		 if(parentApi != undefined && executeCommandEventArgs.success){
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
		 }else{
			parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		 }
    };
    //**********************************************************
    //  Eventos de QUERY VIEW
    //**********************************************************
    //QueryView: GridDisbursementDetail
    task.gridInitDetailTemplate.QV_TSRSE1342_26 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //delete QueryView: GridDisbursementDetail
    task.gridRowDeleting.QV_TSRSE1342_26 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = false;
    };

    //RowSelLiquidateValue QueryView: GridDetailLiquidateValues
    task.gridRowSelecting.QV_TDLIA9011_50 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //NewForm (ImageButton) QueryView: GridDisbursementDetail
    task.gridCommand.CEQV_201_QV_TSRSE1342_26_253 = function(entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
    };

	task.showGridRowDetailIcon.QV_TSRSE1342_26 = function (entities, showGridRowDetailIconEventArgs){
		var result=false;
		var row = showGridRowDetailIconEventArgs.rowData;
		if(row.Currency == "" && row.DisbursementForm == "" && row.DisbursementValue == 0 && row.PriceQuote == 0){
			result=true;
		}else{
			result=false;
		}
		return result;
	};

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormDisbursementFormsExecution
    task.initData.VC_SIURM23_BETIO_527 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = true;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.LoanHeader.Operation = parentParameters.Task.processInstanceIdentifier;
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";
		entities.generalData.officerName = "";
		entities.LoanHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;

		//Obteniendo cliente del inbox
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		entities.LoanHeader.Customer = client.clientName;
		entities.LoanHeader.CustomerId = client.clientId;
			
		//initDataEventArgs.commons.api.viewState.label('VA_DISURMETFR5106_OAIO459', 'BUSIN.DLB_BUSIN_OPEIONBER_32159', false);		
		//DESEMBOLSO BAJO LINEA CREDITO
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		if (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' &&
		    client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' ){
			entities.LoanHeader.NumberLine = client.bussinessInformationStringOne;
			BUSIN.API.show(initDataEventArgs.commons.api.viewState , ['VA_DISURMETFR5106_UERE335']);
			initDataEventArgs.commons.api.viewState.disable("VA_DISURMETFR5106_UERE335");
		}
    };

	task.initDataCallback.VC_SIURM23_BETIO_527 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.api.grid.hideToolBarButton('QV_TSRSE1342_26', 'CEQV_201_QV_TSRSE1342_26_253');
		initDataEventArgs.commons.api.viewState.hide('CM_SIURM23TOR49');
		var ds = initDataEventArgs.commons.api.vc.model['DisbursementDetail'];
		var dsData = ds.data();
		for (var i = 0; i < dsData.length; i ++) {
			initDataEventArgs.commons.api.grid.hideGridRowCommand('QV_TSRSE1342_26', dsData[i], 'delete');
		}
		if(initDataEventArgs.success){
			BUSIN.INBOX.STATUS.nextStep(true,initDataEventArgs.commons.api);
			//initDataEventArgs.commons.api.parentVc.model.Task.servicesID = 'ICommitDisbursementLoan.commitDisbursementLoan';
		}
		task.loadTaskHeader(entities,initDataEventArgs);
	};
	
	task.render = function(entities, renderEventArgs) {
		var viewState = renderEventArgs.commons.api.viewState;
		var ctrs = ['GR_DISURMETFR51_06'];
		BUSIN.API.hide(viewState,ctrs);
		//$("#VC_SIURM23_BETIO_527").attr("style","padding-top:0px")//ajuste en el estilo, pasarse a estilos de base
	};
	
	task.loadTaskHeader=function(entities,eventArgs){
		var client = eventArgs.commons.api.parentVc.model.Task;
		var originalh=entities.LoanHeader;
		var plazo='';	
						
		//Titulo de la cabecera (title)
		LATFO.INBOX.addTaskHeader(taskHeader,'title',client.clientName);		
		
		//Subtitulos de la cabecera		
		LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(originalh.Operation==null||originalh.Operation=='null' ? '--':originalh.Operation),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((originalh.ProposedAmount ==null||originalh.ProposedAmount =='null' ? 0:originalh.ProposedAmount ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',entities.generalData.symbolCurrency,0);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Plazo',plazo,0);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);no existe este campo
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',cobis.userContext.getValue(cobis.constant.USER_OFFICE).value,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficial',((entities.generalData.officerName!="--")?entities.generalData.officerName:cobis.userContext.getValue(cobis.constant.USER_FULLNAME)),1);
		//LATFO.INBOX.addTaskHeader(taskHeader,'Fecha Inicio',BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(),"0",2)+"/"+ BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth()+1),"0",2)+"/"+originalh.InitialDate.getFullYear(),1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.addTaskHeader(taskHeader,'Vinculado',entities.generalData.vinculado,1);		
		LATFO.INBOX.addTaskHeader(taskHeader,'Sector',entities.generalData.sectorNeg,1);		
		//Actualizo el grupo de designer
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
	};
	
}());