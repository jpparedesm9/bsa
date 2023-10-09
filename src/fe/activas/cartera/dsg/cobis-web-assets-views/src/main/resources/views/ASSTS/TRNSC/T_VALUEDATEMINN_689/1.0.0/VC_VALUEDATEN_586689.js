//Designer Generator v 6.4.0.1 - SPR 2018-10 18/05/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.valuedatemain = designerEvents.api.valuedatemain || designer.dsgEvents();

function VC_VALUEDATEN_586689(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_VALUEDATEN_586689_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_VALUEDATEN_586689_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout, $translate) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL);
        }
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT)) {
            $scope.dateFormat = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT);
        } else {
            $scope.dateFormat = 'yyyy/MM/dd';
        }
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT_PLACEHOLDER)) {
            $scope.dateFormatPlaceholder = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT_PLACEHOLDER);
        } else {
            $scope.dateFormatPlaceholder = $scope.dateFormat;
        }
        $scope.designer = designer;
        $scope.validatorOptions = validatorOptions;
        $scope.vc = designer.initViewContainer({
            moduleId: "ASSTS",
            subModuleId: "TRNSC",
            taskId: "T_VALUEDATEMINN_689",
            taskVersion: "1.0.0",
            viewContainerId: "VC_VALUEDATEN_586689",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_VALUEDATEMINN_689",
        designerEvents.api.valuedatemain,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
                hasChangeInitDataSupport: false,
                hasSearchRenderEvent: true,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: false,
                vcName: 'VC_VALUEDATEN_586689'
            };
            if (($scope.vc.isModal($scope) || $scope.isDesignerInclude || $scope.isDesignerDetail) && angular.isDefined($scope.queryParameters)) {
                $scope.vc.pk = $scope.queryParameters.pk;
                $scope.vc.mode = parseInt($scope.queryParameters.mode || designer.constants.mode.Insert);
            } else {
                $scope.vc.pk = $location.search().pk;
                $scope.vc.mode = parseInt($location.search().mode || designer.constants.mode.Insert);
            }
            $scope.vc.args.pk = $scope.vc.pk;
            $scope.vc.args.mode = $scope.vc.mode;
            if (cobis.userContext.getValue(cobis.constant.USER_NAME)) {
                $scope.vc.args.user = cobis.userContext.getValue(cobis.constant.USER_NAME);
            } else {
                $scope.vc.args.user = "UserOutContainer";
            }
            $scope.vc.customDialogParameters = $scope.customDialogParameters;
            $scope.vc.args.channel = $location.search().channel;
            $scope.vc.metadata = {
                taskPk: {
                    moduleId: 'ASSTS',
                    subModuleId: 'TRNSC',
                    taskId: 'T_VALUEDATEMINN_689',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    ValueDateFilter: "ValueDateFilter",
                    TransactionLoan: "TransactionLoan",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
                    Loan: {
                        numProcedure: 'AT10_NUMPROUE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        statusID: 'AT12_STATUSID882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        balanceDue: 'AT21_BALANCDD882',
                        category: 'AT23_CATEGOYR882',
                        operationTypeID: 'AT23_OPERATDP882',
                        codCurrency: 'AT24_CODMONDD882',
                        newStatusID: 'AT25_NEWSTATT882',
                        isDisbursment: 'AT26_ISDISBTU882',
                        migratedOper: 'AT33_MIGRATEO882',
                        loanID: 'AT37_LOANIDFI882',
                        officeID: 'AT37_OFFICEID882',
                        currencyName: 'AT39_CURRENYY882',
                        startDate: 'AT39_STARTDEE882',
                        loanBankID: 'AT42_LOANBADK882',
                        idType: 'AT48_IDTYPEBH882',
                        endDate: 'AT50_ENDDATEE882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        desOperationType: 'AT57_DESOPETI882',
                        redesCont: 'AT58_REDESCTN882',
                        newStatus: 'AT59_NEWSTASS882',
                        group: 'AT62_GROUPTNG882',
                        previousOper: 'AT65_PREVIOPU882',
                        status: 'AT66_STATUSOB882',
                        clientID: 'AT68_CLIENTII882',
                        operationType: 'AT70_OPERATPP882',
                        clientName: 'AT71_CLIENTNA882',
                        disbursementDate: 'AT76_DISBURTS882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        officer: 'AT77_OFFICERR882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        amount: 'AT91_AMOUNTMO882',
                        adjustment: 'AT94_ADJUSTNT882',
                        officerID: 'AT95_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        feeEndDate: 'AT99_FEEENDED882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ValueDateFilter: {
                        valueDate: 'AT54_VALUEDET530',
                        operationType: 'AT12_OPERATNN237',
                        observation: 'AT79_OBSERVTI237',
                        indexTrn: 'AT16_INDEXTRN237',
                        option: 'AT33_OPTIONIL237',
                        _pks: [],
                        _entityId: 'EN_VALUEDAET_237',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    TransactionLoan: {
                        transactionId: 'AT69_TRANSAIO147',
                        secuential: 'AT35_SECUENTA193',
                        operation: 'AT66_OPERATII193',
                        dateTran: 'AT87_DATETRAN193',
                        dateRef: 'AT32_DATEREFF193',
                        user: 'AT63_USERDUKD193',
                        status: 'AT55_STATUSJB193',
                        _pks: [],
                        _entityId: 'EN_TRANSACOA_147',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanInstancia: {
                        idInstancia: 'AT74_IDINSTAA482',
                        idOptionMenu: 'AT59_IDOPTINM482',
                        errorValidation: 'AT62_ERRORVAA482',
                        _pks: [],
                        _entityId: 'EN_LOANINSTC_482',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_TRANSACO_1244 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_TRANSACO_1244 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TRANSACO_1244_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TRANSACO_1244_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_TRANSACOA_147',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TRANSACO_1244',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_TRANSACO_1244_filters = {};
            var defaultValues = {
                Loan: {},
                ValueDateFilter: {},
                TransactionLoan: {},
                LoanInstancia: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (var en in defaultValues) {
                    if (defaultValues.hasOwnProperty(en) && en === entityName) {
                        for (var att in defaultValues[en]) {
                            if (defaultValues[en].hasOwnProperty(att) && att === attributeName) {
                                for (var ch in defaultValues[en][att]) {
                                    if (defaultValues[en][att].hasOwnProperty(ch) && ch === channel) {
                                        return defaultValues[en][att][ch];
                                    }
                                }
                            }
                        }
                    }
                }
                if (typeof valueIfNotExist !== "undefined") {
                    return valueIfNotExist;
                } else {
                    return null;
                }
            };
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                };
                $scope.vc.execute("temporarySave", VC_VALUEDATEN_586689, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_VALUEDATEN_586689, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_VALUEDATEN_586689, data, function() {});
                            $scope.vc.crud.addTrackers($scope.vc.model);
                        }
                        page.hasTemporaryData = result;
                        page.ejecTemporaryData = response.success;
                        return page;
                    });
                } else {
                    page.ejecTemporaryData = false;
                    page.hasTemporaryData = false;
                    return page;
                }
            };
            $scope.vc.viewState.keyDown = function(e) {
                dsgnrUtils.container.validateOnEnter(e, $scope.vc);
            }
            $scope.vc.viewState.VC_VALUEDATEN_586689 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_VALUEDATEN_586689",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAVALO_78292",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_DNIIMAEAVR_174689",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_LENMSHCIMP_164316",
                hasId: true,
                componentStyle: [],
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Loan = {
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                category: $scope.vc.channelDefaultValues("Loan", "category"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                isDisbursment: $scope.vc.channelDefaultValues("Loan", "isDisbursment"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                group: $scope.vc.channelDefaultValues("Loan", "group"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                officerID: $scope.vc.channelDefaultValues("Loan", "officerID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate")
            };
            //ViewState - Group: Group2443
            $scope.vc.createViewState({
                id: "G_LOANHEADOD_564612",
                hasId: true,
                componentStyle: [],
                label: 'Group2443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_143612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1657
            $scope.vc.createViewState({
                id: "G_LOANHEADRO_349612",
                hasId: true,
                componentStyle: [],
                label: 'Group1657',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_867612",
                componentStyle: [],
                labelImageId: "",
                label: "ASSTS.LBL_ASSTS_PRSTAMOFK_44930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVITZRQ_108612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-info-sign",
                label: "ASSTS.LBL_ASSTS_MASINACIN_18792",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONORYJAMS_468612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-search",
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1848
            $scope.vc.createViewState({
                id: "G_LOANHEAINF_340612",
                hasId: true,
                componentStyle: [],
                label: 'Group1848',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_5034UOFCASVGKTK_993612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOCRDOO_69382",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: balanceDue
            $scope.vc.createViewState({
                id: "VA_2463BHBNLZPKLMU_865612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOEXBB_70535",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: status
            $scope.vc.createViewState({
                id: "VA_3853RRTWBIRUGHQ_533612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: office
            $scope.vc.createViewState({
                id: "VA_7292SEAHPRAXOKC_868612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_XPTLQIEYIF_403689",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ValueDateForm
            $scope.vc.createViewState({
                id: "VC_XOLYZFDNSA_971861",
                hasId: true,
                componentStyle: [],
                label: 'ValueDateForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1159
            $scope.vc.createViewState({
                id: "G_VALUEDAETT_568866",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1159',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2594
            $scope.vc.createViewState({
                id: "G_VALUEDAETT_751866",
                hasId: true,
                componentStyle: [],
                label: 'Group2594',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: lastProcessDate
            $scope.vc.createViewState({
                id: "VA_LASTPROCESSDEET_724866",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LTPROCESS_22260",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ValueDateFilter = {
                valueDate: $scope.vc.channelDefaultValues("ValueDateFilter", "valueDate"),
                operationType: $scope.vc.channelDefaultValues("ValueDateFilter", "operationType"),
                observation: $scope.vc.channelDefaultValues("ValueDateFilter", "observation"),
                indexTrn: $scope.vc.channelDefaultValues("ValueDateFilter", "indexTrn"),
                option: $scope.vc.channelDefaultValues("ValueDateFilter", "option")
            };
            //ViewState - Group: Group2999
            $scope.vc.createViewState({
                id: "G_VALUEDATET_698866",
                hasId: true,
                componentStyle: [],
                label: 'Group2999',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValueDateFilter, Attribute: valueDate
            $scope.vc.createViewState({
                id: "VA_3610ZOUUEMDZQED_313866",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAVAOO_18147",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1288
            $scope.vc.createViewState({
                id: "G_VALUEDAETT_261866",
                hasId: true,
                componentStyle: [],
                label: 'Group1288',
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.types.TransactionLoan = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    transactionId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "transactionId", ''),
                        validation: {
                            transactionIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "secuential", 0),
                        validation: {
                            secuentialRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    operation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "operation", ''),
                        validation: {
                            operationRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    dateTran: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "dateTran", ''),
                        validation: {
                            dateTranRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    dateRef: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "dateRef", ''),
                        validation: {
                            dateRefRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    status: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "status", ''),
                        validation: {
                            statusRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    user: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionLoan", "user", ''),
                        validation: {
                            userRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.TransactionLoan = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_TRANSACO_1244();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.TransactionLoan
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1244_89323").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TRANSACO_1244 = $scope.vc.model.TransactionLoan;
            $scope.vc.trackers.TransactionLoan = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.TransactionLoan);
            $scope.vc.model.TransactionLoan.bind('change', function(e) {
                $scope.vc.trackers.TransactionLoan.track(e);
            });
            $scope.vc.grids.QV_1244_89323 = {};
            $scope.vc.grids.QV_1244_89323.queryId = 'Q_TRANSACO_1244';
            $scope.vc.viewState.QV_1244_89323 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1244_89323.column = {};
            $scope.vc.grids.QV_1244_89323.editable = false;
            $scope.vc.grids.QV_1244_89323.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.TransactionLoan.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1244_89323.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_1244_89323");
                    $scope.vc.hideShowColumns("QV_1244_89323", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1244_89323.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1244_89323.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1244_89323.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1244_89323 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1244_89323 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_1244_89323.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_1244_89323.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "TransactionLoan", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1244_89323.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1244_89323.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1244_89323.column.transactionId = {
                title: 'ASSTS.LBL_ASSTS_TRANSACCI_56568',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_TRANSACCI_56568',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXIIN_213866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT69_TRANSAIO147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.transactionId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_TRANSACCI_56568'|translate}}",
                        'id': "VA_TEXTINPUTBOXIIN_213866",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_TRANSACCI_56568') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.transactionId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.transactionId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1244_89323.column.secuential = {
                title: 'ASSTS.LBL_ASSTS_SECUENCAA_14570',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_SECUENCAA_14570',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXMEP_425866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT35_SECUENTA193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.secuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_SECUENCAA_14570'|translate}}",
                        'id': "VA_TEXTINPUTBOXMEP_425866",
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_SECUENCAA_14570') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1244_89323.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_1244_89323.column.secuential.decimals",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.secuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1244_89323.column.operation = {
                title: 'ASSTS.LBL_ASSTS_PRSTAMOCV_96028',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_PRSTAMOCV_96028',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXQOK_378866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT66_OPERATII193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.operation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_PRSTAMOCV_96028'|translate}}",
                        'id': "VA_TEXTINPUTBOXQOK_378866",
                        'maxlength': 20,
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_PRSTAMOCV_96028') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.operation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.operation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1244_89323.column.dateTran = {
                title: 'ASSTS.LBL_ASSTS_FECHATRNN_93009',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_FECHATRNN_93009',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXSNL_252866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT87_DATETRAN193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.dateTran.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_FECHATRNN_93009'|translate}}",
                        'id': "VA_TEXTINPUTBOXSNL_252866",
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_FECHATRNN_93009') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.dateTran.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.dateTran.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1244_89323.column.dateRef = {
                title: 'ASSTS.LBL_ASSTS_FECHAREFF_99584',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_FECHAREFF_99584',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXYSE_969866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT32_DATEREFF193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.dateRef.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_FECHAREFF_99584'|translate}}",
                        'id': "VA_TEXTINPUTBOXYSE_969866",
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_FECHAREFF_99584') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.dateRef.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.dateRef.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1244_89323.column.status = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZAT_127866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT55_STATUSJB193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.status.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_ESTADOEAI_33340'|translate}}",
                        'id': "VA_TEXTINPUTBOXZAT_127866",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_ESTADOEAI_33340') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.status.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.status.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1244_89323.column.user = {
                title: 'ASSTS.LBL_ASSTS_USUARIOTE_48852',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_USUARIOTE_48852',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXARG_897866',
                element: []
            };
            $scope.vc.grids.QV_1244_89323.AT63_USERDUKD193 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1244_89323.column.user.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_USUARIOTE_48852'|translate}}",
                        'id': "VA_TEXTINPUTBOXARG_897866",
                        'maxlength': 14,
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_USUARIOTE_48852') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_1244_89323.column.user.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_VALUEDAETT_568866,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1244_89323.column.user.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'transactionId',
                    title: '{{vc.viewState.QV_1244_89323.column.transactionId.title|translate:vc.viewState.QV_1244_89323.column.transactionId.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.transactionId.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.transactionId.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT69_TRANSAIO147.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.transactionId.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionId, \"QV_1244_89323\", \"transactionId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1244_89323.column.transactionId.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.transactionId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.transactionId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_1244_89323.column.secuential.title|translate:vc.viewState.QV_1244_89323.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.secuential.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.secuential.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT35_SECUENTA193.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.secuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_1244_89323\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_1244_89323.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1244_89323.column.secuential.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'operation',
                    title: '{{vc.viewState.QV_1244_89323.column.operation.title|translate:vc.viewState.QV_1244_89323.column.operation.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.operation.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.operation.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT66_OPERATII193.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.operation.style' ng-bind='vc.getStringColumnFormat(dataItem.operation, \"QV_1244_89323\", \"operation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1244_89323.column.operation.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.operation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.operation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'dateTran',
                    title: '{{vc.viewState.QV_1244_89323.column.dateTran.title|translate:vc.viewState.QV_1244_89323.column.dateTran.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.dateTran.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.dateTran.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT87_DATETRAN193.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.dateTran.style' ng-bind='vc.getStringColumnFormat(dataItem.dateTran, \"QV_1244_89323\", \"dateTran\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1244_89323.column.dateTran.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.dateTran.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.dateTran.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'dateRef',
                    title: '{{vc.viewState.QV_1244_89323.column.dateRef.title|translate:vc.viewState.QV_1244_89323.column.dateRef.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.dateRef.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.dateRef.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT32_DATEREFF193.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.dateRef.style' ng-bind='vc.getStringColumnFormat(dataItem.dateRef, \"QV_1244_89323\", \"dateRef\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1244_89323.column.dateRef.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.dateRef.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.dateRef.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'status',
                    title: '{{vc.viewState.QV_1244_89323.column.status.title|translate:vc.viewState.QV_1244_89323.column.status.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.status.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.status.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT55_STATUSJB193.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.status.style' ng-bind='vc.getStringColumnFormat(dataItem.status, \"QV_1244_89323\", \"status\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1244_89323.column.status.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.status.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.status.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1244_89323.columns.push({
                    field: 'user',
                    title: '{{vc.viewState.QV_1244_89323.column.user.title|translate:vc.viewState.QV_1244_89323.column.user.titleArgs}}',
                    width: $scope.vc.viewState.QV_1244_89323.column.user.width,
                    format: $scope.vc.viewState.QV_1244_89323.column.user.format,
                    editor: $scope.vc.grids.QV_1244_89323.AT63_USERDUKD193.control,
                    template: "<span ng-class='vc.viewState.QV_1244_89323.column.user.style' ng-bind='vc.getStringColumnFormat(dataItem.user, \"QV_1244_89323\", \"user\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1244_89323.column.user.style",
                        "title": "{{vc.viewState.QV_1244_89323.column.user.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1244_89323.column.user.hidden
                });
            }
            $scope.vc.viewState.QV_1244_89323.toolbar = {}
            $scope.vc.grids.QV_1244_89323.toolbar = [];
            //ViewState - Group: Group1222
            $scope.vc.createViewState({
                id: "G_VALUEDAEEE_507866",
                hasId: true,
                componentStyle: [],
                label: 'Group1222',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ValueDateFilter, Attribute: observation
            $scope.vc.createViewState({
                id: "VA_OBSERVATIONDKBP_175866",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OBSERVANN_50010",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_VALUEDATEMINN_689_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_VALUEDATEMINN_689_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_VALUEDAT_NNN",
                componentStyle: [],
                tooltip: "ASSTS.LBL_ASSTS_APLICARIP_57468",
                label: "ASSTS.LBL_ASSTS_APLICARIP_57468",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
        }
        $scope.isInvalid = function(form, field) {
            if (!field) {
                return false;
            }
            var submitted = $scope.vc.submitted[form.$name];
            return ((submitted || field.$dirty) && field.$invalid);
        };
        $scope._initPage_CRUDExecuteQueryEntities = function(page) {
            if (!designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                if (page.hasTemporaryDataSupport && page.ejecTemporaryData && !page.hasTemporaryData) {
                    return $scope.vc.CRUDExecuteQueryEntities(page);
                } else if (page.hasCRUDSupport) {
                    return $scope.vc.CRUDExecuteQueryEntities(page);
                } else {
                    return page;
                }
            } else {
                return page;
            }
        };
        $scope._initPage_InitializeTrackers = function(page) {
            $scope.vc.addChangeEvents($scope);
            $scope.vc.crud.addTrackers($scope.vc.model);
            return page;
        };
        $scope._initPage_ChangeInitData = function(page) {
            return $scope.vc.changeInitData(page, $scope.vc);
        };
        $scope._initPage_ProcessRender = function(page) {
            if (page.hasSearchRenderEvent) {
                $scope.vc.render('VC_VALUEDATEN_586689');
            }
            return page;
        };
        if ($scope.vc.isModal($scope) || $scope.vc.isDetailGrid($scope) || $scope.isDesignerInclude) {
            //para ventanas modales se usa ng-include con onload
            $scope.runLifeCycle = function() {
                var threadLifeCycle = $scope.vc.lifeCycle.prepareThread(page);
                if (threadLifeCycle) {
                    if (!$scope.isDesignerInclude) {
                        cobis.showMessageWindow.loading(true, "none");
                    }
                    $scope.vc.lifeCycle.run(page, threadLifeCycle, $scope);
                    cobis.showMessageWindow.loading(false);
                }
            };
        } else {
            //con ngView no funciona el $document.ready se cambia por $viewContentLoaded
            $scope.$on('$viewContentLoaded', function() {
                if ($scope.vc.loaded) {
                    //Si se esta regresando de otra pantalla
                    $scope.vc.addChangeEvents($scope);
                    if (($scope.vc.hasOnCloseModalEvent && angular.isDefined($scope.vc.dialogParameters.autoSync) && $scope.vc.dialogParameters.autoSync === false) && ($scope.vc.dialogResponse || $scope.vc.customDialogResponse)) {
                        $scope.vc.onCloseModalEvent();
                    }
                    if ($scope.vc.dialogResponse || $scope.vc.customDialogResponse) {
                        $scope.vc.afterCloseGridDialog();
                    }
                    cobis.showMessageWindow.loading(false);
                } else {
                    //Si es la primera vez que se ejecuta la pantalla
                    var threadLifeCycle = $scope.vc.lifeCycle.prepareThread(page);
                    if (threadLifeCycle) {
                        $scope.vc.lifeCycle.run(page, threadLifeCycle, $scope);
                        cobis.showMessageWindow.loading(false);
                    }
                }
            });
        }
    }]);
}
if (typeof cobisMainModule === "undefined") {
    var cobisMainModule = cobis.createModule("VC_VALUEDATEN_586689", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
    cobisMainModule.config(["$controllerProvider", "$compileProvider", "$filterProvider", "$locationProvider", "$routeProvider", "$provide", "$translateProvider", "$translatePartialLoaderProvider", "$ocLazyLoadProvider",

    function($controllerProvider, $compileProvider, $filterProvider, $locationProvider, $routeProvider, $provide, $translateProvider, $translatePartialLoaderProvider, $ocLazyLoadProvider) {
        $ocLazyLoadProvider.config({
            asyncLoader: $script
        });
        $locationProvider.html5Mode(true);
        cobisMainModule.controllerProvider = $controllerProvider;
        cobisMainModule.compileProvider = $compileProvider;
        cobisMainModule.routeProvider = $routeProvider;
        cobisMainModule.filterProvider = $filterProvider;
        cobisMainModule.provide = $provide;
        var culture = cobis.userContext.getValue(cobis.constant.CULTURE);
        $routeProvider.when("/VC_VALUEDATEN_586689", {
            templateUrl: "VC_VALUEDATEN_586689_FORM.html",
            controller: "VC_VALUEDATEN_586689_CTRL",
            labelId: "ASSTS.LBL_ASSTS_FECHAVALO_78292",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_VALUEDATEN_586689?" + $.param(search);
            }
        });
        VC_VALUEDATEN_586689(cobisMainModule);
    }]);
} else {
    VC_VALUEDATEN_586689(cobisMainModule);
}