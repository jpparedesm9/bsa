//"TaskId": "T_LOANSCAIEJKDY_486"
    var taskHeader = {};
    var type = '';

    task.loadTaskHeader = function (entities, eventArgs) {
        //LATFO.INBOX.addTaskHeader(taskHeader, 'title', 'Titulo', 0);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha de Constituci\u00f3n', '01-01-2017', 1);
        //LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del grupo', '01', 2);
        
		
		
		
		LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.Group.code + " - " + entities.Group.nameGroup, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', entities.Credit.creditCode, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', entities.Credit.category, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested  == 'null' ? 0 : entities.Credit.amountRequested ), 2), 1);
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount  == 'null' ? 0 : entities.Credit.approvedAmount ), 2), 1);
		LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.Credit.term, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.Credit.paymentFrecuency, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Credit.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Credit.officeName), 2);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', entities.Credit.subtype, 2);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado',  entities.Credit.linked, 2);
		LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', entities.Group.cycleNumber, 2);
		LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_HEADERGUOP_223993');
        eventArgs.commons.api.viewState.show('G_HEADERGUOP_223993');
    };