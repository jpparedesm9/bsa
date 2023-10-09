    var hasGuarantor = false;    
    var loadStoreKeeper = 0;
    var updateWarranty = false;


    task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var isGuarantor = args.commons.api.vc.customDialogParameters == "guarantor" ? true : false;
        if (isGuarantor) {
            args.model.WarrantyGeneral.guarantor = resp.CodeReceive + "-" + resp.name;
        } else {
            var row = args.model.CustomerSearch.data()[0];
            var wPrincipal = true;
            //Determinar si la garantía ya tiene asociado el cliente principal
            var customerList = args.commons.api.vc.model.CustomerSearch.data();
            for (var i = 0; i < customerList.length; i++) {
                if (customerList[i].Principal) {
                    wPrincipal = false;
                    break;
                }
            }
            row.set('CustomerId', args.commons.api.vc.dialogParameters.CodeReceive);
            if (args.commons.api.vc.dialogParameters.commercialName !== '') {
                row.set('Customer', args.commons.api.vc.dialogParameters.commercialName);
            } else {
                row.set('Customer', args.commons.api.vc.dialogParameters.name);
            }
            row.set('OfficerId', args.commons.api.vc.dialogParameters.officerId);
            row.set('Officer', args.commons.api.vc.dialogParameters.officerName);
            row.set('Principal', wPrincipal);
        }
    };

    //Resultado de envio de Plazo Fijo
    task.closeModalEvent.VC_BYLET28_DTBCT_453 = function (args) {
        console.log("Evento CloseModal VC_BYLET28_DTBCT_453");
        var result = args.result;
        if (result.value != '') {
            args.model.WarrantyGeneral.fixedTerm = result.value;
            args.model.WarrantyGeneral.fixedTermAmount = result.amount;
            args.model.WarrantyGeneral.documentNumber = result.code;
            args.model.WarrantyGeneral.initialValue = result.amount;
        }
    };


    task.closeModalEvent.VC_CRNTO32_RRNYM_717 = function (args) {
        console.log("Evento CloseModal VC_CRNTO32_RRNYM_717");
        //var result = args.result;
        //alert("Close Modal");
    };

    task.setPrincipalCustomer = function (entities, args) {
        //Marcar el primer cliente como principal
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        for (var i = 0; i < customerList.length; i++) {
            if (!customerList[i].Principal) {
                customerList[i].Principal = true;
                break;
            }
        }
    };

    task.validatePersonalWarranty = function (typeOfGuarantee, viewState) {
        //En la Garantía Personal se presenta el campo Garante        
        if ("GARGPE" == typeOfGuarantee) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_MONY430']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_ILAE518']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_ESOE640']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_AIUE963']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_VADT830']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_NVLE498']);
            viewState.disable('VC_RRCAI67_GUPOB_764', true);
            viewState.readOnly('VA_ARANSCATIO0709_RNTR310', true);
            hasGuarantor = true;
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_MONY430']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_ILAE518']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_ESOE640']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_AIUE963']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_VADT830']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_NVLE498']);
            //viewState.enable('VC_RRCAI67_GUPOB_764', true); //POLIZAS DESHABILITADAS
            viewState.readOnly('VA_ARANSCATIO0709_RNTR310', false);
            hasGuarantor = false;
        }
    };

    task.validateDPFWarranty = function (typeOfGuarantee, viewState) {
        //En la Garantía Plazo Fijo se presenta el campo Plazo Fijo        
        if ("GARPFI" == typeOfGuarantee) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_IDER508']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_DRMA851']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_OEBE980']); //numero de documento
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_IDER508']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_DRMA851']);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0709_OEBE980']);
        }
    };

    task.validateHipWarranty = function (superiorTypeOfGuarantee, viewState) {
        if ("HIP" == superiorTypeOfGuarantee) {
            viewState.enableValidation('VA_ARANSCATIO0709_AIUE963', VisualValidationTypeEnum.Required);    
        } else {
            viewState.disableValidation('VA_ARANSCATIO0709_AIUE963', VisualValidationTypeEnum.Required);    
        }        
    };

    task.setGeneralData = function (entities, params, viewState, initDataEventArgs) {
        entities.WarrantyGeneral.currency = 0; //asignar el valor del contexto            
        if (initDataEventArgs.commons.api.parentVc.parentVc != undefined         
            && (initDataEventArgs.commons.api.parentVc.parentVc.parentVc.id == "inbox" ||initDataEventArgs.commons.api.parentVc.parentVc.parentVc.id=='inboxWizardVC')) {
            entities.WarrantyGeneral.currency = initDataEventArgs.commons.api.parentApi().parentVc.model.OriginalHeader.CurrencyRequested;
        }
        entities.WarrantyGeneral.warrantyType = params.typeGuaranteeData.typeOfGuarantee;
        entities.WarrantyGeneral.description = params.typeGuaranteeData.descripcionGuarantee;
        entities.WarrantyGeneral.mandatoryDocument = params.typeGuaranteeData.documentNumber;
        entities.WarrantyGeneral.appraisalValue = 0;
        entities.WarrantyGeneral.initialValue = 0;
        entities.WarrantyGeneral.currentValue = 0;
        entities.WarrantyGeneral.fixedTermAmount = 0;
        entities.WarrantyGeneral.status = "P"; //Propuesta            
        var f = new Date();
        entities.WarrantyGeneral.admissionDate = f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear();
        entities.WarrantyGeneral.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.WarrantyGeneral.filial = cobis.userContext.getValue(cobis.constant.USER_FILIAL);
    };

    task.setSituationData = function (entities, params, viewState) {
        entities.WarrantySituation.classWarranty = params.typeGuaranteeData.classGuarantee;
        entities.WarrantySituation.periodicity = params.typeGuaranteeData.periodicity;
        entities.WarrantySituation.suitable = params.typeGuaranteeData.appropriate;
        entities.WarrantySituation.legalSufficiency = "O";
        entities.WarrantySituation.totalInitialValue = 0;
        entities.WarrantySituation.sharedType = false;
        entities.WarrantySituation.judicialCollectionType = false;
        if ("S" == params.typeGuaranteeData.guaranteeFund) {
            entities.WarrantySituation.guaranteeFund = true;
        } else {
            entities.WarrantySituation.guaranteeFund = false;
        }
    };

    task.hideSituationFields = function (entities, viewState) {
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_CODE053']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_EXTE434']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_TEAE147']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NTLL256']);
        if (entities.WarrantySituation.periodicity == null || entities.WarrantySituation.periodicity == 'N') {
            entities.WarrantySituation.inspectType = false;
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_RDII635']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        } else {
            entities.WarrantySituation.inspectType = true;
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        }
    };

    task.showFieldsVerified = function (entities, viewState) {
        if (entities.WarrantySituation.sharedType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NTLL256']);
        }
        if (entities.WarrantySituation.judicialCollectionType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        }
        if (entities.WarrantySituation.inspectType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_RDII635']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_RDII635']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        }
    };

    task.addPersonalWarrantyList = function (args, isUpdate) {
        //Buscar el id del cliente principal de la garantía
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        var customerId;
        for (var i = 0; i < customerList.length; i++) {
            if (customerList[i].Principal) {
                customerId = customerList[i].CustomerId;
                break;
            }
        }
        var guarantorDescription = args.commons.api.vc.model.WarrantyGeneral.guarantor;
        var indexBegin = guarantorDescription.indexOf("-");
        var indexEnd = guarantorDescription.length;
        var guarantorName = guarantorDescription.substring(indexBegin + 1, indexEnd);
        var personalGuarantorData = {
            CodeWarranty: args.commons.api.vc.model.WarrantyGeneral.externalCode,
            Type: args.commons.api.vc.model.WarrantyGeneral.warrantyType,
            Description: args.commons.api.vc.model.WarrantyGeneral.description,
            GuarantorPrimarySecondary: guarantorName, //cambiar por el nombre del garante
            ClassOpen: args.commons.api.vc.model.WarrantySituation.classWarranty,
            IdCustomer: customerId,
            State: args.commons.api.vc.model.WarrantyGeneral.status,
            DateCIC: null,
            isHeritage: "N", //obtener el valor
            CurrentValue: null,
            Currency: null,
            modifyStatus: "N", //se agrega para la historia de modificación de garantías
            bddStatus:"NO"//se agrega para la historia de modificación de garantías
        };
        if (isUpdate) {
            return personalGuarantorData;
        } else {
            args.commons.api.parentApi().parentApi().grid.addRow("PersonalGuarantor", personalGuarantorData);
        }


    };

    task.addOtherWarrantyList = function (args, isUpdate) {
        //Buscar el id del cliente principal de la garantía
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        var customerId;
        var customerName;
        for (var i = 0; i < customerList.length; i++) {
            if (customerList[i].Principal) {
                customerId = customerList[i].CustomerId;
                customerName = customerList[i].Customer;
                break;
            }
        }
        var appraisalDate = "";
        if (args.commons.api.vc.model.WarrantyGeneral.appraisalDate != null) {
            appraisalDate = BUSIN.CONVERT.NUMBER.Format(args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getMonth() + 1), "0", 2) + "/" + args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getFullYear();
        }
        var otherWarrantyData = {
            CodeWarranty: args.commons.api.vc.model.WarrantyGeneral.externalCode,
            Type: args.commons.api.vc.model.WarrantyGeneral.warrantyType,
            Description: args.commons.api.vc.model.WarrantyGeneral.description,
            InitialValue: args.commons.api.vc.model.WarrantyGeneral.initialValue,
            DateAppraisedValue: appraisalDate,
            ValueApportionment: 0,
            ClassOpen: args.commons.api.vc.model.WarrantySituation.classWarranty,
            ValueAvailable: args.commons.api.vc.model.WarrantyGeneral.fixedTermAmount,
            IdCustomer: customerId,
            NameGar: customerName,
            State: args.commons.api.vc.model.WarrantyGeneral.status,
            Flag: true,
            IsNew: true,
            ValueVNR: 0,
            RelationshipGuarantees: 0,
            isHeritage: "N", //obtener el valor
            relation: 0,
            modifyStatus: "N", //se agrega para la historia de modificación de garantías
            bddStatus:"NO"//se agrega para la historia de modificación de garantías
        };
        if (isUpdate) {
            return otherWarrantyData;
        } else {
            args.commons.api.parentApi().parentApi().grid.addRow("OtherWarranty", otherWarrantyData);
        }

    };

    //Abrir búsqueda de garantes
    task.openFindProgram = function (argsI) {
        var params = "guarantor";
        FLCRE.UTILS.CUSTOMER.openFindGuarantor(argsI, params);
    };

    task.renderAditionalData = function (entities, parentParameters, args) {
        //Llamada a la configuraciÃ³n adicional por producto bancario        
        var api = args.commons.api;
        var nav = args.commons.api.navigation;
        var typeOfWarranty = "",codeWarranty = "";
        //se necesita por problemas con el scope
        api.vc.removeChildVc('FINPMITEMRENDER');
        nav.label = "RENDER";
        nav.customAddress = {
            id: 'FINPMITEMRENDER',
            url: 'fpm/templates/render-items-values.html', //no head
            useMinification: false
        };
        nav.scripts = [{
            module: cobis.modules.FPM,
            files: ['fpm/fpm-tree-process.js', 'fpm/services/fpm-tree-process-srv.js', 'fpm/controllers/fpm-tree-process-ctrl.js', '/fpm/services/render-items-values-srv.js', '/fpm/controllers/render-items-values-ctrl.js']
   }];
        if (api.vc.customDialogParameters == undefined) {
            api.vc.customDialogParameters = api.parentVc.customDialogParameters;
        }

        nav.customDialogParameters = api.vc.customDialogParameters;
        nav.customDialogParameters.Type = "SECCION_RENDERIZADA";
        nav.customDialogParameters.Request = parentParameters.Task.bussinessInformationIntegerTwo;


        if (nav.customDialogParameters.typeGuaranteeData != undefined) {
            nav.customDialogParameters.BankingProductName = nav.customDialogParameters.typeGuaranteeData.descripcionGuarantee;
            typeOfWarranty = nav.customDialogParameters.typeGuaranteeData.typeOfGuarantee;
            codeWarranty = (nav.customDialogParameters.typeGuaranteeData.CodeWarranty===undefined||nav.customDialogParameters.typeGuaranteeData.CodeWarranty===null)? '':nav.customDialogParameters.typeGuaranteeData.CodeWarranty;
        } else {
            nav.customDialogParameters.BankingProductName = api.vc.parentVc.customDialogParameters.currentRow.Description;
            typeOfWarranty = api.vc.parentVc.customDialogParameters.currentRow.Type;
            codeWarranty = (api.vc.parentVc.customDialogParameters.currentRow.CodeWarranty===undefined||api.vc.parentVc.customDialogParameters.currentRow.CodeWarranty===null)? '':api.vc.parentVc.customDialogParameters.currentRow.CodeWarranty;
        }


        nav.customDialogParameters.ModeView = "";
        //modificar los if's cuando la funcionalidad de renderizacion sea la correcta
        nav.customDialogParameters.BankignProductId = typeOfWarranty;
        nav.customDialogParameters.RegisterId = codeWarranty;
        

        nav.registerCustomView('GR_ITAEDEARVE21_03');
    };

    task.validateRenderSection = function (entities, parentParameters, args) {
            
        var customDialogParameters = args.commons.api.parentVc.customDialogParameters;
        var dicCompanyProductType = {};        
        if (entities.dicCompanyProductType) {
            dicCompanyProductType = entities.dicCompanyProductType;
        }
        entities.Values = [];
        var validation = true;
        /*Check validation field by field*/
        if (validation && entities.WarrantyGeneral.warrantyType != 'GARGPE') {                
            angular.forEach(dicCompanyProductType.dictFunctionalityGroups, function (dicFuncGroup) {
                angular.forEach(dicFuncGroup.dictionaryFields, function (field) {
                    //SMO TEMPORAL
                    if(!angular.element("#RFIELD"+field.id).data("kendoValidator").validate() && validation){
                        validation = false;                        
                    }    
                    if(field!=null && field.id!=null){
                        if(field.fieldvalues!=null && field.fieldvalues.length==1 && field.fieldvalues[0].valueSourceId=='P'){
                            if(angular.isDefined(field.value)){
                            var content=field.value.split("-");    
                                if(content.length>1)
                                {
                                    entities.FieldByProductValues = {
                                        requestId: parentParameters.Task.bussinessInformationIntegerTwo, //entities.OriginalHeader.IDRequested,
                                        productId: customDialogParameters.BankignProductId,//customDialogParameters.typeGuaranteeData.typeOfGuarantee, //entities.OriginalHeader.ProductType,
                                        fieldId: field.id,
                                        value: content[0]
                                    }    
                                }
                                else{
                                    entities.FieldByProductValues = {
                                        requestId: parentParameters.Task.bussinessInformationIntegerTwo, //entities.OriginalHeader.IDRequested,
                                        productId: customDialogParameters.BankignProductId,//customDialogParameters.typeGuaranteeData.typeOfGuarantee, //entities.OriginalHeader.ProductType,
                                        fieldId: field.id,
                                        value:field.value 
                                    }
                                }
                            }
                        }
                        else{
                            entities.FieldByProductValues = {
                            requestId: parentParameters.Task.bussinessInformationIntegerTwo, //entities.OriginalHeader.IDRequested,
                            productId: customDialogParameters.BankignProductId,//customDialogParameters.typeGuaranteeData.typeOfGuarantee, //entities.OriginalHeader.ProductType,
                            fieldId: field.id,
                            value: field.value
                            }    
                        };                        
                        entities.Values.push(entities.FieldByProductValues);
                    }
                    
                });
            });
        }

        if (validation) {
            return true;
        } else {            
            return false;            
        }
    };


     task.validateBeforeSave = function (entities, args, operation) {

        var saveWarranty = true;
        var api = args.commons.api;
        var customParameters = api.parentVc.customDialogParameters;
        var customDialogParameters = api.parentVc.customDialogParameters.isNew == true ? api.parentVc.parentVc.parentVc.customDialogParameters : api.parentVc.parentVc.customDialogParameters;
        var showMessageErrorPage = false;
        var processDate = api.parentVc.customDialogParameters.processDate;
        entities.generalData.isNew = true;


        if (customParameters.typeGuaranteeData != undefined) {
            var numErrors = args.commons.api.errors.getErrorsGroup('GR_ARANSCATIO07_09', false);
            var numLocalizationErrors = args.commons.api.errors.getErrorsGroup('GR_ARANSCATIO07_11', false);
            var numSituationErrors = args.commons.api.errors.getErrorsGroup('GR_ARANSCATIO07_15', false);
            var numAditionalDataErrors = task.validateRenderSection(entities, customDialogParameters, args);//args.commons.api.errors.getErrorsGroup('GR_ITAEDEARVE21_02', false);
            if (numErrors > 0 || numLocalizationErrors > 0 || numSituationErrors > 0||!numAditionalDataErrors) {
                saveWarranty = false;
                showMessageErrorPage = true;
                var errorTab=$("#VC_RRCAI67_WACRI_884_tab").data("kendoTabStrip");
                var numErrorTab=0;
                if(numErrors > 0){
                    numErrorTab=0;
                }else if(numLocalizationErrors>0){
                    numErrorTab=1;
                }else if(numSituationErrors>0){
                    numErrorTab=2;
                }else if(!numAditionalDataErrors){
                    numErrorTab=3;
                }
                errorTab.select(numErrorTab);
            }
            if (entities.WarrantySituation.sharedType && VA_ARANSCATIO0715_NTLL256.value <= 0) {
                saveWarranty = false;
                args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSAGITVUE_57419', true);
            }
            if ("S" == entities.WarrantyGeneral.mandatoryDocument && (entities.WarrantyGeneral.documentNumber == undefined || entities.WarrantyGeneral.documentNumber == null)) {
                saveWarranty = false;
                args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MATOYDUME_09219', true);
            }
            if (hasGuarantor && (api.vc.model.WarrantyGeneral.guarantor == null || api.vc.model.WarrantyGeneral.guarantor == "")) {
                saveWarranty = false;
                args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSSEGUARO_46360', true);
            }
            if (showMessageErrorPage) {
                args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ESICINSPG_05163', true);
            }
            if (entities.WarrantyGeneral.guarantor != null) {
                var guarantorDescription = entities.WarrantyGeneral.guarantor;
                var indexEnd = guarantorDescription.indexOf("-");
                var guarantorId = guarantorDescription.substring(0, indexEnd).trim();
                for (var i = 0; i < entities.CustomerSearch.data().length; i++) {
                    if (entities.CustomerSearch.data()[i].CustomerId == guarantorId) {
                        saveWarranty = false;
                        args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_RANTOESSG_12402', true);
                    }
                }
            }

            if (customParameters.typeGuaranteeData.typeOfGuarantee == 'GARPFI') {
                if (BUSIN.VALIDATE.IsNullOrEmpty(entities.WarrantyGeneral.fixedTerm) && (BUSIN.VALIDATE.IsNullOrEmpty(entities.WarrantyGeneral.fixedTermAmount) || entities.WarrantyGeneral.fixedTermAmount == 0)) {
                    saveWarranty = false;
                    args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_URFDTEMRR_83587', true);
                }
            }

            if (saveWarranty == true && task.validateRenderSection(entities, customDialogParameters, args)) {
                //args.commons.execServer = true;                
                var serverParameters = args.commons.api.vc.serverParameters;
                if (operation == "I") {  
                    entities.generalData.isNew = true;                
                    //var serverParameters = args.commons.api.vc.serverParameters;
                    serverParameters.WarrantyGeneral = true;
                    serverParameters.WarrantyLocation = true;
                    serverParameters.WarrantySituation = true;
                    serverParameters.CustomerSearch = true;
                    serverParameters.Values = true;
                    return true;
                } else {
                    entities.generalData.isNew = false;
                    serverParameters.WarrantyGeneral = true;
                    serverParameters.WarrantyLocation = true;
                    serverParameters.WarrantySituation = true;
                    serverParameters.CustomerSearch = true;
                    serverParameters.Values = true;
                    serverParameters.generalData=true;
                    return true;
                }
            } else {
                return false;
            }
        } else {
            return false;
        }
		
		

    };