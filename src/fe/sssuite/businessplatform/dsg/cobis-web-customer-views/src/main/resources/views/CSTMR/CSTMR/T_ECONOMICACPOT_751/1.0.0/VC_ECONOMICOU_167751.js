//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.economicactivitypopupform = designerEvents.api.economicactivitypopupform || designer.dsgEvents();

function VC_ECONOMICOU_167751(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ECONOMICOU_167751_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ECONOMICOU_167751_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ECONOMICACPOT_751",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ECONOMICOU_167751",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_ECONOMICACPOT_751",
        designerEvents.api.economicactivitypopupform,
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
                vcName: 'VC_ECONOMICOU_167751'
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
                    taskId: 'T_ECONOMICACPOT_751',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    EconomicActivity: "EconomicActivity"
                },
                entities: {
                    EconomicActivity: {
                        description: 'AT17_DESCRIPN959',
                        incomeSource: 'AT22_INCOMEUU959',
                        placeAffiliation: 'AT25_PLACEAOF959',
                        gridRow: 'AT28_GRIDROWW959',
                        personSecuential: 'AT35_PERSONAL959',
                        activityStatus: 'AT41_ACTIVISU959',
                        principal: 'AT42_PRINCIPL959',
                        subSector: 'AT47_SUBSECRO959',
                        activitySchedule: 'AT50_ACTIVIHD959',
                        environment: 'AT56_ENVIRONM959',
                        atentionDays: 'AT59_ATENTINN959',
                        personType: 'AT59_PERSONYP959',
                        antiquity: 'AT64_ANTIQUIY959',
                        caedec: 'AT64_CAEDECIK959',
                        sectorDescription: 'AT67_SECTORIS959',
                        attentionSchedule: 'AT71_ATTENTDS959',
                        subActivity: 'AT75_SUBACTVT959',
                        authorized: 'AT80_AUTHOREI959',
                        subSectorDescription: 'AT80_SUBSECPT959',
                        economicActivity: 'AT81_ECONOMTI959',
                        economicSector: 'AT85_ECONOMRT959',
                        verificationDate: 'AT85_VERIFIAT959',
                        affiliate: 'AT86_AFFILIDE959',
                        numberEmployees: 'AT92_NUMBERLP959',
                        secuential: 'AT92_SECUENTI959',
                        verified: 'AT95_VERIFIEE959',
                        verficationSource: 'AT96_VERFICUO959',
                        startdateActivity: 'AT97_ACTIVITD959',
                        propertyType: 'AT99_PROPEREP959',
                        _pks: [],
                        _entityId: 'EN_ECONOMITC_959',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                EconomicActivity: {}
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
                $scope.vc.execute("temporarySave", VC_ECONOMICOU_167751, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_ECONOMICOU_167751, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_ECONOMICOU_167751, data, function() {});
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
            $scope.vc.viewState.VC_ECONOMICOU_167751 = {
                style: []
            }
            $scope.vc.model.EconomicActivity = {
                description: $scope.vc.channelDefaultValues("EconomicActivity", "description"),
                incomeSource: $scope.vc.channelDefaultValues("EconomicActivity", "incomeSource"),
                placeAffiliation: $scope.vc.channelDefaultValues("EconomicActivity", "placeAffiliation"),
                gridRow: $scope.vc.channelDefaultValues("EconomicActivity", "gridRow"),
                personSecuential: $scope.vc.channelDefaultValues("EconomicActivity", "personSecuential"),
                activityStatus: $scope.vc.channelDefaultValues("EconomicActivity", "activityStatus"),
                principal: $scope.vc.channelDefaultValues("EconomicActivity", "principal"),
                subSector: $scope.vc.channelDefaultValues("EconomicActivity", "subSector"),
                activitySchedule: $scope.vc.channelDefaultValues("EconomicActivity", "activitySchedule"),
                environment: $scope.vc.channelDefaultValues("EconomicActivity", "environment"),
                atentionDays: $scope.vc.channelDefaultValues("EconomicActivity", "atentionDays"),
                personType: $scope.vc.channelDefaultValues("EconomicActivity", "personType"),
                antiquity: $scope.vc.channelDefaultValues("EconomicActivity", "antiquity"),
                caedec: $scope.vc.channelDefaultValues("EconomicActivity", "caedec"),
                sectorDescription: $scope.vc.channelDefaultValues("EconomicActivity", "sectorDescription"),
                attentionSchedule: $scope.vc.channelDefaultValues("EconomicActivity", "attentionSchedule"),
                subActivity: $scope.vc.channelDefaultValues("EconomicActivity", "subActivity"),
                authorized: $scope.vc.channelDefaultValues("EconomicActivity", "authorized"),
                subSectorDescription: $scope.vc.channelDefaultValues("EconomicActivity", "subSectorDescription"),
                economicActivity: $scope.vc.channelDefaultValues("EconomicActivity", "economicActivity"),
                economicSector: $scope.vc.channelDefaultValues("EconomicActivity", "economicSector"),
                verificationDate: $scope.vc.channelDefaultValues("EconomicActivity", "verificationDate"),
                affiliate: $scope.vc.channelDefaultValues("EconomicActivity", "affiliate"),
                numberEmployees: $scope.vc.channelDefaultValues("EconomicActivity", "numberEmployees"),
                secuential: $scope.vc.channelDefaultValues("EconomicActivity", "secuential"),
                verified: $scope.vc.channelDefaultValues("EconomicActivity", "verified"),
                verficationSource: $scope.vc.channelDefaultValues("EconomicActivity", "verficationSource"),
                startdateActivity: $scope.vc.channelDefaultValues("EconomicActivity", "startdateActivity"),
                propertyType: $scope.vc.channelDefaultValues("EconomicActivity", "propertyType")
            };
            //ViewState - Group: Group1102
            $scope.vc.createViewState({
                id: "G_ECONOMIPVU_691887",
                hasId: true,
                componentStyle: [],
                label: 'Group1102',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicActivity, Attribute: secuential
            $scope.vc.createViewState({
                id: "VA_SECUENTIALWARUP_426887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SECUENCIA_67555",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicActivity, Attribute: economicSector
            $scope.vc.createViewState({
                id: "VA_ECONOMICSECTORO_655887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CATEGORAA_50169",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ECONOMICSECTORO_655887 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ECONOMICSECTORO_655887', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ECONOMICSECTORO_655887'];
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
            //ViewState - Entity: EconomicActivity, Attribute: subSector
            $scope.vc.createViewState({
                id: "VA_SUBSECTORFKJIRP_876887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SUBCATERA_27708",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SUBSECTORFKJIRP_876887 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_SUBSECTORFKJIRP_876887', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_SUBSECTORFKJIRP_876887'];
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
            //ViewState - Entity: EconomicActivity, Attribute: economicActivity
            $scope.vc.createViewState({
                id: "VA_ECONOMICACTIYTT_504887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ACTIVIDDD_94041",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ECONOMICACTIYTT_504887 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ECONOMICACTIYTT_504887', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ECONOMICACTIYTT_504887'];
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
            //ViewState - Entity: EconomicActivity, Attribute: description
            $scope.vc.createViewState({
                id: "VA_DESCRIPTIONGSVS_438887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DESCRIPIC_16557",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicActivity, Attribute: principal
            $scope.vc.createViewState({
                id: "VA_PRINCIPALJAQWIU_928887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRINCIPLL_85415",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PRINCIPALJAQWIU_928887 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI '
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_PRINCIPALJAQWIU_928887");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: EconomicActivity, Attribute: antiquity
            $scope.vc.createViewState({
                id: "VA_ANTIQUITYAOXEZY_723887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ANTIGEDDD_59143",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: EconomicActivity, Attribute: numberEmployees
            $scope.vc.createViewState({
                id: "VA_NUMBEREMPLOYEEE_936887",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODEAL_38122",
                format: "n0",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ECONOMICACPOT_751_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ECONOMICACPOT_751_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TECONOMI_RSP",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ACEPTARZF_98506",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TECONOMI_2A8",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CANCELARR_82087",
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
                $scope.vc.render('VC_ECONOMICOU_167751');
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
    var cobisMainModule = cobis.createModule("VC_ECONOMICOU_167751", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_ECONOMICOU_167751", {
            templateUrl: "VC_ECONOMICOU_167751_FORM.html",
            controller: "VC_ECONOMICOU_167751_CTRL",
            labelId: "CSTMR.LBL_CSTMR_ACTIVIDAA_39121",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ECONOMICOU_167751?" + $.param(search);
            }
        });
        VC_ECONOMICOU_167751(cobisMainModule);
    }]);
} else {
    VC_ECONOMICOU_167751(cobisMainModule);
}