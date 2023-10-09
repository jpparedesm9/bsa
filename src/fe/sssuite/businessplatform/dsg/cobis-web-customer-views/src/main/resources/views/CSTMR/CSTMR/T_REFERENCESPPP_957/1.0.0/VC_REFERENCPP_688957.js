//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.referencespopupform = designerEvents.api.referencespopupform || designer.dsgEvents();

function VC_REFERENCPP_688957(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REFERENCPP_688957_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REFERENCPP_688957_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_REFERENCESPPP_957",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REFERENCPP_688957",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_REFERENCESPPP_957",
        designerEvents.api.referencespopupform,
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
                vcName: 'VC_REFERENCPP_688957'
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
                    taskId: 'T_REFERENCESPPP_957',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    References: "References"
                },
                entities: {
                    References: {
                        firstLastName: 'AT10_FIRSTLNT825',
                        officePhone: 'AT12_OFFICEEE825',
                        description: 'AT13_DESCRIPP825',
                        cellPhone: 'AT19_CELLPHEE825',
                        postalCode: 'AT36_POSTALED825',
                        country: 'AT37_COUNTRYY825',
                        municipality: 'AT39_MUNICIAP825',
                        state: 'AT42_STATEFJV825',
                        homePhone: 'AT46_HOMEPHNO825',
                        knownTime: 'AT48_KNOWNTMM825',
                        neighborhood: 'AT52_NEIGHBDD825',
                        email: 'AT58_EMAILOAJ825',
                        relationship: 'AT61_RELATIHO825',
                        customerCode: 'AT63_CUSTOMDD825',
                        colony: 'AT69_COLONYUJ825',
                        address: 'AT71_ADDRESSS825',
                        locations: 'AT72_LOCATINS825',
                        references: 'AT76_REFERECE825',
                        names: 'AT79_NAMESQJW825',
                        secondLastName: 'AT88_SECONDTM825',
                        numberOfReferences: 'AT97_NUMBERCC825',
                        street: 'AT98_STREETQD825',
                        _pks: [],
                        _entityId: 'EN_REFERENES_825',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                References: {}
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
                $scope.vc.execute("temporarySave", VC_REFERENCPP_688957, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REFERENCPP_688957, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REFERENCPP_688957, data, function() {});
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
            $scope.vc.viewState.VC_REFERENCPP_688957 = {
                style: []
            }
            $scope.vc.model.References = {
                firstLastName: $scope.vc.channelDefaultValues("References", "firstLastName"),
                officePhone: $scope.vc.channelDefaultValues("References", "officePhone"),
                description: $scope.vc.channelDefaultValues("References", "description"),
                cellPhone: $scope.vc.channelDefaultValues("References", "cellPhone"),
                postalCode: $scope.vc.channelDefaultValues("References", "postalCode"),
                country: $scope.vc.channelDefaultValues("References", "country"),
                municipality: $scope.vc.channelDefaultValues("References", "municipality"),
                state: $scope.vc.channelDefaultValues("References", "state"),
                homePhone: $scope.vc.channelDefaultValues("References", "homePhone"),
                knownTime: $scope.vc.channelDefaultValues("References", "knownTime"),
                neighborhood: $scope.vc.channelDefaultValues("References", "neighborhood"),
                email: $scope.vc.channelDefaultValues("References", "email"),
                relationship: $scope.vc.channelDefaultValues("References", "relationship"),
                customerCode: $scope.vc.channelDefaultValues("References", "customerCode"),
                colony: $scope.vc.channelDefaultValues("References", "colony"),
                address: $scope.vc.channelDefaultValues("References", "address"),
                locations: $scope.vc.channelDefaultValues("References", "locations"),
                references: $scope.vc.channelDefaultValues("References", "references"),
                names: $scope.vc.channelDefaultValues("References", "names"),
                secondLastName: $scope.vc.channelDefaultValues("References", "secondLastName"),
                numberOfReferences: $scope.vc.channelDefaultValues("References", "numberOfReferences"),
                street: $scope.vc.channelDefaultValues("References", "street")
            };
            //ViewState - Group: Group1737
            $scope.vc.createViewState({
                id: "G_REFERENUSO_570331",
                hasId: true,
                componentStyle: [],
                label: 'Group1737',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: names
            $scope.vc.createViewState({
                id: "VA_NAMESPMKVLBMQSO_833331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBRESOQ_57455",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: firstLastName
            $scope.vc.createViewState({
                id: "VA_FIRSTLASTNAMEEE_790331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDSO_11522",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: secondLastName
            $scope.vc.createViewState({
                id: "VA_SECONDLASTNAEEE_703331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: address
            $scope.vc.createViewState({
                id: "VA_ADDRESSRZZIHCFO_158331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCINN_81106",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: homePhone
            $scope.vc.createViewState({
                id: "VA_HOMEPHONEZHJHRI_767331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONODD_82003",
                validationCode: 97,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: officePhone
            $scope.vc.createViewState({
                id: "VA_OFFICEPHONEGMFI_991331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOEF_19020",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: cellPhone
            $scope.vc.createViewState({
                id: "VA_CELLPHONEKFGUJA_158331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CELULARHQ_62133",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: relationship
            $scope.vc.createViewState({
                id: "VA_RELATIONSHIPOYM_385331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PARENTESC_45165",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RELATIONSHIPOYM_385331 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RELATIONSHIPOYM_385331', 'cl_parentesco', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RELATIONSHIPOYM_385331'];
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
            //ViewState - Entity: References, Attribute: description
            $scope.vc.createViewState({
                id: "VA_DESCRIPTIONBRNZ_745331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DESCRIPIC_16557",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: References, Attribute: knownTime
            $scope.vc.createViewState({
                id: "VA_KNOWNTIMEHZVLRC_209331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIEMPODOC_28208",
                format: "n0",
                decimals: 0,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_KNOWNTIMEHZVLRC_209331 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_KNOWNTIMEHZVLRC_209331', 'cl_referencia_tiempo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_KNOWNTIMEHZVLRC_209331'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_KNOWNTIMEHZVLRC_209331");
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
            //ViewState - Entity: References, Attribute: email
            $scope.vc.createViewState({
                id: "VA_EMAILUGHMHUTNDX_801331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CORREOEOC_98049",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1404",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONLYUTEBY_858331",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARRA_63303",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REFERENCESPPP_957_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REFERENCESPPP_957_CANCEL",
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
                $scope.vc.render('VC_REFERENCPP_688957');
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
    var cobisMainModule = cobis.createModule("VC_REFERENCPP_688957", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_REFERENCPP_688957", {
            templateUrl: "VC_REFERENCPP_688957_FORM.html",
            controller: "VC_REFERENCPP_688957_CTRL",
            label: "ReferencesPopupForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REFERENCPP_688957?" + $.param(search);
            }
        });
        VC_REFERENCPP_688957(cobisMainModule);
    }]);
} else {
    VC_REFERENCPP_688957(cobisMainModule);
}