    //"TaskId": "T_FLCRE_68_ITCII49"
    var taskHeader = {};
    var parameterPrint = null;

    task.showButtons = function (args) {
        var api = args.commons.api;
        var parentParameters = args.commons.api.parentVc.customDialogParameters;
        //Boton Principal (Wizard)
        //initDataEventArgs.commons.api.vc.parentVc.executeSaveTask = function(){
        //	initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
        //}

        //Boton Secundario 1 (Wizard)
        //(Para aumentar un boton adicional copiar y pegar el bloque de codigo debajo de estos comentarios)
        //(Posteriormente cambiar el numero de terminacion de la etiqueta Ej. initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 => initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
        //(Posteriormente cambiar el numero de terminacion del metodo Ej. initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function() => initDataEventArgs.commons.api.vc.parentVc.executeCommand2 = function())
        //(Tiene una limitacion de 5 axecute commands)

        if (parentParameters.Task.urlParams.Modo != undefined && parentParameters.Task.urlParams.Modo != null && parentParameters.Task.urlParams.Modo == FLCRE.CONSTANTS.Mode.Query) {
            args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        } else {
            args.commons.api.vc.parentVc.labelExecuteCommand1 = "Imprimir";
            args.commons.api.vc.parentVc.executeCommand1 = function () {
                args.commons.api.vc.executeCommand('CM_ITCII49ITT66', 'PrintOut', undefined, false, false, 'VC_ITCII49_TNYFM_899', false);
            }
        }
    };

    task.loadTaskHeader = function (entities, eventArgs) {

        var client = eventArgs.commons.api.parentVc.model.Task;
        var originalh = entities.OriginalHeader;
        entities.OriginalHeader.CurrencyRequested = 2;
        var customDialogParameters = eventArgs.commons.api.vc.parentVc.customDialogParameters;
		var typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;

        //Titulo de la cabecera (title)
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

        //Subtitulos de la cabecera		
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == 'null' ? '--' : originalh.IDRequested), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Producto', entities.generalData.productTypeName, 0);
        if(typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE)
		 {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.symbolCurrency, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', originalh.Term, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.generalData.paymentFrecuencyName, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.generalData.loanType, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
         }
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((originalh.OfficerName != null) ? originalh.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
        if(typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE)
		 {
        LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
         }
        LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);

        //Actualizo el grupo de designer
        LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
    };

    //si todos los documentos tienen mÃ¡s de una impresiÃ³n pueden pasar
    task.validatePrints = function (entities, args) {
        var nextStep = true;
        var documents = entities.DocumentProduct.data();
        for (var i = 0; i < documents.length; i++) {
            if (parseInt(documents[i].NroImpressions) == 0) {
                nextStep = false;
                break;
            }
        }
        if (nextStep) {
            //permite continuar sin dar click en imprimir
            var parentApi = args.commons.api.parentApi();
            parentApi.vc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
    };

    //QueryView: GridDocumentProduct - Actualiza el Valor de la Entidad.
    // Funcion llamada al dar click en yes/not gracias al template creado en VA_DOCUNODCVW7303_YSNO533
    task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {
        args.commons.execServer = false;
        var index = args.rowIndex;
        for (var i = 0; i <= entities.DocumentProduct.data().length; i++) {
            if (i === index)
                entities.DocumentProduct.data()[i].YesNot = !entities.DocumentProduct.data()[i].YesNot;
        }
        BUSIN.API.changeImageChecker(entities, args);
    };


    // REcupero los asltos
    task.closeModalEvent.VC_ANTTS25_AREPV_622 = function (args) {
        var parentApi = args.commons.api.parentApi();
        var parentVc = parentApi.vc;
        // Recupero el resultado
        var result = args.result;
        parameterPrint = {};
        parameterPrint.nameManager = result.nameManager;
        parameterPrint.city = result.city;

        if (args.result.entities != null && args.result.entities != undefined && args.result.entities != '') {
            var documents, documentTemp;
            documents = args.model.DocumentProduct.data();
            documentTemp = args.result.entities.DocumentProductTmp;
            for (var j = 0; j < documents.length; j++) {
                for (var i = 0; i < documentTemp.length; i++) {
                    if (documentTemp[i].Document != null && documents[j].Document == documentTemp[i].Document) {
                        // se replica la data faltante para enviar la entidad nueva
                        documentTemp[i].YesNot = documents[j].YesNot;

                        if (parentApi != undefined && documentTemp[i].YesNot == true) {
                            parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
                        }

                        console.log("documentProduct.NroImpressions->" + documents[j].NroImpressions + " documentProdTemp.NroImpressions->" + documentTemp[i].NroImpressions);
                        args.commons.api.grid.updateRow('DocumentProduct', j, documentTemp[i], false);
                    }
                }
            }
        }
    };
