//Designer Generator v 6.1.1 - release SPR 2017-03 17/02/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.liberation = designerEvents.api.liberation || designer.dsgEvents();

function VC_LIBERATINO_737422(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LIBERATINO_737422_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LIBERATINO_737422_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            moduleId: "WRRNT",
            subModuleId: "MNTNN",
            taskId: "T_LIBERATIONIFY_422",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LIBERATINO_737422",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/WRRNT/MNTNN/T_LIBERATIONIFY_422",
        designerEvents.api.liberation,
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
                vcName: 'VC_LIBERATINO_737422'
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
                    moduleId: 'WRRNT',
                    subModuleId: 'MNTNN',
                    taskId: 'T_LIBERATIONIFY_422',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    GenericTransaction: "GenericTransaction",
                    Warranty: "Warranty"
                },
                entities: {
                    GenericTransaction: {
                        cause: 'AT52_CAUSESUB648',
                        attribute8486: 'AT8487_8486FCVC648',
                        newValue: 'AT91_NEWVALEE648',
                        _pks: [],
                        _entityId: 'EN_1IFLNNCYO_648',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Warranty: {
                        shareValue: 'AT17_SHAREVUA755',
                        percent: 'AT29_PERCENTT755',
                        coverageValue: 'AT37_COVERAAE755',
                        newCommercialValue: 'AT50_NEWCOMCR755',
                        office: 'AT60_OFFICEPH755',
                        sharesNumber: 'AT71_SHARESBE755',
                        value: 'AT76_VALUETCE755',
                        externalCode: 'AT80_EXTERNLE755',
                        type: 'AT94_TYPEJJLR755',
                        custody: 'AT97_CUSTODYY755',
                        _pks: [],
                        _entityId: 'EN_WARRANTYY_755',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                GenericTransaction: {},
                Warranty: {}
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
                $scope.vc.execute("temporarySave", VC_LIBERATINO_737422, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LIBERATINO_737422, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LIBERATINO_737422, data, function() {});
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
            $scope.vc.viewState.VC_LIBERATINO_737422 = {
                style: []
            }
            //ViewState - Group: GroupLayout2277
            $scope.vc.createViewState({
                id: "G_LIBERATNIN_236804",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2277',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GenericTransaction = {
                cause: $scope.vc.channelDefaultValues("GenericTransaction", "cause"),
                attribute8486: $scope.vc.channelDefaultValues("GenericTransaction", "attribute8486"),
                newValue: $scope.vc.channelDefaultValues("GenericTransaction", "newValue")
            };
            //ViewState - Group: Group2210
            $scope.vc.createViewState({
                id: "G_LIBERATONN_305804",
                hasId: true,
                componentStyle: [],
                label: 'Group2210',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GenericTransaction, Attribute: cause
            $scope.vc.createViewState({
                id: "VA_CAUSETEEYTZREUC_871804",
                componentStyle: [],
                label: "WRRNT.LBL_WRRNT_MOTIVOUHD_26088",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LIBERATIONIFY_422_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LIBERATIONIFY_422_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TLIBERAT_T16",
                componentStyle: [],
                label: "WRRNT.LBL_WRRNT_ACEPTARHL_31841",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TLIBERAT_1TL",
                componentStyle: [],
                label: "WRRNT.LBL_WRRNT_CANCELARR_91565",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Warranty = {
                shareValue: $scope.vc.channelDefaultValues("Warranty", "shareValue"),
                percent: $scope.vc.channelDefaultValues("Warranty", "percent"),
                coverageValue: $scope.vc.channelDefaultValues("Warranty", "coverageValue"),
                newCommercialValue: $scope.vc.channelDefaultValues("Warranty", "newCommercialValue"),
                office: $scope.vc.channelDefaultValues("Warranty", "office"),
                sharesNumber: $scope.vc.channelDefaultValues("Warranty", "sharesNumber"),
                value: $scope.vc.channelDefaultValues("Warranty", "value"),
                externalCode: $scope.vc.channelDefaultValues("Warranty", "externalCode"),
                type: $scope.vc.channelDefaultValues("Warranty", "type"),
                custody: $scope.vc.channelDefaultValues("Warranty", "custody")
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
                $scope.vc.render('VC_LIBERATINO_737422');
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
    var cobisMainModule = cobis.createModule("VC_LIBERATINO_737422", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "WRRNT"]);
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
        $routeProvider.when("/VC_LIBERATINO_737422", {
            templateUrl: "VC_LIBERATINO_737422_FORM.html",
            controller: "VC_LIBERATINO_737422_CTRL",
            labelId: "WRRNT.LBL_WRRNT_LIBERACIN_97447",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('WRRNT');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LIBERATINO_737422?" + $.param(search);
            }
        });
        VC_LIBERATINO_737422(cobisMainModule);
    }]);
} else {
    VC_LIBERATINO_737422(cobisMainModule);
}