//Entity: OriginalHeader
    //OriginalHeader.AmountRequested (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		entities.OriginalHeader.AmountAprobed=changedEventArgs.newValue;
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((changedEventArgs.newValue ==null||changedEventArgs.newValue =='null' ? 0:changedEventArgs.newValue ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Autorizado',BUSIN.CONVERT.CURRENCY.Format((changedEventArgs.newValue ==null||changedEventArgs.newValue =='null' ? 0:changedEventArgs.newValue ),2),0);//--**ACHP
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');
    };