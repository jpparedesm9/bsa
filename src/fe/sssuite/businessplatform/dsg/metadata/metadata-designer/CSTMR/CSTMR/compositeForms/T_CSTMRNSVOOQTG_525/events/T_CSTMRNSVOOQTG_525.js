//"TaskId": "T_CSTMRNSVOOQTG_525"
var taskHeader = {};
var typeRequest = ''; //caso#162288
var mode = ''; //caso#162288
var activeChangeIniDocs = false; //caso153311

task.loadTaskHeader = function (entities, eventArgs) {
    var client = eventArgs.commons.api.parentVc.model.Task;
    var originalh = entities.OriginalHeader;

    // Titulo de la cabecera (title)
    LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

    // Subtitulos de la cabecera       
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.iDRequested == null || originalh.iDRequested == '0' ? '--' : originalh.iDRequested), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', (entities.OriginalHeader.category == null ? ' ' : entities.OriginalHeader.category), 0) //SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', LATFO.CONVERT.CURRENCY.Format((originalh.amountRequested == null || originalh.amountRequested == 'null' ? 0 : originalh.amountRequested), 2), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', LATFO.CONVERT.CURRENCY.Format((originalh.amountAproved == null || originalh.amountAproved == 'null' ? 0 : originalh.amountAproved), 2), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.OriginalHeader.term, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.GeneralData.paymentFrecuencyName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', (entities.OriginalHeader.productType == null ? ' ' : entities.OriginalHeader.productType) + " " + (entities.OriginalHeader.subType == null ? ' ' : entities.OriginalHeader.subType), 1); //SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.GeneralData.vinculado, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.GeneralData.sectorNeg, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (entities.Context.flag1 == null ? '--' : entities.Context.flag1), 1);
    // Actualizo el grupo de designer
    LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_LEGALPEARR_339688');
};
