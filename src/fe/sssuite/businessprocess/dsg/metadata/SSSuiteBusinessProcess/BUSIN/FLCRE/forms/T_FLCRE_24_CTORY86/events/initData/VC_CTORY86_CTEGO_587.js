//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: Category
    task.initData.VC_CTORY86_CTEGO_587 = function (entities, initDataEventArgs){

		entities.Category = {};
		var viewState = initDataEventArgs.commons.api.viewState;
		var api = initDataEventArgs.commons.api,			
			appNumber = api.vc.parentVc.model['PaymentPlanHeader'],
			items = api.vc.parentVc.model['Category'];
		generalParameterLoan = 	api.vc.parentVc.model['GeneralParameterLoan'];
			
		var isNew = api.vc.customDialogParameters.isNew == undefined ? false: api.vc.customDialogParameters.isNew;
		entities.PaymentPlanHeader = initDataEventArgs.commons.api.parentVc.model.PaymentPlanHeader;
		hasDecimals = initDataEventArgs.commons.api.parentVc.model.generalData.currencyDecimals;
				
		if(isNew){					
			entities.Category.Currency =initDataEventArgs.commons.api.parentVc.model.PaymentPlanHeader.currency;
			entities.Category.ProductType=initDataEventArgs.commons.api.parentVc.model.PaymentPlanHeader.productType;
			entities.Category.MethodOfPayment=initDataEventArgs.commons.api.parentVc.model.PaymentPlanHeader.idRequested;
			entities.Category.segment=initDataEventArgs.commons.api.parentVc.model.OfficerAnalysis.Sector;
			entities.Category.sector=initDataEventArgs.commons.api.parentVc.model.generalData.sectorNegCod;		
			entities.Category.bank=initDataEventArgs.commons.api.parentVc.model.PaymentPlan.bank;
			entities.Category.isNew=true;
			task.enableReadjustmentSection(entities, initDataEventArgs, generalParameterLoan.exchangeRate);
			task.disableEnableFields(viewState, entities, isNew);
			initDataEventArgs.commons.execServer = false;
		}else{
			
			entities.Category.Currency =entities.PaymentPlanHeader.currency;
			entities.Category.ProductType=entities.PaymentPlanHeader.productType;
			entities.Category.MethodOfPayment=entities.PaymentPlanHeader.idRequested;
			entities.Category.segment=initDataEventArgs.commons.api.parentVc.model.OfficerAnalysis.Sector;
			entities.Category.sector=initDataEventArgs.commons.api.parentVc.model.generalData.sectorNegCod;
			entities.Category.isNew=false;			
			initDataEventArgs.commons.execServer = true;
		}
    };