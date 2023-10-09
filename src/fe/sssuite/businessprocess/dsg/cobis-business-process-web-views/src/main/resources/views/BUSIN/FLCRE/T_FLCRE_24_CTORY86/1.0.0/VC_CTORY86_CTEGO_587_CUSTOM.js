/* variables locales de T_FLCRE_24_CTORY86*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.category;
    

    //"TaskId": "T_FLCRE_24_CTORY86"
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.category;
	var nuevoValueReference='', hasDecimals = 'N';
	var  decimals = 0;
	var generalParameterLoan = {};

	/*************************************************************************/
	/**********************Métodos Personalizados****************************/
	/************************************************************************/
	task.calculateValor = function(entity){
        var result;
         if (entity.Sign != null && entity.Sign !=' ')
            {
                switch (entity.Sign)
                {
                    case "+":
                        result = entity.ReferenceAmount + entity.Spread;
                        entity.Value = result.toFixed(decimals);
                        break;
                    case "-":
                        result = entity.ReferenceAmount - entity.Spread;
                        entity.Value = result.toFixed(decimals);
                        break;
                    case "*":
                        result = entity.ReferenceAmount * entity.Spread;
                        entity.Value = result.toFixed(decimals);
                        break;
                    case "/":
                        result = entity.ReferenceAmount / entity.Spread;
                        entity.Value = result.toFixed(decimals);
                        break;
                }
            }
            else
            {
                entity.Value = entity.Spread == null ? null : entity.Spread.toFixed(decimals);
            }
    } 
	
	task.cleanFields=function(entities){
		//entities.Category.Sign='';
		entities.Category.ReferenceAmount='';
		entities.Category.Spread='';
		entities.Category.Value='';
		entities.Category.Minimum='';
		entities.Category.Maximun='';
	}

	task.disableEnableFields=function(viewState, entities, isNew){
		var grpsDisable = ['VA_ATACATEGRY1902_RNCU443', //reference amount
					'VA_ATACATEGRY1902_MIMM127', //valor minimo
					'VA_ATACATEGRY1902_MAXU405', //valor maximo
					'VA_ATACATEGRY1902_VALU262']; //valor
		var grpsEnable = [];
					
		if(entities.Category.Sign == null || (entities.Category.Sign != null && entities.Category.Sign.trim() == "")){
			grpsDisable.push('VA_ATACATEGRY1902_SIGN784');
		}else{
			grpsEnable.push('VA_ATACATEGRY1902_SIGN784');
		}
		if(isNew){
			grpsEnable.push('VA_ATACATEGRY1902_COEP019');
			grpsEnable.push('VA_ATACATEGRY1902_AUNL784');
			grpsEnable.push('VA_ATACATEGRY1902_ECRI253');
		}else{
			grpsDisable.push('VA_ATACATEGRY1902_COEP019');
			grpsDisable.push('VA_ATACATEGRY1902_AUNL784');
			grpsDisable.push('VA_ATACATEGRY1902_ECRI253'); 
		}
		BUSIN.API.enable(viewState,grpsEnable);
        BUSIN.API.disable(viewState,grpsDisable);
		viewState.disable('VA_ATACATEGRY1902_MINA980');//se deshabilita la tasa Preferencial
		viewState.hide('VA_ATACATEGRY1902_FNDD538'); //se oculta el campo financiado
	};

	
	//habilita campos cuando es valor u Otros
	task.enableFieldValorUtros=function(viewState){
		var grps = ['VA_ATACATEGRY1902_SPRD943'] //factor o propagacion;
        BUSIN.API.enable(viewState,grps);
		var grps1 = ['VA_ATACATEGRY1902_SIGN784'] //signo
        BUSIN.API.disable(viewState,grps1);
	};
	
		//deshabilita campos cuando factor ,etc
	task.disableFieldFactor=function(viewState){
		var grps = ['VA_ATACATEGRY1902_SIGN784', //signo
					'VA_ATACATEGRY1902_SPRD943'] //factor o propagacion;
        BUSIN.API.enable(viewState,grps);
		//task.enableFieldValorUtros(viewState);
	};
		
	task.updateRows = function(entities, args){
		var api = args.commons.api;
		var data = api.parentVc.model.Category.data();
		var rowData = api.vc.rowData;
		
		for(var i=0;i<=data.length;i++){
			if(data[i].Concept == rowData.Concept){
				rowData.set('Sign',entities.Category.Sign); 
			break;
			}
		}
	}
	
	task.validacionDataRubros = function(eventArgs, entity1, entity2 , idGrid ){
		
		var ds1 = eventArgs.commons.api.parentVc.model[entity1];
		var ds2 = eventArgs.commons.api.parentVc.model[entity2];
		var grid = eventArgs.commons.api.parentVc.grids;
		var dsData1 = ds1.data();
		var dsData2 = ds2.data();
        for (var i = 0; i < dsData.length; i ++) {
		
				var dsRow = dsData[i];
				if(dsRow.isHeritage === 'S'){
					grid.addRowStyle(idGrid, dsRow, 'Disable_CTR');
					//grid.hideGridRowCommand(idGrid, dsRow, 'delete');
				}else{
					grid.removeRowStyle(idGrid, dsRow, 'Disable_CTR');
					//grid.showGridRowCommand(idGrid, dsRow, 'delete');
				}
        }
		eventArgs.commons.api.viewState.refreshData(idGrid);
	};
	
	task.getConceptDescription = function (args, concept){
		var concepts = args.commons.api.vc.catalogs.VA_ATACATEGRY1902_COEP019.data();
		for (var i = 0; i < concepts.length; i++) {
			if(concepts[i].code==concept){
				return concepts[i].value;
			}
		}
	};
	
	task.formatFields = function(entities, args){
		var format = '0';
		if(entities.Category.ConceptType == 'I' || entities.Category.ConceptType == 'M' || 
			entities.Category.ConceptType == 'O' || entities.Category.ConceptType == 'B')
		{
			format = '0.00000';
			decimals = 5;
			
		}else{
			if (hasDecimals == 'S'){
				format = '0.00';
				decimals = 2;
			}
		}
		args.commons.api.viewState.format('VA_ATACATEGRY1902_RNCU443', format, decimals);
		args.commons.api.viewState.format('VA_ATACATEGRY1902_SPRD943', format, decimals);
		args.commons.api.viewState.format('VA_ATACATEGRY1902_VALU262', format, decimals);
		args.commons.api.viewState.format('VA_ATACATEGRY1902_MIMM127', format, decimals);
		args.commons.api.viewState.format('VA_ATACATEGRY1902_MAXU405', format, decimals);
		
		entities.Category.MaxRate = entities.Category.MaxRate==null?null:parseFloat(entities.Category.MaxRate.toFixed(decimals));
		entities.Category.Maximun = entities.Category.Maximun==null?null:parseFloat(entities.Category.Maximun.toFixed(decimals));
		entities.Category.Minimum = entities.Category.Minimum==null?null:parseFloat(entities.Category.Minimum.toFixed(decimals));
		entities.Category.ReferenceAmount = entities.Category.ReferenceAmount==null?null:parseFloat(entities.Category.ReferenceAmount.toFixed(decimals));
		entities.Category.Value = entities.Category.Value==null?null:parseFloat(entities.Category.Value.toFixed(decimals));
	};
	
	
	task.enableReadjustmentSection = function(entities, args, exchangeRate){
		var viewState = args.commons.api.viewState;
		
		if(exchangeRate == 'S' && ((entities.Category.itemType == 'I' || entities.Category.itemType == 'M') || 
			( entities.Category.ConceptType == 'I' || entities.Category.ConceptType == 'M'))){
			viewState.show('GR_ATACATEGRY19_04');
			if(entities.Category.isNew){
				viewState.enable('VA_ATACATEGRY1904_AOOP178');  //CategoryReadjustment AmountToApply
			}			
		}else{
			viewState.hide('GR_ATACATEGRY19_04');
		}
	};
	
	task.validateItem = function(entities, args){
		var isValid = true;
		if(entities.Category.Sign !=null && entities.Category.Sign.trim() != ""){
			if(entities.Category.Value <= entities.Category.MaxRate && 
				entities.Category.Value <= entities.Category.Maximun && 
					entities.Category.Value >= entities.Category.Minimum){
				isValid = true;			
			}else if(entities.Category.MaxRate!= null && entities.Category.MaxRate !=0 && entities.Category.Value > entities.Category.MaxRate){
				isValid = false;
				args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SRRVAOMRE_76004');
			}else if(entities.Category.Maximun!= null && entities.Category.Maximun !=0 && entities.Category.Value > entities.Category.Maximun){
				isValid = false;
				args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_MRVORARXO_62435');
			}else if(entities.Category.Minimum!= null && entities.Category.Minimum !=0 && entities.Category.Value < entities.Category.Minimum){
				isValid = false;
				args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_RRVAOEOIO_04499');
			
			}
		}else{
			isValid = true;
		}
		return isValid;
	};
	
	task.validateItemReadjustment = function(entities, args){
		var isValid = true;
		
		if(entities.Category.Sign !=null && entities.Category.Sign.trim() != ""){
			if(entities.CategoryReadjustment.Value <= entities.CategoryReadjustment.Maximun && 
					entities.CategoryReadjustment.Value >= entities.CategoryReadjustment.Minimum){
				isValid = true;			
			}else if(entities.CategoryReadjustment.Maximun!= null && entities.CategoryReadjustment.Maximun !=0 && 
				entities.CategoryReadjustment.Value > entities.CategoryReadjustment.Maximun){
				isValid = false;
				args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SGRALRMRA_70169');
			}else if(entities.CategoryReadjustment.Minimum!= null && entities.CategoryReadjustment.Minimum !=0 && 
				entities.CategoryReadjustment.Value < entities.CategoryReadjustment.Minimum){
				isValid = false;
				args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_ONORIMATE_29832');
			}
		}else{
			isValid = true;
		}
		return isValid;
	};

    //Entity: Category
    //Category.AmounToApply (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_AUNL784 = function( entities, changedEventArgs ) {
		var nuevoValueAplicar=changedEventArgs.newValue;
		//task.cleanFields(entities);
		var viewState=changedEventArgs.commons.api.viewState;
	     changedEventArgs.commons.execServer = true;
         changedEventArgs.commons.api.vc.serverParameters.Category = true;	
        
    };

//Entity: Category
    //Category.AmounToApply (ComboBox) View: Category
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.changeCallback.VA_ATACATEGRY1902_AUNL784 = function(entities, changedCallbackEventArgs) {
		var viewState=changedCallbackEventArgs.commons.api.viewState;
		task.formatFields(entities, changedCallbackEventArgs);
		if(entities.Category.Sign != null && entities.Category.Sign.trim()!=""){
			viewState.enable('VA_ATACATEGRY1902_SIGN784');
		}else{
			viewState.disable('VA_ATACATEGRY1902_SIGN784');
		}
	};

//Entity: Category
    //Category.Concept (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_COEP019 = function( entities, changedEventArgs ) {
		 changedEventArgs.commons.execServer = true;
         changedEventArgs.commons.api.vc.serverParameters.Category = true;
		 changedEventArgs.commons.api.vc.serverParameters.CategoryReadjustment = true;
		 changedEventArgs.commons.api.vc.serverParameters.PaymentPlanHeader = true;
        
    };

//Entity: Category
    //Category.Concept (ComboBox) View: Category
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
	task.changeCallback.VA_ATACATEGRY1902_COEP019 = function(entities, changedCallbackEventArgs) {
		var viewState = changedCallbackEventArgs.commons.api.viewState;
		task.formatFields(entities, changedCallbackEventArgs);
		if(entities.Category.Sign != null && entities.Category.Sign.trim()!=""){
			viewState.enable('VA_ATACATEGRY1902_SIGN784');
		}else{
			viewState.disable('VA_ATACATEGRY1902_SIGN784');
		}
		task.enableReadjustmentSection(entities, changedCallbackEventArgs, generalParameterLoan.exchangeRate);
		viewState.disable('VA_ATACATEGRY1902_ECRI253'); 
	};

//Entity: Category
    //Category.Sign (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_SIGN784 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
		task.calculateValor(entities.Category);
        
    };

//Entity: Category
    //Category.Spread (TextInputBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1902_SPRD943 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;		
		task.calculateValor(entities.Category);
        
    };

//Entity: CategoryReadjustment
    //CategoryReadjustment.AmountToApply (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1904_AOOP178 = function( entities, changedEventArgs ) {
         changedEventArgs.commons.execServer = false;
		 changedEventArgs.commons.serverParameters.Category = true;
         changedEventArgs.commons.serverParameters.CategoryReadjustment = true;        
    };

//Entity: CategoryReadjustment
    //CategoryReadjustment.Sign (ComboBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1904_SIGN273 = function( entities, changedEventArgs ) {
         changedEventArgs.commons.execServer = false;
        task.calculateValor(entities.CategoryReadjustment);        
    };

//Entity: CategoryReadjustment
    //CategoryReadjustment.Spread (TextInputBox) View: DataCategory
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ATACATEGRY1904_SPED624 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        task.calculateValor(entities.CategoryReadjustment);        
    };

// (Button) 
    //Guardar Rubros (Button) 
    task.executeCommand.CM_CTORY86ARB39 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.execServer = false;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
		
		//permite validar que los rubros ya existan en la tabla de Category
		var ds1 = executeCommandEventArgs.commons.api.parentVc.model.Category;
		//var ds2 = executeCommandEventArgs.commons.api.parentVc.model.CategoryNew;
		var dsData1 = ds1.data();
		//var dsData2 = ds2.data();
		var flag=false;
		var validateItem = true;
		var validateItemReadjustment = true; 
		
		executeCommandEventArgs.commons.serverParameters.PaymentPlanHeader = true;
		executeCommandEventArgs.commons.serverParameters.Category = true; 
		executeCommandEventArgs.commons.serverParameters.CategoryReadjustment = true; 
		validateItem = task.validateItem(entities, executeCommandEventArgs);
		if(generalParameterLoan.exchangeRate == 'S' && ((entities.Category.itemType == 'I' || entities.Category.itemType == 'M') || 
			( entities.Category.ConceptType == 'I' || entities.Category.ConceptType == 'M'))){			
			validateItemReadjustment = task.validateItemReadjustment(entities, executeCommandEventArgs);			
		}
		
		if(validateItem && validateItemReadjustment){
			for (var i = 0; i < dsData1.length; i ++) {
				var dsRow1 = dsData1[i];
				if (entities.Category.isNew && dsRow1.Concept.trim()==entities.Category.Concept){
					executeCommandEventArgs.commons.execServer = false;
					executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_EXSTERUBR_34155');
					flag=true;
					break;
				}
			}
			executeCommandEventArgs.commons.execServer = true;
		}else{
			executeCommandEventArgs.commons.execServer = false;
		}
        
    };

// (Button) 
	task.executeCommandCallback.CM_CTORY86ARB39 = function(entities, executeCommandCallbackEventArgs) {
		var api = executeCommandCallbackEventArgs.commons.api;
		var data =api.vc.model.Category;
		var parentGrid = api.parentApi().grid;
		var	entity = 'Category';
		
		if(executeCommandCallbackEventArgs.success){				
			data.Concept = entities.Category.Concept;
			data.ConceptDescription = task.getConceptDescription(executeCommandCallbackEventArgs, data.Concept);
			data.Sign= entities.Category.Sign;
			data.Reference=entities.Category.Reference;
			data.ConceptType=entities.Category.ConceptType;
			parentGrid.collapseRow("QV_QERYI6962_42", data);
			if(entities.Category.MethodOfPayment!=null && entities.Category.MethodOfPayment.trim() == 'P'){
				executeCommandCallbackEventArgs.commons.api.parentVc.executeCommand('CM_TPYEP21MTE89',
				'Compute', '', true, false, 'VC_TPYEP21_FAETL_814', false);
			}
			executeCommandCallbackEventArgs.commons.api.parentVc.model.Category.sync();//sincronizo los datos de la grilla
			executeCommandCallbackEventArgs.commons.api.vc.closeModal(data);			
		}
	};

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

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: Category
	task.initDataCallback.VC_CTORY86_CTEGO_587 = function(entities, initDataEventArgsCallback) {
		var viewState = initDataEventArgsCallback.commons.api.viewState;
		task.formatFields(entities, initDataEventArgsCallback);
		task.disableEnableFields(viewState, entities, entities.Category.isNew);
		task.enableReadjustmentSection(entities, initDataEventArgsCallback, generalParameterLoan.exchangeRate);
	};

//Entity: Category
    //Category.AmounToApply (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1902_AUNL784 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.Category = true;        
    };

//Entity: Category
    //Category.Concept (ComboBox) View: DataCategory
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1902_COEP019 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.api.vc.serverParameters.Category = true;
		var serverParameters = loadCatalogDataEventArgs.commons.api.vc.serverParameters;
		serverParameters.PaymentPlanHeader = true;
        serverParameters.Category = true;
		loadCatalogDataEventArgs.commons.execServer = false;   
    };

//Entity: CategoryReadjustment
    //CategoryReadjustment.AmountToApply (ComboBox) View: DataCategory
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1904_AOOP178 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.serverParameters.CategoryReadjustment = true;
		loadCatalogDataEventArgs.commons.serverParameters.Category = true; 
    };

//Entity: CategoryReadjustment
    //CategoryReadjustment.Concept (ComboBox) View: DataCategory
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ATACATEGRY1904_COEP407 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.serverParameters.Category = true;
		loadCatalogDataEventArgs.commons.serverParameters.PaymentPlanHeader = true;
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: [object Object]
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
    var tipo = renderEventArgs.commons.api.parentVc.model.OriginalHeader.ProductType;
    if (tipo == 'GRUPAL') {
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_SIGN784');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_SPRD943');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_VALU262');
        
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_MIMM127');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_MAXU405');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_MUPE771');
        renderEventArgs.commons.api.viewState.disable('VA_ATACATEGRY1902_RNCU443');
    }
    };



}));