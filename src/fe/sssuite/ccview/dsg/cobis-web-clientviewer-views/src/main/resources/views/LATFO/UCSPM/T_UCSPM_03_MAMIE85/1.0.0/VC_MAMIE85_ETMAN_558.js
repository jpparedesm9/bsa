<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskdtomaintaining = designerEvents.api.taskdtomaintaining || designer.dsgEvents();

function VC_MAMIE85_ETMAN_558(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MAMIE85_ETMAN_558_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MAMIE85_ETMAN_558_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_UCSPM_03_MAMIE85",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MAMIE85_ETMAN_558",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LATFO/UCSPM/T_UCSPM_03_MAMIE85",
        designerEvents.api.taskdtomaintaining,
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
                vcName: 'VC_MAMIE85_ETMAN_558'
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
                    taskId: 'T_UCSPM_03_MAMIE85',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DTOS: "DTOS",
                    VccProperties: "VccProperties"
                },
                entities: {
                    DTOS: {
                        mnemonic: 'AT_VCC773NNIC24',
                        isList: 'AT_VCC773ILIS60',
                        parent: 'AT_VCC773DAET08',
                        serIdFk: 'AT_VCC773IDFK41',
                        name: 'AT_VCC773ONAE12',
                        dtoId: 'AT_VCC773DTOI22',
                        description: 'AT_VCC773TEIT99',
                        text: 'AT_VCC773DOET74',
                        order: 'AT_VCC773DRER76',
                        parentName: 'AT_VCC773PAME64',
                        _pks: ['dtoId'],
                        _entityId: 'EN_VCCDTOSKF773',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VccProperties: {
                        proId: 'AT_PRP986PRID36',
                        dtoId: 'AT_PRP986TODK34',
                        name: 'AT_PRP986PNAE74',
                        text: 'AT_PRP986REXT29',
                        primaryKey: 'AT_PRP986PRAR85',
                        grouping: 'AT_PRP986GRUI56',
                        detailSection: 'AT_PRP986PASN06',
                        visibleSumaryDetail: 'AT_PRP986PIBE26',
                        visibleSumaryGroup: 'AT_PRP986PISO66',
                        filterInProcess: 'AT_PRP986FNOS88',
                        width: 'AT_PRP986PRWH44',
                        format: 'AT_PRP986PORM08',
                        type: 'AT_PRP986RTYE93',
                        style: 'AT_PRP986PRTE80',
                        order: 'AT_PRP986ORER11',
                        _pks: ['proId', 'dtoId'],
                        _entityId: 'EN_PRPERTES1986',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            defaultValues = {
                DTOS: {},
                VccProperties: {}
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
            $scope.vc.viewState.VC_MAMIE85_ETMAN_558 = {
                style: []
            }
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_OPRTMINNNG88_03",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.VccProperties = {
                proId: $scope.vc.channelDefaultValues("VccProperties", "proId"),
                dtoId: $scope.vc.channelDefaultValues("VccProperties", "dtoId"),
                name: $scope.vc.channelDefaultValues("VccProperties", "name"),
                text: $scope.vc.channelDefaultValues("VccProperties", "text"),
                primaryKey: $scope.vc.channelDefaultValues("VccProperties", "primaryKey"),
                grouping: $scope.vc.channelDefaultValues("VccProperties", "grouping"),
                detailSection: $scope.vc.channelDefaultValues("VccProperties", "detailSection"),
                visibleSumaryDetail: $scope.vc.channelDefaultValues("VccProperties", "visibleSumaryDetail"),
                visibleSumaryGroup: $scope.vc.channelDefaultValues("VccProperties", "visibleSumaryGroup"),
                filterInProcess: $scope.vc.channelDefaultValues("VccProperties", "filterInProcess"),
                width: $scope.vc.channelDefaultValues("VccProperties", "width"),
                format: $scope.vc.channelDefaultValues("VccProperties", "format"),
                type: $scope.vc.channelDefaultValues("VccProperties", "type"),
                style: $scope.vc.channelDefaultValues("VccProperties", "style"),
                order: $scope.vc.channelDefaultValues("VccProperties", "order")
            };
            //ViewState - Group: VccProperties
            $scope.vc.createViewState({
                id: "GR_OPRTMINNNG88_04",
                hasId: true,
                componentStyle: "",
                label: "LATFO.DLB_LATFO_TOPROPERT_49716",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: proId
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PRID947",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_IDRFDFYBK_73505",
                label: "LATFO.DLB_LATFO_IDRLTXGMO_15078",
                haslabelArgs: true,
                format: "######",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: dtoId
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_TODK089",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_IDDTOJECQ_82525",
                label: "LATFO.DLB_LATFO_IDDTOVMWT_08868",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: VccProperties, Attribute: name
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PNAE594",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_NAMEPKVWT_37716",
                label: "LATFO.DLB_LATFO_NAMEIZCDT_71014",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: text
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_REXT518",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_TEXTAYVGZ_30800",
                label: "LATFO.DLB_LATFO_TEXTEJTZO_28884",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: width
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PRWH113",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_WIDTHJBIG_82636",
                label: "LATFO.DLB_LATFO_WIDTHVRKO_55639",
                haslabelArgs: true,
                suffix: "px",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: type
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_RTYE931",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_TYPEXPCEV_52403",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OPRTMINNNG8804_RTYE931 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OPRTMINNNG8804_RTYE931', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OPRTMINNNG8804_RTYE931'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OPRTMINNNG8804_RTYE931");
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
            //ViewState - Entity: VccProperties, Attribute: format
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PORM136",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_FORMATMFQ_39463",
                label: "LATFO.DLB_LATFO_FORMATBMS_96757",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OPRTMINNNG8804_PORM136 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OPRTMINNNG8804_PORM136', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OPRTMINNNG8804_PORM136'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OPRTMINNNG8804_PORM136");
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
            //ViewState - Entity: VccProperties, Attribute: style
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PRTE227",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_STYLEQRQL_92644",
                label: "LATFO.DLB_LATFO_STYLEFKEP_15418",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OPRTMINNNG8804_PRTE227 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OPRTMINNNG8804_PRTE227', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OPRTMINNNG8804_PRTE227'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OPRTMINNNG8804_PRTE227");
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
            //ViewState - Entity: VccProperties, Attribute: order
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_ORER102",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_ORDERRKHX_04081",
                label: "LATFO.DLB_LATFO_ORDENXQSF_38775",
                haslabelArgs: true,
                format: "######",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: primaryKey
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PRAR996",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_PRIMARYMB_67873",
                label: "LATFO.DLB_LATFO_PRIMARYMB_67873",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: grouping
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_GRUI869",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_GROUPINGH_88197",
                label: "LATFO.DLB_LATFO_GROUPINGH_88197",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: detailSection
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PASN358",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_DETAILION_72456",
                label: "LATFO.DLB_LATFO_DETAILION_72456",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: visibleSumaryDetail
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PIBE564",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_ISIBLDAIL_99886",
                label: "LATFO.DLB_LATFO_ISIBLDAIL_99886",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: visibleSumaryGroup
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_PISO681",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_IUMARYGRU_32635",
                label: "LATFO.DLB_LATFO_IUMARYGRU_32635",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: VccProperties, Attribute: filterInProcess
            $scope.vc.createViewState({
                id: "VA_OPRTMINNNG8804_FNOS372",
                componentStyle: "",
                tooltip: "LATFO.DLB_LATFO_IEINPROSS_34183",
                label: "LATFO.DLB_LATFO_IEINPROSS_34183",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_UCSPM_03_MAMIE85_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_UCSPM_03_MAMIE85_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Aceptar
            $scope.vc.createViewState({
                id: "CM_MAMIE85CET66",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_ACEPTAREL_26125",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_MAMIE85CLR24",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_CANCELVZT_56717",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.DTOS = {
                mnemonic: $scope.vc.channelDefaultValues("DTOS", "mnemonic"),
                isList: $scope.vc.channelDefaultValues("DTOS", "isList"),
                parent: $scope.vc.channelDefaultValues("DTOS", "parent"),
                serIdFk: $scope.vc.channelDefaultValues("DTOS", "serIdFk"),
                name: $scope.vc.channelDefaultValues("DTOS", "name"),
                dtoId: $scope.vc.channelDefaultValues("DTOS", "dtoId"),
                description: $scope.vc.channelDefaultValues("DTOS", "description"),
                text: $scope.vc.channelDefaultValues("DTOS", "text"),
                order: $scope.vc.channelDefaultValues("DTOS", "order"),
                parentName: $scope.vc.channelDefaultValues("DTOS", "parentName")
            };
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
                $scope.vc.render('VC_MAMIE85_ETMAN_558');
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
    var cobisMainModule = cobis.createModule("VC_MAMIE85_ETMAN_558", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LATFO"]);
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
        $routeProvider.when("/VC_MAMIE85_ETMAN_558", {
            templateUrl: "VC_MAMIE85_ETMAN_558_FORM.html",
            controller: "VC_MAMIE85_ETMAN_558_CTRL",
            labelId: "LATFO.DLB_LATFO_TOPROPERT_49716",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LATFO');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MAMIE85_ETMAN_558?" + $.param(search);
            }
        });
        VC_MAMIE85_ETMAN_558(cobisMainModule);
    }]);
} else {
    VC_MAMIE85_ETMAN_558(cobisMainModule);
}