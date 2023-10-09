<!-- Designer Generator v 5.0.0.1510 - release SPR 2015-10 29/05/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.entrywarrantymodifyline;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //GuaranteesBtn.SearchGuarantees (Button) View: GuaranteesView
    task.executeCommand.VA_UARNTEESEW9610_HBTN418 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_24_GURNH31','VC_GURNH31_OMREA_904');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
		nav.modalProperties = { size: 'lg' };
		nav.queryParameters = { mode: executeCommandEventArgs.commons.constants.mode.Update };
		nav.customDialogParameters = { };
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);
    };
    task.closeModalEvent.VC_GURNH31_OMREA_904 = function(eventArgs){
		FLCRE.UTILS.GUARANTEE.addFromSearch(eventArgs);
    };

    //LineHeader.[Control Sin Nombre] (TextLink) View: ApplicationHeaderView
	//task.executeCommand.VA_APITONEAEE5507_0000606 = function(entities, executeCommandEventArgs) { // ACH -- hoy porque se cambio del id anterior...
    task.executeCommand.VA_APITONEAEE5510_0000944 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //executeCommandEventArgs.commons.messageHandler.showMessagesInformation('Vista de Detalle Linea');
        var nav = executeCommandEventArgs.commons.api.navigation;
		nav.label =cobis.translate('BUSIN.DLB_BUSIN_CUOMREARH_28245');
        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_14_NEEDA85',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_NEEDA85_LHEIL_830'
        };
        nav.customDialogParameters = {
            lineHeader: entities['LineHeader']
        };
                               nav.popoverProperties = {
            width: 500,
            height: 'auto',
            position: "left bottom"
        };
        nav.openPopover(executeCommandEventArgs.commons.controlId);

    };
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Associate (Button)
    task.executeCommand.CM_EATLI88ITE28 = function(entities, executeCommandEventArgs) {
		if(!FLCRE.UTILS.GUARANTEE.hasDateCIC(entities,executeCommandEventArgs,true)){ //Valida que este ingresada Fecha CIC - Sección de 'Garantía Personal'
			executeCommandEventArgs.commons.execServer = false;
			return;
		}
    };
	task.executeCommandCallback.CM_EATLI88ITE28 = function(entities, executeCommandCallbackEventArgs) {
		BUSIN.INBOX.STATUS.nextStep(executeCommandCallbackEventArgs.success,executeCommandCallbackEventArgs.commons.api);
	};
    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //fileDeleting QueryView: GridPersonalGuarantor
    task.gridRowDeleting.QV_PESAU2317_81 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = true;
    };

    //FileDeleting QueryView: GridOtherWarranty
    task.gridRowDeleting.QV_URYTH5890_66 = function(entities, gridRowDeletingEventArgs) {
         gridRowDeletingEventArgs.commons.execServer = true;
    };

    //Selecting Personal QueryView: GridPersonalGuarantor
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
    task.gridRowSelecting.QV_URYTH5890_66 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: FormEntryWarrantyModifyLine
    task.initData.VC_EATLI88_FNNTI_747 = function(entities, initDataEventArgs) {
        BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
        var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		//MCA
		//entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringTwo;
		entities.LineHeader.Number = parentParameters.Task.bussinessInformationStringOne;
		entities.OriginalHeader.UserL=userL;
        entities.OriginalHeader.TypeRequest = "P";
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.Office=office;
		initDataEventArgs.commons.execServer = true;
    };
	task.initDataCallback.VC_EATLI88_FNNTI_747 = function(entities, initDataEventArgs) { //initData
		BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
		initDataEventArgs.commons.api.grid.showColumn ('QV_PESAU2317_81', 'DateCIC'); //PONE VISIBLE EL CAMPO DateCIC - EN GARANTIAS PERSONALES
    };
    //ViewContainer: FormEntryWarrantyModifyLine
    task.render = function(entities, renderEventArgs) {
         renderEventArgs.commons.execServer = false;
		 var api = renderEventArgs.commons.api;
		// Deshabilito campos de la cabecera
		 api.viewState.disable("VA_APITONEAEE5505_RTAY481");
		 api.viewState.disable("VA_APITONEAEE5505_PROE367");
		 api.viewState.disable("VA_APITONEAEE5505_USED740");
		 api.viewState.disable("VA_APITONEAEE5505_NDTE867");
		 api.viewState.disable("VA_APITONEAEE5505_TERM140");
		 api.viewState.disable("VA_APITONEAEE5505_XPIA086");
		 api.viewState.disable("VA_APITONEAEE5505_OFIC220");
		 api.viewState.disable("VA_APITONEAEE5505_SCTR004");
		 api.viewState.disable("VA_APITONEAEE5505_ADSN125");
		 api.viewState.disable("VA_APITONEAEE5506_ITCE223");
		 api.viewState.disable("VA_APITONEAEE5506_IALT470");
		 api.viewState.disable("VA_APITONEAEE5506_OQUE114");
		 api.viewState.disable("VA_APITONEAEE5506_TERM631");
		 api.viewState.disable("VA_APITONEAEE5506_FICE377");
		 api.viewState.disable("VA_APITONEAEE5511_RQSD053"); //Deshabilito el Código de Solicitud
		 api.viewState.disable("VA_APITONEAEE5505_EPRO465"); //Deshabilito la moneda
		 // Deshabilito monto que se encuentra junto a bonton buscar garantias
		renderEventArgs.commons.api.viewState.hide('VA_UARNTEESEW9610_ONTO328');
    };

}());