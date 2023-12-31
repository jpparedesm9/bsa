//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.reprintdocument = designerEvents.api.reprintdocument || designer.dsgEvents();

function VC_RPUME79_RERNO_643(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RPUME79_RERNO_643_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RPUME79_RERNO_643_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_13_RPUME79",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RPUME79_RERNO_643",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_13_RPUME79",
        designerEvents.api.reprintdocument,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
                hasChangeInitDataSupport: false,
                hasSearchRenderEvent: false,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: true,
                vcName: 'VC_RPUME79_RERNO_643'
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
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_13_RPUME79',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    SearchCriteriaPrintingDocuments: "SearchCriteriaPrintingDocuments",
                    Applications: "Applications",
                    DocumentProduct: "DocumentProduct",
                    OriginalHeader: "OriginalHeader",
                    Context: "Context",
                    DebtorGeneral: "DebtorGeneral",
                    PrintClientsTeam: "PrintClientsTeam"
                },
                entities: {
                    SearchCriteriaPrintingDocuments: {
                        group: 'AT17_GROUPIHP834',
                        claimantId: 'AT_EIE834AMTI70',
                        City: 'AT_EIE834CITY58',
                        codeProcess: 'AT_EIE834CODC75',
                        typeProcess: 'AT_EIE834EOCS93',
                        IdApplication: 'AT_EIE834LIAO71',
                        FlowType: 'AT_EIE834LTYE24',
                        CustomerId: 'AT_EIE834SMID47',
                        typeCustomer: 'AT_EIE834TCSO46',
                        alternateCode: 'AT_EIE834TNCE40',
                        _pks: [],
                        _entityId: 'EN_EIERNNCME834',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Applications: {
                        ApplicationCode: 'AT_APP753AICE81',
                        DebtorName: 'AT_APP753BTAE36',
                        City: 'AT_APP753CITY02',
                        OfficialName: 'AT_APP753CNME72',
                        CreditCode: 'AT_APP753DITE80',
                        CurrencyProposal: 'AT_APP753ENPA09',
                        FlowType: 'AT_APP753FLOW82',
                        PrincipalDebtor: 'AT_APP753INCD06',
                        Official: 'AT_APP753OFIL99',
                        ProposedAmount: 'AT_APP753PEMT71',
                        Selection: 'AT_APP753SLIO32',
                        alternateCode: 'AT_APP753TETO90',
                        _pks: [],
                        _entityId: 'EN_APPLICATO753',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DocumentProduct: {
                        isAutoTemplate: 'AT57_ISAUTOAA175',
                        ReportParamGuarantor: 'AT_OUM175AANT23',
                        Document: 'AT_OUM175DOUN12',
                        NroImpressions: 'AT_OUM175NMON61',
                        Nemonic: 'AT_OUM175NONC04',
                        Description: 'AT_OUM175SITO30',
                        Template: 'AT_OUM175TEME23',
                        YesNot: 'AT_OUM175YSNO59',
                        _pks: [],
                        _entityId: 'EN_OUMTPROUT175',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OriginalHeader: {
                        maximumAmount: 'AT13_MAXIMUOM477',
                        amountRequestedOriginal: 'AT20_AMOUNTGE477',
                        frequency: 'AT28_FREQUENC477',
                        frequencyRevolving: 'AT54_FREQUEVL477',
                        bCBlackListsClient: 'AT74_BCBLACLS477',
                        previousCreditAmount: 'AT75_PREVIOIU477',
                        amountDisbursed: 'AT94_AMOUNTSS477',
                        termInd: 'AT94_TERMINDD477',
                        stageflux: 'AT_RIG477AGFX85',
                        RejectionExcuse: 'AT_RIG477AONC36',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        AmountApproved: 'AT_RIG477AUPR26',
                        CityCredit: 'AT_RIG477CIDI98',
                        Country: 'AT_RIG477COTR74',
                        CreditTarget: 'AT_RIG477CRET05',
                        IsWarrantyDestination: 'AT_RIG477DSIN93',
                        CreditSector: 'AT_RIG477EDCT30',
                        RejectionReason: 'AT_RIG477EIEA32',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Office: 'AT_RIG477FICE32',
                        OfficerName: 'AT_RIG477FNME01',
                        HousingCount: 'AT_RIG477GCUN35',
                        InitialDate: 'AT_RIG477IALT55',
                        IsDebtorOwner: 'AT_RIG477IBTO19',
                        ActivityNumber: 'AT_RIG477IIMB92',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        CityCode: 'AT_RIG477ITCE46',
                        ClientSector: 'AT_RIG477LIEN42',
                        AmountAprobed: 'AT_RIG477MICI25',
                        AmountCalculated: 'AT_RIG477MNLA18',
                        NumberLine: 'AT_RIG477NMLN54',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        OfficerId: 'AT_RIG477OERD27',
                        Province: 'AT_RIG477OINC84',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        AmountRequested: 'AT_RIG477OQUE10',
                        ProductType: 'AT_RIG477PEOE42',
                        PortfolioType: 'AT_RIG477POLY58',
                        Quota: 'AT_RIG477QUOA32',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        IDRequested: 'AT_RIG477RQSD66',
                        ProductFIE: 'AT_RIG477RUCE24',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Score: 'AT_RIG477SCOR35',
                        ScoreType: 'AT_RIG477SOET77',
                        TermLimit: 'AT_RIG477TEIM91',
                        Term: 'AT_RIG477TERM59',
                        ActivityDestination: 'AT_RIG477TETI07',
                        Type: 'AT_RIG477TYPE69',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        UserL: 'AT_RIG477USRL75',
                        RequestLine: 'AT_RIG477UTIN05',
                        Expromission: 'AT_RIG477XSIN84',
                        TypeRequest: 'AT_RIG477YPRU27',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Context: {
                        amountApproved: 'AT10_AMOUNTPP762',
                        officeName: 'AT22_OFFICEME762',
                        amountRequested: 'AT37_AMOUNTUE762',
                        cycleNumber: 'AT60_CYCLENEM762',
                        synchronize: 'AT88_SYNCHRZZ762',
                        enable: 'AT91_ENABLEZV762',
                        ApplicationSubject: 'AT_CON762ACAO34',
                        Application: 'AT_CON762APCI65',
                        Bookmark: 'AT_CON762BKAK11',
                        CustomerId: 'AT_CON762CSTE68',
                        RequestId: 'AT_CON762EUTD32',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        TaskSubject: 'AT_CON762TSUT41',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DebtorGeneral: {
                        riskLevel: 'AT37_RISKLEVV342',
                        customerType: 'AT38_CUSTOMER342',
                        creditBureau: 'AT45_CREDITUU342',
                        rfc: 'AT94_RFCNDBHX342',
                        Address: 'AT_DEB342ADRS63',
                        CustomerCode: 'AT_DEB342CUST03',
                        CustomerName: 'AT_DEB342CUST55',
                        TypeDocumentId: 'AT_DEB342DOTD15',
                        DateCIC: 'AT_DEB342DTCC73',
                        Identification: 'AT_DEB342IDEN84',
                        AditionalCode: 'AT_DEB342ITDE08',
                        Role: 'AT_DEB342ROLE73',
                        Qualification: 'AT_DEB342UALN46',
                        _pks: ['CustomerCode'],
                        _entityId: 'EN_DEBTORHHW342',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    PrintClientsTeam: {
                        statusClient: 'AT10_STATUSNT523',
                        typeSecure: 'AT17_TYPESERU523',
                        dateEnd: 'AT24_DATEENDD523',
                        operation: 'AT37_OPERATIO523',
                        idclient: 'AT51_IDCLIETN523',
                        dateReport: 'AT58_DATEREOR523',
                        idTeam: 'AT64_IDTEAMGG523',
                        amountReturned: 'AT71_AMOUNTEE523',
                        idBank: 'AT76_IDBANKNW523',
                        amountPaid: 'AT81_AMOUNTII523',
                        dateStart: 'AT83_DATESTTA523',
                        formPaid: 'AT84_PAIDNYKD523',
                        amount: 'AT94_AMOUNTGX523',
                        idProcess: 'AT96_IDPROCSS523',
                        _pks: [],
                        _entityId: 'EN_PRINTCLES_523',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ERPLITON_1480 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_ERPLITON_1480 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ERPLITON_1480_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ERPLITON_1480_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_APPLICATO753',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ERPLITON_1480',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_ERPLITON_1480_filters = {};
            $scope.vc.queryProperties.Q_QDMNTPRO_8051 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QDMNTPRO_8051 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QDMNTPRO_8051_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QDMNTPRO_8051_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OUMTPROUT175',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QDMNTPRO_8051',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QDMNTPRO_8051_filters = {};
            var defaultValues = {
                SearchCriteriaPrintingDocuments: {},
                Applications: {},
                DocumentProduct: {},
                OriginalHeader: {},
                Context: {},
                DebtorGeneral: {},
                PrintClientsTeam: {}
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
                $scope.vc.execute("temporarySave", VC_RPUME79_RERNO_643, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_RPUME79_RERNO_643, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_RPUME79_RERNO_643, data, function() {});
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
            $scope.vc.viewState.VC_RPUME79_RERNO_643 = {
                style: []
            }
            //ViewState - Container: FormRePrintDocument
            $scope.vc.createViewState({
                id: "VC_RPUME79_RERNO_643",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RERTIDOMS_66872",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_SearchCriteriaApplicationView
            $scope.vc.createViewState({
                id: "VC_RPUME79_APCII_748",
                hasId: true,
                componentStyle: [],
                label: 'T_SearchCriteriaApplicationView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_SHCTRATNIW77_04",
                hasId: true,
                componentStyle: [],
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.SearchCriteriaPrintingDocuments = {
                group: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "group"),
                claimantId: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "claimantId"),
                City: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "City"),
                codeProcess: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "codeProcess"),
                typeProcess: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "typeProcess"),
                IdApplication: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "IdApplication"),
                FlowType: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "FlowType"),
                CustomerId: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "CustomerId"),
                typeCustomer: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "typeCustomer"),
                alternateCode: $scope.vc.channelDefaultValues("SearchCriteriaPrintingDocuments", "alternateCode")
            };
            //ViewState - Group: Panel Plegable para SearchCriteriaPrintingDocuments
            $scope.vc.createViewState({
                id: "GR_SHCTRATNIW77_05",
                hasId: true,
                componentStyle: [],
                label: 'Panel Plegable para SearchCriteriaPrintingDocuments',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchCriteriaPrintingDocuments, Attribute: FlowType
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_LTYE544",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PROCESOSD_30683",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SHCTRATNIW7705_LTYE544 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_SHCTRATNIW7705_LTYE544', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_SHCTRATNIW7705_LTYE544'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SHCTRATNIW7705_LTYE544");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: SearchCriteriaPrintingDocuments, Attribute: CustomerId
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_SMID298",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CUSTOMERK_83530",
                label: "BUSIN.DLB_BUSIN_CUSTOMERK_83530",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchCriteriaPrintingDocuments, Attribute: claimantId
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_AMTI124",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CLAIMANTM_13519",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchCriteriaPrintingDocuments, Attribute: IdApplication
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_LIAO733",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                label: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchCriteriaPrintingDocuments, Attribute: alternateCode
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_TNCE902",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CDIGOALET_37862",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_0000829",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_SAPPICTIO_80550",
                label: "BUSIN.DLB_BUSIN_SEARCHRYK_55401",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SearchCriteriaPrintingDocuments, Attribute: City
            $scope.vc.createViewState({
                id: "VA_SHCTRATNIW7705_CITY397",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SHCTRATNIW7705_CITY397 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SHCTRATNIW7705_CITY397', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SHCTRATNIW7705_CITY397'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SHCTRATNIW7705_CITY397");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Group: Panel Plegable para Applications
            $scope.vc.createViewState({
                id: "GR_SHCTRATNIW77_06",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PLICATIOS_29685",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Applications = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    ApplicationCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "ApplicationCode", '')
                    },
                    alternateCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "alternateCode", '')
                    },
                    CreditCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "CreditCode", '')
                    },
                    Official: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "Official", '')
                    },
                    FlowType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "FlowType", '')
                    },
                    PrincipalDebtor: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "PrincipalDebtor", '')
                    },
                    ProposedAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "ProposedAmount", 0)
                    },
                    CurrencyProposal: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "CurrencyProposal", '')
                    },
                    Selection: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "Selection", false)
                    },
                    OfficialName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "OfficialName", '')
                    }
                }
            });
            $scope.vc.model.Applications = new kendo.data.DataSource({
                pageSize: 8,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_ERPLITON_1480';
                            var queryRequest = $scope.vc.getRequestQuery_Q_ERPLITON_1480();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_ERPLI1480_97',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                options.success(result);
                                            } else {
                                                options.success([]);
                                            }
                                        } else {
                                            options.error([]);
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': true,
                                            'pageSize': 8
                                        };

                                        function config(queryOptions, queryView) {
                                            var result = undefined;
                                            if (queryView.allowPaging === true) {
                                                result = {};
                                                if (angular.isDefined(queryOptions.appendRecords) && queryOptions.appendRecords === true) {
                                                    result.appendRecords = true;
                                                }
                                                result.pageSize = queryView.pageSize;
                                            }
                                            return result;
                                        }
                                        return config(queryOptions, queryView);
                                    }()));
                                }
                            }
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
                    model: $scope.vc.types.Applications
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_ERPLI1480_97").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ERPLITON_1480 = $scope.vc.model.Applications;
            $scope.vc.trackers.Applications = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Applications);
            $scope.vc.model.Applications.bind('change', function(e) {
                $scope.vc.trackers.Applications.track(e);
            });
            $scope.vc.grids.QV_ERPLI1480_97 = {};
            $scope.vc.grids.QV_ERPLI1480_97.queryId = 'Q_ERPLITON_1480';
            $scope.vc.viewState.QV_ERPLI1480_97 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column = {};
            $scope.vc.grids.QV_ERPLI1480_97.editable = false;
            $scope.vc.grids.QV_ERPLI1480_97.events = {
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
                    $scope.vc.trackers.Applications.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ERPLI1480_97.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_ERPLI1480_97");
                    $scope.vc.hideShowColumns("QV_ERPLI1480_97", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_ERPLI1480_97.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_ERPLI1480_97.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_ERPLI1480_97.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_ERPLI1480_97 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_ERPLI1480_97 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_ERPLI1480_97.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_ERPLI1480_97.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "Applications", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_ERPLI1480_97.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ERPLI1480_97.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ERPLI1480_97.column.ApplicationCode = {
                title: 'BUSIN.DLB_BUSIN_APAONMBER_11346',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_AICE519',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753AICE81 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_AICE519",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.alternateCode = {
                title: 'BUSIN.LBL_BUSIN_CDIGOALTT_52724',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_TETO980',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753TETO90 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.alternateCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_TETO980",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.alternateCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.alternateCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.CreditCode = {
                title: 'BUSIN.DLB_BUSIN_CREDITCOD_87389',
                titleArgs: {},
                tooltip: '',
                width: 95,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_DITE518',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753DITE80 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.CreditCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_DITE518",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.CreditCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.CreditCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.Official = {
                title: 'BUSIN.DLB_BUSIN_OFFICERTU_38261',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_OFIL551',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753OFIL99 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.Official.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_OFIL551",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.Official.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.Official.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.FlowType = {
                title: 'BUSIN.DLB_BUSIN_PROCESOSD_30683',
                titleArgs: {},
                tooltip: '',
                width: 60,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_FLOW443',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753FLOW82 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.FlowType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_FLOW443",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.FlowType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.FlowType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor = {
                title: 'BUSIN.DLB_BUSIN_DEUOINCIL_89500',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_INCD561',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753INCD06 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_INCD561",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.ProposedAmount = {
                title: 'BUSIN.DLB_BUSIN_MONTOFVFP_36531',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_PEMT875',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753PEMT71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_PEMT875",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.format",
                        'k-decimals': "vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.decimals",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SHCTRATNIW7706_ENPA729',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_SHCTRATNIW7706_ENPA729 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_SHCTRATNIW7706_ENPA729',
                            'cl_moneda',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_SHCTRATNIW7706_ENPA729'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753ENPA09 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SHCTRATNIW7706_ENPA729",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.style',
                        'k-data-source': "vc.catalogs.VA_SHCTRATNIW7706_ENPA729",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.template",
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.Selection = {
                title: 'Selection',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXJBQJWQZ_771_06',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753SLIO32 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.Selection.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXJBQJWQZ_771_06",
                        'ng-class': 'vc.viewState.QV_ERPLI1480_97.column.Selection.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_97.column.OfficialName = {
                title: 'Official Name',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNCF_858_06',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_97.AT_APP753CNME72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_97.column.OfficialName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNCF_858_06",
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_97.column.OfficialName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SHCTRATNIW77_04,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_ERPLI1480_97.column.OfficialName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'ApplicationCode',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.title|translate:vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753AICE81.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.style' ng-bind='vc.getStringColumnFormat(dataItem.ApplicationCode, \"QV_ERPLI1480_97\", \"ApplicationCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.ApplicationCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'alternateCode',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.alternateCode.title|translate:vc.viewState.QV_ERPLI1480_97.column.alternateCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.alternateCode.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.alternateCode.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753TETO90.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.alternateCode.style' ng-bind='vc.getStringColumnFormat(dataItem.alternateCode, \"QV_ERPLI1480_97\", \"alternateCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.alternateCode.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.alternateCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.alternateCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'CreditCode',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.CreditCode.title|translate:vc.viewState.QV_ERPLI1480_97.column.CreditCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.CreditCode.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.CreditCode.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753DITE80.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.CreditCode.style' ng-bind='vc.getStringColumnFormat(dataItem.CreditCode, \"QV_ERPLI1480_97\", \"CreditCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.CreditCode.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.CreditCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.CreditCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'Official',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.Official.title|translate:vc.viewState.QV_ERPLI1480_97.column.Official.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.Official.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.Official.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753OFIL99.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.Official.style' ng-bind='vc.getStringColumnFormat(dataItem.Official, \"QV_ERPLI1480_97\", \"Official\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.Official.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.Official.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.Official.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'FlowType',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.FlowType.title|translate:vc.viewState.QV_ERPLI1480_97.column.FlowType.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.FlowType.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.FlowType.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753FLOW82.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.FlowType.style' ng-bind='vc.getStringColumnFormat(dataItem.FlowType, \"QV_ERPLI1480_97\", \"FlowType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.FlowType.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.FlowType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.FlowType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'PrincipalDebtor',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.title|translate:vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753INCD06.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.style' ng-bind='vc.getStringColumnFormat(dataItem.PrincipalDebtor, \"QV_ERPLI1480_97\", \"PrincipalDebtor\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.PrincipalDebtor.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'ProposedAmount',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.title|translate:vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753PEMT71.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.ProposedAmount, \"QV_ERPLI1480_97\", \"ProposedAmount\"):kendo.toString(#=ProposedAmount#, vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.ProposedAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'CurrencyProposal',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.title|translate:vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753ENPA09.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.style' ng-bind='vc.catalogs.VA_SHCTRATNIW7706_ENPA729.get(dataItem.CurrencyProposal).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.CurrencyProposal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'Selection',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.Selection.title|translate:vc.viewState.QV_ERPLI1480_97.column.Selection.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.Selection.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.Selection.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753SLIO32.control,
                    template: "<input name='Selection' type='checkbox' value='#=Selection#' #=Selection?checked='checked':''# disabled='disabled' data-bind='value:Selection' ng-class='vc.viewState.QV_ERPLI1480_97.column.Selection.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.Selection.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.Selection.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.Selection.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_97.columns.push({
                    field: 'OfficialName',
                    title: '{{vc.viewState.QV_ERPLI1480_97.column.OfficialName.title|translate:vc.viewState.QV_ERPLI1480_97.column.OfficialName.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_97.column.OfficialName.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_97.column.OfficialName.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_97.AT_APP753CNME72.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_97.column.OfficialName.style' ng-bind='vc.getStringColumnFormat(dataItem.OfficialName, \"QV_ERPLI1480_97\", \"OfficialName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_97.column.OfficialName.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_97.column.OfficialName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_97.column.OfficialName.hidden
                });
            }
            $scope.vc.viewState.QV_ERPLI1480_97.toolbar = {}
            $scope.vc.grids.QV_ERPLI1480_97.toolbar = []; //ViewState - Container: T_DocumentProductView
            $scope.vc.createViewState({
                id: "VC_RPUME79_LRMTV_332",
                hasId: true,
                componentStyle: [],
                label: 'T_DocumentProductView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_02",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpEntidades
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_05",
                hasId: true,
                componentStyle: [],
                label: 'GrpEntidades',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.OriginalHeader = {
                maximumAmount: $scope.vc.channelDefaultValues("OriginalHeader", "maximumAmount"),
                amountRequestedOriginal: $scope.vc.channelDefaultValues("OriginalHeader", "amountRequestedOriginal"),
                frequency: $scope.vc.channelDefaultValues("OriginalHeader", "frequency"),
                frequencyRevolving: $scope.vc.channelDefaultValues("OriginalHeader", "frequencyRevolving"),
                bCBlackListsClient: $scope.vc.channelDefaultValues("OriginalHeader", "bCBlackListsClient"),
                previousCreditAmount: $scope.vc.channelDefaultValues("OriginalHeader", "previousCreditAmount"),
                amountDisbursed: $scope.vc.channelDefaultValues("OriginalHeader", "amountDisbursed"),
                termInd: $scope.vc.channelDefaultValues("OriginalHeader", "termInd"),
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                RejectionExcuse: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionExcuse"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                IsWarrantyDestination: $scope.vc.channelDefaultValues("OriginalHeader", "IsWarrantyDestination"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                IsDebtorOwner: $scope.vc.channelDefaultValues("OriginalHeader", "IsDebtorOwner"),
                ActivityNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityNumber"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                AmountAprobed: $scope.vc.channelDefaultValues("OriginalHeader", "AmountAprobed"),
                AmountCalculated: $scope.vc.channelDefaultValues("OriginalHeader", "AmountCalculated"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                PortfolioType: $scope.vc.channelDefaultValues("OriginalHeader", "PortfolioType"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                ProductFIE: $scope.vc.channelDefaultValues("OriginalHeader", "ProductFIE"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Score: $scope.vc.channelDefaultValues("OriginalHeader", "Score"),
                ScoreType: $scope.vc.channelDefaultValues("OriginalHeader", "ScoreType"),
                TermLimit: $scope.vc.channelDefaultValues("OriginalHeader", "TermLimit"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                ActivityDestination: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityDestination"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest")
            };
            //ViewState - Group: GrpOriginalHeader
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_06",
                hasId: true,
                componentStyle: [],
                label: 'GrpOriginalHeader',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_06-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                amountApproved: $scope.vc.channelDefaultValues("Context", "amountApproved"),
                officeName: $scope.vc.channelDefaultValues("Context", "officeName"),
                amountRequested: $scope.vc.channelDefaultValues("Context", "amountRequested"),
                cycleNumber: $scope.vc.channelDefaultValues("Context", "cycleNumber"),
                synchronize: $scope.vc.channelDefaultValues("Context", "synchronize"),
                enable: $scope.vc.channelDefaultValues("Context", "enable"),
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject")
            };
            //ViewState - Group: GrpContext
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_07",
                hasId: true,
                componentStyle: [],
                label: 'GrpContext',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_07-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.DebtorGeneral = {
                riskLevel: $scope.vc.channelDefaultValues("DebtorGeneral", "riskLevel"),
                customerType: $scope.vc.channelDefaultValues("DebtorGeneral", "customerType"),
                creditBureau: $scope.vc.channelDefaultValues("DebtorGeneral", "creditBureau"),
                rfc: $scope.vc.channelDefaultValues("DebtorGeneral", "rfc"),
                Address: $scope.vc.channelDefaultValues("DebtorGeneral", "Address"),
                CustomerCode: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerCode"),
                CustomerName: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerName"),
                TypeDocumentId: $scope.vc.channelDefaultValues("DebtorGeneral", "TypeDocumentId"),
                DateCIC: $scope.vc.channelDefaultValues("DebtorGeneral", "DateCIC"),
                Identification: $scope.vc.channelDefaultValues("DebtorGeneral", "Identification"),
                AditionalCode: $scope.vc.channelDefaultValues("DebtorGeneral", "AditionalCode"),
                Role: $scope.vc.channelDefaultValues("DebtorGeneral", "Role"),
                Qualification: $scope.vc.channelDefaultValues("DebtorGeneral", "Qualification")
            };
            //ViewState - Group: GrpBorrower
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_08",
                hasId: true,
                componentStyle: [],
                label: 'GrpBorrower',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_08-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_DOCUNODCVW73_03",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DocumentProduct = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Document: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "Document", '')
                    },
                    Nemonic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "Nemonic", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "Description", '')
                    },
                    NroImpressions: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "NroImpressions", '')
                    },
                    YesNot: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DocumentProduct", "YesNot", false)
                    }
                }
            });
            $scope.vc.model.DocumentProduct = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QDMNTPRO_8051();
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
                    model: $scope.vc.types.DocumentProduct
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_QDMNT8051_16").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QDMNTPRO_8051 = $scope.vc.model.DocumentProduct;
            $scope.vc.trackers.DocumentProduct = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DocumentProduct);
            $scope.vc.model.DocumentProduct.bind('change', function(e) {
                $scope.vc.trackers.DocumentProduct.track(e);
            });
            $scope.vc.grids.QV_QDMNT8051_16 = {};
            $scope.vc.grids.QV_QDMNT8051_16.queryId = 'Q_QDMNTPRO_8051';
            $scope.vc.viewState.QV_QDMNT8051_16 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column = {};
            $scope.vc.grids.QV_QDMNT8051_16.editable = false;
            $scope.vc.grids.QV_QDMNT8051_16.events = {
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
                    $scope.vc.trackers.DocumentProduct.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QDMNT8051_16.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QDMNT8051_16");
                    $scope.vc.hideShowColumns("QV_QDMNT8051_16", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QDMNT8051_16.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QDMNT8051_16.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_QDMNT8051_16.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QDMNT8051_16 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QDMNT8051_16 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_QDMNT8051_16.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QDMNT8051_16.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "DocumentProduct", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QDMNT8051_16.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QDMNT8051_16.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QDMNT8051_16.column.Document = {
                title: 'BUSIN.DLB_BUSIN_DOCUMENTO_76502',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_DOCUMENTO_76502',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000409',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175DOUN12 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Document.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_DOCUMENTO_76502'|translate}}",
                        'id': "VA_DOCUNODCVW7303_0000409",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.Document.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DOCUNODCVW73_02,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.Document.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic = {
                title: 'BUSIN.DLB_BUSIN_NEMNICOZH_18160',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000045',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NONC04 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Nemonic.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000045",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.Nemonic.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DOCUNODCVW73_02,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.Nemonic.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000216',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175SITO30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.Description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000216",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DOCUNODCVW73_02,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.Description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions = {
                title: 'BUSIN.LBL_BUSIN_NROIMPRII_16797',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_0000674',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NMON61 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.NroImpressions.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_0000674",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QDMNT8051_16.column.NroImpressions.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_DOCUNODCVW73_02,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QDMNT8051_16.column.NroImpressions.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot = {
                title: 'BUSIN.LBL_BUSIN_SINORICKD_75084',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DOCUNODCVW7303_YSNO533',
                element: []
            };
            $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175YSNO59 = {
                control: function(container, options) {
                    $scope.options_QV_QDMNT8051_16 = options;
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QDMNT8051_16.column.YesNot.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DOCUNODCVW7303_YSNO533",
                        'ng-class': 'vc.viewState.QV_QDMNT8051_16.column.YesNot.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'Document',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.Document.title|translate:vc.viewState.QV_QDMNT8051_16.column.Document.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.Document.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.Document.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175DOUN12.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.Document.style' ng-bind='vc.getStringColumnFormat(dataItem.Document, \"QV_QDMNT8051_16\", \"Document\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.Document.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.Document.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.Document.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'Nemonic',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.Nemonic.title|translate:vc.viewState.QV_QDMNT8051_16.column.Nemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NONC04.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.Nemonic.style' ng-bind='vc.getStringColumnFormat(dataItem.Nemonic, \"QV_QDMNT8051_16\", \"Nemonic\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.Nemonic.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.Nemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.Nemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.Description.title|translate:vc.viewState.QV_QDMNT8051_16.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.Description.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.Description.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175SITO30.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.Description.style' ng-bind='vc.getStringColumnFormat(dataItem.Description, \"QV_QDMNT8051_16\", \"Description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.Description.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'NroImpressions',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.NroImpressions.title|translate:vc.viewState.QV_QDMNT8051_16.column.NroImpressions.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions.format,
                    editor: $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175NMON61.control,
                    template: "<span ng-class='vc.viewState.QV_QDMNT8051_16.column.NroImpressions.style' ng-bind='vc.getStringColumnFormat(dataItem.NroImpressions, \"QV_QDMNT8051_16\", \"NroImpressions\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.NroImpressions.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.NroImpressions.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.NroImpressions.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QDMNT8051_16.columns.push({
                    field: 'YesNot',
                    title: '{{vc.viewState.QV_QDMNT8051_16.column.YesNot.title|translate:vc.viewState.QV_QDMNT8051_16.column.YesNot.titleArgs}}',
                    width: $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot.width,
                    format: $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_QDMNT8051_16', 'YesNot', $scope.vc.grids.QV_QDMNT8051_16.AT_OUM175YSNO59.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_QDMNT8051_16', 'YesNot', "<input name='YesNot' type='checkbox' value='#=YesNot#' #=YesNot?checked='checked':''# disabled='disabled' data-bind='value:YesNot' ng-class='vc.viewState.QV_QDMNT8051_16.column.YesNot.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QDMNT8051_16.column.YesNot.style",
                        "title": "{{vc.viewState.QV_QDMNT8051_16.column.YesNot.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QDMNT8051_16.column.YesNot.hidden
                });
            }
            $scope.vc.viewState.QV_QDMNT8051_16.toolbar = {
                CEQV_201QV_QDMNT8051_16_807: {
                    visible: true
                },
                CEQV_201QV_QDMNT8051_16_615: {
                    visible: true
                },
                CEQV_201QV_QDMNT8051_16_143: {
                    visible: true
                },
                CEQV_201QV_QDMNT8051_16_659: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_QDMNT8051_16.toolbar = [{
                "name": "CEQV_201QV_QDMNT8051_16_807",
                "text": "{{'BUSIN.DLB_BUSIN_SELECIOAR_14656'|translate}}",
                "template": "<button id='CEQV_201QV_QDMNT8051_16_807' " + " ng-if='vc.viewState.QV_QDMNT8051_16.toolbar.CEQV_201QV_QDMNT8051_16_807.visible' " + "ng-disabled = 'vc.viewState.GR_DOCUNODCVW73_03.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_QDMNT8051_16_807\",\"DocumentProduct\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }, {
                "name": "CEQV_201QV_QDMNT8051_16_615",
                "template": "<button id='CEQV_201QV_QDMNT8051_16_615' " + " ng-if='vc.viewState.QV_QDMNT8051_16.toolbar.CEQV_201QV_QDMNT8051_16_615.visible' " + "ng-disabled = 'vc.viewState.GR_DOCUNODCVW73_03.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_QDMNT8051_16_615\",\"DocumentProduct\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'></button>"
            }, {
                "name": "CEQV_201QV_QDMNT8051_16_143",
                "template": "<button id='CEQV_201QV_QDMNT8051_16_143' " + " ng-if='vc.viewState.QV_QDMNT8051_16.toolbar.CEQV_201QV_QDMNT8051_16_143.visible' " + "ng-disabled = 'vc.viewState.GR_DOCUNODCVW73_03.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_QDMNT8051_16_143\",\"DocumentProduct\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-square'></span></button>"
            }, {
                "name": "CEQV_201QV_QDMNT8051_16_659",
                "template": "<button id='CEQV_201QV_QDMNT8051_16_659' " + " ng-if='vc.viewState.QV_QDMNT8051_16.toolbar.CEQV_201QV_QDMNT8051_16_659.visible' " + "ng-disabled = 'vc.viewState.GR_DOCUNODCVW73_03.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_QDMNT8051_16_659\",\"DocumentProduct\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-check-square'></span></button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_13_RPUME79_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_13_RPUME79_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Print
            $scope.vc.createViewState({
                id: "CM_RPUME79PRN97",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_PRINTNQCA_63767",
                label: "BUSIN.DLB_BUSIN_PRINTNQCA_63767",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PrintClientsTeam = {
                statusClient: $scope.vc.channelDefaultValues("PrintClientsTeam", "statusClient"),
                typeSecure: $scope.vc.channelDefaultValues("PrintClientsTeam", "typeSecure"),
                dateEnd: $scope.vc.channelDefaultValues("PrintClientsTeam", "dateEnd"),
                operation: $scope.vc.channelDefaultValues("PrintClientsTeam", "operation"),
                idclient: $scope.vc.channelDefaultValues("PrintClientsTeam", "idclient"),
                dateReport: $scope.vc.channelDefaultValues("PrintClientsTeam", "dateReport"),
                idTeam: $scope.vc.channelDefaultValues("PrintClientsTeam", "idTeam"),
                amountReturned: $scope.vc.channelDefaultValues("PrintClientsTeam", "amountReturned"),
                idBank: $scope.vc.channelDefaultValues("PrintClientsTeam", "idBank"),
                amountPaid: $scope.vc.channelDefaultValues("PrintClientsTeam", "amountPaid"),
                dateStart: $scope.vc.channelDefaultValues("PrintClientsTeam", "dateStart"),
                formPaid: $scope.vc.channelDefaultValues("PrintClientsTeam", "formPaid"),
                amount: $scope.vc.channelDefaultValues("PrintClientsTeam", "amount"),
                idProcess: $scope.vc.channelDefaultValues("PrintClientsTeam", "idProcess")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_SHCTRATNIW7706_ENPA729.read();
                }
            });
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
                $scope.vc.render('VC_RPUME79_RERNO_643');
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
    var cobisMainModule = cobis.createModule("VC_RPUME79_RERNO_643", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_RPUME79_RERNO_643", {
            templateUrl: "VC_RPUME79_RERNO_643_FORM.html",
            controller: "VC_RPUME79_RERNO_643_CTRL",
            labelId: "BUSIN.DLB_BUSIN_RERTIDOMS_66872",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RPUME79_RERNO_643?" + $.param(search);
            }
        });
        VC_RPUME79_RERNO_643(cobisMainModule);
    }]);
} else {
    VC_RPUME79_RERNO_643(cobisMainModule);
}