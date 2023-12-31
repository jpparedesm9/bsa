//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.generalbusinessdata = designerEvents.api.generalbusinessdata || designer.dsgEvents();

function VC_GENERALBSI_401479(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GENERALBSI_401479_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GENERALBSI_401479_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BSSNS",
            subModuleId: "CSTMR",
            taskId: "T_BSSNSKNPPLXIB_479",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GENERALBSI_401479",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/BSSNS/CSTMR/T_BSSNSKNPPLXIB_479",
        designerEvents.api.generalbusinessdata,
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
                vcName: 'VC_GENERALBSI_401479'
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
                    moduleId: 'BSSNS',
                    subModuleId: 'CSTMR',
                    taskId: 'T_BSSNSKNPPLXIB_479',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Customer: "Customer"
                },
                entities: {
                    Customer: {
                        customerSecondName: 'AT18_CUSTOMDM368',
                        customerId: 'AT21_CUSTOMRR368',
                        customerName: 'AT34_CUSTOMRM368',
                        official: 'AT34_OFFICIAL368',
                        gender: 'AT38_GENDERLN368',
                        customerLastName: 'AT40_CUSTOMEA368',
                        identificationType: 'AT46_IDENTICI368',
                        nationalityCountry: 'AT46_NATIONCL368',
                        santanderCode: 'AT49_SANTANDC368',
                        customerIdentification: 'AT50_CUSTOMFE368',
                        officialDescription: 'AT51_OFFICITI368',
                        processInstance: 'AT54_PROCESEN368',
                        customerMaritalStatus: 'AT56_CUSTOMTS368',
                        customerFullName: 'AT64_CUSTOMLL368',
                        customerSecondLastName: 'AT70_CUSTOMSM368',
                        nationalityDescription: 'AT73_NATIONIY368',
                        _pks: [],
                        _entityId: 'EN_CUSTOMERR_368',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Customer: {}
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
                $scope.vc.execute("temporarySave", VC_GENERALBSI_401479, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GENERALBSI_401479, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GENERALBSI_401479, data, function() {});
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
            $scope.vc.viewState.VC_GENERALBSI_401479 = {
                style: []
            }
            //ViewState - Group: Group1349
            $scope.vc.createViewState({
                id: "G_GENERALSSA_700568",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1349',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_GENERALSSA_700568-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1472
            $scope.vc.createViewState({
                id: "G_GENERALUSS_474568",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1472',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_GENERALUSS_474568-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Customer = {
                customerSecondName: $scope.vc.channelDefaultValues("Customer", "customerSecondName"),
                customerId: $scope.vc.channelDefaultValues("Customer", "customerId"),
                customerName: $scope.vc.channelDefaultValues("Customer", "customerName"),
                official: $scope.vc.channelDefaultValues("Customer", "official"),
                gender: $scope.vc.channelDefaultValues("Customer", "gender"),
                customerLastName: $scope.vc.channelDefaultValues("Customer", "customerLastName"),
                identificationType: $scope.vc.channelDefaultValues("Customer", "identificationType"),
                nationalityCountry: $scope.vc.channelDefaultValues("Customer", "nationalityCountry"),
                santanderCode: $scope.vc.channelDefaultValues("Customer", "santanderCode"),
                customerIdentification: $scope.vc.channelDefaultValues("Customer", "customerIdentification"),
                officialDescription: $scope.vc.channelDefaultValues("Customer", "officialDescription"),
                processInstance: $scope.vc.channelDefaultValues("Customer", "processInstance"),
                customerMaritalStatus: $scope.vc.channelDefaultValues("Customer", "customerMaritalStatus"),
                customerFullName: $scope.vc.channelDefaultValues("Customer", "customerFullName"),
                customerSecondLastName: $scope.vc.channelDefaultValues("Customer", "customerSecondLastName"),
                nationalityDescription: $scope.vc.channelDefaultValues("Customer", "nationalityDescription")
            };
            //ViewState - Group: Group1366
            $scope.vc.createViewState({
                id: "G_GENERALUUS_939568",
                hasId: true,
                componentStyle: [],
                label: 'Group1366',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1609",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BSSNSKNPPLXIB_479_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BSSNSKNPPLXIB_479_CANCEL",
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
                $scope.vc.render('VC_GENERALBSI_401479');
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
    var cobisMainModule = cobis.createModule("VC_GENERALBSI_401479", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BSSNS"]);
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
        $routeProvider.when("/VC_GENERALBSI_401479", {
            templateUrl: "VC_GENERALBSI_401479_FORM.html",
            controller: "VC_GENERALBSI_401479_CTRL",
            label: "GeneralBusinessData",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BSSNS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GENERALBSI_401479?" + $.param(search);
            }
        });
        VC_GENERALBSI_401479(cobisMainModule);
    }]);
} else {
    VC_GENERALBSI_401479(cobisMainModule);
}