//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.ratesmodal = designerEvents.api.ratesmodal || designer.dsgEvents();

function VC_RATESMODAL_789953(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RATESMODAL_789953_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RATESMODAL_789953_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "MNTNN",
            taskId: "T_RATESMODALKUB_953",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RATESMODAL_789953",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_RATESMODALKUB_953",
        designerEvents.api.ratesmodal,
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
                vcName: 'VC_RATESMODAL_789953'
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
                    subModuleId: 'MNTNN',
                    taskId: 'T_RATESMODALKUB_953',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Rates: "Rates",
                    ServerParameter: "ServerParameter"
                },
                entities: {
                    Rates: {
                        referenceValue: 'AT14_REFEREUV494',
                        value: 'AT69_VALUEMQK494',
                        portfolioClass: 'AT61_PORTFOSO494',
                        typePoints: 'AT17_TYPEPONS494',
                        numberDecimals: 'AT26_NUMBERMI494',
                        signDefault: 'AT86_SIGNODEA494',
                        valueDeafult: 'AT25_VALUEDET494',
                        lockedDefault: 'AT65_LOCKEDLL494',
                        signMin: 'AT96_SIGNMINN494',
                        valueMin: 'AT61_VALUEMIN494',
                        lockedMin: 'AT43_LOCKEDMI494',
                        signMax: 'AT87_SIGNMAXX494',
                        valueMax: 'AT57_VALUEMXA494',
                        lockedMax: 'AT80_LOCKEDXX494',
                        rateType: 'AT48_RATETYPE494',
                        clase: 'AT78_CLASEUBE494',
                        _pks: [],
                        _entityId: 'EN_RATESTIRW_494',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ServerParameter: {
                        loanBankID: 'AT83_LOANBADD884',
                        selectedRow: 'AT50_SELECTED884',
                        amount: 'AT64_AMOUNTCK884',
                        condonationPercentage: 'AT30_CONDONIE884',
                        flag: 'AT69_FLAGHWCK884',
                        refresGridFlag: 'AT58_REFRESRG884',
                        refresGrid2Flag: 'AT81_REFRESAD884',
                        _pks: [],
                        _entityId: 'EN_SERVERPRA_884',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Rates: {},
                ServerParameter: {}
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
                $scope.vc.execute("temporarySave", VC_RATESMODAL_789953, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_RATESMODAL_789953, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_RATESMODAL_789953, data, function() {});
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
            $scope.vc.viewState.VC_RATESMODAL_789953 = {
                style: []
            }
            $scope.vc.model.Rates = {
                referenceValue: $scope.vc.channelDefaultValues("Rates", "referenceValue"),
                value: $scope.vc.channelDefaultValues("Rates", "value"),
                portfolioClass: $scope.vc.channelDefaultValues("Rates", "portfolioClass"),
                typePoints: $scope.vc.channelDefaultValues("Rates", "typePoints"),
                numberDecimals: $scope.vc.channelDefaultValues("Rates", "numberDecimals"),
                signDefault: $scope.vc.channelDefaultValues("Rates", "signDefault"),
                valueDeafult: $scope.vc.channelDefaultValues("Rates", "valueDeafult"),
                lockedDefault: $scope.vc.channelDefaultValues("Rates", "lockedDefault"),
                signMin: $scope.vc.channelDefaultValues("Rates", "signMin"),
                valueMin: $scope.vc.channelDefaultValues("Rates", "valueMin"),
                lockedMin: $scope.vc.channelDefaultValues("Rates", "lockedMin"),
                signMax: $scope.vc.channelDefaultValues("Rates", "signMax"),
                valueMax: $scope.vc.channelDefaultValues("Rates", "valueMax"),
                lockedMax: $scope.vc.channelDefaultValues("Rates", "lockedMax"),
                rateType: $scope.vc.channelDefaultValues("Rates", "rateType"),
                clase: $scope.vc.channelDefaultValues("Rates", "clase")
            };
            //ViewState - Group: Group2230
            $scope.vc.createViewState({
                id: "G_RATESMODDD_536778",
                hasId: true,
                componentStyle: [],
                label: 'Group2230',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: referenceValue
            $scope.vc.createViewState({
                id: "VA_REFERENCEVALEEE_875778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORREEA_62571",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_REFERENCEVALEEE_875778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_REFERENCEVALEEE_875778', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_REFERENCEVALEEE_875778'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_REFERENCEVALEEE_875778");
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
            //ViewState - Entity: Rates, Attribute: value
            $scope.vc.createViewState({
                id: "VA_VALUEIAMTJBFHDB_811778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORNPRH_26284",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: typePoints
            $scope.vc.createViewState({
                id: "VA_TYPEPOINTSQGJRC_416778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOPUNOS_62324",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEPOINTSQGJRC_416778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'B',
                            value: 'BASE '
                        }, {
                            code: 'E',
                            value: 'EFECTIVA'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_TYPEPOINTSQGJRC_416778");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Rates, Attribute: numberDecimals
            $scope.vc.createViewState({
                id: "VA_NUMBERDECIMALSL_248778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NMDECIMLA_32351",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NUMBERDECIMALSL_248778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '0',
                            value: '0 '
                        }, {
                            code: '1',
                            value: '1 '
                        }, {
                            code: '2',
                            value: '2 '
                        }, {
                            code: '3',
                            value: '3 '
                        }, {
                            code: '4',
                            value: '4 '
                        }, {
                            code: '5',
                            value: '5 '
                        }, {
                            code: '6',
                            value: '6'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_NUMBERDECIMALSL_248778");
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
                id: "Spacer2425",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: portfolioClass
            $scope.vc.createViewState({
                id: "VA_PORTFOLIOCLASSS_404778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLASECAAR_54576",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PORTFOLIOCLASSS_404778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_PORTFOLIOCLASSS_404778', 'cr_clase_cartera', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_PORTFOLIOCLASSS_404778'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_PORTFOLIOCLASSS_404778");
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
            //ViewState - Group: GroupLayout1846
            $scope.vc.createViewState({
                id: "G_RATESMODLL_990778",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1846',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1928
            $scope.vc.createViewState({
                id: "G_RATESMOAAD_646778",
                hasId: true,
                componentStyle: [],
                label: 'Group1928',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_678778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORDEOE_50169",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: signDefault
            $scope.vc.createViewState({
                id: "VA_SIGNMINPDDMQZST_831778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SIGNORIHO_57042",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SIGNMINPDDMQZST_831778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '+',
                            value: '+ '
                        }, {
                            code: '-',
                            value: '- '
                        }, {
                            code: '*',
                            value: '* '
                        }, {
                            code: '/',
                            value: '/'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_SIGNMINPDDMQZST_831778");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Rates, Attribute: valueDeafult
            $scope.vc.createViewState({
                id: "VA_VALUEDEAFULTCGE_547778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORNPRH_26284",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2265",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: lockedDefault
            $scope.vc.createViewState({
                id: "VA_LOCKEDDEFAULTTT_935778",
                componentStyle: [],
                label: '',
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2808
            $scope.vc.createViewState({
                id: "G_RATESMOLAD_413778",
                hasId: true,
                componentStyle: [],
                label: 'Group2808',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_567778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MNIMOQXTO_64583",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: signMin
            $scope.vc.createViewState({
                id: "VA_SIGNMINKUSGFZGN_277778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SIGNORIHO_57042",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SIGNMINKUSGFZGN_277778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '+',
                            value: '+ '
                        }, {
                            code: '-',
                            value: '- '
                        }, {
                            code: '*',
                            value: '* '
                        }, {
                            code: '/',
                            value: '/'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_SIGNMINKUSGFZGN_277778");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Rates, Attribute: valueMin
            $scope.vc.createViewState({
                id: "VA_VALUEMINGCHKTLJ_996778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORNPRH_26284",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2928",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: lockedMin
            $scope.vc.createViewState({
                id: "VA_LOCKEDMINOJZSTC_260778",
                componentStyle: [],
                label: '',
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2756
            $scope.vc.createViewState({
                id: "G_RATESMOADD_409778",
                hasId: true,
                componentStyle: [],
                label: 'Group2756',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_236778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MXIMOWBZU_39119",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: signMax
            $scope.vc.createViewState({
                id: "VA_SIGNMAXCQWMGYQB_195778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SIGNORIHO_57042",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SIGNMAXCQWMGYQB_195778 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '+',
                            value: '+ '
                        }, {
                            code: '-',
                            value: '- '
                        }, {
                            code: '*',
                            value: '* '
                        }, {
                            code: '/',
                            value: '/'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_SIGNMAXCQWMGYQB_195778");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: Rates, Attribute: valueMax
            $scope.vc.createViewState({
                id: "VA_VALUEMAXAXNIZZF_909778",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORNPRH_26284",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2747",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rates, Attribute: lockedMax
            $scope.vc.createViewState({
                id: "VA_LOCKEDMAXEHQUHM_227778",
                componentStyle: [],
                label: '',
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ServerParameter = {
                loanBankID: $scope.vc.channelDefaultValues("ServerParameter", "loanBankID"),
                selectedRow: $scope.vc.channelDefaultValues("ServerParameter", "selectedRow"),
                amount: $scope.vc.channelDefaultValues("ServerParameter", "amount"),
                condonationPercentage: $scope.vc.channelDefaultValues("ServerParameter", "condonationPercentage"),
                flag: $scope.vc.channelDefaultValues("ServerParameter", "flag"),
                refresGridFlag: $scope.vc.channelDefaultValues("ServerParameter", "refresGridFlag"),
                refresGrid2Flag: $scope.vc.channelDefaultValues("ServerParameter", "refresGrid2Flag")
            };
            //ViewState - Group: Group1897
            $scope.vc.createViewState({
                id: "G_RATESMODDL_236778",
                hasId: true,
                componentStyle: [],
                label: 'Group1897',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ServerParameter, Attribute: refresGridFlag
            $scope.vc.createViewState({
                id: "VA_REFRESGRIDFLGAG_672778",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_RATESMODALKUB_953_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_RATESMODALKUB_953_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TRATESMO_TU_",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GUARDARRI_81055",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TRATESMO_AUS",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CANCELARR_70217",
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
                $scope.vc.render('VC_RATESMODAL_789953');
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
    var cobisMainModule = cobis.createModule("VC_RATESMODAL_789953", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_RATESMODAL_789953", {
            templateUrl: "VC_RATESMODAL_789953_FORM.html",
            controller: "VC_RATESMODAL_789953_CTRL",
            label: "RatesModal",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RATESMODAL_789953?" + $.param(search);
            }
        });
        VC_RATESMODAL_789953(cobisMainModule);
    }]);
} else {
    VC_RATESMODAL_789953(cobisMainModule);
}