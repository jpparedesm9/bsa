//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DocumentPrintingMain
    task.initData.VC_DOCUMENTIG_406178 = function (entities, initDataEventArgs){
        
        initDataEventArgs.commons.execServer = true;
		var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;	
        groupSummary=parameters.parameters.groupSummary;
        operationType=parameters.parameters.operationType;
        disbursementDate=parameters.parameters.disbursementDate;
		
        var Documents = [];
		
    /*  Documents[0] = new Print();
		Documents[0].codigo = 1;
		Documents[0].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_LIQUIDAOA_52380');
		Documents[0].item = false;*/

/*		Documents[1] = new Print();
		Documents[1].codigo = 2;
		Documents[1].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_RECIBOPAG_89342');
		Documents[1].item = false;*/

		Documents[0] = new Print();
		Documents[0].codigo = 3;
		Documents[0].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_TABLAAMIA_39175');
		Documents[0].item = false;

	/*	Documents[3] = new Print();
		Documents[3].codigo = 4;
		Documents[3].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PAGAREAER_20693');
		Documents[3].item = false;

		Documents[4] = new Print();
		Documents[4].codigo = 5;
		Documents[4].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_CONTRATUR_52943');
		Documents[4].item = false;*/
        
        Documents[1] = new Print();
        Documents[1].codigo = 6;
        Documents[1].documentos = 'FICHA DE PAGO CR\u00c9DITO LCR';
        Documents[1].item = false;
        
        Documents[2] = new Print();
        Documents[2].codigo = 7;
        Documents[2].documentos = 'FICHA DE PAGO';
        Documents[2].item = false;
        
        Documents[3] = new Print();
        Documents[3].codigo = 8;
        Documents[3].documentos = 'FICHA DE PRE CANCELACI\u00d3N';
        Documents[3].item = false;
        
        //FICHA DE PAGO GENÉRICA
        if (cobis.containerScope.userInfo.roleName == 'MESA DE OPERACIONES' || cobis.containerScope.userInfo.roleName == 'COBRANZA') {
		    Documents[4] = new Print();
            Documents[4].codigo = 9;
            Documents[4].documentos = initDataEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_FICHADEOO_52167');
            Documents[4].item = false;
        }

	   initDataEventArgs.commons.api.grid.addAllRows('PrintingDocuments',Documents);
        
       initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_5CO');
        initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_MPN');
        initDataEventArgs.commons.api.viewState.hide('CM_TDOCUMEN_1RO');
        
        angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function(processDate)         {
            console.log(processDate);
            processDateLocal = processDate;
        }
        )
    };