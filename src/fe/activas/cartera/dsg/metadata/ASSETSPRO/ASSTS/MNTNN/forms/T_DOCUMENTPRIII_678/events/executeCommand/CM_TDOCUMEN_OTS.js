// (Button) 
    task.executeCommand.CM_TDOCUMEN_OTS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
		
		var dataGrid = entities.PrintingDocuments.data();
		var code = "";
		var itemReporte = "";
		var reportTitle = "";
        
		for (var i=0; i<dataGrid.length; i++)
		{
		if (dataGrid[i].item === true)
			code = dataGrid[i].codigo
		}
		
		switch (code)
			{
			case 1:
				itemReporte = "Liquidation";
				reportTitle = "LIQUIDACI\u00d3N - DESEMBOLSO PARCIAL";
				break;
			case 2:
				itemReporte = "ReceiptPayment";
				reportTitle = "RECIBO DE PAGO";
				break;
			case 3: 
				itemReporte = "PaymentTable";
				reportTitle = "TABLA DE AMORTIZACI\u00d3N";
				break;
			case 4:
				itemReporte = "PromissoryNote";
				reportTitle = "PAGAR\u00c9 A LA ORDEN";
				break;
			case 5:
				itemReporte = "CreditAgreement";
				reportTitle = "CONTRATO DE APERTURA DE CR\u00c9DITO";
				break;
            case 6:
                    var loan = entities.Loan;
                    if (loan.statusID==3){
                         var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                         cobis.showMessageWindow.alert(message, 'MENSAJE', buttons)
                    }else{
                       executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                       var buttons = ['NO', 'SI'];
                       var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');
                       cobis.showMessageWindow.confirm(message, 'MENSAJE', buttons).then(function (resp) {
                       switch (resp.buttonIndex) {
                          case 1: //accept
                          executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                          break;
                       }
                       executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5_6', 'DocumentPrinting', undefined, true, false, 'VC_DOCUMENTPP_352678', false);  
                       });
                    }
				break;
			default: 
				break;
				//alert('Default case');
			}
		
		var args = [['numOperation', entities.LoanPrinting.loanPrinting]];
		//var itemReporte = 'ReciboDePago';
        
        if (code != 6){
           ASSETS.Utils.generarReporte (itemReporte, args, reportTitle);
        }
		
    };