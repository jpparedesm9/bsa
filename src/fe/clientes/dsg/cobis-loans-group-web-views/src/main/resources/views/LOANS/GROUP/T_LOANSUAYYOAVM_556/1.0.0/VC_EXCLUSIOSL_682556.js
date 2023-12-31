//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.exclusionlist = designerEvents.api.exclusionlist || designer.dsgEvents();

function VC_EXCLUSIOSL_682556(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_EXCLUSIOSL_682556_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_EXCLUSIOSL_682556_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANSUAYYOAVM_556",
            taskVersion: "1.0.0",
            viewContainerId: "VC_EXCLUSIOSL_682556",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_LOANSUAYYOAVM_556",
        designerEvents.api.exclusionlist,
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
                vcName: 'VC_EXCLUSIOSL_682556'
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
                    taskId: 'T_LOANSUAYYOAVM_556',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ExclusionListResult: "ExclusionListResult",
                    CustomerExclusionList: "CustomerExclusionList"
                },
                entities: {
                    ExclusionListResult: {
                        rfc: 'AT12_RFCKWUBH143',
                        curp: 'AT14_CURPHYFZ143',
                        score: 'AT27_SCORECDE143',
                        customerName: 'AT36_CUSTOMEM143',
                        customerId: 'AT43_CUSTOMDD143',
                        _pks: [],
                        _entityId: 'EN_EXCLUSIIL_143',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CustomerExclusionList: {
                        customerId: 'AT16_CUSTOMER622',
                        customerName: 'AT31_CUSTOMER622',
                        score: 'AT48_SCORERTS622',
                        operation: 'AT84_OPERATON622',
                        _pks: [],
                        _entityId: 'EN_CUSTOMENL_622',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_EXCLUSIR_9905 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_EXCLUSIR_9905 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_EXCLUSIR_9905_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_EXCLUSIR_9905_filters;
                    parametersAux = {
                        customerId: filters.customerId,
                        score: filters.score
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_EXCLUSIIL_143',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_EXCLUSIR_9905',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['customerId'] = this.filters.customerId;
                            this.parameters['score'] = this.filters.score;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_EXCLUSIR_9905_filters = {};
            var defaultValues = {
                ExclusionListResult: {},
                CustomerExclusionList: {}
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
                $scope.vc.execute("temporarySave", VC_EXCLUSIOSL_682556, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_EXCLUSIOSL_682556, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_EXCLUSIOSL_682556, data, function() {});
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
            $scope.vc.viewState.VC_EXCLUSIOSL_682556 = {
                style: []
            }
            $scope.vc.model.CustomerExclusionList = {
                customerId: $scope.vc.channelDefaultValues("CustomerExclusionList", "customerId"),
                customerName: $scope.vc.channelDefaultValues("CustomerExclusionList", "customerName"),
                score: $scope.vc.channelDefaultValues("CustomerExclusionList", "score"),
                operation: $scope.vc.channelDefaultValues("CustomerExclusionList", "operation")
            };
            //ViewState - Group: Group1799
            $scope.vc.createViewState({
                id: "G_EXCLUSILTN_555111",
                hasId: true,
                componentStyle: [],
                label: 'Group1799',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerExclusionList, Attribute: customerName
            $scope.vc.createViewState({
                id: "VA_1DMKLRVJHUHQTTF_212111",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CLIENTEMZ_77659",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONCMTSGNP_601111",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_BUSCARVEI_85408",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerExclusionList, Attribute: score
            $scope.vc.createViewState({
                id: "VA_SCORENCQIGXRWIM_712111",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CALIFICCC_80806",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONARFKGXV_821111",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_EXCLUIRNI_54992",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2994
            $scope.vc.createViewState({
                id: "G_EXCLUSIIIT_519111",
                hasId: true,
                componentStyle: [],
                label: 'Group2994',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ExclusionListResult = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExclusionListResult", "customerId", 0)
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExclusionListResult", "customerName", '')
                    },
                    rfc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExclusionListResult", "rfc", '')
                    },
                    curp: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExclusionListResult", "curp", '')
                    },
                    score: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExclusionListResult", "score", '')
                    }
                }
            });
            $scope.vc.model.ExclusionListResult = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_EXCLUSIR_9905';
                            var queryRequest = $scope.vc.getRequestQuery_Q_EXCLUSIR_9905();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9905_87019',
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ExclusionListResult',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9905_87019', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ExclusionListResult',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9905_87019', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
                            if (!args.cancel) {
                                options.success(args.row);
                            } else {
                                options.error(new Error('DeletingError'));
                            }
                        });
                        // end block
                    }
                },
                schema: {
                    model: $scope.vc.types.ExclusionListResult
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9905_87019").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EXCLUSIR_9905 = $scope.vc.model.ExclusionListResult;
            $scope.vc.trackers.ExclusionListResult = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ExclusionListResult);
            $scope.vc.model.ExclusionListResult.bind('change', function(e) {
                $scope.vc.trackers.ExclusionListResult.track(e);
            });
            $scope.vc.grids.QV_9905_87019 = {};
            $scope.vc.grids.QV_9905_87019.queryId = 'Q_EXCLUSIR_9905';
            $scope.vc.viewState.QV_9905_87019 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9905_87019.column = {};
            $scope.vc.grids.QV_9905_87019.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_9905_87019.events = {
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
                cancel: function(e) {
                    $scope.vc.trackers.ExclusionListResult.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9905_87019.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_9905_87019', this.dataSource);
                },
                excel: {
                    fileName: 'QV_9905_87019.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_9905_87019.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9905_87019");
                    $scope.vc.hideShowColumns("QV_9905_87019", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9905_87019.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9905_87019.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9905_87019.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9905_87019 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9905_87019 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9905_87019.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9905_87019.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9905_87019.column.customerId = {
                title: 'LOANS.LBL_LOANS_CODSFGYLD_47406',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTIX_907111',
                element: []
            };
            $scope.vc.grids.QV_9905_87019.AT43_CUSTOMDD143 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9905_87019.column.customerId.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9905_87019.column.customerName = {
                title: 'LOANS.LBL_LOANS_CLIENTEMZ_77659',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLXG_513111',
                element: []
            };
            $scope.vc.grids.QV_9905_87019.AT36_CUSTOMEM143 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9905_87019.column.customerName.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9905_87019.column.rfc = {
                title: 'LOANS.LBL_LOANS_RFCWDDWNX_24744',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBBY_744111',
                element: []
            };
            $scope.vc.grids.QV_9905_87019.AT12_RFCKWUBH143 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9905_87019.column.rfc.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9905_87019.column.curp = {
                title: 'LOANS.LBL_LOANS_CURPDBSLN_36727',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWLT_609111',
                element: []
            };
            $scope.vc.grids.QV_9905_87019.AT14_CURPHYFZ143 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9905_87019.column.curp.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9905_87019.column.score = {
                title: 'LOANS.LBL_LOANS_CALIFICCC_80806',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRFU_752111',
                element: []
            };
            $scope.vc.grids.QV_9905_87019.AT27_SCORECDE143 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9905_87019.column.score.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9905_87019.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_9905_87019.column.customerId.title|translate:vc.viewState.QV_9905_87019.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9905_87019.column.customerId.width,
                    format: $scope.vc.viewState.QV_9905_87019.column.customerId.format,
                    editor: $scope.vc.grids.QV_9905_87019.AT43_CUSTOMDD143.control,
                    template: "<span ng-class='vc.viewState.QV_9905_87019.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_9905_87019\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_9905_87019.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9905_87019.column.customerId.style",
                        "title": "{{vc.viewState.QV_9905_87019.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9905_87019.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9905_87019.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_9905_87019.column.customerName.title|translate:vc.viewState.QV_9905_87019.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9905_87019.column.customerName.width,
                    format: $scope.vc.viewState.QV_9905_87019.column.customerName.format,
                    editor: $scope.vc.grids.QV_9905_87019.AT36_CUSTOMEM143.control,
                    template: "<span ng-class='vc.viewState.QV_9905_87019.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_9905_87019\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9905_87019.column.customerName.style",
                        "title": "{{vc.viewState.QV_9905_87019.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9905_87019.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9905_87019.columns.push({
                    field: 'rfc',
                    title: '{{vc.viewState.QV_9905_87019.column.rfc.title|translate:vc.viewState.QV_9905_87019.column.rfc.titleArgs}}',
                    width: $scope.vc.viewState.QV_9905_87019.column.rfc.width,
                    format: $scope.vc.viewState.QV_9905_87019.column.rfc.format,
                    editor: $scope.vc.grids.QV_9905_87019.AT12_RFCKWUBH143.control,
                    template: "<span ng-class='vc.viewState.QV_9905_87019.column.rfc.style' ng-bind='vc.getStringColumnFormat(dataItem.rfc, \"QV_9905_87019\", \"rfc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9905_87019.column.rfc.style",
                        "title": "{{vc.viewState.QV_9905_87019.column.rfc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9905_87019.column.rfc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9905_87019.columns.push({
                    field: 'curp',
                    title: '{{vc.viewState.QV_9905_87019.column.curp.title|translate:vc.viewState.QV_9905_87019.column.curp.titleArgs}}',
                    width: $scope.vc.viewState.QV_9905_87019.column.curp.width,
                    format: $scope.vc.viewState.QV_9905_87019.column.curp.format,
                    editor: $scope.vc.grids.QV_9905_87019.AT14_CURPHYFZ143.control,
                    template: "<span ng-class='vc.viewState.QV_9905_87019.column.curp.style' ng-bind='vc.getStringColumnFormat(dataItem.curp, \"QV_9905_87019\", \"curp\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9905_87019.column.curp.style",
                        "title": "{{vc.viewState.QV_9905_87019.column.curp.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9905_87019.column.curp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9905_87019.columns.push({
                    field: 'score',
                    title: '{{vc.viewState.QV_9905_87019.column.score.title|translate:vc.viewState.QV_9905_87019.column.score.titleArgs}}',
                    width: $scope.vc.viewState.QV_9905_87019.column.score.width,
                    format: $scope.vc.viewState.QV_9905_87019.column.score.format,
                    editor: $scope.vc.grids.QV_9905_87019.AT27_SCORECDE143.control,
                    template: "<span ng-class='vc.viewState.QV_9905_87019.column.score.style' ng-bind='vc.getStringColumnFormat(dataItem.score, \"QV_9905_87019\", \"score\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9905_87019.column.score.style",
                        "title": "{{vc.viewState.QV_9905_87019.column.score.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9905_87019.column.score.hidden
                });
            }
            $scope.vc.viewState.QV_9905_87019.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_9905_87019.column.cmdEdition = {};
            $scope.vc.viewState.QV_9905_87019.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_9905_87019.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_9905_87019.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9905_87019.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_EXCLUSIIIT_519111.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_9905_87019.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_9905_87019.toolbar = {}
            $scope.vc.grids.QV_9905_87019.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_9905_87019.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSUAYYOAVM_556_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSUAYYOAVM_556_CANCEL",
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
                $scope.vc.render('VC_EXCLUSIOSL_682556');
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
    var cobisMainModule = cobis.createModule("VC_EXCLUSIOSL_682556", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_EXCLUSIOSL_682556", {
            templateUrl: "VC_EXCLUSIOSL_682556_FORM.html",
            controller: "VC_EXCLUSIOSL_682556_CTRL",
            labelId: "LOANS.LBL_LOANS_AADIRCLNI_32293",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_EXCLUSIOSL_682556?" + $.param(search);
            }
        });
        VC_EXCLUSIOSL_682556(cobisMainModule);
    }]);
} else {
    VC_EXCLUSIOSL_682556(cobisMainModule);
}