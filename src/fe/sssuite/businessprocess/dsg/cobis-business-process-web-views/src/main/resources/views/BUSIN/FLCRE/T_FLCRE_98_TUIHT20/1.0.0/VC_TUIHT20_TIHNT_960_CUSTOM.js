<!-- Designer Generator v 5.0.0.1511 - release SPR 2015-11 12/06/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tpunishment;
	var fechaCorte = new Date();
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Procesar QueryView: GDPunishment
    task.gridRowCommand.VA_VIWPUISHMN4305_CTDT569 = function(entities, gridRowCommandEventArgs) {
	};
    task.gridRowCommandCallback.VA_VIWPUISHMN4305_CTDT569 = function(entities, gridRowCommandEventArgs) {
        if(gridRowCommandEventArgs.success){
			gridRowCommandEventArgs.commons.api.grid.hideGridRowCommand('QV_URPUH4848_33', gridRowCommandEventArgs.rowData, 'VA_VIWPUISHMN4305_CTDT569');
			//Se abre la pantalla del inbox
			var menu = cobis.translate('COMMONS.MENU.MNU_REQUEST_PUNISHMENT');
			BUSIN.INBOX.STATUS.openNewTab(entities.HeaderPunishment.ApplicationNumber,menu);
		}
	};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //Seleccionar QueryView: GDPunishment
    task.gridRowSelecting.QV_URPUH4848_33 = function(entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
		 var nav = gridRowSelectingEventArgs.commons.api.navigation;
        fechaCorte = gridRowSelectingEventArgs.rowData.idCategory;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: TPunishment
    task.initData.VC_TUIHT20_TIHNT_960 = function(entities, initDataEventArgs) {
        var user = cobis.userContext.getValue(cobis.constant.USER_NAME);
		initDataEventArgs.commons.execServer = true;
		entities.HeaderPunishment.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
    };

    //ViewContainer: TPunishment
    task.render = function(entities, renderEventArgs) {
		var ctr = ['Operation','DescriptionClient','Bank','OperationStatus','CapitalBalance','InterestBalance','MoraBalance','OtherBalance','LastPaymentDate','MoraDay'];
		BUSIN.API.GRID.addColumnsStyle('QV_URPUH4848_33', 'Grid-Column-Header',renderEventArgs.commons.api,ctr);
        renderEventArgs.commons.execServer = false;
    };

}());