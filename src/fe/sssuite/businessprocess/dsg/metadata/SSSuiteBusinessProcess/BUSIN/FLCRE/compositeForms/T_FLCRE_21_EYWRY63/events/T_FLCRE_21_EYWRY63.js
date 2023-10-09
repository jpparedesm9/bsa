    //"TaskId": "T_FLCRE_21_EYWRY63"

    task.EtapaTramite = '';
    task.Etapa = '';
    var taskHeader = {};

    task.closeModalEvent.VC_GURNH31_OMREA_904 = function (eventArgs) {
        FLCRE.UTILS.GUARANTEE.addFromSearch(eventArgs);
        if (eventArgs.result.parameterGuarantee != null && eventArgs.result.parameterGuarantee != undefined) {
            //Set del campo HiddenInCompleted para poder continuar la tarea
            eventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
        }
    };



    //CloseModal Creacion de Garantias
    task.closeModalEvent.VC_RRCAI67_WACRI_884 = function (eventArgs) {
        var response = eventArgs.result;

        if (response != null && response != undefined) {
            if (response.Type != 'GARGPE') {
                var otherWarranties = eventArgs.commons.api.vc.model.OtherWarranty == undefined ? [] : eventArgs.commons.api.vc.model.OtherWarranty.data();
                otherWarranties.forEach(function (otherWarrantyItem) {
                    if (otherWarrantyItem.CodeWarranty == response.CodeWarranty) {
                        otherWarrantyItem.CodeWarranty = response.CodeWarranty;
                        otherWarrantyItem.Type = response.Type;
                        otherWarrantyItem.Description = response.Description;
                        otherWarrantyItem.InitialValue = response.InitialValue;
                        otherWarrantyItem.DateAppraisedValue = response.DateAppraisedValue;
                        otherWarrantyItem.ValueApportionment = response.ValueApportionment;
                        otherWarrantyItem.ClassOpen = response.ClassOpen;
                        otherWarrantyItem.ValueAvailable = response.ValueAvailable;
                        otherWarrantyItem.IdCustomer = response.IdCustomer;
                        otherWarrantyItem.NameGar = response.NameGar;
                        otherWarrantyItem.State = response.State;
                        otherWarrantyItem.Flag = response.Flag;
                        otherWarrantyItem.IsNew = response.IsNew;
                        otherWarrantyItem.ValueVNR = response.ValueVNR;
                        otherWarrantyItem.RelationshipGuarantees = response.RelationshipGuarantees;
                        otherWarrantyItem.isHeritage = response.isHeritage;
                        otherWarrantyItem.relation = response.relation;
                    }
                })
                eventArgs.commons.api.vc.model.OtherWarranty.data(otherWarranties);
            } else {
                var personalWarranties = eventArgs.commons.api.vc.model.PersonalGuarantor == undefined ? [] : eventArgs.commons.api.vc.model.PersonalGuarantor.data();
                personalWarranties.forEach(function (personalWarrantyItem) {
                    if (personalWarrantyItem.CodeWarranty == response.CodeWarranty) {
                        personalWarrantyItem.CodeWarranty = response.CodeWarranty;
                        personalWarrantyItem.Type = response.Type;
                        personalWarrantyItem.Description = response.Description;
                        personalWarrantyItem.GuarantorPrimarySecondary = response.GuarantorPrimarySecondary;
                        personalWarrantyItem.ClassOpen = response.ClassOpen;
                        personalWarrantyItem.IdCustomer = response.IdCustomer;
                        personalWarrantyItem.State = response.State;
                        personalWarrantyItem.DateCIC = response.DateCIC;
                        personalWarrantyItem.isHeritage = response.isHeritage;
                        personalWarrantyItem.CurrentValue = response.CurrentValue;
                        personalWarrantyItem.Currency = response.Currency;
                    }
                })
                eventArgs.commons.api.vc.model.PersonalGuarantor.data(personalWarranties);
            }
            //Set del campo HiddenInCompleted para poder continuar la tarea
            eventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
        }
    };


    task.getMaxPrelation = function (entities) {
        var relations = [];
        entities.PersonalGuarantor.data().forEach(function (garPersonal) {
            relations.push(garPersonal.relation);
        });
        entities.OtherWarranty.data().forEach(function (garOther) {
            relations.push(garOther.relation);
        });
        relations.sort(function (elem1, elem2) {
            return elem2 - elem1;
        });
        return relations[0];
    };

    task.loadTaskHeader = function (entities, eventArgs) {

        var client = eventArgs.commons.api.parentVc.model.Task;
        var originalh = entities.OriginalHeader;
        taskHeader = {};

        if (entities.OriginalHeader.TypeRequest == 'L') {
            //Líneas de Crédito
            //Titulo de la cabecera (title)
            LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

            //Subtitulos de la cabecera

            LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == 'null' ? '--' : originalh.IDRequested), 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'L\u00ednea', originalh.Line, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Producto', entities.generalData.productTypeName, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Monto', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.descripcionMoneda, 0); //tomar el campo de moneda(codigo??)


            LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', cobis.userContext.getValue(cobis.constant.USER_OFFICE).value, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((originalh.OfficerName != null) ? originalh.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);


        } else {
			   //Líneas de Crédito
            //Titulo de la cabecera (title)
            LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);
            //Subtitulos de la cabecera		
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == 'null' ? '--' : originalh.IDRequested), 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Producto', entities.generalData.productTypeName, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', 'USD', 0); //tomar el campo de moneda(codigo??)
            LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', originalh.Term, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.generalData.paymentFrecuencyName, 0);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.generalData.loanType, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', cobis.userContext.getValue(cobis.constant.USER_OFFICE).value, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((originalh.OfficerName != null) ? originalh.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);

        }

        //Actualizo el grupo de designer
        LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');

    };

    task.hideModeQuery = function (args) {

        //Variables
        var api = args.commons.api;
        var personalGuarantorDs = api.vc.model['PersonalGuarantor'].data();
        var otherWarrantyDs = api.vc.model['OtherWarranty'].data();

        //Deshabilito los botones
        args.commons.api.vc.viewState.CM_EYWRY63SOA19.visible = false;
        args.commons.api.vc.viewState.VA_UARNTEESEW9610_HBTN418.visible = false;
        args.commons.api.vc.viewState.VA_UARNTEESEW9610_0000924.visible = false;
        BUSIN.API.GRID.hideCommandColumns('QV_PESAU2317_81', personalGuarantorDs, api, 'edit');
        BUSIN.API.GRID.hideCommandColumns('QV_PESAU2317_81', personalGuarantorDs, api, 'delete');
        BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_66', otherWarrantyDs, api, 'edit');
        BUSIN.API.GRID.hideCommandColumns('QV_URYTH5890_66', otherWarrantyDs, api, 'delete');

        //Set del campo HiddenInCompleted para poder continuar la tarea
        args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";

    };

    task.disableRowGrid = function (eventArgs, entity, idGrid) {

        var ds = eventArgs.commons.api.vc.model[entity];
        var grid = eventArgs.commons.api.grid;
        var dsData = ds.data();
        for (var i = 0; i < dsData.length; i++) {
            var dsRow = dsData[i];
            if (dsRow.isHeritage === 'S') {
                grid.addRowStyle(idGrid, dsRow, 'Disable_CTR');
                grid.hideGridRowCommand(idGrid, dsRow, 'delete');
            } else {
                grid.removeRowStyle(idGrid, dsRow, 'Disable_CTR');
                grid.showGridRowCommand(idGrid, dsRow, 'delete');
            }
        }
        eventArgs.commons.api.viewState.refreshData(idGrid);
    };

    task.showButtons = function (args) {
        var api = args.commons.api;
        var parentParameters = args.commons.api.parentVc.customDialogParameters;
        if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == 'Q') {
            args.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        } else {
            args.commons.api.vc.parentVc.labelExecuteCommand1 = "Asociar";
            args.commons.api.vc.parentVc.executeCommand1 = function () {
                args.commons.api.vc.executeCommand('CM_EYWRY63SOA19', 'Associate', undefined, true, false, 'VC_EYWRY63_FMRRT_302', false);
            }

        }

    };
