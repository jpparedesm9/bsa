//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_AUSMM61_MDSIC_473 = function (entities, initDataEventArgs){
         var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
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