// (Button) Print
    task.executeCommand.CM_PUSEN31RIN94 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false; //JRU false;
		var debtors = entities.DebtorGeneral.data();
		for (var i = 0; i < debtors.length; i++) {
		   if(debtors[i].Role == 'C'){
					var debtorC = debtors[i].CustomerCode;
					break;
			}else{
				    var debtorC = 0;
			}
		}
		if(task.EtapaTramite==FLCRE.CONSTANTS.Stage.Entry){ //APCH
		    var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.ReportPunishmentRequest],['idTramit',entities.HeaderPunishment.IDRequested],['idProcess', entities.HeaderPunishment.ApplicationNumber],['cstDebtor',debtorC]];
		    BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.ReportPunishmentRequest,args);
		}
    };