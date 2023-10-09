//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.complementaryrequestdataform = designerEvents.api.complementaryrequestdataform || designer.dsgEvents();

function VC_COMPLEMEDR_886400(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_COMPLEMEDR_886400_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_COMPLEMEDR_886400_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CSTMRWNGRIQPQ_400",
            taskVersion: "1.0.0",
            viewContainerId: "VC_COMPLEMEDR_886400",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRWNGRIQPQ_400",
        designerEvents.api.complementaryrequestdataform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_COMPLEMEDR_886400'
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
                    taskId: 'T_CSTMRWNGRIQPQ_400',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ComplementaryRequestData: "ComplementaryRequestData"
                },
                entities: {
                    ComplementaryRequestData: {
                        bureauBackground: 'AT15_BUREAUCK873',
                        landlineOne: 'AT18_LANDLIEN873',
                        electronicSignature: 'AT40_ELECTRUS873',
                        customerCode: 'AT47_CUSTOMDE873',
                        landlineTwo: 'AT52_LANDLITN873',
                        personNameMessages: 'AT52_PERSONEA873',
                        ifeNumber: 'AT63_IFENUMBE873',
                        passportNumber: 'AT84_PASSPOUR873',
                        phoneErrands: 'AT84_PHONEERN873',
                        _pks: [],
                        _entityId: 'EN_COMPLEMRR_873',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                ComplementaryRequestData: {}
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
                $scope.vc.execute("temporarySave", VC_COMPLEMEDR_886400, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_COMPLEMEDR_886400, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_COMPLEMEDR_886400, data, function() {});
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
            $scope.vc.viewState.VC_COMPLEMEDR_886400 = {
                style: []
            }
            $scope.vc.model.ComplementaryRequestData = {
                bureauBackground: $scope.vc.channelDefaultValues("ComplementaryRequestData", "bureauBackground"),
                landlineOne: $scope.vc.channelDefaultValues("ComplementaryRequestData", "landlineOne"),
                electronicSignature: $scope.vc.channelDefaultValues("ComplementaryRequestData", "electronicSignature"),
                customerCode: $scope.vc.channelDefaultValues("ComplementaryRequestData", "customerCode"),
                landlineTwo: $scope.vc.channelDefaultValues("ComplementaryRequestData", "landlineTwo"),
                personNameMessages: $scope.vc.channelDefaultValues("ComplementaryRequestData", "personNameMessages"),
                ifeNumber: $scope.vc.channelDefaultValues("ComplementaryRequestData", "ifeNumber"),
                passportNumber: $scope.vc.channelDefaultValues("ComplementaryRequestData", "passportNumber"),
                phoneErrands: $scope.vc.channelDefaultValues("ComplementaryRequestData", "phoneErrands")
            };
            //ViewState - Group: Group1249
            $scope.vc.createViewState({
                id: "G_COMPLEMETQ_738642",
                hasId: true,
                componentStyle: [],
                label: 'Group1249',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: ifeNumber
            $scope.vc.createViewState({
                id: "VA_IFENUMBERTXDDFK_481642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROIFEE_51569",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: passportNumber
            $scope.vc.createViewState({
                id: "VA_PASSPORTNUMBEER_566642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROPAAS_57835",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: electronicSignature
            $scope.vc.createViewState({
                id: "VA_ELECTRONICSIGGU_426642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROSERF_57204",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: phoneErrands
            $scope.vc.createViewState({
                id: "VA_PHONEERRANDSTRD_116642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONODT_17424",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: personNameMessages
            $scope.vc.createViewState({
                id: "VA_PERSONNAMEMEAES_714642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBREPRD_10762",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: bureauBackground
            $scope.vc.createViewState({
                id: "VA_BUREAUBACKGRDDU_704642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CUENTACNU_97404",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BUREAUBACKGRDDU_704642 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BUREAUBACKGRDDU_704642', 'cr_sol_exp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BUREAUBACKGRDDU_704642'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BUREAUBACKGRDDU_704642");
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
            //ViewState - Entity: ComplementaryRequestData, Attribute: landlineOne
            $scope.vc.createViewState({
                id: "VA_LANDLINEONESMPZ_626642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOII_46772",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: landlineTwo
            $scope.vc.createViewState({
                id: "VA_LANDLINETWOBRCP_258642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOER_23297",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRWNGRIQPQ_400_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRWNGRIQPQ_400_CANCEL",
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
                $scope.vc.render('VC_COMPLEMEDR_886400');
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
    var cobisMainModule = cobis.createModule("VC_COMPLEMEDR_886400", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_COMPLEMEDR_886400", {
            templateUrl: "VC_COMPLEMEDR_886400_FORM.html",
            controller: "VC_COMPLEMEDR_886400_CTRL",
            label: "ComplementaryRequestDataForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_COMPLEMEDR_886400?" + $.param(search);
            }
        });
        VC_COMPLEMEDR_886400(cobisMainModule);
    }]);
} else {
    VC_COMPLEMEDR_886400(cobisMainModule);
}