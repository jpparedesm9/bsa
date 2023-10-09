//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TPunishmentPlan
    task.initDataCallback.VC_PUSEN31_TIMNT_481 = function (entities, initDataEventArgs){
        var rowsAmt = entities.Amount.data();
		for (var i = 0; i < rowsAmt.length; i ++) {
			rowsAmt[i].Concept = cobis.translate(rowsAmt[i].Concept);
		}
		task.ValidateImpossibilityDescription(entities, initDataEventArgs);
		task.loadTaskHeader(entities,initDataEventArgs);	
    };  