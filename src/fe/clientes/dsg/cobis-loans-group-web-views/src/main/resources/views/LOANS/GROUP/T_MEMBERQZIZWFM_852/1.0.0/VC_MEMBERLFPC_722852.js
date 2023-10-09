//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.memberpoppupform = designerEvents.api.memberpoppupform || designer.dsgEvents();

function VC_MEMBERLFPC_722852(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MEMBERLFPC_722852_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MEMBERLFPC_722852_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "LOANS",
            subModuleId: "GROUP",
            taskId: "T_MEMBERQZIZWFM_852",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MEMBERLFPC_722852",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_MEMBERQZIZWFM_852",
        designerEvents.api.memberpoppupform,
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
                vcName: 'VC_MEMBERLFPC_722852'
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
                    moduleId: 'LOANS',
                    subModuleId: 'GROUP',
                    taskId: 'T_MEMBERQZIZWFM_852',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Member: "Member"
                },
                entities: {
                    Member: {
                        customerId: 'AT13_CUSTOMDE444',
                        qualification: 'AT16_QUALIFCA444',
                        hasIndividualAccountAux: 'AT17_HASINDUC444',
                        membershipDate: 'AT17_MEMBERIT444',
                        points: 'AT19_POINTSIA444',
                        savingVoluntary: 'AT20_SAVINGTY444',
                        groupId: 'AT27_GROUPIDD444',
                        state: 'AT29_STATEVDB444',
                        creditCode: 'AT40_CREDITCE444',
                        role: 'AT43_ROLEQVSE444',
                        riskLevel: 'AT45_RISKLEVE444',
                        qualificationId: 'AT49_QUALIFIN444',
                        secuential: 'AT51_SECUENIT444',
                        roleId: 'AT64_ROLEDPKV444',
                        level: 'AT65_LEVELGWK444',
                        disconnectionDate: 'AT74_DISCONOI444',
                        ctaIndividual: 'AT77_CTAINDAA444',
                        numberCyclePersonGroup: 'AT85_NUMBERSO444',
                        stateId: 'AT91_STATEIDD444',
                        operation: 'AT92_OPERATIO444',
                        meetingPlace: 'AT94_MEETINAA444',
                        customer: 'AT96_CUSTOMER444',
                        _pks: [],
                        _entityId: 'EN_MEMBERWLM_444',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Member: {}
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
                $scope.vc.execute("temporarySave", VC_MEMBERLFPC_722852, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MEMBERLFPC_722852, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MEMBERLFPC_722852, data, function() {});
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
            $scope.vc.viewState.VC_MEMBERLFPC_722852 = {
                style: []
            }
            $scope.vc.model.Member = {
                customerId: $scope.vc.channelDefaultValues("Member", "customerId"),
                qualification: $scope.vc.channelDefaultValues("Member", "qualification"),
                hasIndividualAccountAux: $scope.vc.channelDefaultValues("Member", "hasIndividualAccountAux"),
                membershipDate: $scope.vc.channelDefaultValues("Member", "membershipDate"),
                points: $scope.vc.channelDefaultValues("Member", "points"),
                savingVoluntary: $scope.vc.channelDefaultValues("Member", "savingVoluntary"),
                groupId: $scope.vc.channelDefaultValues("Member", "groupId"),
                state: $scope.vc.channelDefaultValues("Member", "state"),
                creditCode: $scope.vc.channelDefaultValues("Member", "creditCode"),
                role: $scope.vc.channelDefaultValues("Member", "role"),
                riskLevel: $scope.vc.channelDefaultValues("Member", "riskLevel"),
                qualificationId: $scope.vc.channelDefaultValues("Member", "qualificationId"),
                secuential: $scope.vc.channelDefaultValues("Member", "secuential"),
                roleId: $scope.vc.channelDefaultValues("Member", "roleId"),
                level: $scope.vc.channelDefaultValues("Member", "level"),
                disconnectionDate: $scope.vc.channelDefaultValues("Member", "disconnectionDate"),
                ctaIndividual: $scope.vc.channelDefaultValues("Member", "ctaIndividual"),
                numberCyclePersonGroup: $scope.vc.channelDefaultValues("Member", "numberCyclePersonGroup"),
                stateId: $scope.vc.channelDefaultValues("Member", "stateId"),
                operation: $scope.vc.channelDefaultValues("Member", "operation"),
                meetingPlace: $scope.vc.channelDefaultValues("Member", "meetingPlace"),
                customer: $scope.vc.channelDefaultValues("Member", "customer")
            };
            //ViewState - Group: Group1149
            $scope.vc.createViewState({
                id: "G_MEMBERRWYD_572132",
                hasId: true,
                componentStyle: [],
                label: 'Group1149',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: customer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXOKY_519132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CLIENTEMZ_77659",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: roleId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHYH_612132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ROLOSKZGW_63791",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXHYH_612132 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXHYH_612132', 'cl_rol_grupo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXHYH_612132'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXHYH_612132");
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
            //ViewState - Entity: Member, Attribute: stateId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXAIN_291132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ESTADOIKH_14850",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXAIN_291132 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXAIN_291132', 'cl_estado_ambito', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXAIN_291132'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXAIN_291132");
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
            //ViewState - Entity: Member, Attribute: qualificationId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKTO_991132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NIVELDERI_38662",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: membershipDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDOMJBGT_898132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHADECS_51723",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: savingVoluntary
            $scope.vc.createViewState({
                id: "VA_1162ABGCEPLDHTO_457132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_AHORROVOA_67689",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: meetingPlace
            $scope.vc.createViewState({
                id: "VA_9339JAGVFZSMRSA_972132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_LUGARDENN_49310",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_9339JAGVFZSMRSA_972132 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_9339JAGVFZSMRSA_972132', 'cl_tdireccion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_9339JAGVFZSMRSA_972132'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_9339JAGVFZSMRSA_972132");
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
            //ViewState - Entity: Member, Attribute: disconnectionDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDXINLFQ_109132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHADEED_11977",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Member, Attribute: groupId
            $scope.vc.createViewState({
                id: "VA_GROUPIDJQCFXYPL_528132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GRUPOQVCT_54778",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Member, Attribute: ctaIndividual
            $scope.vc.createViewState({
                id: "VA_8316ZNUUMBGIZYL_525132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CUENTAIDD_22913",
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: numberCyclePersonGroup
            $scope.vc.createViewState({
                id: "VA_NUMBERCYCLEPSSU_968132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CICLOPEON_71451",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: level
            $scope.vc.createViewState({
                id: "VA_LEVELZBRYUVWHXP_209132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NIVELHJQC_23857",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Member, Attribute: points
            $scope.vc.createViewState({
                id: "VA_POINTSTRNBCTOSH_659132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_PUNTOSJEK_22270",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2892",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONXYNUHPG_895132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ACEPTARYN_97581",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONTPUAZVF_333132",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_BUSCARCAA_46527",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_MEMBERQZIZWFM_852_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_MEMBERQZIZWFM_852_CANCEL",
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
                $scope.vc.render('VC_MEMBERLFPC_722852');
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
    var cobisMainModule = cobis.createModule("VC_MEMBERLFPC_722852", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_MEMBERLFPC_722852", {
            templateUrl: "VC_MEMBERLFPC_722852_FORM.html",
            controller: "VC_MEMBERLFPC_722852_CTRL",
            label: "MemberForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MEMBERLFPC_722852?" + $.param(search);
            }
        });
        VC_MEMBERLFPC_722852(cobisMainModule);
    }]);
} else {
    VC_MEMBERLFPC_722852(cobisMainModule);
}