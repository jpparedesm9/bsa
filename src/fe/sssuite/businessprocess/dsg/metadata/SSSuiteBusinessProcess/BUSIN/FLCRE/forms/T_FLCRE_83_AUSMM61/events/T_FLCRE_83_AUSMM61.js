//"TaskId": "T_FLCRE_83_AUSMM61"
 var task = designerEvents.api.taskdisbursementincome;
	var disbFormCHeck = 0;
	var productDisbursement = '';
	var currency=1000;
	var disbFormAHCC = 0;
	task.maxErrorRound = 0.1; //Máximo valor para soportar una diferencia de conversion entre monedas
task.creditType=undefined//

task.closeModalEvent.VC_TKCSO26_CRNTO_867 = function(entities, executeCommandEventArgs){
		var parameter = entities.result.parameterDisbursementForm;
		productDisbursement = parameter.Product;
		entities.model.DisbursementIncome.DisbursementForm = parameter.Product + '/' + parameter.Description;
		//if(parameter.CobisProduct === 3 || parameter.CobisProduct === 4){
        if(parameter.Product=='CHLOCAL')
        {
        	entities.commons.api.viewState.show('VA_SRSNTINOIW6604_ACCU010');
            entities.commons.api.viewState.disable('VA_SRSNTINOIW6604_ACCU010');
            
            //Consultar la cuenta y la tabla de deudores
             if(task.creditType===FLCRE.CONSTANTS.TypeRequest.GRUPAL){
                entities.commons.api.viewState.show('G_DISBURSNVE_552W66');
                 
            }else if(task.creditType===FLCRE.CONSTANTS.TypeRequest.INTERCICLO){
                entities.commons.api.viewState.hide('G_DISBURSNVE_552W66');
            }else{
               entities.commons.api.viewState.hide('G_DISBURSNVE_552W66');
            }
            entities.model.DisbursementIncome.creditType=task.creditType;
            //pasar el parámetro  Java para que lo resuelva
            entities.commons.api.vc.executeCommand('VA_VABUTTONRBZVRHL_639W66','load', undefined, true, false, 'VC_AUSMM61_MDSIC_473', false);
            entities.commons.api.viewState.hide('VA_SRSNTINOIW6604_DCII002');
        
       }else{
           entities.commons.api.viewState.show('VA_SRSNTINOIW6604_DCII002');
			entities.commons.api.viewState.hide('VA_SRSNTINOIW6604_ACCU010');
            entities.commons.api.viewState.hide('G_DISBURSNVE_552W66');
            }
    
    
        if(parameter.CobisProduct === 99){
			entities.commons.api.viewState.show('VA_SRSNTINOIW6604_ACCU010');
            entities.commons.api.viewState.disable('VA_SRSNTINOIW6604_ACCU010');
            
            //Consultar la cuenta y la tabla de deudores
             if(task.creditType===FLCRE.CONSTANTS.TypeRequest.GRUPAL){
                entities.commons.api.viewState.show('G_DISBURSIET_541W66');
                 
            }else if(task.creditType===FLCRE.CONSTANTS.TypeRequest.INTERCICLO){
                entities.commons.api.viewState.hide('G_DISBURSIET_541W66');
            }else{
               entities.commons.api.viewState.hide('G_DISBURSIET_541W66');
            }
            entities.model.DisbursementIncome.creditType=task.creditType;
            //pasar el parámetro  Java para que lo resuelva
            entities.commons.api.vc.executeCommand('VA_VABUTTONIWKBMNP_334W66','load', undefined, true, false, 'VC_AUSMM61_MDSIC_473', false);
            entities.commons.api.viewState.hide('VA_SRSNTINOIW6604_DCII002');
		}else{
			entities.commons.api.viewState.show('VA_SRSNTINOIW6604_DCII002');
			entities.commons.api.viewState.hide('VA_SRSNTINOIW6604_ACCU010');
            entities.commons.api.viewState.hide('G_DISBURSIET_541W66');
		}

		if(parameter.CobisProduct != 42){
			entities.commons.api.viewState.hide('VA_SRSNTINOIW6604_IOFF658');
			disbFormCHeck = 0;
			disbFormAHCC = parameter.CobisProduct;
		}else{
			entities.commons.api.viewState.show('VA_SRSNTINOIW6604_IOFF658');
			disbFormCHeck = parameter.CobisProduct;
		}
	};
task.closeModalEvent.VC_AATIN09_UTINO_445 = function(entities, executeCommandEventArgs){
		var parameter = entities.result.parameterAccount;
		entities.model.DisbursementIncome.Account = parameter.Account + '-' + parameter.AccountDescription;
	};