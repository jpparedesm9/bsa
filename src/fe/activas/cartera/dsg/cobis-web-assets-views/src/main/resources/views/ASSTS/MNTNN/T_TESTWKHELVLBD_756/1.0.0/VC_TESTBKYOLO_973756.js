//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.projectothercharges = designerEvents.api.projectothercharges || designer.dsgEvents();

function VC_TESTBKYOLO_973756(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TESTBKYOLO_973756_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TESTBKYOLO_973756_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_TESTWKHELVLBD_756",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TESTBKYOLO_973756",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_TESTWKHELVLBD_756",
        designerEvents.api.projectothercharges,
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
                vcName: 'VC_TESTBKYOLO_973756'
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
                    taskId: 'T_TESTWKHELVLBD_756',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    OtherCharges: "OtherCharges"
                },
                entities: {
                    OtherCharges: {
                        sequential: 'AT21_SECUENCL824',
                        iniDiv: 'AT93_DIVINIAI824',
                        divUp: 'AT46_DIVFINAA824',
                        date: 'AT48_FECHAXAR824',
                        concept: 'AT57_CONCEPTO824',
                        value: 'AT67_VALORAAB824',
                        commentary: 'AT94_REFEREAA824',
                        categoryType: 'AT72_CATEGORE824',
                        valueApply: 'AT24_VALUEALY824',
                        reference: 'AT93_REFERENE824',
                        valueMin: 'AT26_VALUEMIN824',
                        valueMax: 'AT58_VALUEMXX824',
                        baseCalculation: 'AT70_BASECATL824',
                        balanceOp: 'AT43_BALANCEP824',
                        balanceDesemp: 'AT46_BALANCSP824',
                        rate: 'AT65_RATEKOZZ824',
                        decTapl: 'AT71_DECTAPLL824',
                        range: 'AT32_RANGEVRU824',
                        _pks: [],
                        _entityId: 'EN_INGOTRCSA_824',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                OtherCharges: {}
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
                $scope.vc.execute("temporarySave", VC_TESTBKYOLO_973756, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_TESTBKYOLO_973756, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_TESTBKYOLO_973756, data, function() {});
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
            $scope.vc.viewState.VC_TESTBKYOLO_973756 = {
                style: []
            }
            $scope.vc.model.OtherCharges = {
                sequential: $scope.vc.channelDefaultValues("OtherCharges", "sequential"),
                iniDiv: $scope.vc.channelDefaultValues("OtherCharges", "iniDiv"),
                divUp: $scope.vc.channelDefaultValues("OtherCharges", "divUp"),
                date: $scope.vc.channelDefaultValues("OtherCharges", "date"),
                concept: $scope.vc.channelDefaultValues("OtherCharges", "concept"),
                value: $scope.vc.channelDefaultValues("OtherCharges", "value"),
                commentary: $scope.vc.channelDefaultValues("OtherCharges", "commentary"),
                categoryType: $scope.vc.channelDefaultValues("OtherCharges", "categoryType"),
                valueApply: $scope.vc.channelDefaultValues("OtherCharges", "valueApply"),
                reference: $scope.vc.channelDefaultValues("OtherCharges", "reference"),
                valueMin: $scope.vc.channelDefaultValues("OtherCharges", "valueMin"),
                valueMax: $scope.vc.channelDefaultValues("OtherCharges", "valueMax"),
                baseCalculation: $scope.vc.channelDefaultValues("OtherCharges", "baseCalculation"),
                balanceOp: $scope.vc.channelDefaultValues("OtherCharges", "balanceOp"),
                balanceDesemp: $scope.vc.channelDefaultValues("OtherCharges", "balanceDesemp"),
                rate: $scope.vc.channelDefaultValues("OtherCharges", "rate"),
                decTapl: $scope.vc.channelDefaultValues("OtherCharges", "decTapl"),
                range: $scope.vc.channelDefaultValues("OtherCharges", "range")
            };
            //ViewState - Group: Group1800
            $scope.vc.createViewState({
                id: "G_TESTEKYAAK_356872",
                hasId: true,
                componentStyle: ["padding-label-inf"],
                label: 'Group1800',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: concept
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXUFN_810872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONCEPTOO_29972",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXUFN_810872 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXUFN_810872', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXUFN_810872'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXUFN_810872");
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
            //ViewState - Group: Group2435
            $scope.vc.createViewState({
                id: "G_TESTCYDRBD_191872",
                hasId: true,
                componentStyle: [],
                label: 'Group2435',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITEXPWV_130872",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: categoryType
            $scope.vc.createViewState({
                id: "VA_CATEGORYTYPEOYS_156872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPORUBOR_75950",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: valueApply
            $scope.vc.createViewState({
                id: "VA_VALUEAPPLYTRDBF_557872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORAAAC_43152",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: reference
            $scope.vc.createViewState({
                id: "VA_REFERENCEXBMXWK_229872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REFERENCC_20812",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2508
            $scope.vc.createViewState({
                id: "G_TESTPOYFCM_952872",
                hasId: true,
                componentStyle: [],
                label: 'Group2508',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: baseCalculation
            $scope.vc.createViewState({
                id: "VA_BASECALCULATONI_509872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BASECLCLU_56377",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: iniDiv
            $scope.vc.createViewState({
                id: "VA_INIDIVGJKPNKHJF_695872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUOTADESD_67554",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: divUp
            $scope.vc.createViewState({
                id: "VA_DIVUPQPVWWEQDNI_233872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUOTAHAAS_11841",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2828
            $scope.vc.createViewState({
                id: "G_TESTASOELG_345872",
                hasId: true,
                componentStyle: [],
                label: 'Group2828',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: value
            $scope.vc.createViewState({
                id: "VA_2011UKZSBSFRWRA_245872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORGGEY_80898",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: commentary
            $scope.vc.createViewState({
                id: "VA_COMMENTARYRPSHX_258872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_COMENTAOO_63544",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2294
            $scope.vc.createViewState({
                id: "G_TESTLECLOB_879872",
                hasId: true,
                componentStyle: [],
                label: 'Group2294',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OtherCharges, Attribute: range
            $scope.vc.createViewState({
                id: "VA_RANGEQFHSDDUABD_909872",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RANGOHORR_73584",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_TESTWKHELVLBD_756_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_TESTWKHELVLBD_756_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TTESTWKH_NN5",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GUARDARRI_81055",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TTESTWKH_T57",
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
                $scope.vc.render('VC_TESTBKYOLO_973756');
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
    var cobisMainModule = cobis.createModule("VC_TESTBKYOLO_973756", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_TESTBKYOLO_973756", {
            templateUrl: "VC_TESTBKYOLO_973756_FORM.html",
            controller: "VC_TESTBKYOLO_973756_CTRL",
            label: "Test",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TESTBKYOLO_973756?" + $.param(search);
            }
        });
        VC_TESTBKYOLO_973756(cobisMainModule);
    }]);
} else {
    VC_TESTBKYOLO_973756(cobisMainModule);
}