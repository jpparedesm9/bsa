//showGridRowDetailIcon QueryView: GridDisbursementDetail
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_TSRSE1342_26 = function (entities, showGridRowDetailIconEventArgs){
		var result=false;
		var row = showGridRowDetailIconEventArgs.rowData;
		if(row.Currency == "" && row.DisbursementForm == "" && row.DisbursementValue == 0 && row.PriceQuote == 0){
			result=true;
		}else{
			result=false;
		}
		return result;
	};