//Designer Generator v 6.3.0 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.category = designerEvents.api.category || designer.dsgEvents();

function VC_CTORY86_CTEGO_587(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CTORY86_CTEGO_587_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CTORY86_CTEGO_587_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_FLCRE_24_CTORY86",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CTORY86_CTEGO_587",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_24_CTORY86",
        designerEvents.api.category,
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
                vcName: 'VC_CTORY86_CTEGO_587'
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
                    taskId: 'T_FLCRE_24_CTORY86',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Category: "Category",
                    CategoryReadjustment: "CategoryReadjustment",
                    PaymentPlanHeader: "PaymentPlanHeader"
                },
                entities: {
                    Category: {
                        PaymentArrears: 'AT_CAT957ATRR00',
                        AmounToApply: 'AT_CAT957AUNL12',
                        bank: 'AT_CAT957BANK56',
                        AccountAbono: 'AT_CAT957CNBO35',
                        ConceptAsoc: 'AT_CAT957CNTA33',
                        Concept: 'AT_CAT957COEP74',
                        Currency: 'AT_CAT957CREY02',
                        ConceptTypeDescription: 'AT_CAT957CTCR03',
                        AccountPayment: 'AT_CAT957CTPY07',
                        DifferDays: 'AT_CAT957DRDA32',
                        ReferenceDescription: 'AT_CAT957ECRI97',
                        Reference: 'AT_CAT957EENE30',
                        ReferentialReadjustment: 'AT_CAT957EEUM99',
                        segment: 'AT_CAT957EGMT36',
                        PercentageDay: 'AT_CAT957ENTG63',
                        Factor: 'AT_CAT957FAOR47',
                        Funded: 'AT_CAT957FNDD20',
                        Affectation: 'AT_CAT957FTTO35',
                        Grace: 'AT_CAT957GRCE98',
                        HasDecimals: 'AT_CAT957HDAL27',
                        isHeritage: 'AT_CAT957HETG57',
                        Differ: 'AT_CAT957IFER44',
                        itemType: 'AT_CAT957IMTY53',
                        ItemDesc: 'AT_CAT957ITMS50',
                        CalculatedBase: 'AT_CAT957LEBS82',
                        MaxRate: 'AT_CAT957MAXR59',
                        Maximun: 'AT_CAT957MAXU35',
                        MethodOfPayment: 'AT_CAT957MEON23',
                        Minimum: 'AT_CAT957MIMM00',
                        RotMinimunRate: 'AT_CAT957MIMT63',
                        MinRate: 'AT_CAT957MINA75',
                        Money: 'AT_CAT957MOEY52',
                        AmountToApplyDesc: 'AT_CAT957MUPE99',
                        ConceptType: 'AT_CAT957NCEP81',
                        ConceptDescription: 'AT_CAT957NSPN99',
                        Provisioned: 'AT_CAT957OVON18',
                        ProductType: 'AT_CAT957PDUP16',
                        Percentage: 'AT_CAT957PENG62',
                        Priority: 'AT_CAT957PIRY70',
                        PaymentForm: 'AT_CAT957PMEO22',
                        Readjustment: 'AT_CAT957RJET51',
                        ReferenceAmount: 'AT_CAT957RNCU78',
                        sector: 'AT_CAT957SETR06',
                        Sign: 'AT_CAT957SIGN95',
                        isNew: 'AT_CAT957SNEW75',
                        Spread: 'AT_CAT957SPRD31',
                        DiscountForm: 'AT_CAT957SUOM48',
                        FormThirdPayment: 'AT_CAT957TRAT87',
                        ReadjustmentFactor: 'AT_CAT957USEI06',
                        ReadjustmentSign: 'AT_CAT957UTNI48',
                        Value: 'AT_CAT957VALU37',
                        PaymentFormDescription: 'AT_CAT957YTRP63',
                        _pks: [],
                        _entityId: 'EN_CATEGORYM957',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CategoryReadjustment: {
                        AmountToApply: 'AT_CAT716AOOP42',
                        MaxRate: 'AT_CAT716ARAE25',
                        Maximun: 'AT_CAT716AXIN22',
                        ConceptType: 'AT_CAT716CNCT91',
                        Concept: 'AT_CAT716COEP39',
                        Reference: 'AT_CAT716EENE28',
                        ReferenceAmount: 'AT_CAT716ENEU05',
                        ReferenceDescription: 'AT_CAT716ERRO08',
                        Minimum: 'AT_CAT716MIUM57',
                        ConceptDescription: 'AT_CAT716ORIT72',
                        ConceptTypeDescription: 'AT_CAT716PTTS67',
                        Sign: 'AT_CAT716SIGN85',
                        Spread: 'AT_CAT716SPED14',
                        Value: 'AT_CAT716VALE26',
                        _pks: [],
                        _entityId: 'EN_CATGOREAE716',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentPlanHeader: {
                        account: 'AT42_ACCOUNTT771',
                        typePayment: 'AT80_TYPEPAYN771',
                        amount: 'AT_ANT771AMUN93',
                        approvedAmount: 'AT_ANT771AOUN07',
                        apr: 'AT_ANT771APRE32',
                        auxApprovedAmount: 'AT_ANT771AVEO47',
                        debitAccount: 'AT_ANT771BTCO94',
                        classOperation: 'AT_ANT771CARO73',
                        customerName: 'AT_ANT771CUOM65',
                        debit: 'AT_ANT771DBIT28',
                        daysPerYear: 'AT_ANT771DERA56',
                        idRequested: 'AT_ANT771DQUS87',
                        fee: 'AT_ANT771FEEQ56',
                        initialDate: 'AT_ANT771IATE13',
                        applicationNumber: 'AT_ANT771ICAT12',
                        localCurrency: 'AT_ANT771LURE16',
                        customerCode: 'AT_ANT771MEOE57',
                        productType: 'AT_ANT771ODCP64',
                        operationCode: 'AT_ANT771OEOD19',
                        rate: 'AT_ANT771RATE93',
                        currency: 'AT_ANT771RENC79',
                        shareValue: 'AT_ANT771SHAL56',
                        firstExpirationFeeDate: 'AT_ANT771SPRE60',
                        sumAmount: 'AT_ANT771SUUN83',
                        tea: 'AT_ANT771TEAD55',
                        tir: 'AT_ANT771TIRP92',
                        wayToPay: 'AT_ANT771WAYA88',
                        _pks: [],
                        _entityId: 'EN_ANTAHEDER771',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Category: {},
                CategoryReadjustment: {},
                PaymentPlanHeader: {}
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
                $scope.vc.execute("temporarySave", VC_CTORY86_CTEGO_587, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CTORY86_CTEGO_587, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CTORY86_CTEGO_587, data, function() {});
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
            $scope.vc.viewState.VC_CTORY86_CTEGO_587 = {
                style: []
            }
            //ViewState - Group: Grupo Rubros
            $scope.vc.createViewState({
                id: "GR_ATACATEGRY19_01",
                hasId: true,
                componentStyle: [],
                label: 'Grupo Rubros',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Category = {
                PaymentArrears: $scope.vc.channelDefaultValues("Category", "PaymentArrears"),
                AmounToApply: $scope.vc.channelDefaultValues("Category", "AmounToApply"),
                bank: $scope.vc.channelDefaultValues("Category", "bank"),
                AccountAbono: $scope.vc.channelDefaultValues("Category", "AccountAbono"),
                ConceptAsoc: $scope.vc.channelDefaultValues("Category", "ConceptAsoc"),
                Concept: $scope.vc.channelDefaultValues("Category", "Concept"),
                Currency: $scope.vc.channelDefaultValues("Category", "Currency"),
                ConceptTypeDescription: $scope.vc.channelDefaultValues("Category", "ConceptTypeDescription"),
                AccountPayment: $scope.vc.channelDefaultValues("Category", "AccountPayment"),
                DifferDays: $scope.vc.channelDefaultValues("Category", "DifferDays"),
                ReferenceDescription: $scope.vc.channelDefaultValues("Category", "ReferenceDescription"),
                Reference: $scope.vc.channelDefaultValues("Category", "Reference"),
                ReferentialReadjustment: $scope.vc.channelDefaultValues("Category", "ReferentialReadjustment"),
                segment: $scope.vc.channelDefaultValues("Category", "segment"),
                PercentageDay: $scope.vc.channelDefaultValues("Category", "PercentageDay"),
                Factor: $scope.vc.channelDefaultValues("Category", "Factor"),
                Funded: $scope.vc.channelDefaultValues("Category", "Funded"),
                Affectation: $scope.vc.channelDefaultValues("Category", "Affectation"),
                Grace: $scope.vc.channelDefaultValues("Category", "Grace"),
                HasDecimals: $scope.vc.channelDefaultValues("Category", "HasDecimals"),
                isHeritage: $scope.vc.channelDefaultValues("Category", "isHeritage"),
                Differ: $scope.vc.channelDefaultValues("Category", "Differ"),
                itemType: $scope.vc.channelDefaultValues("Category", "itemType"),
                ItemDesc: $scope.vc.channelDefaultValues("Category", "ItemDesc"),
                CalculatedBase: $scope.vc.channelDefaultValues("Category", "CalculatedBase"),
                MaxRate: $scope.vc.channelDefaultValues("Category", "MaxRate"),
                Maximun: $scope.vc.channelDefaultValues("Category", "Maximun"),
                MethodOfPayment: $scope.vc.channelDefaultValues("Category", "MethodOfPayment"),
                Minimum: $scope.vc.channelDefaultValues("Category", "Minimum"),
                RotMinimunRate: $scope.vc.channelDefaultValues("Category", "RotMinimunRate"),
                MinRate: $scope.vc.channelDefaultValues("Category", "MinRate"),
                Money: $scope.vc.channelDefaultValues("Category", "Money"),
                AmountToApplyDesc: $scope.vc.channelDefaultValues("Category", "AmountToApplyDesc"),
                ConceptType: $scope.vc.channelDefaultValues("Category", "ConceptType"),
                ConceptDescription: $scope.vc.channelDefaultValues("Category", "ConceptDescription"),
                Provisioned: $scope.vc.channelDefaultValues("Category", "Provisioned"),
                ProductType: $scope.vc.channelDefaultValues("Category", "ProductType"),
                Percentage: $scope.vc.channelDefaultValues("Category", "Percentage"),
                Priority: $scope.vc.channelDefaultValues("Category", "Priority"),
                PaymentForm: $scope.vc.channelDefaultValues("Category", "PaymentForm"),
                Readjustment: $scope.vc.channelDefaultValues("Category", "Readjustment"),
                ReferenceAmount: $scope.vc.channelDefaultValues("Category", "ReferenceAmount"),
                sector: $scope.vc.channelDefaultValues("Category", "sector"),
                Sign: $scope.vc.channelDefaultValues("Category", "Sign"),
                isNew: $scope.vc.channelDefaultValues("Category", "isNew"),
                Spread: $scope.vc.channelDefaultValues("Category", "Spread"),
                DiscountForm: $scope.vc.channelDefaultValues("Category", "DiscountForm"),
                FormThirdPayment: $scope.vc.channelDefaultValues("Category", "FormThirdPayment"),
                ReadjustmentFactor: $scope.vc.channelDefaultValues("Category", "ReadjustmentFactor"),
                ReadjustmentSign: $scope.vc.channelDefaultValues("Category", "ReadjustmentSign"),
                Value: $scope.vc.channelDefaultValues("Category", "Value"),
                PaymentFormDescription: $scope.vc.channelDefaultValues("Category", "PaymentFormDescription")
            };
            //ViewState - Group: Rubros
            $scope.vc.createViewState({
                id: "GR_ATACATEGRY19_02",
                hasId: true,
                componentStyle: [],
                label: 'Rubros',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: Concept
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_COEP019",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CODIORURO_89488",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ATACATEGRY1902_COEP019 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ATACATEGRY1902_COEP019', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ATACATEGRY1902_COEP019'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ATACATEGRY1902_COEP019");
                        },
                        options.data.filter, null, 1);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Category, Attribute: ItemDesc
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_ITMS728",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Category, Attribute: AmounToApply
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_AUNL784",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_LORAPICAR_36363",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ATACATEGRY1902_AUNL784 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ATACATEGRY1902_AUNL784', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ATACATEGRY1902_AUNL784'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ATACATEGRY1902_AUNL784");
                        },
                        options.data.filter, null, 1);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Category, Attribute: Reference
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_EENE582",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Query
            });
            //ViewState - Entity: Category, Attribute: ReferenceDescription
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_ECRI253",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_REERENCIA_20799",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: AmountToApplyDesc
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_MUPE771",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Category, Attribute: ReferenceAmount
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_RNCU443",
                componentStyle: [],
                label: '',
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: Sign
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_SIGN784",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SIGNOTCWB_56579",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ATACATEGRY1902_SIGN784 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '+',
                            value: '+'
                        }, {
                            code: '-',
                            value: '-'
                        }, {
                            code: '/',
                            value: '/'
                        }, {
                            code: '*',
                            value: '*'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_ATACATEGRY1902_SIGN784");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Category, Attribute: Spread
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_SPRD943",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SPREADVHA_77471",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: Value
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_VALU262",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_VALORDWSB_39301",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: Minimum
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_MIMM127",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MNIMODJBW_27031",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: Maximun
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_MAXU405",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MXIMOSLVA_91451",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: MaxRate
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_MINA980",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MXIAREERA_18880",
                format: "###.#####",
                suffix: "%",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Category, Attribute: Funded
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1902_FNDD538",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FNANCIADO_68578",
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_ATACATEGRY1902_FNDD538 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_ATACATEGRY1902_FNDD538 !== "undefined") {}
            $scope.vc.model.CategoryReadjustment = {
                AmountToApply: $scope.vc.channelDefaultValues("CategoryReadjustment", "AmountToApply"),
                MaxRate: $scope.vc.channelDefaultValues("CategoryReadjustment", "MaxRate"),
                Maximun: $scope.vc.channelDefaultValues("CategoryReadjustment", "Maximun"),
                ConceptType: $scope.vc.channelDefaultValues("CategoryReadjustment", "ConceptType"),
                Concept: $scope.vc.channelDefaultValues("CategoryReadjustment", "Concept"),
                Reference: $scope.vc.channelDefaultValues("CategoryReadjustment", "Reference"),
                ReferenceAmount: $scope.vc.channelDefaultValues("CategoryReadjustment", "ReferenceAmount"),
                ReferenceDescription: $scope.vc.channelDefaultValues("CategoryReadjustment", "ReferenceDescription"),
                Minimum: $scope.vc.channelDefaultValues("CategoryReadjustment", "Minimum"),
                ConceptDescription: $scope.vc.channelDefaultValues("CategoryReadjustment", "ConceptDescription"),
                ConceptTypeDescription: $scope.vc.channelDefaultValues("CategoryReadjustment", "ConceptTypeDescription"),
                Sign: $scope.vc.channelDefaultValues("CategoryReadjustment", "Sign"),
                Spread: $scope.vc.channelDefaultValues("CategoryReadjustment", "Spread"),
                Value: $scope.vc.channelDefaultValues("CategoryReadjustment", "Value")
            };
            //ViewState - Group: Rubros Reajuste
            $scope.vc.createViewState({
                id: "GR_ATACATEGRY19_04",
                hasId: true,
                componentStyle: [],
                label: 'Rubros Reajuste',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Concept
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_COEP407",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CODIORURO_89488",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ATACATEGRY1904_COEP407 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ATACATEGRY1904_COEP407', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ATACATEGRY1904_COEP407'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ATACATEGRY1904_COEP407");
                        },
                        options.data.filter, null, 1);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: ConceptDescription
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_ORIT592",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Query
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: AmountToApply
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_AOOP178",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_LORAPICAR_36363",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ATACATEGRY1904_AOOP178 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ATACATEGRY1904_AOOP178', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ATACATEGRY1904_AOOP178'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ATACATEGRY1904_AOOP178");
                        },
                        options.data.filter, null, 1);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Reference
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_EENE861",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.Query
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: ReferenceDescription
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_ERRO392",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_REERENCIA_20799",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: ReferenceAmount
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_ENEU551",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_EMPTYDKVF_56325",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Sign
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_SIGN273",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SIGNOTCWB_56579",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ATACATEGRY1904_SIGN273 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '+',
                            value: '+'
                        }, {
                            code: '-',
                            value: '-'
                        }, {
                            code: '/',
                            value: '/'
                        }, {
                            code: '*',
                            value: '*'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_ATACATEGRY1904_SIGN273");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Spread
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_SPED624",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SPREADVHA_77471",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Value
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_VALE195",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_VALORDWSB_39301",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Minimum
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_MIUM176",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MNIMODJBW_27031",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CategoryReadjustment, Attribute: Maximun
            $scope.vc.createViewState({
                id: "VA_ATACATEGRY1904_AXIN199",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MXIMOSLVA_91451",
                format: "0.00000",
                decimals: 5,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_24_CTORY86_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_24_CTORY86_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Guardar Rubros
            $scope.vc.createViewState({
                id: "CM_CTORY86ARB39",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PaymentPlanHeader = {
                account: $scope.vc.channelDefaultValues("PaymentPlanHeader", "account"),
                typePayment: $scope.vc.channelDefaultValues("PaymentPlanHeader", "typePayment"),
                amount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "amount"),
                approvedAmount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "approvedAmount"),
                apr: $scope.vc.channelDefaultValues("PaymentPlanHeader", "apr"),
                auxApprovedAmount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "auxApprovedAmount"),
                debitAccount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "debitAccount"),
                classOperation: $scope.vc.channelDefaultValues("PaymentPlanHeader", "classOperation"),
                customerName: $scope.vc.channelDefaultValues("PaymentPlanHeader", "customerName"),
                debit: $scope.vc.channelDefaultValues("PaymentPlanHeader", "debit"),
                daysPerYear: $scope.vc.channelDefaultValues("PaymentPlanHeader", "daysPerYear"),
                idRequested: $scope.vc.channelDefaultValues("PaymentPlanHeader", "idRequested"),
                fee: $scope.vc.channelDefaultValues("PaymentPlanHeader", "fee"),
                initialDate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "initialDate"),
                applicationNumber: $scope.vc.channelDefaultValues("PaymentPlanHeader", "applicationNumber"),
                localCurrency: $scope.vc.channelDefaultValues("PaymentPlanHeader", "localCurrency"),
                customerCode: $scope.vc.channelDefaultValues("PaymentPlanHeader", "customerCode"),
                productType: $scope.vc.channelDefaultValues("PaymentPlanHeader", "productType"),
                operationCode: $scope.vc.channelDefaultValues("PaymentPlanHeader", "operationCode"),
                rate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "rate"),
                currency: $scope.vc.channelDefaultValues("PaymentPlanHeader", "currency"),
                shareValue: $scope.vc.channelDefaultValues("PaymentPlanHeader", "shareValue"),
                firstExpirationFeeDate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "firstExpirationFeeDate"),
                sumAmount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "sumAmount"),
                tea: $scope.vc.channelDefaultValues("PaymentPlanHeader", "tea"),
                tir: $scope.vc.channelDefaultValues("PaymentPlanHeader", "tir"),
                wayToPay: $scope.vc.channelDefaultValues("PaymentPlanHeader", "wayToPay")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_ATACATEGRY1902_FNDD538.read();
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
                $scope.vc.render('VC_CTORY86_CTEGO_587');
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
    var cobisMainModule = cobis.createModule("VC_CTORY86_CTEGO_587", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_CTORY86_CTEGO_587", {
            templateUrl: "VC_CTORY86_CTEGO_587_FORM.html",
            controller: "VC_CTORY86_CTEGO_587_CTRL",
            label: "Category",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CTORY86_CTEGO_587?" + $.param(search);
            }
        });
        VC_CTORY86_CTEGO_587(cobisMainModule);
    }]);
} else {
    VC_CTORY86_CTEGO_587(cobisMainModule);
}