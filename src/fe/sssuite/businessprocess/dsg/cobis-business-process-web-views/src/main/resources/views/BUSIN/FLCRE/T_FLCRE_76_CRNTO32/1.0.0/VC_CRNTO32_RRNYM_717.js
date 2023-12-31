<!-- Designer Generator v 6.0.0 - release SPR 2016-16 19/08/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.policywarrantycreation = designerEvents.api.policywarrantycreation || designer.dsgEvents();

function VC_CRNTO32_RRNYM_717(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CRNTO32_RRNYM_717_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CRNTO32_RRNYM_717_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_76_CRNTO32",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CRNTO32_RRNYM_717",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_76_CRNTO32",
        designerEvents.api.policywarrantycreation,
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
                vcName: 'VC_CRNTO32_RRNYM_717'
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
                    taskId: 'T_FLCRE_76_CRNTO32',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    WarrantyPoliciy: "WarrantyPoliciy"
                },
                entities: {
                    WarrantyPoliciy: {
                        numberPolicy: 'AT_WRA629UEIC78',
                        insurance: 'AT_WRA629NSNE69',
                        type: 'AT_WRA629TYPE21',
                        description: 'AT_WRA629ERII42',
                        effectiveDate: 'AT_WRA629FTVD85',
                        effectiveDateEnd: 'AT_WRA629FCVN12',
                        endorsementDate: 'AT_WRA629EDRT46',
                        endorsementDateEnd: 'AT_WRA629REMN20',
                        coin: 'AT_WRA629COIN39',
                        policyValue: 'AT_WRA629POLI06',
                        endorsementValue: 'AT_WRA629DSTL03',
                        state: 'AT_WRA629STTE04',
                        custody: 'AT_WRA629CSTD36',
                        branchOffice: 'AT_WRA629AHOI94',
                        custodyType: 'AT_WRA629CUSD60',
                        externalCode: 'AT_WRA629RNAO54',
                        isNew: 'AT_WRA629ISNE61',
                        insuranceDescription: 'AT_WRA629EERN75',
                        _pks: [],
                        _entityId: 'EN_WRANTYPIY629',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            defaultValues = {
                WarrantyPoliciy: {}
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
            $scope.vc.viewState.VC_CRNTO32_RRNYM_717 = {
                style: []
            }
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_WARNTYPOIY77_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLIZAMMVK_53577",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.WarrantyPoliciy = {
                numberPolicy: $scope.vc.channelDefaultValues("WarrantyPoliciy", "numberPolicy"),
                insurance: $scope.vc.channelDefaultValues("WarrantyPoliciy", "insurance"),
                type: $scope.vc.channelDefaultValues("WarrantyPoliciy", "type"),
                description: $scope.vc.channelDefaultValues("WarrantyPoliciy", "description"),
                effectiveDate: $scope.vc.channelDefaultValues("WarrantyPoliciy", "effectiveDate"),
                effectiveDateEnd: $scope.vc.channelDefaultValues("WarrantyPoliciy", "effectiveDateEnd"),
                endorsementDate: $scope.vc.channelDefaultValues("WarrantyPoliciy", "endorsementDate"),
                endorsementDateEnd: $scope.vc.channelDefaultValues("WarrantyPoliciy", "endorsementDateEnd"),
                coin: $scope.vc.channelDefaultValues("WarrantyPoliciy", "coin"),
                policyValue: $scope.vc.channelDefaultValues("WarrantyPoliciy", "policyValue"),
                endorsementValue: $scope.vc.channelDefaultValues("WarrantyPoliciy", "endorsementValue"),
                state: $scope.vc.channelDefaultValues("WarrantyPoliciy", "state"),
                custody: $scope.vc.channelDefaultValues("WarrantyPoliciy", "custody"),
                branchOffice: $scope.vc.channelDefaultValues("WarrantyPoliciy", "branchOffice"),
                custodyType: $scope.vc.channelDefaultValues("WarrantyPoliciy", "custodyType"),
                externalCode: $scope.vc.channelDefaultValues("WarrantyPoliciy", "externalCode"),
                isNew: $scope.vc.channelDefaultValues("WarrantyPoliciy", "isNew"),
                insuranceDescription: $scope.vc.channelDefaultValues("WarrantyPoliciy", "insuranceDescription")
            };
            //ViewState - Group: Grupo para WarrantyPoliciy
            $scope.vc.createViewState({
                id: "GR_WARNTYPOIY77_06",
                hasId: true,
                componentStyle: "",
                label: 'Grupo para WarrantyPoliciy',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: numberPolicy
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_UEIC804",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OLCYNUMBE_44906",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: insurance
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_NSNE946",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASEGURAOA_80576",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WARNTYPOIY7706_NSNE946 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WARNTYPOIY7706_NSNE946', 'cu_des_aseguradora', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WARNTYPOIY7706_NSNE946'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WARNTYPOIY7706_NSNE946");
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
            //ViewState - Entity: WarrantyPoliciy, Attribute: type
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_TYPE722",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TYPEYLJIK_10770",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WARNTYPOIY7706_TYPE722 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WARNTYPOIY7706_TYPE722', 'cu_cob_poliza', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WARNTYPOIY7706_TYPE722'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WARNTYPOIY7706_TYPE722");
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
            //ViewState - Entity: WarrantyPoliciy, Attribute: description
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_ERII912",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DESCRIPCN_50497",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: effectiveDate
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_FTVD738",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_HEVGENCIA_90594",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: effectiveDateEnd
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_FCVN828",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FECADVIGE_91215",
                validationCode: 36,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: endorsementDate
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_EDRT336",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EAEVIENCI_72543",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: endorsementDateEnd
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_REMN585",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FECFINDSO_45630",
                validationCode: 36,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: coin
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_COIN726",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WARNTYPOIY7706_COIN726 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WARNTYPOIY7706_COIN726', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WARNTYPOIY7706_COIN726'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WARNTYPOIY7706_COIN726");
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
            //ViewState - Entity: WarrantyPoliciy, Attribute: policyValue
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_POLI402",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_POLICYALU_25358",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: endorsementValue
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_DSTL580",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VALRENDOS_74667",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 36,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyPoliciy, Attribute: state
            $scope.vc.createViewState({
                id: "VA_WARNTYPOIY7706_STTE568",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_STATEQINL_03037",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WARNTYPOIY7706_STTE568 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WARNTYPOIY7706_STTE568', 'cu_estado_poliza', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WARNTYPOIY7706_STTE568'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WARNTYPOIY7706_STTE568");
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
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_76_CRNTO32_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_76_CRNTO32_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Guardar
            $scope.vc.createViewState({
                id: "CM_CRNTO32ARA57",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_CRNTO32CAL78",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_WARNTYPOIY7706_NSNE946.read();
                    $scope.vc.catalogs.VA_WARNTYPOIY7706_TYPE722.read();
                    $scope.vc.catalogs.VA_WARNTYPOIY7706_COIN726.read();
                    $scope.vc.catalogs.VA_WARNTYPOIY7706_STTE568.read();
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
                $scope.vc.render('VC_CRNTO32_RRNYM_717');
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
    var cobisMainModule = cobis.createModule("VC_CRNTO32_RRNYM_717", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_CRNTO32_RRNYM_717", {
            templateUrl: "VC_CRNTO32_RRNYM_717_FORM.html",
            controller: "VC_CRNTO32_RRNYM_717_CTRL",
            labelId: "BUSIN.DLB_BUSIN_PLIZAMMVK_53577",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CRNTO32_RRNYM_717?" + $.param(search);
            }
        });
        VC_CRNTO32_RRNYM_717(cobisMainModule);
    }]);
} else {
    VC_CRNTO32_RRNYM_717(cobisMainModule);
}