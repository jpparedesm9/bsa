// Imprimir (Button)
	task.executeCommand.CM_OIIRL51INT80 = function(entities, executeCommandEventArgs){
		executeCommandEventArgs.commons.execServer = false;//SMO validar estaba true en el servidor
		var debtor = FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
		if(debtor!=null){
		   if(entities.OriginalHeader.IDRequested!=null){
					var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstDebtor',debtor.CustomerCode],['cstName',debtor.CustomerName],['cstId',debtor.Identification],['cstTrId',entities.OriginalHeader.IDRequested],['cstAplId',entities.OriginalHeader.ApplicationNumber]];
					var debtors = entities.DebtorGeneral.data();
					var count = 0;
					for (var i = 0; i < debtors.length; i++) {
						if(debtors[i].Role == 'C'){
							count = count + 1;
							args.push(['cstCodeu'+count, debtors[i].CustomerCode]);
						}
					}
					BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.LoanApplication,args);
				} else {
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532');
		   }
		}else {
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SAOUCENTD_07389');
		}
                    
         
        
	};