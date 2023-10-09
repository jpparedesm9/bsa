//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_TPYEP21_FAETL_814 = function (entities, initDataEventArgs){
        passInitDataCallback = false;
		entities.Context = {};
		entities.OfficerAnalysis = {};
		entities.CreditOtherData = {};
		entities.PaymentPlanHeader = {};
		entities.OriginalHeader = {};
		entities.PaymentCapacity = [];
		entities.PaymentCapacityHeader = {};
		entities.AmortizationTableHeader = {};	
		entities.generalData={};//entidad a mano -> para informacion
		entities.generalData.productTypeName = "";		
		entities.generalData.paymentFrecuencyName = "";		
        var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;
		//GRUPALES
        task.creditType = customDialogParameters.Task.urlParams.SOLICITUD;
        
		//Se elimina el requerido  para el atributo -- Fecha vencimiento primera cuota
		initDataEventArgs.commons.api.viewState.disableValidation('VA_VWPAYMENLA2615_SPRE849', VisualValidationTypeEnum.Required);
		
		FLCRE.UTILS.APPLICATION.setContext(entities, initDataEventArgs, false, false);
        var viewState = initDataEventArgs.commons.api.viewState;
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		var client = initDataEventArgs.commons.api.parentVc.model.Task;
		
        //Oculta Menu de Cabecera en Tabla de amortizacion
        BUSIN.API.GRID.hideFilter('QV_QUYOI3312_16', initDataEventArgs.commons.api);
        BUSIN.API.disable(viewState,['VA_VWPAYMENLA2615_AOUN065']);
		
        //Set Por Requerimiento
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
        entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.UserL=cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;			
		
		entities.PaymentPlanHeader.applicationNumber = parentParameters.Task.processInstanceIdentifier;
        entities.PaymentPlanHeader.debit = 'N';        
		entities.PaymentPlanHeader.customerCode = client.clientId;
		entities.PaymentPlanHeader.customerName = client.clientName;
        //entities.PaymentPlan.daysPerYear = 365;
        entities.PaymentPlan.calculationBased = 'E'; //Calendario
		
        //Set Por Defaults
        //entities.PaymentPlan.tableType = 'ALEMANA';
        entities.PaymentPlan.quota = 0;
        entities.PaymentPlan.capital = 0;
        entities.PaymentPlan.paymentDay = 0;
        entities.GeneralParameterLoan.periodicity = 0;
	
        if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.TRAMITE)){
            task.TipoTramite = parentParameters.Task.urlParams.TRAMITE;
        }
        if(!BUSIN.VALIDATE.IsNull(parentParameters.Task.urlParams.ETAPA)){
            task.Etapa = parentParameters.Task.urlParams.ETAPA;
        }
        
        if(task.creditType != 'GRUPAL'){
            initDataEventArgs.commons.api.viewState.hide('VA_DISPERSIONDATTT_417A26');
        }
        
		//Boton Principal (Wizard)
		initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
			initDataEventArgs.commons.api.vc.executeCommand('CM_TPYEP21MTE89','Compute', undefined, true, false, 'VC_TPYEP21_FAETL_814', false);
		}
       
    //Inicio Req.194284 Dia de Pago
    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function (processDate) {        
        processDateTemp = new Date(processDate);
        console.log('Fecha proceso: '+ processDateTemp);
    })
    
    if (task.creditType == 'REVOLVENTE') {
        initDataEventArgs.commons.api.viewState.hide('VA_PAYMENTDAYSQXGZ_884A26');
    }
    //Fin Req.194284 Dia de Pago
        
    };