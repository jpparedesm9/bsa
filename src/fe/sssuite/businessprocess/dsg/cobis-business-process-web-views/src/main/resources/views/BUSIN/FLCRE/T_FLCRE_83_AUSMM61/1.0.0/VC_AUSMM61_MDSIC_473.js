//Designer Generator v 6.1.1 - release SPR 2017-05_01 03/10/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskdisbursementincome = designerEvents.api.taskdisbursementincome || designer.dsgEvents();

function VC_AUSMM61_MDSIC_473(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AUSMM61_MDSIC_473_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AUSMM61_MDSIC_473_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
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
            taskId: "T_FLCRE_83_AUSMM61",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AUSMM61_MDSIC_473",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_83_AUSMM61",
        designerEvents.api.taskdisbursementincome,
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
                hasCRUDSupport: false,
                vcName: 'VC_AUSMM61_MDSIC_473'
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
                    taskId: 'T_FLCRE_83_AUSMM61',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DisbursementIncome: "DisbursementIncome",
                    MemberAmount: "MemberAmount",
                    MemberGroup: "MemberGroup",
                    DisbursementDetail: "DisbursementDetail",
                    PaymentSelection: "PaymentSelection",
                    LoanHeader: "LoanHeader"
                },
                entities: {
                    DisbursementIncome: {
                        Account: 'AT_DSB368ACCU53',
                        Observations: 'AT_DSB368BERI16',
                        BalanceOperation: 'AT_DSB368BNRN26',
                        CurrentBalance: 'AT_DSB368CNAN61',
                        DisbursementForm: 'AT_DSB368DBUF23',
                        Description: 'AT_DSB368DCII26',
                        Office: 'AT_DSB368FFIC77',
                        DisbursementValue: 'AT_DSB368IBTU32',
                        ImpOffice: 'AT_DSB368IOFF02',
                        DisbursementId: 'AT_DSB368ISEN09',
                        ClientID: 'AT_DSB368LITI35',
                        DisbursementValueDec: 'AT_DSB368NTVC46',
                        Quotation: 'AT_DSB368OAIN04',
                        Comment: 'AT_DSB368OMEN38',
                        TQuotationOP: 'AT_DSB368OTON42',
                        TQuotationDS: 'AT_DSB368QOTN77',
                        QuotationOP: 'AT_DSB368QUTO76',
                        CurrencyOP: 'AT_DSB368RENP96',
                        Currency: 'AT_DSB368RNCY21',
                        Sequential: 'AT_DSB368SQET27',
                        OperationId: 'AT_DSB368TIOI01',
                        ValueMl: 'AT_DSB368VUML78',
                        _pks: [],
                        _entityId: 'EN_DSBUSETIO368',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    MemberAmount: {
                        memberId: 'AT17_MEMBERII619',
                        groupId: 'AT35_GROUPIDD619',
                        memberName: 'AT58_MEMBERNE619',
                        credit: 'AT74_CREDITMV619',
                        amount: 'AT80_AMOUNTHS619',
                        accountNumber: 'AT82_ACCOUNMM619',
                        secuential: 'AT95_SECUENLI619',
                        _pks: [],
                        _entityId: 'EN_MEMBERATN_619',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    MemberGroup: {
                        amount: 'AT29_AMOUNTUT791',
                        credit: 'AT51_CREDITAU791',
                        check: 'AT56_CHECKKAA791',
                        groupId: 'AT59_GROUPIDD791',
                        individualAccount: 'AT77_INDIVIDO791',
                        secuential: 'AT83_SECUENLA791',
                        memberName: 'AT85_MEMBEREE791',
                        memberId: 'AT88_MEMBERDI791',
                        accountNumber: 'AT97_ACCOUNER791',
                        _pks: [],
                        _entityId: 'EN_MEMBERGPO_791',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DisbursementDetail: {
                        AmountMOP: 'AT_DBS924ATOP33',
                        Atx: 'AT_DBS924ATXX05',
                        ValueMl: 'AT_DBS924AUML51',
                        DisbursementValue: 'AT_DBS924BSNT06',
                        Currency: 'AT_DBS924CNCY45',
                        DisbursementId: 'AT_DBS924DBTI19',
                        DisbursementFormId: 'AT_DBS924DSSN62',
                        PriceQuote: 'AT_DBS924RUTE44',
                        sequential: 'AT_DBS924SEUL29',
                        DisbursementForm: 'AT_DBS924SUEN66',
                        _pks: [],
                        _entityId: 'EN_DBSMTDEAL924',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    PaymentSelection: {
                        creditType: 'AT65_CREDITYT825',
                        transactionNumber: 'AT70_TRANSANT825',
                        groupId: 'AT73_GROUPIDD825',
                        _pks: [],
                        _entityId: 'EN_PAYMENTLT_825',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanHeader: {
                        ValuetoDisburse: 'AT_LON746ATBS57',
                        BalanceOperation: 'AT_LON746BAIO42',
                        LockDelete: 'AT_LON746CDEE65',
                        Currency: 'AT_LON746CURR52',
                        CreditLineValid: 'AT_LON746DINI26',
                        Office: 'AT_LON746FFIE81',
                        InitialDate: 'AT_LON746IIAT97',
                        LockCode: 'AT_LON746LOOE05',
                        Operation: 'AT_LON746OAIO61',
                        OfficeId: 'AT_LON746OEID34',
                        OperationBanck: 'AT_LON746OERB97',
                        ProposedAmount: 'AT_LON746OMUT02',
                        PriceQuote: 'AT_LON746PIQO17',
                        ProductType: 'AT_LON746PTTP33',
                        ProcessNumber: 'AT_LON746RCME88',
                        CustomerId: 'AT_LON746TORI83',
                        NumberLine: 'AT_LON746UERE34',
                        AmounttoDisburse: 'AT_LON746UOBU96',
                        Customer: 'AT_LON746USMR12',
                        ValueDiscount: 'AT_LON746UUNT10',
                        _pks: [],
                        _entityId: 'EN_LONHEADER746',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_MEMBEROP_5438 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_MEMBEROP_5438 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MEMBEROP_5438_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MEMBEROP_5438_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MEMBERGPO_791',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MEMBEROP_5438',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_MEMBEROP_5438_filters = {};
            $scope.vc.queryProperties.Q_MEMBERNA_9304 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_MEMBERNA_9304 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MEMBERNA_9304_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MEMBERNA_9304_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MEMBERATN_619',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MEMBERNA_9304',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_MEMBERNA_9304_filters = {};
            var defaultValues = {
                DisbursementIncome: {},
                MemberAmount: {},
                MemberGroup: {},
                DisbursementDetail: {},
                PaymentSelection: {},
                LoanHeader: {}
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
                $scope.vc.execute("temporarySave", VC_AUSMM61_MDSIC_473, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_AUSMM61_MDSIC_473, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_AUSMM61_MDSIC_473, data, function() {});
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
            $scope.vc.viewState.VC_AUSMM61_MDSIC_473 = {
                style: []
            }
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_SRSNTINOIW66_03",
                hasId: true,
                componentStyle: [],
                label: 'Contenedor Acorde\u00f3n',
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.DisbursementIncome = {
                Account: $scope.vc.channelDefaultValues("DisbursementIncome", "Account"),
                Observations: $scope.vc.channelDefaultValues("DisbursementIncome", "Observations"),
                BalanceOperation: $scope.vc.channelDefaultValues("DisbursementIncome", "BalanceOperation"),
                CurrentBalance: $scope.vc.channelDefaultValues("DisbursementIncome", "CurrentBalance"),
                DisbursementForm: $scope.vc.channelDefaultValues("DisbursementIncome", "DisbursementForm"),
                Description: $scope.vc.channelDefaultValues("DisbursementIncome", "Description"),
                Office: $scope.vc.channelDefaultValues("DisbursementIncome", "Office"),
                DisbursementValue: $scope.vc.channelDefaultValues("DisbursementIncome", "DisbursementValue"),
                ImpOffice: $scope.vc.channelDefaultValues("DisbursementIncome", "ImpOffice"),
                DisbursementId: $scope.vc.channelDefaultValues("DisbursementIncome", "DisbursementId"),
                ClientID: $scope.vc.channelDefaultValues("DisbursementIncome", "ClientID"),
                DisbursementValueDec: $scope.vc.channelDefaultValues("DisbursementIncome", "DisbursementValueDec"),
                Quotation: $scope.vc.channelDefaultValues("DisbursementIncome", "Quotation"),
                Comment: $scope.vc.channelDefaultValues("DisbursementIncome", "Comment"),
                TQuotationOP: $scope.vc.channelDefaultValues("DisbursementIncome", "TQuotationOP"),
                TQuotationDS: $scope.vc.channelDefaultValues("DisbursementIncome", "TQuotationDS"),
                QuotationOP: $scope.vc.channelDefaultValues("DisbursementIncome", "QuotationOP"),
                CurrencyOP: $scope.vc.channelDefaultValues("DisbursementIncome", "CurrencyOP"),
                Currency: $scope.vc.channelDefaultValues("DisbursementIncome", "Currency"),
                Sequential: $scope.vc.channelDefaultValues("DisbursementIncome", "Sequential"),
                OperationId: $scope.vc.channelDefaultValues("DisbursementIncome", "OperationId"),
                ValueMl: $scope.vc.channelDefaultValues("DisbursementIncome", "ValueMl")
            };
            //ViewState - Group: Panel de Acordeón para DisbursementIncome
            $scope.vc.createViewState({
                id: "GR_SRSNTINOIW66_04",
                hasId: true,
                componentStyle: [],
                label: 'Panel de Acorde\u00f3n para DisbursementIncome',
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: Currency
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_RNCY790",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_MONEDAQAQ_04700",
                label: "BUSIN.DLB_BUSIN_MONEDAQAQ_04700",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SRSNTINOIW6604_RNCY790 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_SRSNTINOIW6604_RNCY790', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_SRSNTINOIW6604_RNCY790'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SRSNTINOIW6604_RNCY790");
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
            //ViewState - Entity: DisbursementIncome, Attribute: Quotation
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_OAIN735",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_COTIZACIN_81787",
                label: "BUSIN.DLB_BUSIN_COTIZACIN_81787",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: DisbursementForm
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_DBUF584",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_FORMAEMSO_26637",
                label: "BUSIN.DLB_BUSIN_FORMAEMSO_26637",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_FFIC500",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_OFFICEWWB_98352",
                label: "BUSIN.DLB_BUSIN_OFFICEWWB_98352",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SRSNTINOIW6604_FFIC500 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SRSNTINOIW6604_FFIC500', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SRSNTINOIW6604_FFIC500'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SRSNTINOIW6604_FFIC500");
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
            //ViewState - Entity: DisbursementIncome, Attribute: Account
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_ACCU010",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CUENTAVIU_30208",
                label: "BUSIN.DLB_BUSIN_CUENTAVIU_30208",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: Description
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_DCII002",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_DESCRIPCI_06123",
                label: "BUSIN.DLB_BUSIN_DESCRIPCI_06123",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: DisbursementValue
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_IBTU111",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_VALOREYDC_15105",
                label: "BUSIN.DLB_BUSIN_VALOREYDC_15105",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: Comment
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_OMEN228",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CORIBECIO_49322",
                label: "BUSIN.DLB_BUSIN_CORIBECIO_49322",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DisbursementIncome, Attribute: ImpOffice
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_IOFF658",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_OINAIMPES_25497",
                label: "BUSIN.DLB_BUSIN_OINAIMPES_25497",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SRSNTINOIW6604_IOFF658 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SRSNTINOIW6604_IOFF658', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SRSNTINOIW6604_IOFF658'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SRSNTINOIW6604_IOFF658");
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
            //ViewState - Entity: DisbursementIncome, Attribute: Observations
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6604_BERI479",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_SERVACINS_39064",
                label: "BUSIN.DLB_BUSIN_SERVACINS_39064",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1765
            $scope.vc.createViewState({
                id: "G_DISBURSIET_541W66",
                hasId: true,
                componentStyle: [],
                label: 'Group1765',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.MemberAmount = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    memberId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "memberId", 0)
                    },
                    memberName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "memberName", '')
                    },
                    accountNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "accountNumber", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "amount", 0)
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "secuential", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "groupId", 0)
                    },
                    credit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "credit", 0)
                    }
                }
            });
            $scope.vc.model.MemberAmount = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_MEMBERNA_9304();
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
                    model: $scope.vc.types.MemberAmount
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9304_89513").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MEMBERNA_9304 = $scope.vc.model.MemberAmount;
            $scope.vc.trackers.MemberAmount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.MemberAmount);
            $scope.vc.model.MemberAmount.bind('change', function(e) {
                $scope.vc.trackers.MemberAmount.track(e);
            });
            $scope.vc.grids.QV_9304_89513 = {};
            $scope.vc.grids.QV_9304_89513.queryId = 'Q_MEMBERNA_9304';
            $scope.vc.viewState.QV_9304_89513 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9304_89513.column = {};
            $scope.vc.grids.QV_9304_89513.editable = false;
            $scope.vc.grids.QV_9304_89513.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.MemberAmount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9304_89513.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_9304_89513");
                    $scope.vc.hideShowColumns("QV_9304_89513", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9304_89513.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9304_89513.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_9304_89513.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9304_89513 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9304_89513 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9304_89513.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9304_89513.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9304_89513.column.memberId = {
                title: 'BUSIN.LBL_BUSIN_CDIGODECT_31316',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWSY_978W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT17_MEMBERII619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.memberId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWSY_978W66",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.memberId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_89513.column.memberId.format",
                        'k-decimals': "vc.viewState.QV_9304_89513.column.memberId.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.memberId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_89513.column.memberName = {
                title: 'BUSIN.DLB_BUSIN_LJRXITRFW_70117',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLJR_831W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT58_MEMBERNE619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.memberName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLJR_831W66",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.memberName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.memberName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_89513.column.accountNumber = {
                title: 'BUSIN.LBL_BUSIN_NMERODEAN_36022',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIXZ_626W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT82_ACCOUNMM619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.accountNumber.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIXZ_626W66",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.accountNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.accountNumber.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_89513.column.amount = {
                title: 'amount',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRIP_230W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT80_AMOUNTHS619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.amount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRIP_230W66",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_89513.column.amount.format",
                        'k-decimals': "vc.viewState.QV_9304_89513.column.amount.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.amount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_89513.column.secuential = {
                title: 'secuential',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKRG_584W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT95_SECUENLI619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.secuential.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKRG_584W66",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_89513.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_9304_89513.column.secuential.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.secuential.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_89513.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRNL_879W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT35_GROUPIDD619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.groupId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRNL_879W66",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_89513.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_9304_89513.column.groupId.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.groupId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_89513.column.credit = {
                title: 'credit',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEMR_240W66',
                element: []
            };
            $scope.vc.grids.QV_9304_89513.AT74_CREDITMV619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_89513.column.credit.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEMR_240W66",
                        'data-validation-code': "{{vc.viewState.QV_9304_89513.column.credit.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_89513.column.credit.format",
                        'k-decimals': "vc.viewState.QV_9304_89513.column.credit.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,1",
                        'ng-class': "vc.viewState.QV_9304_89513.column.credit.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'memberId',
                    title: '{{vc.viewState.QV_9304_89513.column.memberId.title|translate:vc.viewState.QV_9304_89513.column.memberId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.memberId.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.memberId.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT17_MEMBERII619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.memberId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.memberId, \"QV_9304_89513\", \"memberId\"):kendo.toString(#=memberId#, vc.viewState.QV_9304_89513.column.memberId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_89513.column.memberId.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.memberId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.memberId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'memberName',
                    title: '{{vc.viewState.QV_9304_89513.column.memberName.title|translate:vc.viewState.QV_9304_89513.column.memberName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.memberName.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.memberName.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT58_MEMBERNE619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.memberName.element[dataItem.uid].style'>#if (memberName !== null) {# #=memberName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9304_89513.column.memberName.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.memberName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.memberName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'accountNumber',
                    title: '{{vc.viewState.QV_9304_89513.column.accountNumber.title|translate:vc.viewState.QV_9304_89513.column.accountNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.accountNumber.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.accountNumber.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT82_ACCOUNMM619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.accountNumber.element[dataItem.uid].style'>#if (accountNumber !== null) {# #=accountNumber# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9304_89513.column.accountNumber.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.accountNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.accountNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_9304_89513.column.amount.title|translate:vc.viewState.QV_9304_89513.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.amount.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.amount.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT80_AMOUNTHS619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.amount.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_9304_89513\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_9304_89513.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_89513.column.amount.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_9304_89513.column.secuential.title|translate:vc.viewState.QV_9304_89513.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.secuential.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.secuential.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT95_SECUENLI619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.secuential.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_9304_89513\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_9304_89513.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_89513.column.secuential.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9304_89513.column.groupId.title|translate:vc.viewState.QV_9304_89513.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.groupId.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.groupId.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT35_GROUPIDD619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.groupId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9304_89513\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9304_89513.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_89513.column.groupId.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_89513.columns.push({
                    field: 'credit',
                    title: '{{vc.viewState.QV_9304_89513.column.credit.title|translate:vc.viewState.QV_9304_89513.column.credit.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_89513.column.credit.width,
                    format: $scope.vc.viewState.QV_9304_89513.column.credit.format,
                    editor: $scope.vc.grids.QV_9304_89513.AT74_CREDITMV619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_89513.column.credit.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.credit, \"QV_9304_89513\", \"credit\"):kendo.toString(#=credit#, vc.viewState.QV_9304_89513.column.credit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_89513.column.credit.style",
                        "title": "{{vc.viewState.QV_9304_89513.column.credit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_89513.column.credit.hidden
                });
            }
            $scope.vc.viewState.QV_9304_89513.toolbar = {}
            $scope.vc.grids.QV_9304_89513.toolbar = [];
            //ViewState - Group: Group1112
            $scope.vc.createViewState({
                id: "G_DISBURSNVE_552W66",
                hasId: true,
                componentStyle: [],
                label: 'Group1112',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.MemberGroup = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    memberName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "memberName", '')
                    },
                    accountNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "accountNumber", '')
                    },
                    check: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "check", 0)
                    },
                    memberId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "memberId", 0)
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "amount", 0)
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "secuential", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "groupId", 0)
                    },
                    credit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "credit", 0)
                    },
                    individualAccount: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberGroup", "individualAccount", '')
                    }
                }
            });
            $scope.vc.model.MemberGroup = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_MEMBEROP_5438();
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'MemberGroup',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5438_61030', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.MemberGroup
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5438_61030").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MEMBEROP_5438 = $scope.vc.model.MemberGroup;
            $scope.vc.trackers.MemberGroup = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.MemberGroup);
            $scope.vc.model.MemberGroup.bind('change', function(e) {
                $scope.vc.trackers.MemberGroup.track(e);
            });
            $scope.vc.grids.QV_5438_61030 = {};
            $scope.vc.grids.QV_5438_61030.queryId = 'Q_MEMBEROP_5438';
            $scope.vc.viewState.QV_5438_61030 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5438_61030.column = {};
            $scope.vc.grids.QV_5438_61030.editable = {
                mode: 'incell',
            };
            $scope.vc.grids.QV_5438_61030.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.MemberGroup.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    var columnIndex = this.cellIndex(e.container);
                    var fieldName = this.thead.find("th").eq(columnIndex).data("field");
                    if (angular.isDefined($scope.vc.viewState.QV_5438_61030.column[fieldName]) && $scope.vc.viewState.QV_5438_61030.column[fieldName].enabled === false) {
                        this.closeCell();
                        return;
                    }
                    $scope.vc.grids.QV_5438_61030.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_5438_61030");
                    $scope.vc.hideShowColumns("QV_5438_61030", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5438_61030.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5438_61030.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_5438_61030.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5438_61030 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5438_61030 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                save: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                },
                remove: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5438_61030.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5438_61030.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5438_61030.column.memberName = {
                title: 'BUSIN.DLB_BUSIN_LJRXITRFW_70117',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMGH_940W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT85_MEMBEREE791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.memberName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMGH_940W66",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.memberName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.memberName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.accountNumber = {
                title: 'BUSIN.LBL_BUSIN_NMERODEAN_36022',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYQQ_939W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT97_ACCOUNER791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.accountNumber.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYQQ_939W66",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.accountNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.accountNumber.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.check = {
                title: 'BUSIN.LBL_BUSIN_NMERODEUC_85608',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBBW_718W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT56_CHECKKAA791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.check.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBBW_718W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.check.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5438_61030.column.check.format",
                        'k-decimals': "vc.viewState.QV_5438_61030.column.check.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXBBW_718W66',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXBBW_718W66',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.check.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.memberId = {
                title: 'memberId',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNVS_261W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT88_MEMBERDI791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.memberId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNVS_261W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.memberId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5438_61030.column.memberId.format",
                        'k-decimals': "vc.viewState.QV_5438_61030.column.memberId.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.memberId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.amount = {
                title: 'amount',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTTN_598W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT29_AMOUNTUT791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.amount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTTN_598W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5438_61030.column.amount.format",
                        'k-decimals': "vc.viewState.QV_5438_61030.column.amount.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.amount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.secuential = {
                title: 'secuential',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLVZ_567W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT83_SECUENLA791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.secuential.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLVZ_567W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5438_61030.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_5438_61030.column.secuential.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.secuential.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRGZ_445W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT59_GROUPIDD791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.groupId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRGZ_445W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5438_61030.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_5438_61030.column.groupId.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.groupId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.credit = {
                title: 'credit',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJHI_234W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT51_CREDITAU791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.credit.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJHI_234W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.credit.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5438_61030.column.credit.format",
                        'k-decimals': "vc.viewState.QV_5438_61030.column.credit.decimals",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.credit.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5438_61030.column.individualAccount = {
                title: 'individualAccount',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRUP_491W66',
                element: []
            };
            $scope.vc.grids.QV_5438_61030.AT77_INDIVIDO791 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5438_61030.column.individualAccount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRUP_491W66",
                        'data-validation-code': "{{vc.viewState.QV_5438_61030.column.individualAccount.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_SRSNTINOIW66_03,2",
                        'ng-class': "vc.viewState.QV_5438_61030.column.individualAccount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'memberName',
                    title: '{{vc.viewState.QV_5438_61030.column.memberName.title|translate:vc.viewState.QV_5438_61030.column.memberName.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.memberName.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.memberName.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT85_MEMBEREE791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.memberName.element[dataItem.uid].style'>#if (memberName !== null) {# #=memberName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5438_61030.column.memberName.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.memberName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.memberName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'accountNumber',
                    title: '{{vc.viewState.QV_5438_61030.column.accountNumber.title|translate:vc.viewState.QV_5438_61030.column.accountNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.accountNumber.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.accountNumber.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT97_ACCOUNER791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.accountNumber.element[dataItem.uid].style'>#if (accountNumber !== null) {# #=accountNumber# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5438_61030.column.accountNumber.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.accountNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.accountNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'check',
                    title: '{{vc.viewState.QV_5438_61030.column.check.title|translate:vc.viewState.QV_5438_61030.column.check.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.check.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.check.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT56_CHECKKAA791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.check.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.check, \"QV_5438_61030\", \"check\"):kendo.toString(#=check#, vc.viewState.QV_5438_61030.column.check.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5438_61030.column.check.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.check.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.check.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'memberId',
                    title: '{{vc.viewState.QV_5438_61030.column.memberId.title|translate:vc.viewState.QV_5438_61030.column.memberId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.memberId.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.memberId.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT88_MEMBERDI791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.memberId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.memberId, \"QV_5438_61030\", \"memberId\"):kendo.toString(#=memberId#, vc.viewState.QV_5438_61030.column.memberId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5438_61030.column.memberId.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.memberId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.memberId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_5438_61030.column.amount.title|translate:vc.viewState.QV_5438_61030.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.amount.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.amount.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT29_AMOUNTUT791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.amount.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_5438_61030\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_5438_61030.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5438_61030.column.amount.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_5438_61030.column.secuential.title|translate:vc.viewState.QV_5438_61030.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.secuential.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.secuential.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT83_SECUENLA791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.secuential.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_5438_61030\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_5438_61030.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5438_61030.column.secuential.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_5438_61030.column.groupId.title|translate:vc.viewState.QV_5438_61030.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.groupId.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.groupId.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT59_GROUPIDD791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.groupId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_5438_61030\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_5438_61030.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5438_61030.column.groupId.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'credit',
                    title: '{{vc.viewState.QV_5438_61030.column.credit.title|translate:vc.viewState.QV_5438_61030.column.credit.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.credit.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.credit.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT51_CREDITAU791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.credit.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.credit, \"QV_5438_61030\", \"credit\"):kendo.toString(#=credit#, vc.viewState.QV_5438_61030.column.credit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5438_61030.column.credit.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.credit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.credit.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5438_61030.columns.push({
                    field: 'individualAccount',
                    title: '{{vc.viewState.QV_5438_61030.column.individualAccount.title|translate:vc.viewState.QV_5438_61030.column.individualAccount.titleArgs}}',
                    width: $scope.vc.viewState.QV_5438_61030.column.individualAccount.width,
                    format: $scope.vc.viewState.QV_5438_61030.column.individualAccount.format,
                    editor: $scope.vc.grids.QV_5438_61030.AT77_INDIVIDO791.control,
                    template: "<span ng-class='vc.viewState.QV_5438_61030.column.individualAccount.element[dataItem.uid].style'>#if (individualAccount !== null) {# #=individualAccount# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5438_61030.column.individualAccount.style",
                        "title": "{{vc.viewState.QV_5438_61030.column.individualAccount.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5438_61030.column.individualAccount.hidden
                });
            }
            $scope.vc.viewState.QV_5438_61030.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5438_61030.toolbar = {}
            $scope.vc.grids.QV_5438_61030.toolbar = [];
            $scope.vc.model.DisbursementDetail = {
                AmountMOP: $scope.vc.channelDefaultValues("DisbursementDetail", "AmountMOP"),
                Atx: $scope.vc.channelDefaultValues("DisbursementDetail", "Atx"),
                ValueMl: $scope.vc.channelDefaultValues("DisbursementDetail", "ValueMl"),
                DisbursementValue: $scope.vc.channelDefaultValues("DisbursementDetail", "DisbursementValue"),
                Currency: $scope.vc.channelDefaultValues("DisbursementDetail", "Currency"),
                DisbursementId: $scope.vc.channelDefaultValues("DisbursementDetail", "DisbursementId"),
                DisbursementFormId: $scope.vc.channelDefaultValues("DisbursementDetail", "DisbursementFormId"),
                PriceQuote: $scope.vc.channelDefaultValues("DisbursementDetail", "PriceQuote"),
                sequential: $scope.vc.channelDefaultValues("DisbursementDetail", "sequential"),
                DisbursementForm: $scope.vc.channelDefaultValues("DisbursementDetail", "DisbursementForm")
            };
            //ViewState - Group: [Grupo Botones]
            $scope.vc.createViewState({
                id: "GR_SRSNTINOIW66_05",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Botones]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_SRSNTINOIW6605_0000073",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONIWKBMNP_334W66",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CARGARMOB_35713",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONRBZVRHL_639W66",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CARGAMIBM_68908",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.PaymentSelection = {
                creditType: $scope.vc.channelDefaultValues("PaymentSelection", "creditType"),
                transactionNumber: $scope.vc.channelDefaultValues("PaymentSelection", "transactionNumber"),
                groupId: $scope.vc.channelDefaultValues("PaymentSelection", "groupId")
            };
            //ViewState - Group: Group2818
            $scope.vc.createViewState({
                id: "G_DISBURSNTE_326W66",
                hasId: true,
                componentStyle: [],
                label: 'Group2818',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentSelection, Attribute: groupId
            $scope.vc.createViewState({
                id: "VA_GROUPIDALCBRZCO_334W66",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_GRUPOSMDD_37129",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: PaymentSelection, Attribute: transactionNumber
            $scope.vc.createViewState({
                id: "VA_TRANSACTIONNBUM_649W66",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_TRANSACCN_64673",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.LoanHeader = {
                ValuetoDisburse: $scope.vc.channelDefaultValues("LoanHeader", "ValuetoDisburse"),
                BalanceOperation: $scope.vc.channelDefaultValues("LoanHeader", "BalanceOperation"),
                LockDelete: $scope.vc.channelDefaultValues("LoanHeader", "LockDelete"),
                Currency: $scope.vc.channelDefaultValues("LoanHeader", "Currency"),
                CreditLineValid: $scope.vc.channelDefaultValues("LoanHeader", "CreditLineValid"),
                Office: $scope.vc.channelDefaultValues("LoanHeader", "Office"),
                InitialDate: $scope.vc.channelDefaultValues("LoanHeader", "InitialDate"),
                LockCode: $scope.vc.channelDefaultValues("LoanHeader", "LockCode"),
                Operation: $scope.vc.channelDefaultValues("LoanHeader", "Operation"),
                OfficeId: $scope.vc.channelDefaultValues("LoanHeader", "OfficeId"),
                OperationBanck: $scope.vc.channelDefaultValues("LoanHeader", "OperationBanck"),
                ProposedAmount: $scope.vc.channelDefaultValues("LoanHeader", "ProposedAmount"),
                PriceQuote: $scope.vc.channelDefaultValues("LoanHeader", "PriceQuote"),
                ProductType: $scope.vc.channelDefaultValues("LoanHeader", "ProductType"),
                ProcessNumber: $scope.vc.channelDefaultValues("LoanHeader", "ProcessNumber"),
                CustomerId: $scope.vc.channelDefaultValues("LoanHeader", "CustomerId"),
                NumberLine: $scope.vc.channelDefaultValues("LoanHeader", "NumberLine"),
                AmounttoDisburse: $scope.vc.channelDefaultValues("LoanHeader", "AmounttoDisburse"),
                Customer: $scope.vc.channelDefaultValues("LoanHeader", "Customer"),
                ValueDiscount: $scope.vc.channelDefaultValues("LoanHeader", "ValueDiscount")
            };
            //ViewState - Group: GrpHideLoan
            $scope.vc.createViewState({
                id: "GR_SRSNTINOIW66_06",
                hasId: true,
                componentStyle: [],
                label: 'GrpHideLoan',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_SRSNTINOIW66_06-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_83_AUSMM61_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_83_AUSMM61_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
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
                $scope.vc.render('VC_AUSMM61_MDSIC_473');
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
    var cobisMainModule = cobis.createModule("VC_AUSMM61_MDSIC_473", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_AUSMM61_MDSIC_473", {
            templateUrl: "VC_AUSMM61_MDSIC_473_FORM.html",
            controller: "VC_AUSMM61_MDSIC_473_CTRL",
            label: "FormDisbursementIncome",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AUSMM61_MDSIC_473?" + $.param(search);
            }
        });
        VC_AUSMM61_MDSIC_473(cobisMainModule);
    }]);
} else {
    VC_AUSMM61_MDSIC_473(cobisMainModule);
}