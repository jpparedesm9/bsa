//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.amortizationquotedetailform = designerEvents.api.amortizationquotedetailform || designer.dsgEvents();

function VC_AMORTIZATE_895881(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AMORTIZATE_895881_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AMORTIZATE_895881_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "MNTNN",
            taskId: "T_AMORTIZATIDTE_881",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AMORTIZATE_895881",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_AMORTIZATIDTE_881",
        designerEvents.api.amortizationquotedetailform,
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
                vcName: 'VC_AMORTIZATE_895881'
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
                    subModuleId: 'MNTNN',
                    taskId: 'T_AMORTIZATIDTE_881',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    AmortizationQuoteDetail: "AmortizationQuoteDetail"
                },
                entities: {
                    AmortizationQuoteDetail: {
                        item: 'AT61_ITEMQDYX340',
                        statusItem: 'AT23_STATUSEE340',
                        period: 'AT98_PERIODSM340',
                        quote: 'AT60_QUOTEYPC340',
                        grace: 'AT92_GRACERVL340',
                        paid: 'AT58_PAIDVFCY340',
                        accumulated: 'AT54_ACCUMUAE340',
                        sequential: 'AT56_SEQUENLI340',
                        titleForm: 'AT43_TITLESEZ340',
                        _pks: [],
                        _entityId: 'EN_AMORTIZIQ_340',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_AMORTITT_8477 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_AMORTITT_8477 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMORTITT_8477_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMORTITT_8477_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_AMORTIZIQ_340',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMORTITT_8477',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_AMORTITT_8477_filters = {};
            var defaultValues = {
                AmortizationQuoteDetail: {}
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
                $scope.vc.execute("temporarySave", VC_AMORTIZATE_895881, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_AMORTIZATE_895881, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_AMORTIZATE_895881, data, function() {});
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
            $scope.vc.viewState.VC_AMORTIZATE_895881 = {
                style: []
            }
            //ViewState - Group: Group2966
            $scope.vc.createViewState({
                id: "G_AMORTIZLIA_656813",
                hasId: true,
                componentStyle: [],
                label: 'Group2966',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AmortizationQuoteDetail = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    item: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "item", '')
                    },
                    statusItem: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "statusItem", '')
                    },
                    period: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "period", 0)
                    },
                    quote: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "quote", 0)
                    },
                    grace: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "grace", 0)
                    },
                    paid: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "paid", 0)
                    },
                    accumulated: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "accumulated", 0)
                    },
                    sequential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationQuoteDetail", "sequential", 0)
                    }
                }
            });
            $scope.vc.model.AmortizationQuoteDetail = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_AMORTITT_8477';
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMORTITT_8477();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8477_65404',
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
                    model: $scope.vc.types.AmortizationQuoteDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8477_65404").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMORTITT_8477 = $scope.vc.model.AmortizationQuoteDetail;
            $scope.vc.trackers.AmortizationQuoteDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationQuoteDetail);
            $scope.vc.model.AmortizationQuoteDetail.bind('change', function(e) {
                $scope.vc.trackers.AmortizationQuoteDetail.track(e);
            });
            $scope.vc.grids.QV_8477_65404 = {};
            $scope.vc.grids.QV_8477_65404.queryId = 'Q_AMORTITT_8477';
            $scope.vc.viewState.QV_8477_65404 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8477_65404.column = {};
            $scope.vc.grids.QV_8477_65404.editable = false;
            $scope.vc.grids.QV_8477_65404.events = {
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
                    $scope.vc.trackers.AmortizationQuoteDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8477_65404.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_8477_65404");
                    $scope.vc.hideShowColumns("QV_8477_65404", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8477_65404.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8477_65404.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8477_65404.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8477_65404 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8477_65404 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8477_65404.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8477_65404.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8477_65404.column.item = {
                title: 'ASSTS.LBL_ASSTS_RUBROFKGQ_42963',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKBJ_160813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT61_ITEMQDYX340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.item.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKBJ_160813",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.item.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.item.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.statusItem = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOJL_993813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT23_STATUSEE340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.statusItem.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOJL_993813",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.statusItem.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.statusItem.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.period = {
                title: 'ASSTS.LBL_ASSTS_PERODOLPP_96245',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAZT_394813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT98_PERIODSM340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.period.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAZT_394813",
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.period.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8477_65404.column.period.format",
                        'k-decimals': "vc.viewState.QV_8477_65404.column.period.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.period.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.quote = {
                title: 'ASSTS.LBL_ASSTS_CUOTAJJEW_83973',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVZZ_676813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT60_QUOTEYPC340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.quote.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVZZ_676813",
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.quote.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8477_65404.column.quote.format",
                        'k-decimals': "vc.viewState.QV_8477_65404.column.quote.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.quote.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.grace = {
                title: 'ASSTS.LBL_ASSTS_GRACIAVXF_14263',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOKT_824813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT92_GRACERVL340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.grace.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOKT_824813",
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.grace.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8477_65404.column.grace.format",
                        'k-decimals': "vc.viewState.QV_8477_65404.column.grace.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.grace.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.paid = {
                title: 'ASSTS.LBL_ASSTS_PAGADOQEI_51658',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSWA_743813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT58_PAIDVFCY340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.paid.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSWA_743813",
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.paid.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8477_65404.column.paid.format",
                        'k-decimals': "vc.viewState.QV_8477_65404.column.paid.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.paid.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.accumulated = {
                title: 'ASSTS.LBL_ASSTS_ACUMULAOO_17499',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEEZ_207813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT54_ACCUMUAE340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.accumulated.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEEZ_207813",
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.accumulated.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8477_65404.column.accumulated.format",
                        'k-decimals': "vc.viewState.QV_8477_65404.column.accumulated.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.accumulated.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8477_65404.column.sequential = {
                title: 'ASSTS.LBL_ASSTS_SECUENCAI_43909',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXECP_560813',
                element: []
            };
            $scope.vc.grids.QV_8477_65404.AT56_SEQUENLI340 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8477_65404.column.sequential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXECP_560813",
                        'data-validation-code': "{{vc.viewState.QV_8477_65404.column.sequential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8477_65404.column.sequential.format",
                        'k-decimals': "vc.viewState.QV_8477_65404.column.sequential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8477_65404.column.sequential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'item',
                    title: '{{vc.viewState.QV_8477_65404.column.item.title|translate:vc.viewState.QV_8477_65404.column.item.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.item.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.item.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT61_ITEMQDYX340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.item.style' ng-bind='vc.getStringColumnFormat(dataItem.item, \"QV_8477_65404\", \"item\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8477_65404.column.item.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.item.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.item.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'statusItem',
                    title: '{{vc.viewState.QV_8477_65404.column.statusItem.title|translate:vc.viewState.QV_8477_65404.column.statusItem.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.statusItem.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.statusItem.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT23_STATUSEE340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.statusItem.style' ng-bind='vc.getStringColumnFormat(dataItem.statusItem, \"QV_8477_65404\", \"statusItem\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8477_65404.column.statusItem.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.statusItem.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.statusItem.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'period',
                    title: '{{vc.viewState.QV_8477_65404.column.period.title|translate:vc.viewState.QV_8477_65404.column.period.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.period.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.period.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT98_PERIODSM340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.period.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.period, \"QV_8477_65404\", \"period\"):kendo.toString(#=period#, vc.viewState.QV_8477_65404.column.period.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8477_65404.column.period.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.period.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.period.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'quote',
                    title: '{{vc.viewState.QV_8477_65404.column.quote.title|translate:vc.viewState.QV_8477_65404.column.quote.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.quote.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.quote.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT60_QUOTEYPC340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.quote.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quote, \"QV_8477_65404\", \"quote\"):kendo.toString(#=quote#, vc.viewState.QV_8477_65404.column.quote.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8477_65404.column.quote.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.quote.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.quote.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'grace',
                    title: '{{vc.viewState.QV_8477_65404.column.grace.title|translate:vc.viewState.QV_8477_65404.column.grace.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.grace.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.grace.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT92_GRACERVL340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.grace.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.grace, \"QV_8477_65404\", \"grace\"):kendo.toString(#=grace#, vc.viewState.QV_8477_65404.column.grace.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8477_65404.column.grace.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.grace.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.grace.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'paid',
                    title: '{{vc.viewState.QV_8477_65404.column.paid.title|translate:vc.viewState.QV_8477_65404.column.paid.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.paid.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.paid.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT58_PAIDVFCY340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.paid.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.paid, \"QV_8477_65404\", \"paid\"):kendo.toString(#=paid#, vc.viewState.QV_8477_65404.column.paid.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8477_65404.column.paid.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.paid.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.paid.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'accumulated',
                    title: '{{vc.viewState.QV_8477_65404.column.accumulated.title|translate:vc.viewState.QV_8477_65404.column.accumulated.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.accumulated.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.accumulated.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT54_ACCUMUAE340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.accumulated.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.accumulated, \"QV_8477_65404\", \"accumulated\"):kendo.toString(#=accumulated#, vc.viewState.QV_8477_65404.column.accumulated.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8477_65404.column.accumulated.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.accumulated.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.accumulated.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8477_65404.columns.push({
                    field: 'sequential',
                    title: '{{vc.viewState.QV_8477_65404.column.sequential.title|translate:vc.viewState.QV_8477_65404.column.sequential.titleArgs}}',
                    width: $scope.vc.viewState.QV_8477_65404.column.sequential.width,
                    format: $scope.vc.viewState.QV_8477_65404.column.sequential.format,
                    editor: $scope.vc.grids.QV_8477_65404.AT56_SEQUENLI340.control,
                    template: "<span ng-class='vc.viewState.QV_8477_65404.column.sequential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequential, \"QV_8477_65404\", \"sequential\"):kendo.toString(#=sequential#, vc.viewState.QV_8477_65404.column.sequential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8477_65404.column.sequential.style",
                        "title": "{{vc.viewState.QV_8477_65404.column.sequential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8477_65404.column.sequential.hidden
                });
            }
            $scope.vc.viewState.QV_8477_65404.toolbar = {}
            $scope.vc.grids.QV_8477_65404.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_AMORTIZATIDTE_881_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_AMORTIZATIDTE_881_CANCEL",
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
                $scope.vc.render('VC_AMORTIZATE_895881');
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
    var cobisMainModule = cobis.createModule("VC_AMORTIZATE_895881", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_AMORTIZATE_895881", {
            templateUrl: "VC_AMORTIZATE_895881_FORM.html",
            controller: "VC_AMORTIZATE_895881_CTRL",
            label: "AmortizationQuoteDetailForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AMORTIZATE_895881?" + $.param(search);
            }
        });
        VC_AMORTIZATE_895881(cobisMainModule);
    }]);
} else {
    VC_AMORTIZATE_895881(cobisMainModule);
}