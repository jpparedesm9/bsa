/*global designerEvents, console */
/*Generado 08/06/2017 00:59*/
(function () {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola
    //  console.log("executeCommand");

    //  Para enviar mensaje use
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validaciÃ³n a nivel de servidor
    //  eventArgs.commons.execServer = false;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************

    var task = designerEvents.api.taskdisbursementincome;

//"TaskId": "T_FLCRE_83_AUSMM61"
 var task = designerEvents.api.taskdisbursementincome;
	var disbFormCHeck = 0;
	var productDisbursement = '';
	var currency=1000;
	var disbFormAHCC = 0;
	task.maxErrorRound = 0.1; //MÃ¡ximo valor para soportar una diferencia de conversion entre monedas
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
            //pasar el parÃ¡metro  Java para que lo resuelva
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
            //pasar el parÃ¡metro  Java para que lo resuelva
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

//Entity: DisbursementIncome
    //DisbursementIncome.Account (TextInputButton) View: TaskDisbursementIncome
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SRSNTINOIW6604_ACCU010 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: DisbursementIncome
    //DisbursementIncome.DisbursementForm (TextInputButton) View: TaskDisbursementIncome
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SRSNTINOIW6604_DBUF584 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: DisbursementIncome
    //DisbursementIncome.DisbursementValue (TextInputBox) View: TaskDisbursementIncome
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SRSNTINOIW6604_IBTU111 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: MemberGroup
    //MemberGroup.check (TextInputBox) View: TaskDisbursementIncome
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXBBW_718W66 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;//cambiar si no sale
    
        //changedEventArgs.commons.serverParameters.MemberGroup = true;
    };

//Start signature to Callback event to VA_TEXTINPUTBOXBBW_718W66
task.changeCallback.VA_TEXTINPUTBOXBBW_718W66 = function(entities, changeCallbackEventArgs) {
//here your code
};

//Entity: DisbursementDetail
    //DisbursementDetail. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acciÃ³n a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_SRSNTINOIW6605_0000073 = function(  entities, executeCommandEventArgs ) {
       var ds = executeCommandEventArgs.commons.api.vc.model['DisbursementDetail'];
  var flag = 0;
  var dsData = ds.data();

           entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
        entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;
        
          if(task.creditType===FLCRE.CONSTANTS.TypeRequest.GRUPAL){
                 entities.DisbursementIncome.isGroup="S";
              entities.DisbursementIncome.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
            }else if(task.creditType===FLCRE.CONSTANTS.TypeRequest.INTERCICLO){
                entities.DisbursementIncome.isGroup="N";                
            }else{
              
                
            }
        
       
        
        
        entities.DisbursementIncome.operationNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;

        
        
  if (entities.DisbursementIncome.DisbursementForm == null){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FASOAMSBL_03352');
  }else if(entities.DisbursementIncome.Office == null){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_FICNOBLIT_56699');
  }else if(disbFormCHeck == 42 && entities.DisbursementIncome.ImpOffice == null){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_OIAPROGAO_73803');
  }else if (entities.DisbursementIncome.DisbursementValue == 0){
   executeCommandEventArgs.commons.execServer = false;
   executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IBUMALUER_52287');
  }else if (disbFormAHCC === 3 || disbFormAHCC === 4){
   /*if(entities.DisbursementIncome.Account == null){
    executeCommandEventArgs.commons.execServer = false;
    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MENSOORIO_09614');
   }*/
  }else {
   for (var i = 0; i < dsData.length; i ++) {
    if(dsData[i].DisbursementForm == productDisbursement){
     flag = 1;
    }
   }
   if(flag == 1){
    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IUEMEAXSS_85831');
    executeCommandEventArgs.commons.execServer = false;
   }else{
    if((executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.BalanceOperation+task.maxErrorRound) >=  entities.DisbursementIncome.CurrentBalance){
     executeCommandEventArgs.commons.execServer = true;
    }else{
     executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MOAALDRON_83113');
     executeCommandEventArgs.commons.execServer = false;
    }
   }
  }
        
    };

//Start signature to Callback event to VA_SRSNTINOIW6605_0000073
task.executeCommandCallback.VA_SRSNTINOIW6605_0000073 = function(entities, executeCommandEventArgs) {
//here your code
    
    if(executeCommandEventArgs.success != false){
   var api = executeCommandEventArgs.commons.api;
   var newBalanceOperation = (api.parentVc.model.LoanHeader.BalanceOperation - Math.round(entities.DisbursementIncome.CurrentBalance*100)/100);
   if( (newBalanceOperation<0) && ((newBalanceOperation*-1)-task.maxErrorRound ) ){ //SI ES NEGATIVO SE REDONDEA A '0' CERO 
    newBalanceOperation=0;
   }
   api.parentVc.model.LoanHeader.BalanceOperation = newBalanceOperation;
   
   
   var disburmentIncomeForm =entities.DisbursementIncome.DisbursementForm.split("/");
   var prueba= {DisbursementForm: disburmentIncomeForm[0],
       Currency: entities.DisbursementIncome.Currency,
       DisbursementValue: entities.DisbursementIncome.DisbursementValue,
       ValueMl: entities.DisbursementIncome.ValueMl,
       PriceQuote: entities.DisbursementIncome.Quotation,
       DisbursementFormId: entities.DisbursementIncome.Sequential,
       AmountMOP: entities.DisbursementIncome.CurrentBalance,
       Sequential: entities.DisbursementIncome.Sequential,
       DisbursementId: entities.DisbursementIncome.DisbursementId};
   var detail = api.vc.rowData;
   //PARA DESTRUIR MANUALMENTE EL SCOPE Y EVITAR QUE SE EJECUTE VARIAS VECES EL EVENTO CHANGE
   var scope = angular.element($('#QV_TSRSE1342_26 tr.k-detail-row td.k-detail-cell > div')).scope();
   if (angular.isDefined(scope)) {
    scope.$destroy();
   };
   detail.set('DisbursementForm', prueba.DisbursementForm );
   detail.set('Currency', prueba.Currency );
   detail.set('DisbursementValue', prueba.DisbursementValue );
   detail.set('ValueMl', prueba.ValueMl );
   detail.set('PriceQuote', prueba.PriceQuote );
   detail.set('DisbursementFormId', prueba.DisbursementFormId );
   detail.set('AmountMOP', prueba.AmountMOP );
   detail.set('sequential', prueba.Sequential );
   detail.set('DisbursementId', prueba.DisbursementId );
  }
};

//Entity: DisbursementDetail
    //DisbursementDetail. (Button) View: TaskDisbursementIncome
    //Evento ExecuteCommand: Permite personalizar la acciÃ³n a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONIWKBMNP_334W66 = function(  entities, executeCommandEventArgs ) {

        executeCommandEventArgs.commons.execServer = true;
        entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
        entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;
         entities.PaymentSelection.creditType=task.creditType;
    
        //executeCommandEventArgs.commons.serverParameters.DisbursementDetail = true;
    };

//Entity: DisbursementDetail
    //DisbursementDetail. (Button) View: TaskDisbursementIncome
    //Evento ExecuteCommand: Permite personalizar la acciÃ³n a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONRBZVRHL_639W66 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
         entities.PaymentSelection.groupId=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.CustomerId;
         entities.PaymentSelection.transactionNumber=executeCommandEventArgs.commons.api.parentVc.model.LoanHeader.Operation;
         entities.PaymentSelection.creditType=task.creditType;
    
        //executeCommandEventArgs.commons.serverParameters.DisbursementDetail = true;
    };

//Evento initData : InicializaciÃ³n de datos del formulario, despuÃ©s de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_AUSMM61_MDSIC_473 = function (entities, initDataEventArgs){
         var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
		   initDataEventArgs.commons.api.viewState.hide('G_DISBURSIET_541W66');
  initDataEventArgs.commons.api.viewState.hide('G_DISBURSNVE_552W66');
  initDataEventArgs.commons.api.viewState.hide('VA_SRSNTINOIW6604_ACCU010');
  initDataEventArgs.commons.api.viewState.hide('VA_SRSNTINOIW6604_DCII002');
  initDataEventArgs.commons.api.viewState.hide('VA_SRSNTINOIW6604_IOFF658');
  initDataEventArgs.commons.api.viewState.disable('VA_SRSNTINOIW6604_OAIN735');
  entities.LoanHeader=initDataEventArgs.commons.api.parentVc.model.LoanHeader;

  var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE);
  entities.DisbursementIncome.Office = office.code;
  entities.DisbursementIncome.CurrentBalance = parentParameters.balanceOperation;
  entities.DisbursementIncome.CurrencyOP = parentParameters.currency;
  entities.DisbursementIncome.Currency = parentParameters.currency;
  entities.DisbursementIncome.BalanceOperation = parentParameters.balanceOperation;
  entities.DisbursementIncome.QuotationOP = parentParameters.priceQuote;
  entities.DisbursementIncome.OperationId = parentParameters.operationBanck;
  entities.DisbursementIncome.Quotation = parentParameters.priceQuote;
  entities.DisbursementIncome.ClientID = parentParameters.clientId;
  entities.DisbursementIncome.DisbursementValue = entities.DisbursementIncome.BalanceOperation;
  entities.DisbursementDetail = parentParameters.arrayDisbursementDetail;
  initDataEventArgs.commons.execServer = false;
  initDataEventArgs.commons.api.vc.change2('VA_SRSNTINOIW6604_RNCY790',entities.DisbursementIncome.Currency, 99);
        
        task.creditType=parentParameters.creditType;
        
        
         if(task.creditType===FLCRE.CONSTANTS.TypeRequest.GRUPAL){
            initDataEventArgs.commons.api.viewState.disable('VA_SRSNTINOIW6604_IBTU111');
         }
        
    };

//Entity: DisbursementIncome
    //DisbursementIncome.Currency (ComboBox) View: TaskDisbursementIncome
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catÃ¡logo.
    task.loadCatalog.VA_SRSNTINOIW6604_RNCY790 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        loadCatalogDataEventArgs.commons.serverParameters.LoanHeader = true;
    };

//Entity: DisbursementIncome
    //DisbursementIncome.Account (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_SRSNTINOIW6604_ACCU010 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;

  var nav = textInputButtonEventArgs.commons.api.navigation;
        var api = textInputButtonEventArgs.commons.api;
        nav.customDialogParameters = {
   clientID: textInputButtonEventArgs.model.DisbursementIncome.CustomerId
        }
        nav.address = {
           moduleId: 'BUSIN',
           subModuleId: 'FLCRE',
           taskId: 'T_FLCRE_11_AATIN09',
           taskVersion: '1.0.0',
           viewContainerId: 'VC_AATIN09_UTINO_445'
        }
  nav.modalProperties = {
   size: "lg"
  }
        
    };

//Entity: DisbursementIncome
    //DisbursementIncome.DisbursementForm (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_SRSNTINOIW6604_DBUF584 = function( textInputButtonEventArgs ) {
        if(textInputButtonEventArgs.model.DisbursementIncome.Currency != undefined || textInputButtonEventArgs.model.DisbursementIncome.Currency != null){
   var nav = textInputButtonEventArgs.commons.api.navigation;
   nav.customDialogParameters = {
    currency: textInputButtonEventArgs.model.DisbursementIncome.Currency
   }
   nav.address = {
      moduleId: 'BUSIN',
      subModuleId: 'FLCRE',
      taskId: 'T_FLCRE_53_TKCSO26',
      taskVersion: '1.0.0',
      viewContainerId: 'VC_TKCSO26_CRNTO_867'
   }
   nav.modalProperties = {
    size: "lg"
   }
  }else{
   textInputButtonEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LETCRENCY_55231');
  }
        
    };

//gridRowUpdating QueryView: QV_5438_61030
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_5438_61030 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            //gridRowUpdatingEventArgs.commons.serverParameters.MemberGroup = true;
        };

//Start signature to Callback event to QV_5438_61030
task.gridRowUpdatingCallback.QV_5438_61030 = function(entities, gridRowUpdatingCallbackEventArgs) {
//here your code
};


}());