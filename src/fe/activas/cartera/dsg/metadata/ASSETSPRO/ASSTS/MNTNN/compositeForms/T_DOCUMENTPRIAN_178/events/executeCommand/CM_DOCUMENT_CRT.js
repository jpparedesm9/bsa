// (Button) 
    task.executeCommand.CM_DOCUMENT_CRT = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;   

		var dataGrid = entities.PrintingDocuments.data();
		var code = "";
		var itemReporte = "";
		var reportTitle = "";
		var args = [];
    
		for (var i=0; i<dataGrid.length; i++)
		{
			if (dataGrid[i].item == true){
				
				code = dataGrid[i].codigo
				itemReporte = "";
				args = [];
			
				switch (code)
				{
					case 1:
						itemReporte = "Liquidation";
						reportTitle = "LIQUIDACI\u00d3N - DESEMBOLSO PARCIAL";
						var args = [['numOperation', entities.Loan.loanBankID.trim()],
									['secLiquidation', 4],
									['currencyLiquidation', 0]]
						break;
					case 2:
						//Open Modal
						var nav = executeCommandEventArgs.commons.api.navigation;
						reportTitle = "RECIBO DE PAGO";
						nav.label = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_LISTADOGC_53251');
						nav.address = {
							moduleId: 'ASSTS',
							subModuleId: 'MNTNN',
							taskId: 'T_BEFOREPRINNAA_172',
							taskVersion: '1.0.0',
							viewContainerId: 'VC_BEFOREPRAN_111172'
						};
						nav.queryParameters = {
							mode: 8
						};
						nav.modalProperties = {
							size: 'md',
							height: null,
							callFromGrid: false
						};
						nav.customDialogParameters = {
							loanInstancia:entities.LoanInstancia
						};
						nav.openModalWindow("CM_DOCUMENT_CRT", executeCommandEventArgs.modelRow);
						break;
					case 3: 
						itemReporte = "PaymentTable";
						reportTitle = "TABLA DE AMORTIZACI\u00d3N";
						var args = [['numOperation', entities.Loan.loanBankID.trim()],
							['paymentTableHis', "N"]];
						break;
					case 4:
						itemReporte = "PromissoryNote";
						reportTitle = "PAGAR\u00c9 A LA ORDEN";
						var args = [['numOperation', entities.Loan.loanBankID.trim()]];
						break;
					case 5:
						itemReporte = "CreditAgreement";
						reportTitle = "CONTRATO DE APERTURA DE CR\u00c9DITO";
						var args = [['numOperation', entities.Loan.loanBankID.trim()]];
						break;
                    case 6:
                        var loan = entities.Loan;
                        
                        if(operationType!='REVOLVENTE'){
                            cobis.showMessageWindow.alertInfo("No se admiten pagos Individuales para este tipo de Cr\u00e9dito","AVISO");   
                        }else{
                            
                            if (loan.statusID==3){
                                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
                                cobis.showMessageWindow.alert(message, 'FICHA DE PAGO CR\u00c9DITO INDIVIDUAL', buttons)
                            }else{
						      executeCommandEventArgs.commons.api.vc.serverParameters.sendMail ="1"; //PDF
                                var buttons = ['NO', 'SI'];
                                var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');
                                cobis.showMessageWindow.confirm(message, 'AVISO', buttons).then(function (resp)     {
                                switch (resp.buttonIndex) {
                                    case 1: //accept
                                        executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2";// ENVIO CORREO
                                   break;
                                    } 
                                    executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                                });
                            }
                        }
                        break;
                        
                        case 7:
                         executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_MPN', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false); 
                        
                        break;
                        
                        case 8:
                        executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_1RO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);  
                        break;
                        
                case 9:
				
                    //FICHA DE PAGO GENÉRICA				
					if (entities.Loan.statusID == 1 || entities.Loan.statusID == 2 || entities.Loan.statusID == 4 || entities.Loan.statusID == 12) {
						itemReporte = "GenericPaymentSlip";
                        reportTitle = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_FICHADEOO_52167');
                        var args = [
                        ['bank', entities.Loan.loanBankID.trim()],
                        ['clientID', entities.Loan.clientID]
                        ];
                        ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
                    } else {
                        var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_ESTADODIA_28122');
                        cobis.showMessageWindow.alertInfo(message, "AVISO");
                    }
                    break;

                default:
                    break;
            }
            if (code != 2 && code != 6 && code != 7 && code != 8 && code != 9) {
                ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
            }
        }
    }
};