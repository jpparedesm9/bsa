//gridInitDetailTemplate QueryView: GridDisbursementDetail
        //
        task.gridInitDetailTemplate.QV_TSRSE1342_26 = function(entities, gridInitDetailTemplateArgs) {        
		 gridInitDetailTemplateArgs.commons.execServer = false;
		 
		var nav = gridInitDetailTemplateArgs.commons.api.navigation;
        var api = gridInitDetailTemplateArgs.commons.api;
        nav.customDialogParameters = {
			currency: entities.LoanHeader.Currency,
			balanceOperation: entities.LoanHeader.BalanceOperation,
			priceQuote: entities.LoanHeader.PriceQuote,			
			operationBanck: entities.LoanHeader.OperationBanck,
			clientId: entities.LoanHeader.CustomerId,
			arrayDisbursementDetail: entities.DisbursementDetail//aqui
        };
        nav.address = {
           moduleId: 'BUSIN',
           subModuleId: 'FLCRE',
           taskId: 'T_FLCRE_83_AUSMM61',
           taskVersion: '1.0.0',
           viewContainerId: 'VC_AUSMM61_MDSIC_473'
           };
        nav.openDetailTemplate('QV_TSRSE1342_26', gridInitDetailTemplateArgs.modelRow);
    };