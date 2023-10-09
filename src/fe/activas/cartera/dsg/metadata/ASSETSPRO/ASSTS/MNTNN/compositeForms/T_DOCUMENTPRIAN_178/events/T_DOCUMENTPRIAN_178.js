//"TaskId": "T_DOCUMENTPRIAN_178"
	
	function Print () {
		this.codigo = "";
		this.documentos = "";
		this.item = "";
	}

task.isValidDate = function(processDate,initDate){
    var maxDays = 10;
    var processDateSplit = processDate.split('/');
    var processDateTime = new Date(processDateSplit[2],processDateSplit[0]-1,processDateSplit[1]).getTime();
    var initDateTime = initDate.getTime(); 
    var dif = processDateTime - initDateTime;
    var difDays = Math.round(dif/(1000*60*60*24));
    if(difDays > maxDays){
         cobis.showMessageWindow.alertInfo("No se admiten cancelaciones individuales de un cr\u00e9dito grupal fuera del plazo establecido","AVISO");
        return false;
    }
    return true;
    

}
	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeDialog();
        var subModuleId = "CMMNS",
          taskId = "T_LOANSEARCHSWA_959",
          vcId = "VC_LOANSEARHC_144959",
          parameters = '',
          label=executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_BSQUEDASS_55923');
      ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId,label, executeCommandEventArgs, parameters);
	  return true;
    };

task.gridRowCommand.VA_VDATOSALUD3211_SEOA837 = function (rowData, gridRowCommandEventArgs) {
    var viewState = gridRowCommandEventArgs.commons.api.viewState;
    var anterior = true;
    gridRowCommandEventArgs.commons.execServer = false;
    gridRowCommandEventArgs.stopPropagation = true;
    anterior = gridRowCommandEventArgs.rowData.item;
    if (anterior == false) {
        gridRowCommandEventArgs.rowData.item = true;
    } else {
        gridRowCommandEventArgs.rowData.item = false;
    }
};