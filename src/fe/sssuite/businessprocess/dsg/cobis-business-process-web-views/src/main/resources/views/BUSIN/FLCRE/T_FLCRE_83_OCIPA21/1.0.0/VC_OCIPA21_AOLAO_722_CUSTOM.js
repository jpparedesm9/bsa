<!-- Designer Generator v 5.0.0.1508 - release SPR 2015-08 30/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";
    var task = designerEvents.api.reallocationapplication;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //.Search (Button) View: ReallocationApplication
    task.executeCommand.VA_RALLTIPLAI7410_0000703 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
    };

    //FilterApplications.FlowType (ComboBox) View: ReallocationApplication
    task.loadCatalog.VA_RALLTIPLAI7407_FWPE686 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.FilterApplications = true;
		loadCatalogDataEventArgs.commons.execServer = true;
		
    };

    //FilterApplications.Official (ComboBox) View: ReallocationApplication
    task.loadCatalog.VA_RALLTIPLAI7407_OIIL146 = function(loadCatalogDataEventArgs) {
        var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
        serverParameters.FilterApplications = true;
		loadCatalogDataEventArgs.commons.execServer = true;
    };

    //FilterApplications.AssigningOfficial (ComboBox) View: ReallocationApplication
    task.loadCatalog.VA_RALLTIPLAI7408_SNGI309 = function(loadCatalogDataEventArgs) {
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
		serverParameters.FilterApplications = true;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Assign Official (Button)
    task.executeCommand.CM_OCIPA21DTE50 = function(entities, executeCommandEventArgs) {
	   if (entities.FilterApplications.Official===entities.FilterApplications.AssigningOfficial){
		 executeCommandEventArgs.commons.messageHandler.showMessagesInformation('BUSIN.DLB_BUSIN_ASIGOFICE_68233')
		 executeCommandEventArgs.commons.execServer = false;
	   }
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: ReallocationApplication
    task.initData.VC_OCIPA21_AOLAO_722 = function(entities, initDataEventArgs) {
		var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE);
		var subsidiary = cobis.userContext.getValue(cobis.constant.USER_FILIAL);
		entities.FilterApplications.Office = office.code;
		//entities.FilterApplications.Subsidiary = subsidiary.code;
	    initDataEventArgs.commons.execServer = true;
	};

	//QueryView: GridApplications
    task.gridInitColumnTemplate.QV_ERPLI1480_27 = function(idColumn) {
        if(idColumn === 'Selection'){
			return "<input type=\'checkbox\' name=\'Selection\' id=\'VA_RALLTIPLAI7406_SLIO599\' #if (Selection === true) {# checked #}# ng-click=\"vc.grids.QV_ERPLI1480_27.events.customRowClick($event, \'VA_RALLTIPLAI7406_SLIO599\', \'Applications\', grids.QV_ERPLI1480_27)\"/>";
		}
    };

	task.gridRowCommand.VA_RALLTIPLAI7406_SLIO599 = function(entities, args) {
		var x=0;
		args.commons.execServer = false;
		var index = args.rowIndex;
		for (var i = 0; i<=entities.Applications.data().length; i++)
		{
			if (i === index)
				entities.Applications.data()[i].Selection = !entities.Applications.data()[i].Selection;
		}
    };

}());