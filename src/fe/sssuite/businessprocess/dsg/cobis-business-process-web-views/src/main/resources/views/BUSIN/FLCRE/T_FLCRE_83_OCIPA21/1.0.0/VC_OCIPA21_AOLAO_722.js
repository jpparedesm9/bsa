<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.reallocationapplication = designerEvents.api.reallocationapplication || designer.dsgEvents();

function VC_OCIPA21_AOLAO_722(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_OCIPA21_AOLAO_722_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_OCIPA21_AOLAO_722_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_83_OCIPA21",
            taskVersion: "1.0.0",
            viewContainerId: "VC_OCIPA21_AOLAO_722",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_83_OCIPA21",
        designerEvents.api.reallocationapplication,
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
                hasCRUDSupport: true,
                vcName: 'VC_OCIPA21_AOLAO_722'
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
                    taskId: 'T_FLCRE_83_OCIPA21',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    FilterApplications: "FilterApplications",
                    Applications: "Applications"
                },
                entities: {
                    FilterApplications: {
                        Official: 'AT_FLT513OIIL89',
                        FlowType: 'AT_FLT513FWPE79',
                        AssigningOfficial: 'AT_FLT513SNGI86',
                        Office: 'AT_FLT513OFIC07',
                        Subsidiary: 'AT_FLT513SDIA41',
                        _pks: [],
                        _entityId: 'EN_FLTRAPICS513',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Applications: {
                        ApplicationCode: 'AT_APP753AICE81',
                        CreditCode: 'AT_APP753DITE80',
                        Official: 'AT_APP753OFIL99',
                        FlowType: 'AT_APP753FLOW82',
                        PrincipalDebtor: 'AT_APP753INCD06',
                        ProposedAmount: 'AT_APP753PEMT71',
                        CurrencyProposal: 'AT_APP753ENPA09',
                        Selection: 'AT_APP753SLIO32',
                        OfficialName: 'AT_APP753CNME72',
                        DebtorName: 'AT_APP753BTAE36',
                        City: 'AT_APP753CITY02',
                        alternateCode: 'AT_APP753TETO90',
                        _pks: [],
                        _entityId: 'EN_APPLICATO753',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ERPLITON_1480 = {
                autoCrud: false
            };
            $scope.vc.queries.Q_ERPLITON_1480 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_ERPLITON_1480 = {
                mainEntityPk: {
                    entityId: 'EN_APPLICATO753',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_ERPLITON_1480',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            defaultValues = {
                FilterApplications: {},
                Applications: {}
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
            $scope.vc.viewState.VC_OCIPA21_AOLAO_722 = {
                style: []
            }
            //ViewState - Group: Contenedor de Pestañas
            $scope.vc.createViewState({
                id: "GR_RALLTIPLAI74_05",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor de Pesta\u00f1as',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.FilterApplications = {
                Official: $scope.vc.channelDefaultValues("FilterApplications", "Official"),
                FlowType: $scope.vc.channelDefaultValues("FilterApplications", "FlowType"),
                AssigningOfficial: $scope.vc.channelDefaultValues("FilterApplications", "AssigningOfficial"),
                Office: $scope.vc.channelDefaultValues("FilterApplications", "Office"),
                Subsidiary: $scope.vc.channelDefaultValues("FilterApplications", "Subsidiary")
            };
            //ViewState - Group: Officer
            $scope.vc.createViewState({
                id: "GR_RALLTIPLAI74_07",
                hasId: true,
                componentStyle: "",
                label: 'Officer',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FilterApplications, Attribute: Official
            $scope.vc.createViewState({
                id: "VA_RALLTIPLAI7407_OIIL146",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RALLTIPLAI7407_OIIL146 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_RALLTIPLAI7407_OIIL146', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_RALLTIPLAI7407_OIIL146'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RALLTIPLAI7407_OIIL146");
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
            //ViewState - Entity: FilterApplications, Attribute: FlowType
            $scope.vc.createViewState({
                id: "VA_RALLTIPLAI7407_FWPE686",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_IODEFLUJO_93372",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RALLTIPLAI7407_FWPE686 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_RALLTIPLAI7407_FWPE686', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_RALLTIPLAI7407_FWPE686'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RALLTIPLAI7407_FWPE686");
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
            //ViewState - Group: Event
            $scope.vc.createViewState({
                id: "GR_RALLTIPLAI74_10",
                hasId: true,
                componentStyle: "",
                label: 'Event',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RALLTIPLAI7410_0000172",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RALLTIPLAI7410_0000703",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BUSCARGJN_88350",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Separte
            $scope.vc.createViewState({
                id: "GR_RALLTIPLAI74_09",
                hasId: true,
                componentStyle: "",
                label: 'Separte',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_RALLTIPLAI7409_0000219",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_RALLTIPLAI74_08",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FilterApplications, Attribute: AssigningOfficial
            $scope.vc.createViewState({
                id: "VA_RALLTIPLAI7408_SNGI309",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASGNRFIIL_89720",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RALLTIPLAI7408_SNGI309 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_RALLTIPLAI7408_SNGI309', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_RALLTIPLAI7408_SNGI309'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RALLTIPLAI7408_SNGI309");
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
            //ViewState - Group: application
            $scope.vc.createViewState({
                id: "GR_RALLTIPLAI74_06",
                hasId: true,
                componentStyle: "",
                label: ' application',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Applications = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    ApplicationCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "ApplicationCode", '')
                    },
                    CreditCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "CreditCode", '')
                    },
                    Official: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "Official", '')
                    },
                    OfficialName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "OfficialName", '')
                    },
                    FlowType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "FlowType", '')
                    },
                    PrincipalDebtor: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "PrincipalDebtor", '')
                    },
                    ProposedAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "ProposedAmount", 0)
                    },
                    CurrencyProposal: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "CurrencyProposal", '')
                    },
                    Selection: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Applications", "Selection", false)
                    },
                    alternateCode: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.Applications = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_ERPLITON_1480';
                            var queryRequest = $scope.vc.request.qr[queryId];
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_ERPLI1480_27',
                                    queryRequest.queryPk.queryId,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                options.success(result);
                                            } else {
                                                options.success([]);
                                            }
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': false,
                                            'pageSize': 0
                                        };

                                        function config(queryOptions, queryView) {
                                            var result = undefined;
                                            if (queryView.allowPaging === true) {
                                                result = {};
                                                if (angular.isDefined(queryOptions.appendRecords) && queryOptions.appendRecords === true) {
                                                    result.appendRecords = true;
                                                }
                                                result.pageSize = queryView.pageSize;
                                            }
                                            return result;
                                        }
                                        return config(queryOptions, queryView);
                                    }()));
                                }
                            }
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.Applications
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ERPLI1480_27").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ERPLITON_1480 = $scope.vc.model.Applications;
            $scope.vc.trackers.Applications = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Applications);
            $scope.vc.model.Applications.bind('change', function(e) {
                $scope.vc.trackers.Applications.track(e);
            });
            $scope.vc.grids.QV_ERPLI1480_27 = {};
            $scope.vc.grids.QV_ERPLI1480_27.queryId = 'Q_ERPLITON_1480';
            $scope.vc.viewState.QV_ERPLI1480_27 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column = {};
            $scope.vc.grids.QV_ERPLI1480_27.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.Applications.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ERPLI1480_27.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_ERPLI1480_27");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_ERPLI1480_27.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ERPLI1480_27.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ERPLI1480_27.column.ApplicationCode = {
                title: 'BUSIN.DLB_BUSIN_OICDRIACO_62979',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_AICE869',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753AICE81 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_AICE869",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.CreditCode = {
                title: 'BUSIN.DLB_BUSIN_CDOASGACN_88013',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_DITE259',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753DITE80 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.CreditCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_DITE259",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.CreditCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.CreditCode.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.CreditCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.Official = {
                title: 'BUSIN.DLB_BUSIN_CODEOFIER_74970',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_OFIL200',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753OFIL99 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.Official.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_OFIL200",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.Official.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.Official.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.Official.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.OfficialName = {
                title: 'BUSIN.DLB_BUSIN_OFFCRNAME_81207',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_OFCERNAME_86082',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_CNME370',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753CNME72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.OfficialName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_OFCERNAME_86082'|translate}}",
                        'id': "VA_RALLTIPLAI7406_CNME370",
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.OfficialName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.OfficialName.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.OfficialName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.FlowType = {
                title: 'BUSIN.DLB_BUSIN_IODEFLUJO_93372',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_FLOW590',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753FLOW82 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.FlowType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_FLOW590",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.FlowType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.FlowType.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.FlowType.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor = {
                title: 'BUSIN.DLB_BUSIN_DEUOINCIL_89500',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_INCD142',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753INCD06 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_INCD142",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.ProposedAmount = {
                title: 'BUSIN.DLB_BUSIN_ONTPOPETO_08741',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_PEMT057',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753PEMT71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_PEMT057",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.format",
                        'k-decimals': "vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.decimals",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal = {
                title: 'BUSIN.DLB_BUSIN_MODAPROEA_35445',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_ENPA326',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_RALLTIPLAI7406_ENPA326 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_RALLTIPLAI7406_ENPA326_values)) {
                            $scope.vc.catalogs.VA_RALLTIPLAI7406_ENPA326_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_RALLTIPLAI7406_ENPA326',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_RALLTIPLAI7406_ENPA326'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_RALLTIPLAI7406_ENPA326_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ERPLI1480_27", "VA_RALLTIPLAI7406_ENPA326");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_RALLTIPLAI7406_ENPA326_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ERPLI1480_27", "VA_RALLTIPLAI7406_ENPA326");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753ENPA09 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_ENPA326",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_RALLTIPLAI7406_ENPA326",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.template",
                        'data-validation-code': "{{vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.validationCode}}",
                        'data-cobis-group': "Group,GR_RALLTIPLAI74_05,4",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.Selection = {
                title: 'BUSIN.DLB_BUSIN_SELECIOAR_14656',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_RALLTIPLAI7406_SLIO599',
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753SLIO32 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.Selection.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_RALLTIPLAI7406_SLIO599",
                        'ng-class': 'vc.viewState.QV_ERPLI1480_27.column.Selection.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ERPLI1480_27.column.alternateCode = {
                title: 'alternateCode',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ERPLI1480_27.AT_APP753TETO90 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ERPLI1480_27.column.alternateCode.enabled",
                        'ng-class': "vc.viewState.QV_ERPLI1480_27.column.alternateCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'ApplicationCode',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.title|translate:vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753AICE81.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.element[dataItem.uid].style'>#if (ApplicationCode !== null) {# #=ApplicationCode# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.ApplicationCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'CreditCode',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.CreditCode.title|translate:vc.viewState.QV_ERPLI1480_27.column.CreditCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.CreditCode.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.CreditCode.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753DITE80.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.CreditCode.element[dataItem.uid].style'>#if (CreditCode !== null) {# #=CreditCode# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.CreditCode.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.CreditCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.CreditCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'Official',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.Official.title|translate:vc.viewState.QV_ERPLI1480_27.column.Official.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.Official.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.Official.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753OFIL99.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.Official.element[dataItem.uid].style'>#if (Official !== null) {# #=Official# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.Official.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.Official.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.Official.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'OfficialName',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.OfficialName.title|translate:vc.viewState.QV_ERPLI1480_27.column.OfficialName.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.OfficialName.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.OfficialName.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753CNME72.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.OfficialName.element[dataItem.uid].style'>#if (OfficialName !== null) {# #=OfficialName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.OfficialName.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.OfficialName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.OfficialName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'FlowType',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.FlowType.title|translate:vc.viewState.QV_ERPLI1480_27.column.FlowType.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.FlowType.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.FlowType.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753FLOW82.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.FlowType.element[dataItem.uid].style'>#if (FlowType !== null) {# #=FlowType# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.FlowType.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.FlowType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.FlowType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'PrincipalDebtor',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.title|translate:vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753INCD06.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.element[dataItem.uid].style'>#if (PrincipalDebtor !== null) {# #=PrincipalDebtor# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.PrincipalDebtor.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'ProposedAmount',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.title|translate:vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753PEMT71.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=ProposedAmount#, vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.ProposedAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'CurrencyProposal',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.title|translate:vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753ENPA09.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_RALLTIPLAI7406_ENPA326.get(dataItem.CurrencyProposal).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.CurrencyProposal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'Selection',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.Selection.title|translate:vc.viewState.QV_ERPLI1480_27.column.Selection.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.Selection.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.Selection.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_ERPLI1480_27', 'Selection', $scope.vc.grids.QV_ERPLI1480_27.AT_APP753SLIO32.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_ERPLI1480_27', 'Selection'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.Selection.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.Selection.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.Selection.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERPLI1480_27.columns.push({
                    field: 'alternateCode',
                    title: '{{vc.viewState.QV_ERPLI1480_27.column.alternateCode.title|translate:vc.viewState.QV_ERPLI1480_27.column.alternateCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERPLI1480_27.column.alternateCode.width,
                    format: $scope.vc.viewState.QV_ERPLI1480_27.column.alternateCode.format,
                    editor: $scope.vc.grids.QV_ERPLI1480_27.AT_APP753TETO90.control,
                    template: "<span ng-class='vc.viewState.QV_ERPLI1480_27.column.alternateCode.element[dataItem.uid].style'>#if (alternateCode !== null) {# #=alternateCode# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERPLI1480_27.column.alternateCode.style",
                        "title": "{{vc.viewState.QV_ERPLI1480_27.column.alternateCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERPLI1480_27.column.alternateCode.hidden
                });
            }
            $scope.vc.viewState.QV_ERPLI1480_27.toolbar = {}
            $scope.vc.grids.QV_ERPLI1480_27.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_83_OCIPA21_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_83_OCIPA21_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Assign Official
            $scope.vc.createViewState({
                id: "CM_OCIPA21DTE50",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASGNRFIIL_89720",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_RALLTIPLAI7406_ENPA326.read();
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
                $scope.vc.render('VC_OCIPA21_AOLAO_722');
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
    var cobisMainModule = cobis.createModule("VC_OCIPA21_AOLAO_722", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_OCIPA21_AOLAO_722", {
            templateUrl: "VC_OCIPA21_AOLAO_722_FORM.html",
            controller: "VC_OCIPA21_AOLAO_722_CTRL",
            label: "ReallocationApplication",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_OCIPA21_AOLAO_722?" + $.param(search);
            }
        });
        VC_OCIPA21_AOLAO_722(cobisMainModule);
    }]);
} else {
    VC_OCIPA21_AOLAO_722(cobisMainModule);
}