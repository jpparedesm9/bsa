//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.grouppayment = designerEvents.api.grouppayment || designer.dsgEvents();

function VC_GROUPPAYTT_620892(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GROUPPAYTT_620892_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GROUPPAYTT_620892_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "TRNSC",
            taskId: "T_ASSTSEMLSGJAK_892",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GROUPPAYTT_620892",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_ASSTSEMLSGJAK_892",
        designerEvents.api.grouppayment,
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
                vcName: 'VC_GROUPPAYTT_620892'
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
                    subModuleId: 'TRNSC',
                    taskId: 'T_ASSTSEMLSGJAK_892',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    GroupPaymentFilter: "GroupPaymentFilter",
                    GroupPayment: "GroupPayment",
                    GroupPaymenInfo: "GroupPaymenInfo"
                },
                entities: {
                    GroupPaymentFilter: {
                        group: 'AT53_GROUPMCV264',
                        _pks: [],
                        _entityId: 'EN_GROUPPAME_264',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GroupPayment: {
                        groupId: 'AT10_GROUPIDD487',
                        expiredQuotas: 'AT30_EXPIREUA487',
                        customerName: 'AT37_CUSTOMRN487',
                        bank: 'AT48_BANKJVDH487',
                        collateralBalance: 'AT64_COLLATLE487',
                        rol: 'AT66_ROLJZZBC487',
                        expiredAmount: 'AT68_EXPIREUU487',
                        operation: 'AT83_OPERATNI487',
                        _pks: [],
                        _entityId: 'EN_GROUPPATE_487',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GroupPaymenInfo: {
                        valueAmountUseGuarantee: 'AT14_VALUEAEU126',
                        totalAmount: 'AT39_TOTALATU126',
                        collateralBalance: 'AT52_COLLATAA126',
                        groupName: 'AT95_GROUPNMA126',
                        _pks: [],
                        _entityId: 'EN_GROUPPAEE_126',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_GROUPPAME_264',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_GROUPPATE_487',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT53_GROUPMCV264',
                        attributeIdFk: 'AT10_GROUPIDD487'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_GROUPPTY_9025 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_GROUPPTY_9025 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_GROUPPTY_9025_filters)) {
                    parametersAux = {
                        groupId: $scope.vc.model.GroupPaymentFilter.group
                    };
                } else {
                    var filters = $scope.vc.queries.Q_GROUPPTY_9025_filters;
                    parametersAux = {
                        groupId: filters.groupId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_GROUPPATE_487',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_GROUPPTY_9025',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['groupId'] = $scope.vc.model.GroupPaymentFilter.group;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['groupId'] = this.filters.groupId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_GROUPPTY_9025_filters = {};
            var defaultValues = {
                GroupPaymentFilter: {},
                GroupPayment: {},
                GroupPaymenInfo: {}
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
                $scope.vc.execute("temporarySave", VC_GROUPPAYTT_620892, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GROUPPAYTT_620892, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GROUPPAYTT_620892, data, function() {});
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
            $scope.vc.viewState.VC_GROUPPAYTT_620892 = {
                style: []
            }
            //ViewState - Group: GroupLayout1618
            $scope.vc.createViewState({
                id: "G_GROUPPANTE_575946",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1618',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GroupPaymentFilter = {
                group: $scope.vc.channelDefaultValues("GroupPaymentFilter", "group")
            };
            //ViewState - Group: Group1534
            $scope.vc.createViewState({
                id: "G_GROUPPAMMN_992946",
                hasId: true,
                componentStyle: [],
                label: 'Group1534',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GroupPaymentFilter, Attribute: group
            $scope.vc.createViewState({
                id: "VA_GROUPUQEWUGMETV_318946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GRUPOOBAY_84995",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONPCXFLAH_830946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_GROUPPTY_9025',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2327
            $scope.vc.createViewState({
                id: "G_GROUPPAYET_105946",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORESAA_23651",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.GroupPayment = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("GroupPayment", "customerName", '')
                    },
                    rol: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("GroupPayment", "rol", '')
                    },
                    bank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("GroupPayment", "bank", '')
                    },
                    expiredQuotas: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("GroupPayment", "expiredQuotas", 0)
                    },
                    expiredAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("GroupPayment", "expiredAmount", 0)
                    },
                    collateralBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("GroupPayment", "collateralBalance", 0)
                    },
                    groupId: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.GroupPaymentFilter.group
                        }
                    },
                    operation: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.GroupPayment = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_GROUPPTY_9025';
                            var queryRequest = $scope.vc.getRequestQuery_Q_GROUPPTY_9025();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9025_57410',
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
                    model: $scope.vc.types.GroupPayment
                },
                aggregate: [{
                    field: "expiredAmount",
                    aggregate: "sum"
                }, {
                    field: "collateralBalance",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9025_57410").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_GROUPPTY_9025 = $scope.vc.model.GroupPayment;
            $scope.vc.trackers.GroupPayment = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.GroupPayment);
            $scope.vc.model.GroupPayment.bind('change', function(e) {
                $scope.vc.trackers.GroupPayment.track(e);
            });
            $scope.vc.grids.QV_9025_57410 = {};
            $scope.vc.grids.QV_9025_57410.queryId = 'Q_GROUPPTY_9025';
            $scope.vc.viewState.QV_9025_57410 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9025_57410.column = {};
            $scope.vc.grids.QV_9025_57410.editable = false;
            $scope.vc.grids.QV_9025_57410.events = {
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
                    $scope.vc.trackers.GroupPayment.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9025_57410.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_9025_57410");
                    $scope.vc.hideShowColumns("QV_9025_57410", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9025_57410.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9025_57410.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9025_57410.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9025_57410 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9025_57410 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9025_57410.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9025_57410.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9025_57410.column.customerName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREULS_81822',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEXA_679946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT37_CUSTOMRN487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEXA_679946",
                        'maxlength': 254,
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.rol = {
                title: 'ASSTS.LBL_ASSTS_ROLDOBJMA_96413',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZVS_709946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT66_ROLJZZBC487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.rol.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZVS_709946",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.rol.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.rol.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.bank = {
                title: 'ASSTS.LBL_ASSTS_NUMPRSTOO_83774',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVAB_182946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT48_BANKJVDH487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.bank.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVAB_182946",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.bank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.bank.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.expiredQuotas = {
                title: 'ASSTS.LBL_ASSTS_CUOTASVEN_82891',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHOT_654946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT30_EXPIREUA487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.expiredQuotas.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHOT_654946",
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.expiredQuotas.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9025_57410.column.expiredQuotas.format",
                        'k-decimals': "vc.viewState.QV_9025_57410.column.expiredQuotas.decimals",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.expiredQuotas.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.expiredAmount = {
                title: 'ASSTS.LBL_ASSTS_MONTOVEDC_35140',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTHH_535946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT68_EXPIREUU487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.expiredAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTHH_535946",
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.expiredAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9025_57410.column.expiredAmount.format",
                        'k-decimals': "vc.viewState.QV_9025_57410.column.expiredAmount.decimals",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.expiredAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.collateralBalance = {
                title: 'ASSTS.LBL_ASSTS_SALDOGARD_29588',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOZK_951946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT64_COLLATLE487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.collateralBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOZK_951946",
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.collateralBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9025_57410.column.collateralBalance.format",
                        'k-decimals': "vc.viewState.QV_9025_57410.column.collateralBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.collateralBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWPG_361946',
                element: []
            };
            $scope.vc.grids.QV_9025_57410.AT10_GROUPIDD487 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9025_57410.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWPG_361946",
                        'maxlength': 12,
                        'data-validation-code': "{{vc.viewState.QV_9025_57410.column.groupId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_GROUPPANTE_575946,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9025_57410.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9025_57410.column.operation = {
                title: 'operation',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_9025_57410.column.customerName.title|translate:vc.viewState.QV_9025_57410.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.customerName.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.customerName.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT37_CUSTOMRN487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_9025_57410\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9025_57410.column.customerName.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'rol',
                    title: '{{vc.viewState.QV_9025_57410.column.rol.title|translate:vc.viewState.QV_9025_57410.column.rol.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.rol.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.rol.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT66_ROLJZZBC487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.rol.style' ng-bind='vc.getStringColumnFormat(dataItem.rol, \"QV_9025_57410\", \"rol\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9025_57410.column.rol.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.rol.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.rol.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'bank',
                    title: '{{vc.viewState.QV_9025_57410.column.bank.title|translate:vc.viewState.QV_9025_57410.column.bank.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.bank.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.bank.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT48_BANKJVDH487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.bank.style' ng-bind='vc.getStringColumnFormat(dataItem.bank, \"QV_9025_57410\", \"bank\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9025_57410.column.bank.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.bank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.bank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'expiredQuotas',
                    title: '{{vc.viewState.QV_9025_57410.column.expiredQuotas.title|translate:vc.viewState.QV_9025_57410.column.expiredQuotas.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.expiredQuotas.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.expiredQuotas.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT30_EXPIREUA487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.expiredQuotas.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.expiredQuotas, \"QV_9025_57410\", \"expiredQuotas\"):kendo.toString(#=expiredQuotas#, vc.viewState.QV_9025_57410.column.expiredQuotas.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9025_57410.column.expiredQuotas.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.expiredQuotas.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.expiredQuotas.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'expiredAmount',
                    title: '{{vc.viewState.QV_9025_57410.column.expiredAmount.title|translate:vc.viewState.QV_9025_57410.column.expiredAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.expiredAmount.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.expiredAmount.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT68_EXPIREUU487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.expiredAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.expiredAmount, \"QV_9025_57410\", \"expiredAmount\"):kendo.toString(#=expiredAmount#, vc.viewState.QV_9025_57410.column.expiredAmount.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.expiredAmount.sum, $scope.vc.viewState.QV_9025_57410.column.expiredAmount.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9025_57410.column.expiredAmount.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.expiredAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.expiredAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'collateralBalance',
                    title: '{{vc.viewState.QV_9025_57410.column.collateralBalance.title|translate:vc.viewState.QV_9025_57410.column.collateralBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.collateralBalance.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.collateralBalance.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT64_COLLATLE487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.collateralBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.collateralBalance, \"QV_9025_57410\", \"collateralBalance\"):kendo.toString(#=collateralBalance#, vc.viewState.QV_9025_57410.column.collateralBalance.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.collateralBalance.sum, $scope.vc.viewState.QV_9025_57410.column.collateralBalance.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9025_57410.column.collateralBalance.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.collateralBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.collateralBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9025_57410.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9025_57410.column.groupId.title|translate:vc.viewState.QV_9025_57410.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9025_57410.column.groupId.width,
                    format: $scope.vc.viewState.QV_9025_57410.column.groupId.format,
                    editor: $scope.vc.grids.QV_9025_57410.AT10_GROUPIDD487.control,
                    template: "<span ng-class='vc.viewState.QV_9025_57410.column.groupId.style' ng-bind='vc.getStringColumnFormat(dataItem.groupId, \"QV_9025_57410\", \"groupId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9025_57410.column.groupId.style",
                        "title": "{{vc.viewState.QV_9025_57410.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9025_57410.column.groupId.hidden
                });
            }
            $scope.vc.viewState.QV_9025_57410.toolbar = {}
            $scope.vc.grids.QV_9025_57410.toolbar = [];
            $scope.vc.model.GroupPaymenInfo = {
                valueAmountUseGuarantee: $scope.vc.channelDefaultValues("GroupPaymenInfo", "valueAmountUseGuarantee"),
                totalAmount: $scope.vc.channelDefaultValues("GroupPaymenInfo", "totalAmount"),
                collateralBalance: $scope.vc.channelDefaultValues("GroupPaymenInfo", "collateralBalance"),
                groupName: $scope.vc.channelDefaultValues("GroupPaymenInfo", "groupName")
            };
            //ViewState - Group: Group1696
            $scope.vc.createViewState({
                id: "G_GROUPPAYMY_137946",
                hasId: true,
                componentStyle: [],
                label: 'Group1696',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: GroupPaymenInfo, Attribute: groupName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLIJ_380946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GRUPOOBAY_84995",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GroupPaymenInfo, Attribute: valueAmountUseGuarantee
            $scope.vc.createViewState({
                id: "VA_VALUEAMOUNTUARE_193946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORAPAA_99910",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 96,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GroupPaymenInfo, Attribute: totalAmount
            $scope.vc.createViewState({
                id: "VA_TOTALAMOUNTYQVG_560946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALEXIG_45949",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1541",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GroupPaymenInfo, Attribute: collateralBalance
            $scope.vc.createViewState({
                id: "VA_COLLATERALBAECN_124946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDODELA_45894",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONRSJMLRR_647946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PAGARUXOO_57284",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2753",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSEMLSGJAK_892_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSEMLSGJAK_892_CANCEL",
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
                $scope.vc.render('VC_GROUPPAYTT_620892');
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
    var cobisMainModule = cobis.createModule("VC_GROUPPAYTT_620892", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_GROUPPAYTT_620892", {
            templateUrl: "VC_GROUPPAYTT_620892_FORM.html",
            controller: "VC_GROUPPAYTT_620892_CTRL",
            labelId: "ASSTS.LBL_ASSTS_PAGOSGRNO_24792",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GROUPPAYTT_620892?" + $.param(search);
            }
        });
        VC_GROUPPAYTT_620892(cobisMainModule);
    }]);
} else {
    VC_GROUPPAYTT_620892(cobisMainModule);
}