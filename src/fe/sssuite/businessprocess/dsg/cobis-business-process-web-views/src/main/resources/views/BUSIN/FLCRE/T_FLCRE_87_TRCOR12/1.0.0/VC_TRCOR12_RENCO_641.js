<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskrevenuecustomer = designerEvents.api.taskrevenuecustomer || designer.dsgEvents();

function VC_TRCOR12_RENCO_641(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TRCOR12_RENCO_641_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TRCOR12_RENCO_641_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)
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
            taskId: "T_FLCRE_87_TRCOR12",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TRCOR12_RENCO_641",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_87_TRCOR12",
        designerEvents.api.taskrevenuecustomer,
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
                vcName: 'VC_TRCOR12_RENCO_641'
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
                    taskId: 'T_FLCRE_87_TRCOR12',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    SourceRevenueCustomer: "SourceRevenueCustomer"
                },
                entities: {
                    SourceRevenueCustomer: {
                        Type: 'AT_RER755TYPE77',
                        Sector: 'AT_RER755SCOR68',
                        SubSector: 'AT_RER755STOR39',
                        EconomicActivity: 'AT_RER755OCIT66',
                        ExplanationActivity: 'AT_RER755ENTY85',
                        CodeFIE: 'AT_RER755IECO72',
                        SourceFinancing: 'AT_RER755SORN75',
                        Rol: 'AT_RER755ROLU15',
                        IdClient: 'AT_RER755DCLN75',
                        Clarification: 'AT_RER755LRIN62',
                        descriptionActivity: 'AT_RER755ATVY95',
                        _pks: [],
                        _entityId: 'EN_RERUCUTOR755',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            defaultValues = {
                SourceRevenueCustomer: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (en in defaultValues) {
                    if (en == entityName) {
                        for (att in defaultValues[en]) {
                            if (att == attributeName) {
                                for (ch in defaultValues[en][att]) {
                                    if (ch == channel) {
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
            }
            $scope.vc.executeCRUDQuery = function(queryId, loadInModel) {
                var queryRequest = $scope.vc.request.qr[queryId];
                return $scope.vc.CRUDExecuteQueryId(queryRequest, loadInModel);
            }
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                }
                $scope.vc.execute("temporarySave", null, data, function(response) {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    console.log("readTemporaryData");
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    }
                    return $scope.vc.executeService("readTemporaryData", null, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", null, data, function(response) {});
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
            $scope.vc.viewState.VC_TRCOR12_RENCO_641 = {
                style: []
            }
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VENUECUSOE18_04",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.SourceRevenueCustomer = {
                Type: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Type"),
                Sector: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Sector"),
                SubSector: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "SubSector"),
                EconomicActivity: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "EconomicActivity"),
                ExplanationActivity: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "ExplanationActivity"),
                CodeFIE: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "CodeFIE"),
                SourceFinancing: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "SourceFinancing"),
                Rol: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Rol"),
                IdClient: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "IdClient"),
                Clarification: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Clarification"),
                descriptionActivity: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "descriptionActivity")
            };
            //ViewState - Group: [Grupo Controles]
            $scope.vc.createViewState({
                id: "GR_VENUECUSOE18_05",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Controles]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: Type
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_TYPE982",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIPOXAASN_24763",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VENUECUSOE1805_TYPE982 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '1',
                            value: 'PRINCIPAL'
                        }, {
                            code: '2',
                            value: 'SECUNDARIO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_VENUECUSOE1805_TYPE982");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_SCOR033",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ECORCIVDA_03835",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VENUECUSOE1805_SCOR033 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
                        $scope.vc.setComboBoxDefaultValue("VA_VENUECUSOE1805_SCOR033");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: SubSector
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_STOR785",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SSECTCTID_26184",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VENUECUSOE1805_STOR785 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
                        $scope.vc.setComboBoxDefaultValue("VA_VENUECUSOE1805_STOR785");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: EconomicActivity
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_OCIT805",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIVDECOIA_60481",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VENUECUSOE1805_OCIT805 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
                        $scope.vc.setComboBoxDefaultValue("VA_VENUECUSOE1805_OCIT805");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: ExplanationActivity
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_ENTY317",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AAITIVIDA_62459",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: CodeFIE
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_IECO664",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CDIGOFIEY_30089",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: SourceFinancing
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1805_SORN426",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FETEFIMIO_08044",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Botones]
            $scope.vc.createViewState({
                id: "GR_VENUECUSOE18_06",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Botones]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: SourceFinancing
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1806_SORN079",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SourceRevenueCustomer, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_VENUECUSOE1806_SCOR060",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_87_TRCOR12_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_87_TRCOR12_CANCEL",
                componentStyle: "",
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
                $scope.vc.render('VC_TRCOR12_RENCO_641');
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
    var cobisMainModule = cobis.createModule("VC_TRCOR12_RENCO_641", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_TRCOR12_RENCO_641", {
            templateUrl: "VC_TRCOR12_RENCO_641_FORM.html",
            controller: "VC_TRCOR12_RENCO_641_CTRL",
            label: " FormRevenueCustomer",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TRCOR12_RENCO_641?" + $.param(search);
            }
        });
        VC_TRCOR12_RENCO_641(cobisMainModule);
    }]);
} else {
    VC_TRCOR12_RENCO_641(cobisMainModule);
}