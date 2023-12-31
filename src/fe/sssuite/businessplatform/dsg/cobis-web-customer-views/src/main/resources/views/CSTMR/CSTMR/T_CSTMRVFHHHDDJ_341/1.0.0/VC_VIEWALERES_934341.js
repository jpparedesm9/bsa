//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.viewalertseditform = designerEvents.api.viewalertseditform || designer.dsgEvents();

function VC_VIEWALERES_934341(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_VIEWALERES_934341_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_VIEWALERES_934341_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CSTMRVFHHHDDJ_341",
            taskVersion: "1.0.0",
            viewContainerId: "VC_VIEWALERES_934341",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRVFHHHDDJ_341",
        designerEvents.api.viewalertseditform,
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
                vcName: 'VC_VIEWALERES_934341'
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
                    taskId: 'T_CSTMRVFHHHDDJ_341',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    WarningRisk: "WarningRisk"
                },
                entities: {
                    WarningRisk: {
                        observations: 'AT10_OBSERVIT699',
                        riskLevel: 'AT12_RISKLEEL699',
                        customerCode: 'AT16_CUSTOMDE699',
                        office: 'AT18_OFFICEUF699',
                        alertType: 'AT23_ALERTTYY699',
                        consultDate: 'AT23_CONSULDE699',
                        amount: 'AT24_AMOUNTYB699',
                        operationType: 'AT32_OPERATOE699',
                        contract: 'AT33_CONTRACT699',
                        productType: 'AT38_PRODUCPY699',
                        stage: 'AT40_STAGEYYM699',
                        customerName: 'AT41_CUSTOMEE699',
                        etiquet: 'AT46_ETIQUETT699',
                        groupName: 'AT48_GROUPNME699',
                        dictatesDate: 'AT54_DICTATAD699',
                        customerRFC: 'AT58_CUSTOMRR699',
                        listType: 'AT67_LISTTYEE699',
                        alertDate: 'AT69_ALERTDAE699',
                        alertCode: 'AT79_ALERTCED699',
                        generateReports: 'AT81_GENERAEE699',
                        operationDate: 'AT82_OPERATOD699',
                        reportDate: 'AT88_REPORTTA699',
                        group: 'AT90_GROUPTBS699',
                        statusAlert: 'AT98_STATUSRE699',
                        _pks: [],
                        _entityId: 'EN_WARNINGRI_699',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                WarningRisk: {}
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
                $scope.vc.execute("temporarySave", VC_VIEWALERES_934341, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_VIEWALERES_934341, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_VIEWALERES_934341, data, function() {});
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
            $scope.vc.viewState.VC_VIEWALERES_934341 = {
                style: []
            }
            $scope.vc.model.WarningRisk = {
                observations: $scope.vc.channelDefaultValues("WarningRisk", "observations"),
                riskLevel: $scope.vc.channelDefaultValues("WarningRisk", "riskLevel"),
                customerCode: $scope.vc.channelDefaultValues("WarningRisk", "customerCode"),
                office: $scope.vc.channelDefaultValues("WarningRisk", "office"),
                alertType: $scope.vc.channelDefaultValues("WarningRisk", "alertType"),
                consultDate: $scope.vc.channelDefaultValues("WarningRisk", "consultDate"),
                amount: $scope.vc.channelDefaultValues("WarningRisk", "amount"),
                operationType: $scope.vc.channelDefaultValues("WarningRisk", "operationType"),
                contract: $scope.vc.channelDefaultValues("WarningRisk", "contract"),
                productType: $scope.vc.channelDefaultValues("WarningRisk", "productType"),
                stage: $scope.vc.channelDefaultValues("WarningRisk", "stage"),
                customerName: $scope.vc.channelDefaultValues("WarningRisk", "customerName"),
                etiquet: $scope.vc.channelDefaultValues("WarningRisk", "etiquet"),
                groupName: $scope.vc.channelDefaultValues("WarningRisk", "groupName"),
                dictatesDate: $scope.vc.channelDefaultValues("WarningRisk", "dictatesDate"),
                customerRFC: $scope.vc.channelDefaultValues("WarningRisk", "customerRFC"),
                listType: $scope.vc.channelDefaultValues("WarningRisk", "listType"),
                alertDate: $scope.vc.channelDefaultValues("WarningRisk", "alertDate"),
                alertCode: $scope.vc.channelDefaultValues("WarningRisk", "alertCode"),
                generateReports: $scope.vc.channelDefaultValues("WarningRisk", "generateReports"),
                operationDate: $scope.vc.channelDefaultValues("WarningRisk", "operationDate"),
                reportDate: $scope.vc.channelDefaultValues("WarningRisk", "reportDate"),
                group: $scope.vc.channelDefaultValues("WarningRisk", "group"),
                statusAlert: $scope.vc.channelDefaultValues("WarningRisk", "statusAlert")
            };
            //ViewState - Group: Group1157
            $scope.vc.createViewState({
                id: "G_VIEWALEDTT_299173",
                hasId: true,
                componentStyle: [],
                label: 'Group1157',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarningRisk, Attribute: statusAlert
            $scope.vc.createViewState({
                id: "VA_6316JFVGVVCUOPG_835173",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTATUSQO_78542",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_6316JFVGVVCUOPG_835173 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_6316JFVGVVCUOPG_835173', 'cl_estado_alerta', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_6316JFVGVVCUOPG_835173'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_6316JFVGVVCUOPG_835173");
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
            //ViewState - Entity: WarningRisk, Attribute: generateReports
            $scope.vc.createViewState({
                id: "VA_7144TPKQRNCGGEO_365173",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GENERAROP_81309",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_7144TPKQRNCGGEO_365173 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_7144TPKQRNCGGEO_365173");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: WarningRisk, Attribute: observations
            $scope.vc.createViewState({
                id: "VA_3831FTIGRDFHULJ_171173",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OBSERVACE_30841",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2820",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONXWSXRPU_614173",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONXANXRER_647173",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CANCELARR_82087",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRVFHHHDDJ_341_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRVFHHHDDJ_341_CANCEL",
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
                $scope.vc.render('VC_VIEWALERES_934341');
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
    var cobisMainModule = cobis.createModule("VC_VIEWALERES_934341", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_VIEWALERES_934341", {
            templateUrl: "VC_VIEWALERES_934341_FORM.html",
            controller: "VC_VIEWALERES_934341_CTRL",
            label: "ViewAlertsEditForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_VIEWALERES_934341?" + $.param(search);
            }
        });
        VC_VIEWALERES_934341(cobisMainModule);
    }]);
} else {
    VC_VIEWALERES_934341(cobisMainModule);
}