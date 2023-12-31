//Designer Generator v 6.5.0 - release SPR 2017-18 15/09/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.terminalmanagementform = designerEvents.api.terminalmanagementform || designer.dsgEvents();

function VC_TERMINALAA_708522(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TERMINALAA_708522_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TERMINALAA_708522_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "MBILE",
            subModuleId: "ADMIN",
            taskId: "T_MBILEHJPNKLMQ_522",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TERMINALAA_708522",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/MBILE/ADMIN/T_MBILEHJPNKLMQ_522",
        designerEvents.api.terminalmanagementform,
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
                vcName: 'VC_TERMINALAA_708522'
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
                    moduleId: 'MBILE',
                    subModuleId: 'ADMIN',
                    taskId: 'T_MBILEHJPNKLMQ_522',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Terminal: "Terminal",
                    TerminalFiltro: "TerminalFiltro"
                },
                entities: {
                    Terminal: {
                        reference1: 'AT18_REFEREE1822',
                        reference2: 'AT35_REFERE2E822',
                        mac1: 'AT43_MAC1TXFG822',
                        filterName: 'AT49_FILTERNA822',
                        filterValue: 'AT70_FILTERLU822',
                        mac2: 'AT85_MAC2ABMR822',
                        mac: 'AT87_MACKIYSS822',
                        _pks: [],
                        _entityId: 'EN_TERMINALL_822',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    TerminalFiltro: {
                        filterValue: 'AT20_MACQXRUZ466',
                        filterName: 'AT30_NOMBREFK466',
                        _pks: [],
                        _entityId: 'EN_TERMINAIL_466',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_TERMINAIL_466',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_TERMINALL_822',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT20_MACQXRUZ466',
                        attributeIdFk: 'AT70_FILTERLU822'
                    }, {
                        attributeIdPk: 'AT30_NOMBREFK466',
                        attributeIdFk: 'AT49_FILTERNA822'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_TERMINLA_5241 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_TERMINLA_5241 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TERMINLA_5241_filters)) {
                    parametersAux = {
                        filterName: $scope.vc.model.TerminalFiltro.filterName,
                        filterValue: $scope.vc.model.TerminalFiltro.filterValue
                    };
                } else {
                    var filters = $scope.vc.queries.Q_TERMINLA_5241_filters;
                    parametersAux = {
                        filterName: filters.filterName,
                        filterValue: filters.filterValue
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_TERMINALL_822',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TERMINLA_5241',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['filterName'] = $scope.vc.model.TerminalFiltro.filterName;
                            this.parameters['filterValue'] = $scope.vc.model.TerminalFiltro.filterValue;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['filterName'] = this.filters.filterName;
                            this.parameters['filterValue'] = this.filters.filterValue;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_TERMINLA_5241_filters = {};
            var defaultValues = {
                Terminal: {},
                TerminalFiltro: {}
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
                $scope.vc.execute("temporarySave", VC_TERMINALAA_708522, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_TERMINALAA_708522, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_TERMINALAA_708522, data, function() {});
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
            $scope.vc.viewState.VC_TERMINALAA_708522 = {
                style: []
            }
            $scope.vc.model.TerminalFiltro = {
                filterValue: $scope.vc.channelDefaultValues("TerminalFiltro", "filterValue"),
                filterName: $scope.vc.channelDefaultValues("TerminalFiltro", "filterName")
            };
            //ViewState - Group: Group1443
            $scope.vc.createViewState({
                id: "G_TERMINANNL_722748",
                hasId: true,
                componentStyle: [],
                label: 'Group1443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TerminalFiltro, Attribute: filterName
            $scope.vc.createViewState({
                id: "VA_FILTERNAMECVENW_287748",
                componentStyle: [],
                label: "MBILE.LBL_MBILE_FILTROJOB_79801",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_FILTERNAMECVENW_287748 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_FILTERNAMECVENW_287748', 'cr_filtro_terminal', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_FILTERNAMECVENW_287748'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_FILTERNAMECVENW_287748");
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
            //ViewState - Entity: TerminalFiltro, Attribute: filterValue
            $scope.vc.createViewState({
                id: "VA_FILTERVALUEKKSF_591748",
                componentStyle: [],
                label: "MBILE.LBL_MBILE_VALORYWZX_55284",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VAIMAGEBUTTONNN_867748",
                componentStyle: [],
                imageId: "fa fa-search",
                label: '',
                queryId: 'Q_TERMINLA_5241',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1719
            $scope.vc.createViewState({
                id: "G_TERMINALME_421748",
                hasId: true,
                componentStyle: [],
                label: 'Group1719',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Terminal = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    reference1: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Terminal", "reference1", '')
                    },
                    mac: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Terminal", "mac", '')
                    },
                    mac1: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Terminal", "mac1", '')
                    },
                    mac2: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Terminal", "mac2", '')
                    },
                    reference2: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Terminal", "reference2", '')
                    },
                    filterName: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TerminalFiltro.filterName
                        }
                    },
                    filterValue: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TerminalFiltro.filterValue
                        }
                    }
                }
            });
            $scope.vc.model.Terminal = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_TERMINLA_5241';
                            var queryRequest = $scope.vc.getRequestQuery_Q_TERMINLA_5241();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5241_65721',
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
                                            'pageSize': 10
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
                            nameEntityGrid: 'Terminal',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5241_65721', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Terminal',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5241_65721', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Terminal',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5241_65721', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Terminal
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5241_65721").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TERMINLA_5241 = $scope.vc.model.Terminal;
            $scope.vc.trackers.Terminal = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Terminal);
            $scope.vc.model.Terminal.bind('change', function(e) {
                $scope.vc.trackers.Terminal.track(e);
            });
            $scope.vc.grids.QV_5241_65721 = {};
            $scope.vc.grids.QV_5241_65721.queryId = 'Q_TERMINLA_5241';
            $scope.vc.viewState.QV_5241_65721 = {
                style: []
            };
            $scope.vc.viewState.QV_5241_65721.column = {};
            $scope.vc.grids.QV_5241_65721.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_5241_65721.events = {
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
                    $scope.vc.trackers.Terminal.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_5241_65721.selectedRow = e.model;
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_5241_65721", false, grid);
                    $scope.vc.hideShowColumns("QV_5241_65721", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5241_65721.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5241_65721.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5241_65721.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5241_65721 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5241_65721 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5241_65721.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5241_65721.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5241_65721.column.reference1 = {
                title: 'MBILE.LBL_MBILE_NOMBREDEP_23258',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVTG_534748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT18_REFEREE1822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.reference1.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVTG_534748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.reference1.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.reference1.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5241_65721.column.mac = {
                title: 'MBILE.LBL_MBILE_MACADDRSE_57169',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "^[a-zA-Z0-9_.-]*$",
                decimals: 4,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNYI_718748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT87_MACKIYSS822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.mac.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNYI_718748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.mac.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.mac.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5241_65721.column.mac1 = {
                title: 'MBILE.LBL_MBILE_MACADDRSE_94280',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFTY_929748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT43_MAC1TXFG822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.mac1.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFTY_929748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.mac1.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.mac1.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5241_65721.column.mac2 = {
                title: 'MBILE.LBL_MBILE_MACADDRSE_34964',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWQI_710748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT85_MAC2ABMR822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.mac2.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWQI_710748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.mac2.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.mac2.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5241_65721.column.reference2 = {
                title: 'MBILE.LBL_MBILE_DESCRIPCN_22728',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXXE_799748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT35_REFERE2E822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.reference2.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXXE_799748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.reference2.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.reference2.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5241_65721.column.filterName = {
                title: 'filterName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRPK_557748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT49_FILTERNA822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.filterName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRPK_557748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.filterName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.filterName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5241_65721.column.filterValue = {
                title: 'filterValue',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMRD_773748',
                element: []
            };
            $scope.vc.grids.QV_5241_65721.AT70_FILTERLU822 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5241_65721.column.filterValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMRD_773748",
                        'data-validation-code': "{{vc.viewState.QV_5241_65721.column.filterValue.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5241_65721.column.filterValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'reference1',
                    title: '{{vc.viewState.QV_5241_65721.column.reference1.title|translate:vc.viewState.QV_5241_65721.column.reference1.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.reference1.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.reference1.format,
                    editor: $scope.vc.grids.QV_5241_65721.AT18_REFEREE1822.control,
                    template: "<span ng-class='vc.viewState.QV_5241_65721.column.reference1.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.reference1, \"QV_5241_65721\", \"reference1\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.reference1.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.reference1.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.reference1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'mac',
                    title: '{{vc.viewState.QV_5241_65721.column.mac.title|translate:vc.viewState.QV_5241_65721.column.mac.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.mac.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.mac.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_5241_65721', 'mac', $scope.vc.grids.QV_5241_65721.AT87_MACKIYSS822.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_5241_65721', 'mac', "<span ng-class='vc.viewState.QV_5241_65721.column.mac.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.mac, \"QV_5241_65721\", \"mac\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.mac.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.mac.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.mac.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'mac1',
                    title: '{{vc.viewState.QV_5241_65721.column.mac1.title|translate:vc.viewState.QV_5241_65721.column.mac1.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.mac1.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.mac1.format,
                    editor: $scope.vc.grids.QV_5241_65721.AT43_MAC1TXFG822.control,
                    template: "<span ng-class='vc.viewState.QV_5241_65721.column.mac1.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.mac1, \"QV_5241_65721\", \"mac1\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.mac1.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.mac1.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.mac1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'mac2',
                    title: '{{vc.viewState.QV_5241_65721.column.mac2.title|translate:vc.viewState.QV_5241_65721.column.mac2.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.mac2.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.mac2.format,
                    editor: $scope.vc.grids.QV_5241_65721.AT85_MAC2ABMR822.control,
                    template: "<span ng-class='vc.viewState.QV_5241_65721.column.mac2.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.mac2, \"QV_5241_65721\", \"mac2\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.mac2.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.mac2.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.mac2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'reference2',
                    title: '{{vc.viewState.QV_5241_65721.column.reference2.title|translate:vc.viewState.QV_5241_65721.column.reference2.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.reference2.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.reference2.format,
                    editor: $scope.vc.grids.QV_5241_65721.AT35_REFERE2E822.control,
                    template: "<span ng-class='vc.viewState.QV_5241_65721.column.reference2.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.reference2, \"QV_5241_65721\", \"reference2\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.reference2.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.reference2.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.reference2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'filterName',
                    title: '{{vc.viewState.QV_5241_65721.column.filterName.title|translate:vc.viewState.QV_5241_65721.column.filterName.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.filterName.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.filterName.format,
                    editor: $scope.vc.grids.QV_5241_65721.AT49_FILTERNA822.control,
                    template: "<span ng-class='vc.viewState.QV_5241_65721.column.filterName.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.filterName, \"QV_5241_65721\", \"filterName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.filterName.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.filterName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.filterName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5241_65721.columns.push({
                    field: 'filterValue',
                    title: '{{vc.viewState.QV_5241_65721.column.filterValue.title|translate:vc.viewState.QV_5241_65721.column.filterValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_5241_65721.column.filterValue.width,
                    format: $scope.vc.viewState.QV_5241_65721.column.filterValue.format,
                    editor: $scope.vc.grids.QV_5241_65721.AT70_FILTERLU822.control,
                    template: "<span ng-class='vc.viewState.QV_5241_65721.column.filterValue.element[dataItem.dsgnrId].style' ng-bind='vc.getStringColumnFormat(dataItem.filterValue, \"QV_5241_65721\", \"filterValue\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5241_65721.column.filterValue.style",
                        "title": "{{vc.viewState.QV_5241_65721.column.filterValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5241_65721.column.filterValue.hidden
                });
            }
            $scope.vc.viewState.QV_5241_65721.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5241_65721.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_5241_65721.column.cmdEdition = {};
            $scope.vc.viewState.QV_5241_65721.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_5241_65721.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_5241_65721.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5241_65721.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_TERMINALME_421748.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': (vc.confirmDeleteRow)?false:true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_5241_65721.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5241_65721.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_TERMINALME_421748.disabled==true?true:false) " + "ng-click='(vc.confirmDeleteRow) && vc.confirmDeleteRow(dataItem, \"QV_5241_65721\")'" + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_5241_65721.column.cmdEdition.hidden,
                width: Number(sessionStorage.columnSize) || 100
            });
            $scope.vc.viewState.QV_5241_65721.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_5241_65721.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_5241_65721.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_TERMINALME_421748.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_MBILEHJPNKLMQ_522_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_MBILEHJPNKLMQ_522_CANCEL",
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
                $scope.vc.render('VC_TERMINALAA_708522');
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
    var cobisMainModule = cobis.createModule("VC_TERMINALAA_708522", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "MBILE"]);
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
        $routeProvider.when("/VC_TERMINALAA_708522", {
            templateUrl: "VC_TERMINALAA_708522_FORM.html",
            controller: "VC_TERMINALAA_708522_CTRL",
            label: "TerminalManagementForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('MBILE');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TERMINALAA_708522?" + $.param(search);
            }
        });
        VC_TERMINALAA_708522(cobisMainModule);
    }]);
} else {
    VC_TERMINALAA_708522(cobisMainModule);
}