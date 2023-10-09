//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.creditcandidates = designerEvents.api.creditcandidates || designer.dsgEvents();

function VC_CREDITCAAD_894925(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CREDITCAAD_894925_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CREDITCAAD_894925_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "ASSTS",
            subModuleId: "QERYS",
            taskId: "T_ASSTSTCUPYEAZ_925",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CREDITCAAD_894925",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSTCUPYEAZ_925",
        designerEvents.api.creditcandidates,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_CREDITCAAD_894925'
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
                    moduleId: 'ASSTS',
                    subModuleId: 'QERYS',
                    taskId: 'T_ASSTSTCUPYEAZ_925',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CreditCandidates: "CreditCandidates"
                },
                entities: {
                    CreditCandidates: {
                        groupName: 'AT14_GROUPNEM379',
                        groupId: 'AT16_GROUPCOO379',
                        isChecked: 'AT37_SELECTDD379',
                        clientId: 'AT43_CLIENTDD379',
                        dateDispersion: 'AT45_DATEDIPS379',
                        auxText: 'AT46_AUXTEXTT379',
                        description: 'AT49_OBSERVIN379',
                        officerAssigned: 'AT53_OFFICERR379',
                        clientName: 'AT56_CLIENTME379',
                        officerAssignedId: 'AT59_OFFICEAS379',
                        officeId: 'AT60_OFFICECY379',
                        periodicity: 'AT64_PERIODII379',
                        dateInsertion: 'AT76_DATEINEO379',
                        officerReassigned: 'AT81_OFFICEAR379',
                        officerReassignedId: 'AT85_OFFICEIS379',
                        officeName: 'AT94_OFFICENM379',
                        _pks: [],
                        _entityId: 'EN_CREDITCAI_379',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CREDITNT_9492 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CREDITNT_9492 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CREDITNT_9492_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CREDITNT_9492_filters;
                    parametersAux = {
                        groupCode: filters.groupCode,
                        clientId: filters.clientId,
                        dateInsertion: filters.dateInsertion
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CREDITCAI_379',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CREDITNT_9492',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['groupCode'] = this.filters.groupCode;
                            this.parameters['clientId'] = this.filters.clientId;
                            this.parameters['dateInsertion'] = this.filters.dateInsertion;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_CREDITNT_9492_filters = {};
            var defaultValues = {
                CreditCandidates: {}
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
                $scope.vc.execute("temporarySave", VC_CREDITCAAD_894925, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CREDITCAAD_894925, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CREDITCAAD_894925, data, function() {});
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
            $scope.vc.viewState.VC_CREDITCAAD_894925 = {
                style: []
            }
            //ViewState - Group: Group1877
            $scope.vc.createViewState({
                id: "G_CREDITCAAA_159782",
                hasId: true,
                componentStyle: [],
                label: 'Group1877',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1654",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_988782",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_AUTORIZOE_31479",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1931
            $scope.vc.createViewState({
                id: "G_CREDITCSNS_624782",
                hasId: true,
                componentStyle: [],
                label: 'Group1931',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CreditCandidates = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    isChecked: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "isChecked", false)
                    },
                    dateDispersion: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "dateDispersion", new Date())
                    },
                    dateInsertion: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "dateInsertion", new Date())
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "groupId", 0)
                    },
                    officerAssigned: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "officerAssigned", '')
                    },
                    officeId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "officeId", 0)
                    },
                    groupName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "groupName", '')
                    },
                    clientId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "clientId", 0)
                    },
                    clientName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "clientName", '')
                    },
                    officerReassigned: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "officerReassigned", '')
                    },
                    officerAssignedId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "officerAssignedId", 0)
                    },
                    officerReassignedId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "officerReassignedId", 0)
                    },
                    officeName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "officeName", '')
                    },
                    periodicity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "periodicity", '')
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "description", '')
                    },
                    auxText: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditCandidates", "auxText", '')
                    }
                }
            });
            $scope.vc.model.CreditCandidates = new kendo.data.DataSource({
                pageSize: 50,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CREDITNT_9492';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CREDITNT_9492();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9492_89518',
                                    queryRequest,
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
                                        } else {
                                            options.error([]);
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': true,
                                            'pageSize': 50
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'CreditCandidates',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9492_89518', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.CreditCandidates
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9492_89518").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CREDITNT_9492 = $scope.vc.model.CreditCandidates;
            $scope.vc.trackers.CreditCandidates = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CreditCandidates);
            $scope.vc.model.CreditCandidates.bind('change', function(e) {
                $scope.vc.trackers.CreditCandidates.track(e);
            });
            $scope.vc.grids.QV_9492_89518 = {};
            $scope.vc.grids.QV_9492_89518.queryId = 'Q_CREDITNT_9492';
            $scope.vc.viewState.QV_9492_89518 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9492_89518.column = {};
            $scope.vc.grids.QV_9492_89518.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_9492_89518.events = {
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "QERYS",
                        taskId: "T_ASSTSEWQQZQBV_441",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_CREDITCAUS_223441',
                        title: '',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_9492_89518", dialogParameters);
                },
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_9492_89518', this.dataSource);
                },
                excel: {
                    fileName: 'QV_9492_89518.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_9492_89518.pdf'
                },
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'CreditCandidates',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_9492_89518", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9492_89518");
                    $scope.vc.hideShowColumns("QV_9492_89518", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9492_89518.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9492_89518.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9492_89518.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9492_89518 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9492_89518 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_9492_89518.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9492_89518.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9492_89518.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9492_89518.column.isChecked = {
                title: 'ASSTS.LBL_ASSTS_SNDZZLFIU_18200',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXXPZAELV_726782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.dateDispersion = {
                title: 'ASSTS.LBL_ASSTS_FECHALTMO_82240',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDQDOZJA_206782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.dateInsertion = {
                title: 'dateInsertion',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDAHZZUG_620782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.groupId = {
                title: 'groupCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFRS_483782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.officerAssigned = {
                title: 'ASSTS.LBL_ASSTS_ASESORASA_56636',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMII_498782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.officeId = {
                title: 'office',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXRV_214782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.groupName = {
                title: 'ASSTS.LBL_ASSTS_GRUPOOBAY_84995',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQOD_239782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.clientId = {
                title: 'ASSTS.LBL_ASSTS_IDCLIENTT_49211',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXQM_769782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.clientName = {
                title: 'ASSTS.LBL_ASSTS_NOMBRECNI_63306',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBOU_871782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.officerReassigned = {
                title: 'officerReassign',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFND_148782',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXFND_148782 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_9492_89518.column.officerAssignedId = {
                title: 'ASSTS.LBL_ASSTS_ASESORASA_56636',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQRC_115782',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQRC_115782 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXQRC_115782', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQRC_115782'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.viewState.QV_9492_89518.column.officerReassignedId = {
                title: 'ASSTS.LBL_ASSTS_REASIGNEE_38792',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQAF_920782',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQAF_920782 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXQAF_920782', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQAF_920782'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.viewState.QV_9492_89518.column.officeName = {
                title: 'ASSTS.LBL_ASSTS_OFICINAAN_39609',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDIV_153782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.periodicity = {
                title: 'ASSTS.LBL_ASSTS_PERIODIAA_74042',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVLO_782782',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXVLO_782782 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXVLO_782782',
                            'ca_periodicidad_lcr',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXVLO_782782'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.viewState.QV_9492_89518.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPII_28027',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNIR_684782',
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.auxText = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPII_28027',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNIR_549782',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'isChecked',
                    title: '{{vc.viewState.QV_9492_89518.column.isChecked.title|translate:vc.viewState.QV_9492_89518.column.isChecked.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.isChecked.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.isChecked.format,
                    template: $scope.vc.gridInitColumnTemplate('QV_9492_89518', 'isChecked', "<input name='isChecked' type='checkbox' value='#=isChecked#' #=isChecked?checked='checked':''# disabled='disabled' data-bind='value:isChecked' ng-class='vc.viewState.QV_9492_89518.column.isChecked.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.isChecked.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.isChecked.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.isChecked.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'dateDispersion',
                    title: '{{vc.viewState.QV_9492_89518.column.dateDispersion.title|translate:vc.viewState.QV_9492_89518.column.dateDispersion.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.dateDispersion.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.dateDispersion.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.dateDispersion.style'>#=((dateDispersion !== null) ? kendo.toString(dateDispersion, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.dateDispersion.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.dateDispersion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.dateDispersion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'dateInsertion',
                    title: '{{vc.viewState.QV_9492_89518.column.dateInsertion.title|translate:vc.viewState.QV_9492_89518.column.dateInsertion.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.dateInsertion.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.dateInsertion.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.dateInsertion.style'>#=((dateInsertion !== null) ? kendo.toString(dateInsertion, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.dateInsertion.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.dateInsertion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.dateInsertion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9492_89518.column.groupId.title|translate:vc.viewState.QV_9492_89518.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.groupId.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.groupId.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9492_89518\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9492_89518.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9492_89518.column.groupId.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'officerAssigned',
                    title: '{{vc.viewState.QV_9492_89518.column.officerAssigned.title|translate:vc.viewState.QV_9492_89518.column.officerAssigned.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.officerAssigned.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.officerAssigned.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.officerAssigned.style' ng-bind='vc.getStringColumnFormat(dataItem.officerAssigned, \"QV_9492_89518\", \"officerAssigned\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.officerAssigned.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.officerAssigned.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.officerAssigned.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'officeId',
                    title: '{{vc.viewState.QV_9492_89518.column.officeId.title|translate:vc.viewState.QV_9492_89518.column.officeId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.officeId.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.officeId.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.officeId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.officeId, \"QV_9492_89518\", \"officeId\"):kendo.toString(#=officeId#, vc.viewState.QV_9492_89518.column.officeId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9492_89518.column.officeId.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.officeId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.officeId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'groupName',
                    title: '{{vc.viewState.QV_9492_89518.column.groupName.title|translate:vc.viewState.QV_9492_89518.column.groupName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.groupName.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.groupName.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.groupName.style' ng-bind='vc.getStringColumnFormat(dataItem.groupName, \"QV_9492_89518\", \"groupName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.groupName.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.groupName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.groupName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'clientId',
                    title: '{{vc.viewState.QV_9492_89518.column.clientId.title|translate:vc.viewState.QV_9492_89518.column.clientId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.clientId.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.clientId.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.clientId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.clientId, \"QV_9492_89518\", \"clientId\"):kendo.toString(#=clientId#, vc.viewState.QV_9492_89518.column.clientId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9492_89518.column.clientId.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.clientId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.clientId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'clientName',
                    title: '{{vc.viewState.QV_9492_89518.column.clientName.title|translate:vc.viewState.QV_9492_89518.column.clientName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.clientName.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.clientName.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.clientName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientName, \"QV_9492_89518\", \"clientName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.clientName.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.clientName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.clientName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'officerReassigned',
                    title: '{{vc.viewState.QV_9492_89518.column.officerReassigned.title|translate:vc.viewState.QV_9492_89518.column.officerReassigned.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.officerReassigned.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.officerReassigned.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.officerReassigned.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXFND_148782.get(dataItem.officerReassigned).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.officerReassigned.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.officerReassigned.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.officerReassigned.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'officerAssignedId',
                    title: '{{vc.viewState.QV_9492_89518.column.officerAssignedId.title|translate:vc.viewState.QV_9492_89518.column.officerAssignedId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.officerAssignedId.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.officerAssignedId.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.officerAssignedId.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQRC_115782.get(dataItem.officerAssignedId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.officerAssignedId.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.officerAssignedId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.officerAssignedId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'officerReassignedId',
                    title: '{{vc.viewState.QV_9492_89518.column.officerReassignedId.title|translate:vc.viewState.QV_9492_89518.column.officerReassignedId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.officerReassignedId.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.officerReassignedId.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.officerReassignedId.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQAF_920782.get(dataItem.officerReassignedId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.officerReassignedId.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.officerReassignedId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.officerReassignedId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'officeName',
                    title: '{{vc.viewState.QV_9492_89518.column.officeName.title|translate:vc.viewState.QV_9492_89518.column.officeName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.officeName.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.officeName.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.officeName.style' ng-bind='vc.getStringColumnFormat(dataItem.officeName, \"QV_9492_89518\", \"officeName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.officeName.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.officeName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.officeName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'periodicity',
                    title: '{{vc.viewState.QV_9492_89518.column.periodicity.title|translate:vc.viewState.QV_9492_89518.column.periodicity.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.periodicity.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.periodicity.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.periodicity.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXVLO_782782.get(dataItem.periodicity).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.periodicity.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.periodicity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.periodicity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_9492_89518.column.description.title|translate:vc.viewState.QV_9492_89518.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.description.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.description.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_9492_89518\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.description.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9492_89518.columns.push({
                    field: 'auxText',
                    title: '{{vc.viewState.QV_9492_89518.column.auxText.title|translate:vc.viewState.QV_9492_89518.column.auxText.titleArgs}}',
                    width: $scope.vc.viewState.QV_9492_89518.column.auxText.width,
                    format: $scope.vc.viewState.QV_9492_89518.column.auxText.format,
                    template: "<span ng-class='vc.viewState.QV_9492_89518.column.auxText.style' ng-bind='vc.getStringColumnFormat(dataItem.auxText, \"QV_9492_89518\", \"auxText\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9492_89518.column.auxText.style",
                        "title": "{{vc.viewState.QV_9492_89518.column.auxText.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9492_89518.column.auxText.hidden
                });
            }
            $scope.vc.viewState.QV_9492_89518.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_9492_89518.column.cmdEdition = {};
            $scope.vc.viewState.QV_9492_89518.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_9492_89518.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "CreditCandidates",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_9492_89518.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9492_89518.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_CREDITCSNS_624782.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_9492_89518.events.customEdit($event, \"#:entity#\", grids.QV_9492_89518)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_9492_89518.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_9492_89518.toolbar = {
                CEQV_201QV_9492_89518_895: {
                    visible: true
                },
                CEQV_201QV_9492_89518_819: {
                    visible: true
                },
                CEQV_201QV_9492_89518_856: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_9492_89518.toolbar = [{
                "name": "CEQV_201QV_9492_89518_895",
                "template": "<button id='CEQV_201QV_9492_89518_895' " + " ng-if='vc.viewState.QV_9492_89518.toolbar.CEQV_201QV_9492_89518_895.visible' " + "ng-disabled = 'vc.viewState.G_CREDITCSNS_624782.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_9492_89518_895\",\"CreditCandidates\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-square'></span></button>"
            }, {
                "name": "CEQV_201QV_9492_89518_819",
                "template": "<button id='CEQV_201QV_9492_89518_819' " + " ng-if='vc.viewState.QV_9492_89518.toolbar.CEQV_201QV_9492_89518_819.visible' " + "ng-disabled = 'vc.viewState.G_CREDITCSNS_624782.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_9492_89518_819\",\"CreditCandidates\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-check-square'></span></button>"
            }, {
                "name": "CEQV_201QV_9492_89518_856",
                "text": "{{'ASSTS.LBL_ASSTS_SELECCIRR_76753'|translate}}",
                "template": "<button id='CEQV_201QV_9492_89518_856' " + " ng-if='vc.viewState.QV_9492_89518.toolbar.CEQV_201QV_9492_89518_856.visible' " + "ng-disabled = 'vc.viewState.G_CREDITCSNS_624782.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_9492_89518_856\",\"CreditCandidates\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }, {
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_9492_89518.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSTCUPYEAZ_925_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSTCUPYEAZ_925_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TASSTSTC_95A",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_AUTORIZOP_17319",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TASSTSTC_YQ9",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESCARTIP_90248",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TASSTSTC_U29",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_POSPONEOR_18814",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQRC_115782.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQAF_920782.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXVLO_782782.read();
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
                $scope.vc.render('VC_CREDITCAAD_894925');
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
    var cobisMainModule = cobis.createModule("VC_CREDITCAAD_894925", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_CREDITCAAD_894925", {
            templateUrl: "VC_CREDITCAAD_894925_FORM.html",
            controller: "VC_CREDITCAAD_894925_CTRL",
            labelId: "ASSTS.LBL_ASSTS_AUTORIZOE_31479",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CREDITCAAD_894925?" + $.param(search);
            }
        });
        VC_CREDITCAAD_894925(cobisMainModule);
    }]);
} else {
    VC_CREDITCAAD_894925(cobisMainModule);
}