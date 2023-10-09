// (Button)  Declaración Juramentada
        task.executeCommand.CM_OTENA94AAI98 = function(entities, executeCommandEventArgs) {
        //APCH
		if(task.Type === FLCRE.CONSTANTS.OfficerType.ChiefAgency){
		   executeCommandEventArgs.commons.execServer = false;//JRU false
		   var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.AffidavitPunishment],['grupo',entities.HeaderPunishment.GroupID],['typeDDJJ','AGENCIA']];
		   BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.AffidavitPunishment,args);
		   executeCommandEventArgs.commons.api.vc.closeModal();
		} else if (task.Type === FLCRE.CONSTANTS.OfficerType.RegionalManager){
		   executeCommandEventArgs.commons.execServer = false;
		   var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.AffidavitPunishment],['grupo',entities.HeaderPunishment.GroupID],['typeDDJJ','REGIONAL']];
		   var args1 = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.ReportRequestPunishment],['grupo',entities.HeaderPunishment.GroupID],['typeDDJJ','REGIONAL']];		
		   BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.AffidavitPunishment,args);
		   BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.ReportRequestPunishment,args1);
		   executeCommandEventArgs.commons.api.vc.closeModal();
		} else if (task.Type === FLCRE.CONSTANTS.OfficerType.CreditAnalyst){		   
		   executeCommandEventArgs.commons.execServer = false;
		   var nav = BUSIN.API.getApiNavigation('FLCRE',executeCommandEventArgs,'T_FLCRE_63_TAKNO30','VC_TAKNO30_INIOS_332');
		   nav.modalProperties = { size: 'md' };
		   nav.customDialogParameters = { group: entities.HeaderPunishment};
		   nav.openModalWindow(executeCommandEventArgs.commons.controlId);
		}		
    };