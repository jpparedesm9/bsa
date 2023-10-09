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