<!-- Designer Generator v 5.0.0.1518 - release SPR 2015-16 18/09/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.entrywarrantyticket;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity:
    //.Boton (Button) View: ViewGuaranteesTicket
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_IEWGUARNTK6812_0000459 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_24_GURNH31','VC_GURNH31_OMREA_904');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
		nav.modalProperties = { size: 'lg' };
		nav.queryParameters = { mode: executeCommandEventArgs.commons.constants.mode.Update };
		nav.customDialogParameters = {operationComext: entities.HeaderGuaranteesTicket.CurrencyRequested };
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);
    };
	task.closeModalEvent.VC_GURNH31_OMREA_904 = function(eventArgs){
		FLCRE.UTILS.GUARANTEE.addFromSearch(eventArgs);
    };

    //Entity: OriginalHeader
    //OriginalHeader.CreditSector (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6805_EDCT992 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: OriginalHeader
    //OriginalHeader.Province (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6805_OINC062 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6806_LIES496 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IEWGUARNTK6809_EEAR819 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.CreditLineDistrib (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEWGUARNTK6806_LIES496 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.WarrantyType (ComboBox) View: ViewGuaranteesTicket
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_IEWGUARNTK6806_WNTP122 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.HeaderGuaranteesTicket = true;

    };

    //Entity: HeaderGuaranteesTicket
    //HeaderGuaranteesTicket.NameBeneficiary (TextInputButton) View: ViewGuaranteesTicket
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto.
    task.textInputButtonEvent.VA_IEWGUARNTK6809_EEAR819 = function(textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Asoaciar (Button)
    task.executeCommand.CM_NTATT53AAR41 = function(entities, executeCommandEventArgs) {
		var parentApi = executeCommandEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;

		var dsPersonalGuarantor= executeCommandEventArgs.commons.api.vc.model['PersonalGuarantor'];
		var dsOtherWarranty = executeCommandEventArgs.commons.api.vc.model['OtherWarranty'];
		var dsDataPersonalGuarantor = dsPersonalGuarantor.data();
		var dsOtherWarranty = dsOtherWarranty.data();
		var lengthPersonalGuarantor=dsDataPersonalGuarantor.length;
		var lengthOtherWarranty=dsOtherWarranty.length;

		if (lengthPersonalGuarantor > 0 && lengthOtherWarranty > 0){
			executeCommandEventArgs.commons.execServer = true;
		}else if (lengthPersonalGuarantor > 0 || lengthOtherWarranty > 0){
			executeCommandEventArgs.commons.execServer = true;
		}else{
			executeCommandEventArgs.commons.execServer = false;
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_UEIESURTA_16554');
		}
		//Valida que este ingresada Fecha CIC - Sección de 'Garantía Personal'
		if(!FLCRE.UTILS.GUARANTEE.hasDateCIC(entities,executeCommandEventArgs,true)){
			executeCommandEventArgs.commons.execServer = false;
			return;
		}
    };

	task.executeCommandCallback.CM_NTATT53AAR41 = function(entities, executeCommandCallbackEventArgs) { //Compute (Button)
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
        task.disableRowGrid(executeCommandCallbackEventArgs, 'OtherWarranty', 'QV_URYTH5890_66');
		task.disableRowGrid(executeCommandCallbackEventArgs, 'PersonalGuarantor','QV_PESAU2317_81');
		executeCommandCallbackEventArgs.commons.api.grid.addColumnStyle('QV_PESAU2317_81', 'DateCIC', 'Enable_CTR');
		if(parentApi != undefined && executeCommandCallbackEventArgs.success){
		var parentVc = parentApi.vc;
		task.enableBotonContinuar(parentVc,executeCommandCallbackEventArgs);
     }
	};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //fileDeleting QueryView: GridPersonalGuarantor
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_PESAU2317_81 = function(entities, gridRowDeletingEventArgs) {

		var parentApi = gridRowDeletingEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		task.enableBotonContinuar(parentVc,gridRowDeletingEventArgs);
		gridRowDeletingEventArgs.commons.execServer = true;
    };

    //FileDeleting QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_URYTH5890_66 = function(entities, gridRowDeletingEventArgs) {

		var parentApi = gridRowDeletingEventArgs.commons.api.parentApi();
		var parentVc = parentApi.vc;
		task.enableBotonContinuar(parentVc,gridRowDeletingEventArgs);
		 gridRowDeletingEventArgs.commons.execServer = true;
    };

    //Selecting Personal QueryView: GridPersonalGuarantor
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_PESAU2317_81 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };
	task.gridInitColumnTemplate.QV_PESAU2317_81 = function(idColumn) { //QueryView: GridPersonalGuarantor
		if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.GUARANTEE.getTemplateForDateCIC();
		}
	};
	task.change.VA_PRSAUARNTE3588_DATE142 = function(entities, changedEventArgs) {
		changedEventArgs.commons.execServer = false;
		FLCRE.UTILS.GUARANTEE.setDateCIC(changedEventArgs);
	};

    //Selecting Other QueryView: GridOtherWarranty
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_URYTH5890_66 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: EntryWarrantyTicket
    task.initData.VC_NTATT53_WAACE_467 = function(entities, initDataEventArgs) {
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.HeaderGuaranteesTicket.CustomerName=client.clientName; //Recupero el NOmbre del Cliente
		entities.HeaderGuaranteesTicket.CustomerType = client.clientType;//Se agrega el tipo de cliente para buscar dirección del cliente
		entities.HeaderGuaranteesTicket.RenewOperation= client.bussinessInformationStringOne; // Se agrega el valor de la operacion a renovar

		entities.HeaderGuaranteesTicket.CustomerId=client.clientId;//Recupero el Id del Cliente
		//entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.HeaderGuaranteesTicket.User = cobis.userContext.getValue(cobis.constant.USER_NAME);
    };
    task.initDataCallback.VC_NTATT53_WAACE_467 = function(entities, initDataEventArgs) { //initData
		initDataEventArgs.commons.api.grid.showColumn ('QV_PESAU2317_81', 'DateCIC'); //PONE VISIBLE EL CAMPO DateCIC - EN GARANTIAS PERSONALES
	};

    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: EntryWarrantyTicket
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
		var viewState = renderEventArgs.commons.api.viewState;
		task.showField(viewState);
		task.hideField(viewState);
		task.disableAllField(viewState);
		renderEventArgs.commons.api.viewState.refreshData('VA_IEWGUARNTK6806_WNTP122');
		BUSIN.API.readOnlyAsync(renderEventArgs,['VA_IEWGUARNTK6806_WNTP122'],true,3000); //Tipo de Garantía
		task.disableRowGrid(renderEventArgs, 'OtherWarranty', 'QV_URYTH5890_66');
		task.disableRowGrid(renderEventArgs, 'PersonalGuarantor','QV_PESAU2317_81');
		renderEventArgs.commons.api.grid.addColumnStyle('QV_PESAU2317_81', 'DateCIC', 'Enable_CTR');
    };

	//Funcion para deshabilitar todos los campos
	task.hideField = function(viewState) {
		var grps = ['GR_IEWGUARNTK68_09','GR_IEWGUARNTK68_08','VA_IEWGUARNTK6810_OUEE698','VA_IEWGUARNTK6810_DLCO699','VA_IEWGUARNTK6810_ALNI891','VA_IEWGUARNTK6810_INTE642',
		'VA_IEWGUARNTK6805_EDCT992','VA_IEWGUARNTK6806_REWP949','VA_IEWGUARNTK6812_0000268'];
		BUSIN.API.hide(viewState,grps);
	};
	//Funcion para deshabilitar todos los campos
	task.disableAllField = function(viewState) {
		var grps = ['VA_IEWGUARNTK6805_OINC062','VA_IEWGUARNTK6806_RRQE376','VA_IEWGUARNTK6806_WNTS030','VA_IEWGUARNTK6806_WNTP122','VA_IEWGUARNTK6806_TREU555','VA_IEWGUARNTK6806_ATRO527','VA_IEWGUARNTK6806_UMRO301',
		'VA_IEWGUARNTK6807_TORR665','VA_IEWGUARNTK6806_LIES496','VA_IEWGUARNTK6806_EUER032','VA_IEWGUARNTK6806_POTE119','VA_IEWGUARNTK6806_DAPS003'];
		BUSIN.API.disable(viewState,grps);
	};
	task.showField = function(viewState){
		var grps = ['VA_IEWGUARNTK6812_0000459','VA_IEWGUARNTK6805_OINC062','VA_IEWGUARNTK6805_EDCT992','VA_IEWGUARNTK6806_DAPS003'];
		BUSIN.API.show(viewState,grps);
	}
	task.disableRowGrid = function(renderEventArgs, entity, IdGrid ){
		//HABILITA LAS FILAS DE LA GRILLA DE LAS GARANTIAS QUE SE PUEDEN APROBAR
		var ds = renderEventArgs.commons.api.vc.model[entity];
		var grid = renderEventArgs.commons.api.grid;
		var dsData = ds.data();
        for (var i = 0; i < dsData.length; i ++) {
            var dsRow = dsData[i];
            if(dsRow.isHeritage === 'S'){
                grid.addRowStyle(IdGrid, dsRow, 'Disable_CTR');
			    grid.hideGridRowCommand(IdGrid, dsRow, 'delete');
            }else{
				grid.removeRowStyle(IdGrid, dsRow, 'Disable_CTR');
				grid.showGridRowCommand(IdGrid, dsRow, 'delete');
			}
        }
		renderEventArgs.commons.api.viewState.refreshData(IdGrid);
	}

	//Permite habilitar el continuar cuando se tenga una sóla garantia, ya sea de la grilla PersonalGuarantor o de OtherWarranty
	task.enableBotonContinuar=function(parentVc,gridRowDeletingEventArgs){
		var dsPersonalGuarantor= gridRowDeletingEventArgs.commons.api.vc.model['PersonalGuarantor'];
		var dsOtherWarranty = gridRowDeletingEventArgs.commons.api.vc.model['OtherWarranty'];
		var dsDataPersonalGuarantor = dsPersonalGuarantor.data();
		var dsOtherWarranty = dsOtherWarranty.data();
		var lengthPersonalGuarantor=dsDataPersonalGuarantor.length;
		var lengthOtherWarranty=dsOtherWarranty.length;

		if (lengthPersonalGuarantor > 0 && lengthOtherWarranty > 0){
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";

		}else if (lengthPersonalGuarantor > 0 || lengthOtherWarranty > 0){
					parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
				}else{
					parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
				}
	}

}());