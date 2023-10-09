    //"TaskId": "T_FLCRE_35_RDPCA77"
    var taskHeader = {};

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
            args.commons.api.vc.parentVc.labelExecuteCommand1 = "Autorizar";
            args.commons.api.vc.parentVc.executeCommand1 = function () {
                args.commons.api.vc.executeCommand('CM_RDPCA77SAE65', 'Autorizar', undefined, true, false, 'VC_RDPCA77_ICANR_753', false);
            }
        }
    };

    task.loadTaskHeader = function (entities, eventArgs) {
        var client = eventArgs.commons.api.parentVc.model.Task;
        var originalh = entities.OriginalHeader;
        var plazo = '0';

        if (originalh.Term == null || originalh.Term == undefined) {
            entities.OriginalHeader.Term = 0;
            plazo = '0';
        } else {
            //entities.OriginalHeader.Term=entities.OfficerAnalysis.Term;
            plazo = entities.OriginalHeader.Term;
        }
        entities.OriginalHeader.CurrencyRequested = 2;

        //Titulo de la cabecera (title)
        LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

        //Subtitulos de la cabecera		
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == 'null' ? '--' : originalh.IDRequested), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Producto', entities.generalData.productTypeName, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.symbolCurrency, 0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', plazo + ' ' + entities.generalData.paymentFrecuencyName, 0);
        //LATFO.INBOX.addTaskHeader(taskHeader,'Frecuencia',entities.generalData.paymentFrecuencyName,0);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', cobis.userContext.getValue(cobis.constant.USER_OFFICE).value, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((originalh.OfficierName != null) ? originalh.OfficierName.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.generalData.loanType, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);
        LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
        //Actualizo el grupo de designer
        LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
    };

    //QueryView: GridExceptions - Actualiza el Valor de la Entidad.
    task.gridRowCommand.VA_OVECRDTRQE4824_EULT673 = function (entities, args) {
        args.commons.execServer = false;
        var index = args.rowIndex;
        for (var i = 0; i <= entities.Exceptions.data.length; i++) {
            if (i === index)
                entities.Exceptions.data()[i].Aproved = !entities.Exceptions.data()[i].Aproved;
        }
    };
