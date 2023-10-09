<!-- Designer Generator v 6.0.0 - release SPR 2016-13 08/07/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tobservationpenalization = designerEvents.api.tobservationpenalization || designer.dsgEvents();

function VC_TAONE32_GEPLI_734(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TAONE32_GEPLI_734_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TAONE32_GEPLI_734_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_03_TAONE32",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TAONE32_GEPLI_734",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_03_TAONE32",
        designerEvents.api.tobservationpenalization,
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
                vcName: 'VC_TAONE32_GEPLI_734'
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
                    taskId: 'T_FLCRE_03_TAONE32',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    HeaderPunishment: "HeaderPunishment"
                },
                entities: {
                    HeaderPunishment: {
                        SpecificForecast: 'AT_EDR212AANS58',
                        PercentageRecovered: 'AT_EDR212AGRD14',
                        CourtDate: 'AT_EDR212ORTT66',
                        DisbursementDate: 'AT_EDR212SBME09',
                        CreditStatus: 'AT_EDR212DTTA08',
                        CustomerOriginalActivity: 'AT_EDR212SMIA17',
                        NumberCreditsEarned: 'AT_EDR212BEDS90',
                        CourtDaysLate: 'AT_EDR212OURS34',
                        ApplicationDaysLate: 'AT_EDR212APCA64',
                        OfficialGrant: 'AT_EDR212CIRA07',
                        ResponsibleCurrent: 'AT_EDR212RENN73',
                        ActualUseLoan: 'AT_EDR212AUOA04',
                        Trouble: 'AT_EDR212TOBL12',
                        ImpossibilityDescription: 'AT_EDR212EPTI39',
                        DescripNotRecoverGaranties: 'AT_EDR212PNUR98',
                        DisbursedAmount: 'AT_EDR212IBRS42',
                        ApplicationNumber: 'AT_EDR212LINU69',
                        IDRequested: 'AT_EDR212EUED07',
                        Agency: 'AT_EDR212AGCY42',
                        CityCode: 'AT_EDR212CTYE71',
                        CurrencyRequest: 'AT_EDR212CQUE29',
                        CreditTarget: 'AT_EDR212RDRE99',
                        NumberOperation: 'AT_EDR212PRAI16',
                        ConsistencyApplication: 'AT_EDR212DTIN81',
                        Observation: 'AT_EDR212BRTO11',
                        Province: 'AT_EDR212RINE98',
                        UserL: 'AT_EDR212UELI22',
                        CustomerId: 'AT_EDR212UTMD63',
                        Type: 'AT_EDR212TYPE26',
                        Status: 'AT_EDR212STAU79',
                        ParentGroupID: 'AT_EDR212ARNI56',
                        GroupID: 'AT_EDR212GPID89',
                        Sindico1: 'AT_EDR212NICO38',
                        Sindico2: 'AT_EDR212SII259',
                        Step: 'AT_EDR212STEP97',
                        _pks: [],
                        _entityId: 'EN_EDRPNSMET212',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            defaultValues = {
                HeaderPunishment: {}
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
            $scope.vc.viewState.VC_TAONE32_GEPLI_734 = {
                style: []
            }
            //ViewState - Container: FGeneralPenalization
            $scope.vc.createViewState({
                id: "VC_TAONE32_GEPLI_734",
                hasId: true,
                componentStyle: "",
                label: 'FGeneralPenalization',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GrpObservation
            $scope.vc.createViewState({
                id: "VC_TAONE32_RPBEO_194",
                hasId: true,
                componentStyle: "",
                label: 'GrpObservation',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GrpPrincipal
            $scope.vc.createViewState({
                id: "GR_OOPENIATIO41_04",
                hasId: true,
                componentStyle: "",
                label: 'GrpPrincipal',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.HeaderPunishment = {
                SpecificForecast: $scope.vc.channelDefaultValues("HeaderPunishment", "SpecificForecast"),
                PercentageRecovered: $scope.vc.channelDefaultValues("HeaderPunishment", "PercentageRecovered"),
                CourtDate: $scope.vc.channelDefaultValues("HeaderPunishment", "CourtDate"),
                DisbursementDate: $scope.vc.channelDefaultValues("HeaderPunishment", "DisbursementDate"),
                CreditStatus: $scope.vc.channelDefaultValues("HeaderPunishment", "CreditStatus"),
                CustomerOriginalActivity: $scope.vc.channelDefaultValues("HeaderPunishment", "CustomerOriginalActivity"),
                NumberCreditsEarned: $scope.vc.channelDefaultValues("HeaderPunishment", "NumberCreditsEarned"),
                CourtDaysLate: $scope.vc.channelDefaultValues("HeaderPunishment", "CourtDaysLate"),
                ApplicationDaysLate: $scope.vc.channelDefaultValues("HeaderPunishment", "ApplicationDaysLate"),
                OfficialGrant: $scope.vc.channelDefaultValues("HeaderPunishment", "OfficialGrant"),
                ResponsibleCurrent: $scope.vc.channelDefaultValues("HeaderPunishment", "ResponsibleCurrent"),
                ActualUseLoan: $scope.vc.channelDefaultValues("HeaderPunishment", "ActualUseLoan"),
                Trouble: $scope.vc.channelDefaultValues("HeaderPunishment", "Trouble"),
                ImpossibilityDescription: $scope.vc.channelDefaultValues("HeaderPunishment", "ImpossibilityDescription"),
                DescripNotRecoverGaranties: $scope.vc.channelDefaultValues("HeaderPunishment", "DescripNotRecoverGaranties"),
                DisbursedAmount: $scope.vc.channelDefaultValues("HeaderPunishment", "DisbursedAmount"),
                ApplicationNumber: $scope.vc.channelDefaultValues("HeaderPunishment", "ApplicationNumber"),
                IDRequested: $scope.vc.channelDefaultValues("HeaderPunishment", "IDRequested"),
                Agency: $scope.vc.channelDefaultValues("HeaderPunishment", "Agency"),
                CityCode: $scope.vc.channelDefaultValues("HeaderPunishment", "CityCode"),
                CurrencyRequest: $scope.vc.channelDefaultValues("HeaderPunishment", "CurrencyRequest"),
                CreditTarget: $scope.vc.channelDefaultValues("HeaderPunishment", "CreditTarget"),
                NumberOperation: $scope.vc.channelDefaultValues("HeaderPunishment", "NumberOperation"),
                ConsistencyApplication: $scope.vc.channelDefaultValues("HeaderPunishment", "ConsistencyApplication"),
                Observation: $scope.vc.channelDefaultValues("HeaderPunishment", "Observation"),
                Province: $scope.vc.channelDefaultValues("HeaderPunishment", "Province"),
                UserL: $scope.vc.channelDefaultValues("HeaderPunishment", "UserL"),
                CustomerId: $scope.vc.channelDefaultValues("HeaderPunishment", "CustomerId"),
                Type: $scope.vc.channelDefaultValues("HeaderPunishment", "Type"),
                Status: $scope.vc.channelDefaultValues("HeaderPunishment", "Status"),
                ParentGroupID: $scope.vc.channelDefaultValues("HeaderPunishment", "ParentGroupID"),
                GroupID: $scope.vc.channelDefaultValues("HeaderPunishment", "GroupID"),
                Sindico1: $scope.vc.channelDefaultValues("HeaderPunishment", "Sindico1"),
                Sindico2: $scope.vc.channelDefaultValues("HeaderPunishment", "Sindico2"),
                Step: $scope.vc.channelDefaultValues("HeaderPunishment", "Step")
            };
            //ViewState - Group: DataGrp
            $scope.vc.createViewState({
                id: "GR_OOPENIATIO41_05",
                hasId: true,
                componentStyle: "",
                label: 'DataGrp',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: Observation
            $scope.vc.createViewState({
                id: "VA_OOPENIATIO4105_BRTO752",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OBSERVACI_93291",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_03_TAONE32_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_03_TAONE32_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Acpetar
            $scope.vc.createViewState({
                id: "CM_TAONE32TAR13",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ACEPTARXV_30181",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_TAONE32CAR77",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
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
                $scope.vc.render('VC_TAONE32_GEPLI_734');
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
    var cobisMainModule = cobis.createModule("VC_TAONE32_GEPLI_734", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_TAONE32_GEPLI_734", {
            templateUrl: "VC_TAONE32_GEPLI_734_FORM.html",
            controller: "VC_TAONE32_GEPLI_734_CTRL",
            label: "FGeneralPenalization",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TAONE32_GEPLI_734?" + $.param(search);
            }
        });
        VC_TAONE32_GEPLI_734(cobisMainModule);
    }]);
} else {
    VC_TAONE32_GEPLI_734(cobisMainModule);
}