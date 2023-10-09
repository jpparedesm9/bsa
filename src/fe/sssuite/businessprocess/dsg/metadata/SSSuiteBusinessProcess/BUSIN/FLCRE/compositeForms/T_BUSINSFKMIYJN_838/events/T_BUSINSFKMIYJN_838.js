//"TaskId": "T_BUSINSFKMIYJN_838"

var taskHeader = {};
var typeRequest = '';

task.loadTaskHeader = function (entities, eventArgs) {    
    var client = eventArgs.commons.api.parentVc.model.Task;
    var context = entities.Context;
    var originalh = entities.OriginalHeader;
    
   // Titulo de la cabecera (title)
   if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
	   LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientId + " - " + client.clientName);
   }else{
	   LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);
   }
   
    // Subtitulos de la cabecera       
   LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == '0' ? '--' : originalh.IDRequested), 0);

   //LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', (entities.OriginalHeader.category == null ? ' ': entities.OriginalHeader.category), 0)//SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
   LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountAprobed == null || originalh.AmountAprobed == 'null' ? 0 : originalh.AmountAprobed), 2), 0);//ACHP
   //SMO cambia en grupales  LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.GeneralData.symbolCurrency, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.GeneralData.mnemonicCurrency, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.OriginalHeader.Term, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.GeneralData.paymentFrecuencyName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
   //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((entities.OfficerAnalysis.OfficierName != null) ? entities.OfficerAnalysis.OfficierName.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
    //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
    //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.GeneralData.loanType, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', (entities.OriginalHeader.Type == null ? ' ' : entities.OriginalHeader.Type) + " " + (entities.OriginalHeader.subType == null ? ' ' : entities.OriginalHeader.subType), 1);//SMO se agrega en grupales
    LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.GeneralData.vinculado, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.GeneralData.sectorNeg, 1);
    if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
	    LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', (context.cycleNumber == null? '--' : context.cycleNumber), 1);
    }else{
	    LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (context.cycleNumber == null? '--' : context.cycleNumber), 1);
    }

    // Actualizo el grupo de designer
    LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_HEADERZBOW_963263');
};

   task.showButtons = function (args) {
       var api = args.commons.api;
       var parentParameters = args.commons.api.parentVc.customDialogParameters;
       // Boton Principal (Wizard)
       // initDataEventArgs.commons.api.vc.parentVc.executeSaveTask =
       // function(){
       // initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save',
       // undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
       // }

       // Boton Secundario 1 (Wizard)
       // (Para aumentar un boton adicional copiar y pegar el bloque de codigo
       // debajo de estos comentarios)
       // (Posteriormente cambiar el numero de terminacion de la etiqueta Ej.
       // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 =>
       // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
       // (Posteriormente cambiar el numero de terminacion del metodo Ej.
       // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
       // function() =>
       // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
       // function())
       // (Tiene una limitacion de 5 axecute commands)

       if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == "Q") {
           args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
       } else {
           args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
           args.commons.api.vc.parentVc.executeCommand1 = function () {
               args.commons.api.vc.executeCommand('CM_TBUSINSF_3N8', 'Save', undefined, true, false, 'VC_DATAVERITO_790838', false);
           }

           args.commons.api.vc.parentVc.labelExecuteCommand2 = "Sincronizar Movil";
           args.commons.api.vc.parentVc.executeCommand2 = function () {
               args.commons.api.vc.executeCommand('CM_TBUSINSF_SSU', "Synchronize Mobile", undefined, true, false, 'VC_DATAVERITO_790838', false);
           }		   
       }
   };