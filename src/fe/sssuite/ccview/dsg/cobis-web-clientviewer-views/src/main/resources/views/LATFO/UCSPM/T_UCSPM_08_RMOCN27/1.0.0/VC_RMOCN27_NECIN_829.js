<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tasksectionsmaintaining = designerEvents.api.tasksectionsmaintaining || designer.dsgEvents();

function VC_RMOCN27_NECIN_829(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RMOCN27_NECIN_829_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RMOCN27_NECIN_829_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            moduleId: "LATFO",
            subModuleId: "UCSPM",
            taskId: "T_UCSPM_08_RMOCN27",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RMOCN27_NECIN_829",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LATFO/UCSPM/T_UCSPM_08_RMOCN27",
        designerEvents.api.tasksectionsmaintaining,
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
                vcName: 'VC_RMOCN27_NECIN_829'
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
                    moduleId: 'LATFO',
                    subModuleId: 'UCSPM',
                    taskId: 'T_UCSPM_08_RMOCN27',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    SectionsMaintaining: "SectionsMaintaining"
                },
                entities: {
                    SectionsMaintaining: {
                        prdOrder: 'AT_CRO328PRRD49',
                        prdTypeClient: 'AT_CRO328DPLT05',
                        prdParent: 'AT_CRO328RARE15',
                        prdName: 'AT_CRO328RDAE63',
                        prdId: 'AT_CRO328RDID19',
                        dtoIdFk: 'AT_CRO328DOIF19',
                        prdDescription: 'AT_CRO328RDRI42',
                        prdMnemonic: 'AT_CRO328PRNO46',
                        prdParentDesc: 'AT_CRO328PTDE03',
                        dtoIdFkDesc: 'AT_CRO328TIDE46',
                        _pks: ['prdId'],
                        _entityId: 'EN_CROADNEAL328',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            defaultValues = {
                SectionsMaintaining: {}
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
            $scope.vc.viewState.VC_RMOCN27_NECIN_829 = {
                style: []
            }
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_CTNSMATINN69_03",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.SectionsMaintaining = {
                prdOrder: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdOrder"),
                prdTypeClient: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdTypeClient"),
                prdParent: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdParent"),
                prdName: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdName"),
                prdId: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdId"),
                dtoIdFk: $scope.vc.channelDefaultValues("SectionsMaintaining", "dtoIdFk"),
                prdDescription: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdDescription"),
                prdMnemonic: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdMnemonic"),
                prdParentDesc: $scope.vc.channelDefaultValues("SectionsMaintaining", "prdParentDesc"),
                dtoIdFkDesc: $scope.vc.channelDefaultValues("SectionsMaintaining", "dtoIdFkDesc")
            };
            //ViewState - Group:
            $scope.vc.createViewState({
                id: "GR_CTNSMATINN69_04",
                hasId: true,
                componentStyle: "",
                label: ' ',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdId
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_RDID469",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MANTSECTI_84401",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdMnemonic
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_PRNO548",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_NTSECTNEM_26074",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdDescription
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_RDRI869",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_ANTECTESC_05568",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdName
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_RDAE458",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MANTETETI_20997",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdParentDesc
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_RARE854",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MANTECADE_73269",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdTypeClient
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_DPLT912",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MANTSTTPO_67588",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CTNSMATINN6904_DPLT912 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CTNSMATINN6904_DPLT912', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CTNSMATINN6904_DPLT912'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CTNSMATINN6904_DPLT912");
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
            //ViewState - Entity: SectionsMaintaining, Attribute: dtoIdFkDesc
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_DOIF418",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MTSECTDTO_10138",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SectionsMaintaining, Attribute: prdOrder
            $scope.vc.createViewState({
                id: "VA_CTNSMATINN6904_PRRD020",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MNTSECORD_28858",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_UCSPM_08_RMOCN27_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_UCSPM_08_RMOCN27_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: BtnAccept
            $scope.vc.createViewState({
                id: "CM_RMOCN27BTA76",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MATCTCEPT_33322",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: BtnDecline
            $scope.vc.createViewState({
                id: "CM_RMOCN27TCL40",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_MATSETDEL_57681",
                haslabelArgs: true,
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
                $scope.vc.render('VC_RMOCN27_NECIN_829');
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
    var cobisMainModule = cobis.createModule("VC_RMOCN27_NECIN_829", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LATFO"]);
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
        $routeProvider.when("/VC_RMOCN27_NECIN_829", {
            templateUrl: "VC_RMOCN27_NECIN_829_FORM.html",
            controller: "VC_RMOCN27_NECIN_829_CTRL",
            label: "FormTaskSectionsMaintaining",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LATFO');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RMOCN27_NECIN_829?" + $.param(search);
            }
        });
        VC_RMOCN27_NECIN_829(cobisMainModule);
    }]);
} else {
    VC_RMOCN27_NECIN_829(cobisMainModule);
}