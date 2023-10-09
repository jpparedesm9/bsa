//Start signature to callBack event to VC_TPYEP21_FAETL_814
task.initDataCallback.VC_TPYEP21_FAETL_814 = function (entities, initDataEventArgs) {
    passInitDataCallback = true;
    // Validacion para fechas
    if (entities.PaymentPlanHeader.dispersionDate == null) {
        entities.PaymentPlanHeader.dispersionDate = entities.PaymentPlanHeader.initialDate
    }
    //initData
    var api = initDataEventArgs.commons.api;
    var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
    if (initDataEventArgs.success) {
        initDataEventArgs.commons.api.viewState.enable('CM_TPYEP21MTE89');
        wasInInitData = true;
    }
    //Cargar las fechas en variables

    fechaValidacion = entities.PaymentPlanHeader.dispersionDateValidate;
    console.log("FECHA VALIDACION");
    console.log(fechaValidacion);

    //Si no es una renovación se inicializa la línea de crédito 
    if ('R' != entities.OriginalHeader.TypeRequest && FLCRE.UTILS.APPLICATION.isDisbursement(initDataEventArgs.commons.api)) {
        var client = initDataEventArgs.commons.api.parentVc.model.Task;
        entities.OriginalHeader.NumberLine = client.bussinessInformationStringOne;
        task.IsDisbursement = true;
        //viewState.show('VA_ORIAHEADER8602_NMLN737');
    }

    //Se coloca para fines de presentación -- borrar
    entities.PaymentPlanHeader.productType = entities.OriginalHeader.ProductType;
    entities.PaymentPlanHeader.auxApprovedAmount = entities.OriginalHeader.AmountRequested;

    api.viewState.disable('VA_VWPAYMENLA2615_APRE101');
    api.viewState.disable('VA_VWPAYMENLA2615_TIRP175');
    api.viewState.disable('VA_VWPAYMENLA2615_RATE787');

    //Grid Rubros Nuevos
    api.vc.viewState.GR_VWPAYMENLA26_27.visible = false;

    if (entities.PaymentPlan.interestPeriodGrace > 0) {
        api.viewState.enable('VA_VWPAYMENLA2605_QAIT788');
    } else if (entities.PaymentPlan.interestPeriodGrace == 0) {
        entities.PaymentPlan.quotaInterest = " ";
        api.viewState.disable('VA_VWPAYMENLA2605_QAIT788');
    }
    task.setNullValuesFE(entities, initDataEventArgs);

    task.loadTaskHeader(entities, initDataEventArgs);
    task.changePaymentFrecuency(entities, initDataEventArgs);
    task.enableDisabledByAcceptsAdditionalPayments(entities, initDataEventArgs);
    task.enableDisabledByExchangeRate(entities, initDataEventArgs);
    task.enableDisabledByPaymentType(entities, initDataEventArgs);

    task.formatAmortizationTable(entities, initDataEventArgs.commons.api);
    if (entities.PaymentPlan.tableType == 'MANUAL') {
        task.disableToolbarAmortizationTable(initDataEventArgs, 'AmortizationTableItem', 'QV_QUYOI3312_16', true);
    } else {
        task.disableToolbarAmortizationTable(initDataEventArgs, 'AmortizationTableItem', 'QV_QUYOI3312_16', false);
    }
    task.enableDiableQuotaInterest(entities, initDataEventArgs);
    initQuota = angular.copy(entities.PaymentPlan.quota);

    //Validación Día de Pago
    if (entities.PaymentPlan.fixedpPaymentDate == 'S') {
        initDataEventArgs.commons.api.viewState.enable('VA_VWPAYMENLA2605_ETDY540');
    } else {
        entities.PaymentPlan.paymentDay = 0;
        initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_ETDY540');
    }

    //Validación cuando la tabla de amortización es de tipo consulta
    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null &&
        parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.Query) {
        BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success, api); //Habilita el continuar cuando sea modo consulta
        BUSIN.API.GRID.disableEnableToolbar(initDataEventArgs, 'Category', 'QV_UYCTE6570_70', false, 'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para edición en modo CONSULTA
        task.disablePaymentCondition(initDataEventArgs); // Deshabilita condiciones de pago si es etapa de CONSULTA
        if (entities.PaymentPlan.tableType == 'MANUAL') {
            task.disableToolbarAmortizationTable(initDataEventArgs, 'AmortizationTableItem', 'QV_QUYOI3312_16', false);
        }
    }
    //Etapa de Recálculo en la tabla de amortización
    if (task.Etapa === FLCRE.CONSTANTS.Stage.Recalculation) {
        BUSIN.API.GRID.disableEnableToolbar(initDataEventArgs, 'Category', 'QV_UYCTE6570_70', false, 'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para edición en modo CONSULTA
        task.disablePaymentCondition(initDataEventArgs);
        initDataEventArgs.commons.api.viewState.enable('VA_VWPAYMENLA2615_IATE307') //Fecha de Inicio
        initDataEventArgs.commons.api.viewState.enable('VA_VWPAYMENLA2615_SPRE849') //Fecha de primera cuota
    }

    task.showButtons(initDataEventArgs);

    //Se mapea en cero para CPN que no tiene bien calculado el valor en ca_operacion_tmp (opt_cuota)
    entities.PaymentPlan.quota = 0;


    if (entities.AmortizationTableItem.data() != undefined && entities.AmortizationTableItem.data().length > 0 &&
        entities.OriginalHeader.Term != entities.AmortizationTableItem.data().length) {
        initDataEventArgs.commons.api.viewState.lockScreen('VC_TPYEP21_FAETL_814', null);
        initDataEventArgs.commons.api.vc.executeCommand('CM_TPYEP21MTE89', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
    }

    //Se configura los rubros editables
    task.setEditableCategory(initDataEventArgs);

    //GRUPALES
    task.creditType = parentParameters.Task.urlParams.SOLICITUD;
    //CARGAR EL RADIO BUTTON LISTA DE MIEMBROS DEL GRUPO DEPENDIENDO DEL FLUJO DEL CUAL SE ESTA CARGANDO
    if (parentParameters.Task.urlParams.SOLICITUD == 'GRUPAL') {

        entities.PaymentPlanHeader.typePayment = 'I'; //Se requiere que este por defecto = I         
        //entities.PaymentPlanHeader.wayToPay = 'NDAH';
        //initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2618_MEOE230');
        initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.hide('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.show('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.viewState.disable('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPSZFMGQ_712A26', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
        initDataEventArgs.commons.api.viewState.hide('G_VWPAYMELNP_969A26');
        initDataEventArgs.commons.api.grid.hideToolBarButton('QV_UYCTE6570_70', 'CEQV_201_QV_UYCTE6570_70_368')
        task.change.VA_8375LIFACAQCGJL_261A26(entities, initDataEventArgs);
    } else if (parentParameters.Task.urlParams.SOLICITUD == 'INTERCICLO') {
        entities.PaymentPlanHeader.paymentType = undefined;
        initDataEventArgs.commons.api.viewState.hide('G_VWPAYMELNP_969A26');
        initDataEventArgs.commons.api.viewState.hide('VA_8375LIFACAQCGJL_261A26');
        initDataEventArgs.commons.api.viewState.show('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.viewState.disable('VA_ACCOUNTQXYRZIXM_963A26');
        initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.hide('VA_VWPAYMENLA2618_BTCO941');
        //entities.PaymentPlanHeader.wayToPay = 'NDAH';
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPSZFMGQ_712A26', 'Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);


    } else if (parentParameters.Task.urlParams.SOLICITUD == 'NORMAL') {
        initDataEventArgs.commons.api.viewState.hide('G_VWPAYMELNP_969A26');
        //entities.PaymentPlanHeader.wayToPay = 'NDAH';
        initDataEventArgs.commons.api.viewState.show('VA_VWPAYMENLA2618_BTCO941');
        initDataEventArgs.commons.api.viewState.hide('VA_8375LIFACAQCGJL_261A26');
        entities.PaymentPlanHeader.paymentType = undefined;
    }

    //Caso 98119 mejoras de originación solo deja habilitada la fecha de dispersión y permite recalcular
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2615_IATE307')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2615_SPRE849')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_BLYE585')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_QUOT918')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_TERM808')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_ATQC570')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2607_UATI478')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_ATTE607')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_NENT977')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_TATY621')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_PILO354')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_EREP542')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_IALR796')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2605_EACE223')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2617_GARR154')
    initDataEventArgs.commons.api.viewState.disable('VA_VWPAYMENLA2617_OHOI726')

    BUSIN.API.GRID.disableEnableToolbar(initDataEventArgs, 'Category', 'QV_UYCTE6570_70', false, 'CEQV_201_QV_UYCTE6570_70_368'); // Deshabilita grilla de Rubros para ediciÃ³n en modo CONSULTA
    task.disablePaymentCondition(initDataEventArgs);
    initDataEventArgs.commons.api.viewState.enable('VA_DISPERSIONDATTT_417A26')

    //Inicio Req.194284 Dia de Pago
    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null &&
        parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.Query) {
		initDataEventArgs.commons.api.viewState.hide('VA_PAYMENTDAYSQXGZ_884A26');
		initDataEventArgs.commons.api.viewState.disable('VA_DISPERSIONDATTT_417A26');
    } else {
		initDataEventArgs.commons.api.viewState.enable('VA_PAYMENTDAYSQXGZ_884A26');
	}
    entities.PaymentPlanHeader.paymentDay = processDateTemp;
    //Fin Req.194284 Dia de Pago

};
