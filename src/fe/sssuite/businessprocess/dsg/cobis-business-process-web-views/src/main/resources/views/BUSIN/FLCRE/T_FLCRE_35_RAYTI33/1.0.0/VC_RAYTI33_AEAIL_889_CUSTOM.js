<!-- Designer Generator v 5.0.0.1516 - release SPR 2015-16 21/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.warrantymodifydetail;
	    task.rowData = '';
		task.RequestName = '';
		task.RequestStage = '';
		task.OtherWarranty = '';
		
	//**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Hide (Button) 
    task.executeCommand.CM_RAYTI33HIE19 = function(entities, executeCommandEventArgs) {
    };
	task.executeCommandCallback.CM_RAYTI33HIE19 = function(entities, executeCommandEventArgs) {
		task.validateRowsCount(entities, executeCommandEventArgs);//CONTROL PARA QUE SOLO DEJE INGRESAR UNA GARANTIA
	}
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************  
    //Insertwarranty QueryView: GWarrantyDetail
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos. 
    task.gridRowInserting.QV_WANTY5919_76 = function(entities, gridRowInsertingEventArgs) {
         gridRowInsertingEventArgs.commons.execServer = true;
    };
	task.gridRowInsertingCallback.QV_WANTY5919_76 = function(entities, gridRowInsertingEventArgs) {
		if(gridRowInsertingEventArgs.success===false){
			gridRowInsertingEventArgs.commons.api.vc.executeCommand('CM_RAYTI33HIE19','Hide', undefined, false, false, 'VC_RAYTI33_AEAIL_889', false);
		}else{
			task.validateRowsCount(entities, gridRowInsertingEventArgs);//CONTROL PARA QUE SOLO DEJE INGRESAR UNA GARANTIA
		}
    };

    //DeleteWuarranty QueryView: GWarrantyDetail
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos. 
    task.gridRowDeleting.QV_WANTY5919_76 = function(entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
		task.validateRowsCount(entities, gridRowDeletingEventArgs);//CONTROL PARA QUE SOLO DEJE INGRESAR UNA GARANTIA
    };

    //After InsertWarranty QueryView: GWarrantyDetail
    //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla. 
    task.gridAfterLeaveInLineRow.QV_WANTY5919_76 = function(entities, gridAfterLeaveInLineRowEventArgs) {
        gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
    };
    //IngresoDeGarantias QueryView: GWarrantyDetail
    //Evento GridBeforeEnterInlineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.. 
    task.gridBeforeEnterInLineRow.QV_WANTY5919_76 = function(entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
			var regs = entities.Warranty.data();
			//Elimina el registro de ingreso
			if(regs.length>0){
				gridABeforeEnterInLineRowEventArgs.commons.api.grid.removeRow('Warranty', 0);
			}
			//Abrir pantalla de busqueda de garantias
			var nav = FLCRE.API.getApiNavigation(gridABeforeEnterInLineRowEventArgs,'T_FLCRE_24_GURNH31','VC_GURNH31_OMREA_904');
			nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
			nav.modalProperties = { size: 'lg' };
			nav.queryParameters = { mode: gridABeforeEnterInLineRowEventArgs.commons.constants.mode.Update };
			nav.customDialogParameters = { };
			nav.openModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId);
	};
	 //**********************************************************
    //  Acciones Windows
    //**********************************************************
	task.closeModalEvent.VC_GURNH31_OMREA_904 = function(args){
		var parameter = args.result.parameterGuarantee;
		var exitsWarranty = false;
		if(task.rowData.CodeWarranty === parameter.GuaranteeCode){
			args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_SQULSOLEA_55728',null,5000); // No puede ingresar la misma garantía
		}
		else{
			//Valida que el registro no se encuentre en la grilla
			if(task.existWarrantyModify(args.model.Warranty, parameter)===false && task.existWarrantyModify(task.OtherWarranty, parameter)===false){
					var Warranty={
								CodeWarranty: parameter.GuaranteeCode,
								Type: parameter.GuaranteeType,
								Description: parameter.Description,
								//GuarantorPrimarySecondary: parameter.GuarantorName,
								InitialValue: parameter.InitialValue,
								DateAppraisedValue: parameter.AppraisedValueDate,
								ValueApportionment: null, //OJA VALIDAR CON AURELIA PORQUE ESTA QUEMADO ESTE VALOR
								ClassOpen: parameter.CloseOpen,
								ValueAvailable: parameter.ValueAvailable,
								IdCustomer:parameter.CustomerId,
								NameGar: parameter.GuarantorName,
								State: parameter.Status,
								IsNew: true,
								Flag: false
							};
							//Añade a la grilla ejecutando el evento insert de la grilla
							args.commons.api.grid.addRow('Warranty', Warranty, true);
			}else{
				args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_SGXISTNTY_07918',null,5000); // La garantía ya se encuentra ingresada
			}
		}
	}
 //SelectingWarranty QueryView: GWarrantyDetail
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos. 
    task.gridRowSelecting.QV_WANTY5919_76 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: WarrantyModify 
    task.initData.VC_RAYTI33_AEAIL_889 = function(entities, initDataEventArgs) {
		initDataEventArgs.commons.api.viewState.hide('CM_RAYTI33HIE19');
        
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		task.rowData = parentParameters.Data;
		task.OtherWarranty = parentParameters.OtherWarranty;
		if(parentParameters.RequestName != null && parentParameters.RequestName !== undefined){
			task.RequestName = parentParameters.RequestName;
		}
		if(parentParameters.RequestStage != null && parentParameters.RequestStage !== undefined){
			task.RequestStage = parentParameters.RequestStage;
		}
		//Se crea una nueva entidada para con los datos necesarios para las diferentes acciones
		entities.originalInformation = {
			previousWarranties : parentParameters.Data.CodeWarranty, //Código de la garantia padre
			opNumberBank : parentParameters.OriginalHeader.OpNumberBank , //Número de banco
			tramit : parentParameters.OriginalHeader.IDRequested //número de trámite
		}
		initDataEventArgs.commons.execServer = true;
    };

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: WarrantyModify 
    task.render = function(entities, renderEventArgs) {
		task.validateRowsCount(entities, renderEventArgs);
		if(!(task.isWarrantyModify() && task.isEntry())){
			renderEventArgs.commons.api.grid.hideToolBarButton('QV_WANTY5919_76', 'create')
			BUSIN.API.GRID.hideCommandColumns('QV_WANTY5919_76',entities.Warranty.data(),renderEventArgs.commons.api,'delete');	
		}
    };
	//Valida que la garantía no se encuentre ingresada.
	  task.existWarrantyModify = function(Warranty, parameter) { 
	  var regs = Warranty.data();
	  var flag = false;
			if(regs.length>0){
				regs.forEach(function(data){
					if(data.CodeWarranty===parameter.GuaranteeCode){
						flag =  true;
					}
				});
			}
			return flag;	
	  };
	  task.isWarrantyModify = function() { return task.RequestName === FLCRE.CONSTANTS.RequestName.WarrantyModify;};
	  task.isAnalysis = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.Analisis;};
	  task.isAsocWarranty = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.AsociacionGarantias;};
	  task.isEntry = function() { return task.RequestStage === FLCRE.CONSTANTS.Stage.Entry;};
	  
	task.validateRowsCount = function(entities, args) { //CONTROL PARA QUE SOLO DEJE INGRESAR UNA GARANTIA
		if(entities.Warranty.data().length > 0){
			args.commons.api.grid.hideToolBarButton('QV_WANTY5919_76', 'create');
		}else{
			args.commons.api.grid.showToolBarButton('QV_WANTY5919_76', 'create');
		}
    };
}());