//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.transactiondetailform = designerEvents.api.transactiondetailform || designer.dsgEvents();

function VC_TRANSACTDE_986486(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TRANSACTDE_986486_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TRANSACTDE_986486_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSCJVXOOMB_486",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TRANSACTDE_986486",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSCJVXOOMB_486",
        designerEvents.api.transactiondetailform,
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
                vcName: 'VC_TRANSACTDE_986486'
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
                    taskId: 'T_ASSTSCJVXOOMB_486',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    TransactionDetail: "TransactionDetail"
                },
                entities: {
                    TransactionDetail: {
                        transactionConcept: 'AT32_TRANSAOO988',
                        amount: 'AT44_AMOUNTVT988',
                        sequence: 'AT45_SEQUENCC988',
                        transactionStatus: 'AT62_TRANSACA988',
                        transactionFee: 'AT79_TRANSAUI988',
                        valueCode: 'AT92_VALUECEO988',
                        _pks: [],
                        _entityId: 'EN_TRANSACOI_988',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_TRANSAOI_8690 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_TRANSAOI_8690 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TRANSAOI_8690_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TRANSAOI_8690_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_TRANSACOI_988',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TRANSAOI_8690',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_TRANSAOI_8690_filters = {};
            var defaultValues = {
                TransactionDetail: {}
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
                $scope.vc.execute("temporarySave", VC_TRANSACTDE_986486, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_TRANSACTDE_986486, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_TRANSACTDE_986486, data, function() {});
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
            $scope.vc.viewState.VC_TRANSACTDE_986486 = {
                style: []
            }
            //ViewState - Group: GroupLayout1147
            $scope.vc.createViewState({
                id: "G_TRANSACITO_604566",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1147',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1535
            $scope.vc.createViewState({
                id: "G_TRANSACETT_296566",
                hasId: true,
                componentStyle: [],
                label: 'Group1535',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.TransactionDetail = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    transactionConcept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionDetail", "transactionConcept", '')
                    },
                    transactionStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionDetail", "transactionStatus", '')
                    },
                    transactionFee: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionDetail", "transactionFee", '')
                    },
                    sequence: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionDetail", "sequence", '')
                    },
                    valueCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionDetail", "valueCode", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("TransactionDetail", "amount", 0)
                    }
                }
            });
            $scope.vc.model.TransactionDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_TRANSAOI_8690';
                            var queryRequest = $scope.vc.getRequestQuery_Q_TRANSAOI_8690();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8690_22996',
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
                    model: $scope.vc.types.TransactionDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8690_22996").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TRANSAOI_8690 = $scope.vc.model.TransactionDetail;
            $scope.vc.trackers.TransactionDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.TransactionDetail);
            $scope.vc.model.TransactionDetail.bind('change', function(e) {
                $scope.vc.trackers.TransactionDetail.track(e);
            });
            $scope.vc.grids.QV_8690_22996 = {};
            $scope.vc.grids.QV_8690_22996.queryId = 'Q_TRANSAOI_8690';
            $scope.vc.viewState.QV_8690_22996 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8690_22996.column = {};
            $scope.vc.grids.QV_8690_22996.editable = false;
            $scope.vc.grids.QV_8690_22996.events = {
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
                    $scope.vc.trackers.TransactionDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8690_22996.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_8690_22996");
                    $scope.vc.hideShowColumns("QV_8690_22996", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8690_22996.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8690_22996.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8690_22996.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8690_22996 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8690_22996 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8690_22996.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8690_22996.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8690_22996.column.transactionConcept = {
                title: 'ASSTS.LBL_ASSTS_CONCEPTOO_16181',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDSM_946566',
                element: []
            };
            $scope.vc.grids.QV_8690_22996.AT32_TRANSAOO988 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8690_22996.column.transactionConcept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDSM_946566",
                        'data-validation-code': "{{vc.viewState.QV_8690_22996.column.transactionConcept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACITO_604566,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8690_22996.column.transactionConcept.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8690_22996.column.transactionStatus = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKDB_936566',
                element: []
            };
            $scope.vc.grids.QV_8690_22996.AT62_TRANSACA988 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8690_22996.column.transactionStatus.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKDB_936566",
                        'data-validation-code': "{{vc.viewState.QV_8690_22996.column.transactionStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACITO_604566,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8690_22996.column.transactionStatus.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8690_22996.column.transactionFee = {
                title: 'ASSTS.LBL_ASSTS_CUOTAJJEW_83973',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBXQ_653566',
                element: []
            };
            $scope.vc.grids.QV_8690_22996.AT79_TRANSAUI988 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8690_22996.column.transactionFee.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBXQ_653566",
                        'data-validation-code': "{{vc.viewState.QV_8690_22996.column.transactionFee.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACITO_604566,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8690_22996.column.transactionFee.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8690_22996.column.sequence = {
                title: 'ASSTS.LBL_ASSTS_SECUENCAI_43909',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHLG_914566',
                element: []
            };
            $scope.vc.grids.QV_8690_22996.AT45_SEQUENCC988 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8690_22996.column.sequence.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHLG_914566",
                        'data-validation-code': "{{vc.viewState.QV_8690_22996.column.sequence.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACITO_604566,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8690_22996.column.sequence.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8690_22996.column.valueCode = {
                title: 'ASSTS.LBL_ASSTS_CDIGOVARR_64856',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIXR_425566',
                element: []
            };
            $scope.vc.grids.QV_8690_22996.AT92_VALUECEO988 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8690_22996.column.valueCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIXR_425566",
                        'data-validation-code': "{{vc.viewState.QV_8690_22996.column.valueCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACITO_604566,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8690_22996.column.valueCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8690_22996.column.amount = {
                title: 'ASSTS.LBL_ASSTS_MONTOEMFX_52083',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBIW_371566',
                element: []
            };
            $scope.vc.grids.QV_8690_22996.AT44_AMOUNTVT988 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8690_22996.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBIW_371566",
                        'data-validation-code': "{{vc.viewState.QV_8690_22996.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8690_22996.column.amount.format",
                        'k-decimals': "vc.viewState.QV_8690_22996.column.amount.decimals",
                        'data-cobis-group': "GroupLayout,G_TRANSACITO_604566,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8690_22996.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8690_22996.columns.push({
                    field: 'transactionConcept',
                    title: '{{vc.viewState.QV_8690_22996.column.transactionConcept.title|translate:vc.viewState.QV_8690_22996.column.transactionConcept.titleArgs}}',
                    width: $scope.vc.viewState.QV_8690_22996.column.transactionConcept.width,
                    format: $scope.vc.viewState.QV_8690_22996.column.transactionConcept.format,
                    editor: $scope.vc.grids.QV_8690_22996.AT32_TRANSAOO988.control,
                    template: "<span ng-class='vc.viewState.QV_8690_22996.column.transactionConcept.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionConcept, \"QV_8690_22996\", \"transactionConcept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8690_22996.column.transactionConcept.style",
                        "title": "{{vc.viewState.QV_8690_22996.column.transactionConcept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8690_22996.column.transactionConcept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8690_22996.columns.push({
                    field: 'transactionStatus',
                    title: '{{vc.viewState.QV_8690_22996.column.transactionStatus.title|translate:vc.viewState.QV_8690_22996.column.transactionStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_8690_22996.column.transactionStatus.width,
                    format: $scope.vc.viewState.QV_8690_22996.column.transactionStatus.format,
                    editor: $scope.vc.grids.QV_8690_22996.AT62_TRANSACA988.control,
                    template: "<span ng-class='vc.viewState.QV_8690_22996.column.transactionStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionStatus, \"QV_8690_22996\", \"transactionStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8690_22996.column.transactionStatus.style",
                        "title": "{{vc.viewState.QV_8690_22996.column.transactionStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8690_22996.column.transactionStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8690_22996.columns.push({
                    field: 'transactionFee',
                    title: '{{vc.viewState.QV_8690_22996.column.transactionFee.title|translate:vc.viewState.QV_8690_22996.column.transactionFee.titleArgs}}',
                    width: $scope.vc.viewState.QV_8690_22996.column.transactionFee.width,
                    format: $scope.vc.viewState.QV_8690_22996.column.transactionFee.format,
                    editor: $scope.vc.grids.QV_8690_22996.AT79_TRANSAUI988.control,
                    template: "<span ng-class='vc.viewState.QV_8690_22996.column.transactionFee.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionFee, \"QV_8690_22996\", \"transactionFee\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8690_22996.column.transactionFee.style",
                        "title": "{{vc.viewState.QV_8690_22996.column.transactionFee.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8690_22996.column.transactionFee.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8690_22996.columns.push({
                    field: 'sequence',
                    title: '{{vc.viewState.QV_8690_22996.column.sequence.title|translate:vc.viewState.QV_8690_22996.column.sequence.titleArgs}}',
                    width: $scope.vc.viewState.QV_8690_22996.column.sequence.width,
                    format: $scope.vc.viewState.QV_8690_22996.column.sequence.format,
                    editor: $scope.vc.grids.QV_8690_22996.AT45_SEQUENCC988.control,
                    template: "<span ng-class='vc.viewState.QV_8690_22996.column.sequence.style' ng-bind='vc.getStringColumnFormat(dataItem.sequence, \"QV_8690_22996\", \"sequence\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8690_22996.column.sequence.style",
                        "title": "{{vc.viewState.QV_8690_22996.column.sequence.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8690_22996.column.sequence.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8690_22996.columns.push({
                    field: 'valueCode',
                    title: '{{vc.viewState.QV_8690_22996.column.valueCode.title|translate:vc.viewState.QV_8690_22996.column.valueCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_8690_22996.column.valueCode.width,
                    format: $scope.vc.viewState.QV_8690_22996.column.valueCode.format,
                    editor: $scope.vc.grids.QV_8690_22996.AT92_VALUECEO988.control,
                    template: "<span ng-class='vc.viewState.QV_8690_22996.column.valueCode.style' ng-bind='vc.getStringColumnFormat(dataItem.valueCode, \"QV_8690_22996\", \"valueCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8690_22996.column.valueCode.style",
                        "title": "{{vc.viewState.QV_8690_22996.column.valueCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8690_22996.column.valueCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8690_22996.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_8690_22996.column.amount.title|translate:vc.viewState.QV_8690_22996.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_8690_22996.column.amount.width,
                    format: $scope.vc.viewState.QV_8690_22996.column.amount.format,
                    editor: $scope.vc.grids.QV_8690_22996.AT44_AMOUNTVT988.control,
                    template: "<span ng-class='vc.viewState.QV_8690_22996.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_8690_22996\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_8690_22996.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8690_22996.column.amount.style",
                        "title": "{{vc.viewState.QV_8690_22996.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8690_22996.column.amount.hidden
                });
            }
            $scope.vc.viewState.QV_8690_22996.toolbar = {}
            $scope.vc.grids.QV_8690_22996.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSCJVXOOMB_486_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSCJVXOOMB_486_CANCEL",
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
                $scope.vc.render('VC_TRANSACTDE_986486');
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
    var cobisMainModule = cobis.createModule("VC_TRANSACTDE_986486", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_TRANSACTDE_986486", {
            templateUrl: "VC_TRANSACTDE_986486_FORM.html",
            controller: "VC_TRANSACTDE_986486_CTRL",
            label: "TransactionDetailForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TRANSACTDE_986486?" + $.param(search);
            }
        });
        VC_TRANSACTDE_986486(cobisMainModule);
    }]);
} else {
    VC_TRANSACTDE_986486(cobisMainModule);
}