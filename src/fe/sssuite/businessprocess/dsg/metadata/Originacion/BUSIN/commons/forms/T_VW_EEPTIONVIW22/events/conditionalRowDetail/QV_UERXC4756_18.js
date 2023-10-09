//showGridRowDetailIcon QueryView: GridExceptions
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_UERXC4756_18 = function (entities, showGridRowDetailIconEventArgs) {
       var result=false;
		var row = showGridRowDetailIconEventArgs.rowData;
		if(row.Type==='D'){
			result=false;
		}else{
			result=true;
		}
	return result;
	};
	task.gridRowSelecting.QV_UERXC4756_18 = function(entities, gridInitDetailTemplateArgs) {
        gridInitDetailTemplateArgs.commons.execServer = false;
    };