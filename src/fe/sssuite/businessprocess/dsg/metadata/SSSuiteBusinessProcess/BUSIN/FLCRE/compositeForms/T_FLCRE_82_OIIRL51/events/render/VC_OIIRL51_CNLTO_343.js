//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: GenericApplication
task.render = function (entities, renderEventArgs) {
    document.getElementById('VA_TEXTINPUTBOXGRN_916576').readOnly = true;
    var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
    var viewState = renderEventArgs.commons.api.viewState;
    var parentApi = renderEventArgs.commons.api.parentApi();
    var parentVc = parentApi.vc;
    //SMO se agrega en grupales
    var api = renderEventArgs.commons.api;
    var customDialogParameters = renderEventArgs.commons.api.vc.parentVc.customDialogParameters; //--ACHP
    typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
    modeRequest = customDialogParameters.Task.urlParams.MODE; //PXSG    

    /*var ctrs = ['VA_ORIAHEADER8608_TAOR020',
		            'VA_ORIAHEADER8608_TCTC534',
		            'VA_ORIAHEADER8608_TTCD057',
		            'VA_ORIAHEADER8608_CCAA829', // seccion de alicuota
		            'VC_OIIRL51_RUPNR_606',	     // seccion, operaciones,spacerCreditLine
		            'VA_ORIAHEADER8605_TIRC927', // tipoProduto
		            'VA_ORIAHEADER8605_ERTO640'];// Linea de Credito
                    'CM_TFLCRE_8__II' // Botón Validar LCR*/

    var ctrs = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TCTC534', 'VA_ORIAHEADER8608_TTCD057',
        'VA_ORIAHEADER8608_CCAA829', 'VA_ORIAHEADER8605_ERTO640', 'VA_AMOUNTDISBURSEE_600R86',
        'VA_COMBOBOXAURNLPO_247R86', 'VA_INSURANCEPACKEG_674R86', 'VA_TERMMEDICALAISS_991R86', 'CM_OIIRL51INT80', 'CM_TFLCRE_8__II', 'CM_TFLCRE_8_925'
    ]

    BUSIN.API.hide(viewState, ctrs);

    // Template para combo Linea de credito
    var viewState = renderEventArgs.commons.api.viewState;
    var template = '<span><h4>#: value#</h4></span>' + '<span><b>Monto:</b> #: attributes[0] #</span> - ' + '<span><b>Disponible:</b> #: attributes[1] #</span> - ' + '<span><b>Moneda:</b> #: attributes[2] #</span>';
    viewState.template('VA_ORIAHEADER8605_ERTO640', template);

    // Realizo el change para que cambie el segmento
    entities.EntidadInfo.sector = entities.generalData.segment;

    var template2 = '<span><h4>#: code#</h4></span>' + '<span>#: attributes[0]#</span><br>' + '<span>#: attributes[1]#</span><br>' + '<span>#: attributes[2]#</span><br>';
    viewState.template('VA_ORIAHEADER8608_TTCD057', template2);
    viewState.template('VA_ORIAHEADER8608_TAOR020', template2);


    // Alicuota
    var ctrs1Alicuota = [];
    entities.Alicuota.Alicuota = (entities.Alicuota.Alicuota !== null) ? entities.Alicuota.Alicuota : "N-A";
    var alicuotaValue = entities.Alicuota.Alicuota;
    if (alicuotaValue === 'S') {
        ctrs1Alicuota = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TCTC534', 'VA_ORIAHEADER8608_TTCD057', 'VA_ORIAHEADER8608_CCAA829'];
        BUSIN.API.show(viewState, ctrs1Alicuota);
    } else if (alicuotaValue === 'N') {
        viewState.label("VA_ORIAHEADER8608_CCAA829", 'BUSIN.DLB_BUSIN_ALICUOTAI_84613'); // cambio de etiqueta
        ctrs1Alicuota = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TTCD057', 'VA_ORIAHEADER8608_CCAA829'];
        BUSIN.API.show(viewState, ctrs1Alicuota);
        if (entities.Alicuota.CtaCertificada !== undefined) {
            viewState.disableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
        }
        if (entities.Alicuota.CtaAhorros !== undefined) {
            viewState.disableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
        }
    }

    // Modo Consulta
    task.showButtons(renderEventArgs);
    if ((parentParameters.Task.urlParams.MODE === "Q") || (parentParameters.Task.urlParams.MODE === "A")) { // en el caso de que la
        // tarea se utilice con
        // todos los campos
        // deshabilitados
        /*var ctrsToDisable = ['VC_OIIRL51_TBRMT_122',
                             'VC_OIIRL51_PTONI_284',
                             'VC_OIIRL51_GTDOS_515',
                             'VC_OIIRL51_RUPNR_606',
                             'CM_OIIRL51SVE80',
                             'CM_OIIRL51INT80'];// btn guardar, btn imprimir*/

        var ctrsToDisable = ['VC_OIIRL51_TBRMT_122', 'VC_OIIRL51_PTONI_284', 'VC_OIIRL51_GTDOS_515',
            'CM_OIIRL51SVE80'
        ];
        BUSIN.API.disable(viewState, ctrsToDisable);
        if (parentParameters.Task.urlParams.MODE === "A") {
            var ctrsToDisableAutomatic = ['VA_TEXTINPUTBOXGRN_916576',
                'VA_VABUTTONFUIXKXW_718576',
                'VA_CUSTOMEREXPEIII_577R86',
                'VA_COMBOBOXGTFCJFR_317R86'
            ];
            BUSIN.API.disable(viewState, ctrsToDisableAutomatic);
        }
        if (parentParameters.Task.urlParams.TIPO === "C") {
            if (typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
                renderEventArgs.commons.messageHandler.showMessagesInformation('Tiene un credito Activo, espere a su cancelaci\u00f3n.');
            }
        }
        /*renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');// boton
        																				// nuevo
        																				// deudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');// boton
        																										// eliminar
        																										// deudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');// boton
        																										// nuevo
        																										// operaciones
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');// boton
        																										// eliminar
        																										// operaciones*/
        //cambio en grupales
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton nuevodeudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //boton eliminar deudores

        //Ocultar el boton edit del grid de deudores
        //task.hideButtonGridDebtors(renderEventArgs);//no existe en grupales

        //Recupera % de la garantia cuando no hay el boton Guardar en las diferentes Etapas
        var parameterRender = renderEventArgs.commons.api.parentVc.customDialogParameters;
        parameterRender.Task.porcentaje = entities.ApplicationInfoAux.percentageGuarantee;
    }

    /*//Ocultar el boton edit del grid de deudores
    if (parentParameters.Task.urlParams.TRAMITE !== FLCRE.CONSTANTS.RequestName.Renovation &&
        parentParameters.Task.urlParams.TRAMITE !== FLCRE.CONSTANTS.RequestName.Reestructuration){
    	task.hideButtonGridDebtors(renderEventArgs);
    }*/ //SMO no existe en grupales

    // Etapas Tramite
    // Refinanciamiento, Reestructuracion, Renovacion
    if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Refinancing ||
        parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation ||
        parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration) {

        // Grilla de operaciones y tipo de producto en los flujos
        // especificos
        //var ctrsToShow = ['VC_OIIRL51_RUPNR_606', 'VA_ORIAHEADER8605_TIRC927'];
        //cambio grupales
        var ctrsToShow = [ //'VC_OIIRL51_RUPNR_606', 
            'VA_ORIAHEADER8605_TIRC927'
        ];
        BUSIN.API.show(viewState, ctrsToShow);

        // spacerTypeProduct
        var ctrsToHide = ['VA_ORIAHEADER8605_0000029'];
        BUSIN.API.hide(viewState, ctrsToHide);
        /*NO existe en grupales
		    // Oculta columnas
		    var columnsRefinancingOperations = ['RefinancingOption', 'InternalCustomerClassification', 'Rate', 'CreditType'];
		    BUSIN.API.GRID.hideColumns('QV_ITRIC1523_63', columnsRefinancingOperations, renderEventArgs.commons.api);

		    //Ajusta el tamaño de las cabeceras al campo de la grilla
		    var columns = ['OperationBank', 'CurrencyOperation', 'Balance', 'LocalCurrencyBalance', 'OriginalAmount', 'LocalCurrencyAmount', 'CreditType',
							'InternalCustomerClassification', 'DateGranting', 'IdOperation', 'RefinancingOption', 'IsBase', 'Rate', 'ExpirationDate', 'State',
							'TypeOperation', 'interestBalance', 'otherItemsBalance', 'totalCapitalization'];
		    BUSIN.API.GRID.addColumnsStyle('QV_ITRIC1523_63', 'Grid-Column-Header', renderEventArgs.commons.api, columns);

		    //Disable de columnas de la grilla
		    var grid = renderEventArgs.commons.api.grid;
        grid.disabledColumn('QV_ITRIC1523_63','IsBase');
		    grid.disabledColumn('QV_ITRIC1523_63', 'OperationBank');
		    grid.disabledColumn('QV_ITRIC1523_63', 'TypeOperation');
		    grid.disabledColumn('QV_ITRIC1523_63', 'ExpirationDate');
		    grid.disabledColumn('QV_ITRIC1523_63', 'State');
		    grid.disabledColumn('QV_ITRIC1523_63', 'DateGranting');

		    var columnsOperationsHide = ['LocalCurrencyBalance', 'LocalCurrencyAmount', 'DateGranting', 'PayoutPercentage', 'OperationQualification', 'oficialOperation'];
		    BUSIN.API.GRID.hideColumns('QV_ITRIC1523_63', columnsOperationsHide, renderEventArgs.commons.api);*/
    }
    /* No existe en grupales
		if(parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Reestructuration) {			
			//configuracion especifica para Reestructuracion
			var ctrsToHide=['VA_ORIAHEADER8605_TIRC927'];
			BUSIN.API.hide(viewState,ctrsToHide);
			// spacerTypeProduct
			var ctrsToShow=['VA_ORIAHEADER8605_0000029'];
			BUSIN.API.show(viewState,ctrsToShow);
			var ctrsToDisable = ['VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826'];// monto solicitado y monto aprobado
			BUSIN.API.disable(viewState,ctrsToDisable);	
		
			renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');// boton
																													// nuevo
																													// operaciones
			renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');// boton
																													// eliminar
																													// operaciones
		}*/

    //Bloquea el tipo de producto en base al parametro que llega del an_component DISABLE_PRODUCT_TYPE
    /*if(parentParameters.Task.urlParams.DISABLE_PRODUCT_TYPE == "S") {
    	var ctrsToDisable = ['VA_ORIAHEADER8605_TIRC927'];
    	BUSIN.API.disable(viewState,ctrsToDisable);
     }*/ //MTA se quita validacion y para todos los casos siempre debe estar bloqueado la oficina y tipo de producto
    var ctrsToDisable = ['VA_ORIAHEADER8605_ORTR915', 'VA_ORIAHEADER8605_TIRC927', 'VA_ORIAHEADER8602_URQT595', 'VA_EJECUTIVOZUEHTQ_752W91'];
    BUSIN.API.disable(viewState, ctrsToDisable);


    /* No existe en grupales
		//habilita la edicion de las operaciones
		if(parentParameters.Task.urlParams.EDIT_OPERATION == FLCRE.CONSTANTS.Mode.Editable){
			renderEventArgs.commons.api.grid.showToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');// boton
																													// nuevo
																													// operaciones
			renderEventArgs.commons.api.grid.showToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');// boton
																													// eliminar
																													// operaciones
		}
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create');// boton
																						// de
																						// la
																						// grilla
																						// de
																						// operaciones
		*/
    //Se agrega de grupales
    //Tramite grupal	
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        // var ctrsToDisable = ['VA_GRUPALKFSXRLTTA_514W91']; // NewAliquot.grupal
        var ctrsToHide = [
            'VA_NIVELCOLECTIOVO_641R86',
            'VA_INGRESOSMENSUUE_680R86'];
        BUSIN.API.hide(viewState, ctrsToHide);
        BUSIN.API.GRID.hideColumns('QV_BOREG0798_55', ['creditBureau'], api);
        var ctrsAux = ['VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826']
        BUSIN.API.disable(viewState, ctrsAux);
        if (entities.OriginalHeader.IDRequested == 0) {
            entities.OriginalHeader.AmountRequested = 0.0;
            entities.OriginalHeader.AmountAprobed = 0.0;
        }
        var ctrsAuxRen = ['VA_COMBOBOXGTFCJFR_317R86', 'VA_TEXTINPUTBOXRXU_762R86']
        if (entities.Context.Flag1 > 1) {
            BUSIN.API.enable(viewState, ctrsAuxRen);
        } else {
            BUSIN.API.disable(viewState, ctrsAuxRen);
        }
        viewState.label("VC_OIIRL51_GTDOS_515", 'BUSIN.LBL_BUSIN_CLIENTESS_18177'); //Caso Incidencia #85832-cambio de etiqueta
    }

    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        var ctrsAuxHide = ['VA_TEXTINPUTBOXRXU_762R86', 'VA_CUSTOMEREXPEIII_577R86', 'VA_NIVELCOLECTIOVO_641R86', 'VA_INGRESOSMENSUUE_680R86', 'CM_TFLCRE_8_IO1']; //mta
        var ctrsAuxShow = ['VA_MAXIMUMAMOUNTTT_215R86']; //mta
        var ctrsAuxDisable = [];

        if (modeRequest === 'AP') {
            ctrsAuxDisable = ['VA_NUEVODESTINOIJR_765R86', 'VA_COMBOBOXGTFCJFR_317R86', 'VA_COMBOBOXTQEDQWM_929R86', 'VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826', 'VA_FREQUENCYLTUZDL_595R86', 'VA_TERMINDTMTELITU_695R86'];
            ctrsAuxShow.push('VA_INSURANCEPACKEG_674R86');
            ctrsAuxShow.push('VA_TERMMEDICALAISS_991R86');
        } else if (modeRequest === 'APR') {
            ctrsAuxDisable = ['VA_NUEVODESTINOIJR_765R86', 'VA_COMBOBOXGTFCJFR_317R86', 'VA_COMBOBOXTQEDQWM_929R86', 'VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826', 'VA_FREQUENCYLTUZDL_595R86', 'VA_TERMINDTMTELITU_695R86', 'VA_INSURANCEPACKEG_674R86', 'VA_TERMMEDICALAISS_991R86'];
            ctrsAuxShow.push('VA_INSURANCEPACKEG_674R86');
            ctrsAuxShow.push('VA_TERMMEDICALAISS_991R86');
        }

        BUSIN.API.hide(viewState, ctrsAuxHide);
        BUSIN.API.show(viewState, ctrsAuxShow);
        BUSIN.API.disable(viewState, ctrsAuxDisable);
        viewState.label("VC_OIIRL51_GTDOS_515", 'BUSIN.LBL_BUSIN_CLIENTEPK_21523'); //Caso Incidencia #85832-cambio de etiqueta

        var ctrsAuxFlag = ['VA_COMBOBOXGTFCJFR_317R86']
        if (entities.Context.Flag1 >= 1) {
            BUSIN.API.show(viewState, ctrsAuxFlag);
        } else {
            BUSIN.API.hide(viewState, ctrsAuxFlag);
        }
    }

    if (modeRequest === 'Q') {
        var ctrsAuxDisable = ['VC_OIIRL51_GREEG_881', 'VC_OIIRL51_RCUOA_445', 'VC_OIIRL51_GPOOG_815', 'VC_ZVXQIUJDIP_665L51']
        BUSIN.API.disable(viewState, ctrsAuxDisable);
    }

    //habilitar campo es promocion en el render
    if (modeRequest === undefined) {
        var ctrsAuxVarPromo = ['VA_COMBOBOXTQEDQWM_929R86']
        BUSIN.API.enable(viewState, ctrsAuxVarPromo);
    }
    //Caso Incidencia #85830
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL || typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        var ctrsAuxDisable = ['VA_ORIAHEADER8605_TIRC927', 'VA_BANCAEQGJPXCNHY_767R86', 'VA_GEOGRAPHICALSIS_291R86']
        BUSIN.API.disable(viewState, ctrsAuxDisable);
        //Incidencia #85832
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton nuevodeudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //boton eliminar deudores

    }
    //Requerimiento 103753 campos bloqueados para LCR
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE || typeRequest === FLCRE.CONSTANTS.TypeRequest.COLECTIVOS) {
        //VA_BANCAEQGJPXCNHY_767R86, VA_GEOGRAPHICALSIS_291R86, VA_NUEVODESTINOIJR_765R86, VA_ORIAHEADER8602_OQUE134, VA_ORIAHEADER8602_MICI826, VA_COMBOBOXTQEDQWM_929R86, VA_COMBOBOXGTFCJFR_317R86, VA_TEXTINPUTBOXRXU_762R86, 
        //Campo Priodicidad VA_ORIAHEADER8602_NQUE773
        var ctrsAuxDisable = [
            'VA_BANCAEQGJPXCNHY_767R86',
            'VA_GEOGRAPHICALSIS_291R86',
            'VA_NUEVODESTINOIJR_765R86',
            'VA_ORIAHEADER8602_OQUE134',
            'VA_ORIAHEADER8602_MICI826',
            'VA_COMBOBOXTQEDQWM_929R86',
            'VA_COMBOBOXGTFCJFR_317R86',
            'VA_TEXTINPUTBOXRXU_762R86',
            'VC_OIIRL51_GPOOG_815',
            'VA_NIVELCOLECTIOVO_641R86',
            'VA_INGRESOSMENSUUE_680R86'
        ];
        var ctrsHide = [
            'VA_ORIAHEADER8602_MICI826',
            'VA_ORIAHEADER8602_FICE546',
            'VA_VACOMPOSITEMXIH_497R86',
            'VA_BCBLACKLISTSCLL_583R86',
            'VA_ORIAHEADER8602_MNLA393',
            'CM_OIIRL51SVE80',
            'VA_COMBOBOXTQEDQWM_929R86',
            'VA_COMBOBOXAURNLPO_247R86',
            'VA_TEXTINPUTBOXLZA_843R86',
            'VA_COMBOBOXGTFCJFR_317R86',
            'VA_ISPARTNERZBPHXB_883R86',
            'VA_TEXTINPUTBOXRXU_762R86',
            'VA_CUSTOMEREXPEIII_577R86',
            'VA_GEOGRAPHICALSIS_291R86',
            'VA_ORIAHEADER8602_OQUE134',
            'VA_ORIAHEADER8602_URQT595'
        ];
        var ctrsAuxEnable = ['VA_ORIAHEADER8602_NQUE773'];
        var ctrsShow = ['CM_TFLCRE_8_IO1', 'VA_7694PEJSETHIYUL_239R86'];
        BUSIN.API.disable(viewState, ctrsAuxDisable);
        BUSIN.API.enable(viewState, ctrsAuxEnable);
        BUSIN.API.show(viewState, ctrsShow);
        BUSIN.API.hide(viewState, ctrsHide);
    }

    if ((typeRequest == FLCRE.CONSTANTS.TypeRequest.REVOLVENTE ||
            typeRequest === FLCRE.CONSTANTS.TypeRequest.COLECTIVOS) && modeRequest == FLCRE.CONSTANTS.Mode.Query) {
        var disabledCreditRevolvente = ['VC_OIIRL51_GREEG_881', 'VC_OIIRL51_GPOOG_815', 'CM_TFLCRE_8_IO1']
        BUSIN.API.disable(viewState, disabledCreditRevolvente);
    }
    if ((typeRequest == FLCRE.CONSTANTS.TypeRequest.REVOLVENTE ||
            typeRequest === FLCRE.CONSTANTS.TypeRequest.COLECTIVOS) && modeRequest == 'A') {
        var disabledCreditRevolvente = ['VC_OIIRL51_GREEG_881', 'VC_OIIRL51_GPOOG_815', 'CM_TFLCRE_8_IO1']
        BUSIN.API.disable(viewState, disabledCreditRevolvente);
        parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
    }
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE && entities.OriginalHeader.isCandidate == "S") {
        var ctrsAuxDisable = ['VA_7694PEJSETHIYUL_239R86'];
        BUSIN.API.disable(viewState, ctrsAuxDisable);
    }

    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        if (entities.EntidadInfo.insurancePackage == 'EXTENDIDO') {
            renderEventArgs.commons.api.viewState.enable('VA_TERMMEDICALAISS_991R86');
        } else {
            renderEventArgs.commons.api.viewState.disable('VA_TERMMEDICALAISS_991R86');
        }
    }
    
    if (entities.EntidadInfo.insurancePackage == null || entities.EntidadInfo.insurancePackage == '' || entities.EntidadInfo.insurancePackage == undefined) {
        entities.EntidadInfo.insurancePackage = "BASICO";
    }

};