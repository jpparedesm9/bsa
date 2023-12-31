//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.manualconciliation = designerEvents.api.manualconciliation || designer.dsgEvents();

function VC_MANUALCOLT_571678(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MANUALCOLT_571678_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MANUALCOLT_571678_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSODKKUGLX_678",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MANUALCOLT_571678",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_ASSTSODKKUGLX_678",
        designerEvents.api.manualconciliation,
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
                vcName: 'VC_MANUALCOLT_571678'
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
                    taskId: 'T_ASSTSODKKUGLX_678',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ConciliationSearch: "ConciliationSearch"
                },
                entities: {
                    ConciliationSearch: {
                        customerCode: 'AT11_CUSTOMEO147',
                        reference: 'AT18_REFERECC147',
                        amount: 'AT25_AMOUNTZD147',
                        dateUntil: 'AT37_DATEUNLT147',
                        paymentState: 'AT40_ESTADOSM147',
                        type: 'AT45_TYPEKPEI147',
                        conciliate: 'AT47_CONCILAA147',
                        paymentReceiptDate: 'AT51_PAYMENCE147',
                        notConciliationReason: 'AT54_CONCILIA147',
                        conciliationDate: 'AT56_CONCILAT147',
                        paymentReceiptAmount: 'AT56_PAYMENAP147',
                        conciliationStatus: 'AT58_CONCILST147',
                        dateFrom: 'AT66_DATEFRMM147',
                        uploadConciliationFileDate: 'AT66_UPLOADTN147',
                        observation: 'AT74_OBSERVTI147',
                        conciliationUser: 'AT80_CONCILAE147',
                        operation: 'AT92_OPERATNN147',
                        amountReportedInFile: 'AT93_AMOUNTER147',
                        customerName: 'AT95_CUSTOMEE147',
                        _pks: [],
                        _entityId: 'EN_CONCILICC_147',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                ConciliationSearch: {}
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
                $scope.vc.execute("temporarySave", VC_MANUALCOLT_571678, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MANUALCOLT_571678, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MANUALCOLT_571678, data, function() {});
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
            $scope.vc.viewState.VC_MANUALCOLT_571678 = {
                style: []
            }
            //ViewState - Group: GroupLayout1628
            $scope.vc.createViewState({
                id: "G_MANUALCNNO_948939",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1628',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ConciliationSearch = {
                customerCode: $scope.vc.channelDefaultValues("ConciliationSearch", "customerCode"),
                reference: $scope.vc.channelDefaultValues("ConciliationSearch", "reference"),
                amount: $scope.vc.channelDefaultValues("ConciliationSearch", "amount"),
                dateUntil: $scope.vc.channelDefaultValues("ConciliationSearch", "dateUntil"),
                paymentState: $scope.vc.channelDefaultValues("ConciliationSearch", "paymentState"),
                type: $scope.vc.channelDefaultValues("ConciliationSearch", "type"),
                conciliate: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliate"),
                paymentReceiptDate: $scope.vc.channelDefaultValues("ConciliationSearch", "paymentReceiptDate"),
                notConciliationReason: $scope.vc.channelDefaultValues("ConciliationSearch", "notConciliationReason"),
                conciliationDate: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliationDate"),
                paymentReceiptAmount: $scope.vc.channelDefaultValues("ConciliationSearch", "paymentReceiptAmount"),
                conciliationStatus: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliationStatus"),
                dateFrom: $scope.vc.channelDefaultValues("ConciliationSearch", "dateFrom"),
                uploadConciliationFileDate: $scope.vc.channelDefaultValues("ConciliationSearch", "uploadConciliationFileDate"),
                observation: $scope.vc.channelDefaultValues("ConciliationSearch", "observation"),
                conciliationUser: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliationUser"),
                operation: $scope.vc.channelDefaultValues("ConciliationSearch", "operation"),
                amountReportedInFile: $scope.vc.channelDefaultValues("ConciliationSearch", "amountReportedInFile"),
                customerName: $scope.vc.channelDefaultValues("ConciliationSearch", "customerName")
            };
            //ViewState - Group: Group1114
            $scope.vc.createViewState({
                id: "G_MANUALCLIC_609939",
                hasId: true,
                componentStyle: [],
                label: 'Group1114',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: type
            $scope.vc.createViewState({
                id: "VA_TYPEJRKMHPCUARK_310939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOLDSKB_46090",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEJRKMHPCUARK_310939 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPEJRKMHPCUARK_310939', 'ca_tipo_pago', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPEJRKMHPCUARK_310939'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TYPEJRKMHPCUARK_310939");
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
            //ViewState - Entity: ConciliationSearch, Attribute: customerName
            $scope.vc.createViewState({
                id: "VA_CUSTOMERNAMEWZK_347939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NOMBREDLE_56666",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: paymentReceiptDate
            $scope.vc.createViewState({
                id: "VA_PAYMENTRECEITDT_688939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAREPI_32477",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: paymentReceiptAmount
            $scope.vc.createViewState({
                id: "VA_PAYMENTRECEIAUO_271939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORDELO_59378",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: conciliate
            $scope.vc.createViewState({
                id: "VA_CONCILIATERMJGF_837939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONCILIOA_81081",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: notConciliationReason
            $scope.vc.createViewState({
                id: "VA_NOTCONCILIATOAN_739939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RAZNNOCLN_35399",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NOTCONCILIATOAN_739939 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NOTCONCILIATOAN_739939', 'ca_razon_no_conciliacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NOTCONCILIATOAN_739939'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NOTCONCILIATOAN_739939");
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
            //ViewState - Entity: ConciliationSearch, Attribute: conciliationDate
            $scope.vc.createViewState({
                id: "VA_CONCILIATIONTDT_618939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHACOCI_65892",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: conciliationUser
            $scope.vc.createViewState({
                id: "VA_CONCILIATIONRRR_922939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_USUARIOCC_49645",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearch, Attribute: observation
            $scope.vc.createViewState({
                id: "VA_OBSERVATIONHGGT_420939",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OBSERVACI_90665",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSODKKUGLX_678_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSODKKUGLX_678_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TASSTSOD_AT8",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REGISTRAA_30892",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TASSTSOD_S4X",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALIRVFSG_51278",
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
                $scope.vc.render('VC_MANUALCOLT_571678');
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
    var cobisMainModule = cobis.createModule("VC_MANUALCOLT_571678", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_MANUALCOLT_571678", {
            templateUrl: "VC_MANUALCOLT_571678_FORM.html",
            controller: "VC_MANUALCOLT_571678_CTRL",
            labelId: "ASSTS.LBL_ASSTS_CONCILINA_99171",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MANUALCOLT_571678?" + $.param(search);
            }
        });
        VC_MANUALCOLT_571678(cobisMainModule);
    }]);
} else {
    VC_MANUALCOLT_571678(cobisMainModule);
}