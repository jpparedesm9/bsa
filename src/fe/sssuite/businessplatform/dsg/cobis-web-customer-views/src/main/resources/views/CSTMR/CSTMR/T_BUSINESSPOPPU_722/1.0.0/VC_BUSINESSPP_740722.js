//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.businesspopupform = designerEvents.api.businesspopupform || designer.dsgEvents();

function VC_BUSINESSPP_740722(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_BUSINESSPP_740722_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_BUSINESSPP_740722_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CSTMR",
            subModuleId: "CSTMR",
            taskId: "T_BUSINESSPOPPU_722",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BUSINESSPP_740722",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_BUSINESSPOPPU_722",
        designerEvents.api.businesspopupform,
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
                vcName: 'VC_BUSINESSPP_740722'
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
                    moduleId: 'CSTMR',
                    subModuleId: 'CSTMR',
                    taskId: 'T_BUSINESSPOPPU_722',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Business: "Business"
                },
                entities: {
                    Business: {
                        colony: 'AT11_COLONYKL830',
                        customerCode: 'AT13_CUSTOMER830',
                        phone: 'AT13_PHONEWJC830',
                        economicActivity: 'AT14_ECONOMVA830',
                        street: 'AT17_STREETFK830',
                        economicActivityDesc: 'AT22_ECONOMVC830',
                        typeLocal: 'AT22_TYPELOAC830',
                        mountlyIncomes: 'AT27_MOUNTLEO830',
                        areEntrepreneur: 'AT35_AREENTPE830',
                        numberOfBusiness: 'AT46_NUMBERSI830',
                        postalCode: 'AT48_POSTALCE830',
                        whichResource: 'AT48_WHICHRCE830',
                        timeBusinessAddress: 'AT53_TIMEBUES830',
                        state: 'AT60_STATEHSX830',
                        timeActivity: 'AT61_TIMEACYI830',
                        resources: 'AT72_RESOUREC830',
                        country: 'AT73_COUNTRYY830',
                        code: 'AT77_CODESODR830',
                        municipality: 'AT78_MUNICILL830',
                        dateBusiness: 'AT82_CREDITAA830',
                        creditDestination: 'AT87_CREDITIO830',
                        turnaround: 'AT90_TURNARDO830',
                        locations: 'AT91_LOCATIOO830',
                        names: 'AT98_NAMESVED830',
                        _pks: [],
                        _entityId: 'EN_BUSINESSS_830',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Business: {}
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
                $scope.vc.execute("temporarySave", VC_BUSINESSPP_740722, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_BUSINESSPP_740722, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_BUSINESSPP_740722, data, function() {});
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
            $scope.vc.viewState.VC_BUSINESSPP_740722 = {
                style: []
            }
            $scope.vc.model.Business = {
                colony: $scope.vc.channelDefaultValues("Business", "colony"),
                customerCode: $scope.vc.channelDefaultValues("Business", "customerCode"),
                phone: $scope.vc.channelDefaultValues("Business", "phone"),
                economicActivity: $scope.vc.channelDefaultValues("Business", "economicActivity"),
                street: $scope.vc.channelDefaultValues("Business", "street"),
                economicActivityDesc: $scope.vc.channelDefaultValues("Business", "economicActivityDesc"),
                typeLocal: $scope.vc.channelDefaultValues("Business", "typeLocal"),
                mountlyIncomes: $scope.vc.channelDefaultValues("Business", "mountlyIncomes"),
                areEntrepreneur: $scope.vc.channelDefaultValues("Business", "areEntrepreneur"),
                numberOfBusiness: $scope.vc.channelDefaultValues("Business", "numberOfBusiness"),
                postalCode: $scope.vc.channelDefaultValues("Business", "postalCode"),
                whichResource: $scope.vc.channelDefaultValues("Business", "whichResource"),
                timeBusinessAddress: $scope.vc.channelDefaultValues("Business", "timeBusinessAddress"),
                state: $scope.vc.channelDefaultValues("Business", "state"),
                timeActivity: $scope.vc.channelDefaultValues("Business", "timeActivity"),
                resources: $scope.vc.channelDefaultValues("Business", "resources"),
                country: $scope.vc.channelDefaultValues("Business", "country"),
                code: $scope.vc.channelDefaultValues("Business", "code"),
                municipality: $scope.vc.channelDefaultValues("Business", "municipality"),
                dateBusiness: $scope.vc.channelDefaultValues("Business", "dateBusiness"),
                creditDestination: $scope.vc.channelDefaultValues("Business", "creditDestination"),
                turnaround: $scope.vc.channelDefaultValues("Business", "turnaround"),
                locations: $scope.vc.channelDefaultValues("Business", "locations"),
                names: $scope.vc.channelDefaultValues("Business", "names")
            };
            //ViewState - Group: Group2611
            $scope.vc.createViewState({
                id: "G_BUSINESPUP_840246",
                hasId: true,
                componentStyle: [],
                label: 'Group2611',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Business, Attribute: names
            $scope.vc.createViewState({
                id: "VA_NAMESIOSKVXJVCI_342246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBREDOC_82750",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Business, Attribute: dateBusiness
            $scope.vc.createViewState({
                id: "VA_DATEBUSINESSBNU_397246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETR_78877",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Business, Attribute: turnaround
            $scope.vc.createViewState({
                id: "VA_TURNAROUNDZKHZG_712246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GIROQYDVN_82921",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TURNAROUNDZKHZG_712246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TURNAROUNDZKHZG_712246', 'cl_giro_negocio', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TURNAROUNDZKHZG_712246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TURNAROUNDZKHZG_712246");
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
            //ViewState - Entity: Business, Attribute: economicActivity
            $scope.vc.createViewState({
                id: "VA_ECONOMICACTIITI_682246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ACTIVIDAA_39121",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ECONOMICACTIITI_682246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ECONOMICACTIITI_682246', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ECONOMICACTIITI_682246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            maxRecords: 20,
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Business, Attribute: typeLocal
            $scope.vc.createViewState({
                id: "VA_TYPELOCALUWBLBM_820246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODELAL_16702",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPELOCALUWBLBM_820246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPELOCALUWBLBM_820246', 'cr_tipo_local', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPELOCALUWBLBM_820246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                        }, {
                            filterType: 'startswith'
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
            //ViewState - Entity: Business, Attribute: country
            $scope.vc.createViewState({
                id: "VA_COUNTRYIIWTTPSU_839246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASDSYTGI_62008",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COUNTRYIIWTTPSU_839246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COUNTRYIIWTTPSU_839246', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COUNTRYIIWTTPSU_839246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Business, Attribute: state
            $scope.vc.createViewState({
                id: "VA_STATEILWSIRFUNE_256246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOXKN_15577",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_STATEILWSIRFUNE_256246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_STATEILWSIRFUNE_256246', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_STATEILWSIRFUNE_256246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Business, Attribute: municipality
            $scope.vc.createViewState({
                id: "VA_MUNICIPALITYALV_646246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DELEGACIP_68755",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_MUNICIPALITYALV_646246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_MUNICIPALITYALV_646246', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_MUNICIPALITYALV_646246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Business, Attribute: colony
            $scope.vc.createViewState({
                id: "VA_COLONYYSQOLWTXJ_927246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_COLONIADI_43389",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COLONYYSQOLWTXJ_927246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COLONYYSQOLWTXJ_927246', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COLONYYSQOLWTXJ_927246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Business, Attribute: street
            $scope.vc.createViewState({
                id: "VA_STREETMZFYCLAJY_509246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CALLEIMUG_56828",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Business, Attribute: numberOfBusiness
            $scope.vc.createViewState({
                id: "VA_NUMBEROFBUSIESE_150246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROXAVE_57372",
                format: "####",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Business, Attribute: postalCode
            $scope.vc.createViewState({
                id: "VA_POSTALCODENPHOT_989246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOPOSL_94606",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Business, Attribute: phone
            $scope.vc.createViewState({
                id: "VA_PHONEMCFABMNRNP_309246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOVK_75532",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Business, Attribute: timeActivity
            $scope.vc.createViewState({
                id: "VA_TIMEACTIVITYKTZ_955246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIEMPODAA_42945",
                format: "n0",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TIMEACTIVITYKTZ_955246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TIMEACTIVITYKTZ_955246', 'cl_referencia_tiempo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TIMEACTIVITYKTZ_955246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TIMEACTIVITYKTZ_955246");
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
            //ViewState - Entity: Business, Attribute: timeBusinessAddress
            $scope.vc.createViewState({
                id: "VA_TIMEBUSINESSSSE_790246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIEMPODOA_97102",
                format: "n0",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TIMEBUSINESSSSE_790246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TIMEBUSINESSSSE_790246', 'cl_referencia_tiempo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TIMEBUSINESSSSE_790246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TIMEBUSINESSSSE_790246");
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
            //ViewState - Entity: Business, Attribute: areEntrepreneur
            $scope.vc.createViewState({
                id: "VA_AREENTREPRENUUU_244246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESEMPRENO_47778",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Business, Attribute: resources
            $scope.vc.createViewState({
                id: "VA_RESOURCESXCAKTO_414246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ORIGENLUE_60745",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RESOURCESXCAKTO_414246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RESOURCESXCAKTO_414246', 'cl_recursos_credito', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RESOURCESXCAKTO_414246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                        }, {
                            filterType: 'startswith'
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
            //ViewState - Entity: Business, Attribute: whichResource
            $scope.vc.createViewState({
                id: "VA_WHICHRESOURCEEE_338246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CULZFYLDO_13438",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Business, Attribute: mountlyIncomes
            $scope.vc.createViewState({
                id: "VA_MOUNTLYINCOMSEE_419246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INGRESOAM_55561",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Business, Attribute: creditDestination
            $scope.vc.createViewState({
                id: "VA_CREDITDESTINOII_258246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DESTINOTR_63871",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CREDITDESTINOII_258246 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CREDITDESTINOII_258246', 'cl_destino_credito', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CREDITDESTINOII_258246'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CREDITDESTINOII_258246");
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
            $scope.vc.createViewState({
                id: "Spacer2754",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONYULNPZK_374246",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARNG_58868",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BUSINESSPOPPU_722_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BUSINESSPOPPU_722_CANCEL",
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
                $scope.vc.render('VC_BUSINESSPP_740722');
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
    var cobisMainModule = cobis.createModule("VC_BUSINESSPP_740722", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_BUSINESSPP_740722", {
            templateUrl: "VC_BUSINESSPP_740722_FORM.html",
            controller: "VC_BUSINESSPP_740722_CTRL",
            labelId: "CSTMR.LBL_CSTMR_NEGOCIOSS_45525",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_BUSINESSPP_740722?" + $.param(search);
            }
        });
        VC_BUSINESSPP_740722(cobisMainModule);
    }]);
} else {
    VC_BUSINESSPP_740722(cobisMainModule);
}