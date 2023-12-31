//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.detailsaho = designerEvents.api.detailsaho || designer.dsgEvents();

function VC_DETAILSAOH_471635(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DETAILSAOH_471635_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DETAILSAOH_471635_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_DETAILSAHOANJ_635",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DETAILSAOH_471635",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_DETAILSAHOANJ_635",
        designerEvents.api.detailsaho,
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
                vcName: 'VC_DETAILSAOH_471635'
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
                    taskId: 'T_DETAILSAHOANJ_635',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CuentaGrupal: "CuentaGrupal",
                    DetailsAho: "DetailsAho"
                },
                entities: {
                    CuentaGrupal: {
                        cuentaGrupal: 'AT47_CUENTAUL436',
                        _pks: [],
                        _entityId: 'EN_CUENTAGUP_436',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DetailsAho: {
                        operation: 'AT83_OPERATNO708',
                        ente: 'AT41_ENTEGQUO708',
                        nameEnte: 'AT56_NAMEENET708',
                        saldo: 'AT12_SALDOONR708',
                        incentive: 'AT81_INCENTIV708',
                        gain: 'AT79_GAINKWNC708',
                        cuentaGrupal: 'AT19_CUENTARL708',
                        _pks: [],
                        _entityId: 'EN_DETAILSOO_708',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DETAILSA_3162 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_DETAILSA_3162 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DETAILSA_3162_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DETAILSA_3162_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DETAILSOO_708',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DETAILSA_3162',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_DETAILSA_3162_filters = {};
            var defaultValues = {
                CuentaGrupal: {},
                DetailsAho: {}
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
                $scope.vc.execute("temporarySave", VC_DETAILSAOH_471635, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DETAILSAOH_471635, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DETAILSAOH_471635, data, function() {});
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
            $scope.vc.viewState.VC_DETAILSAOH_471635 = {
                style: []
            }
            $scope.vc.model.CuentaGrupal = {
                cuentaGrupal: $scope.vc.channelDefaultValues("CuentaGrupal", "cuentaGrupal")
            };
            //ViewState - Group: Group1909
            $scope.vc.createViewState({
                id: "G_DETAILSHAH_790444",
                hasId: true,
                componentStyle: [],
                label: 'Group1909',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CuentaGrupal, Attribute: cuentaGrupal
            $scope.vc.createViewState({
                id: "VA_CUENTAGRUPALESW_299444",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUENTAGAR_72912",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2522
            $scope.vc.createViewState({
                id: "G_DETAILSHHA_119444",
                hasId: true,
                componentStyle: [],
                label: 'Group2522',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DetailsAho = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    operation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailsAho", "operation", 0)
                    },
                    ente: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailsAho", "ente", 0)
                    },
                    nameEnte: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailsAho", "nameEnte", '')
                    },
                    saldo: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailsAho", "saldo", 0)
                    },
                    incentive: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailsAho", "incentive", 0)
                    },
                    gain: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DetailsAho", "gain", 0)
                    }
                }
            });
            $scope.vc.model.DetailsAho = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_DETAILSA_3162();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
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
                    model: $scope.vc.types.DetailsAho
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3162_24937").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DETAILSA_3162 = $scope.vc.model.DetailsAho;
            $scope.vc.trackers.DetailsAho = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DetailsAho);
            $scope.vc.model.DetailsAho.bind('change', function(e) {
                $scope.vc.trackers.DetailsAho.track(e);
            });
            $scope.vc.grids.QV_3162_24937 = {};
            $scope.vc.grids.QV_3162_24937.queryId = 'Q_DETAILSA_3162';
            $scope.vc.viewState.QV_3162_24937 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3162_24937.column = {};
            $scope.vc.grids.QV_3162_24937.editable = false;
            $scope.vc.grids.QV_3162_24937.events = {
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
                    $scope.vc.trackers.DetailsAho.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3162_24937.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_3162_24937");
                    $scope.vc.hideShowColumns("QV_3162_24937", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3162_24937.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3162_24937.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3162_24937.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3162_24937 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3162_24937 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3162_24937.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3162_24937.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3162_24937.column.operation = {
                title: 'ASSTS.LBL_ASSTS_OPERACINN_38893',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXUP_694444',
                element: []
            };
            $scope.vc.grids.QV_3162_24937.AT83_OPERATNO708 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3162_24937.column.operation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXUP_694444",
                        'data-validation-code': "{{vc.viewState.QV_3162_24937.column.operation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3162_24937.column.operation.format",
                        'k-decimals': "vc.viewState.QV_3162_24937.column.operation.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3162_24937.column.operation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3162_24937.column.ente = {
                title: 'ASSTS.LBL_ASSTS_CLIENTEWV_22561',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXXP_581444',
                element: []
            };
            $scope.vc.grids.QV_3162_24937.AT41_ENTEGQUO708 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3162_24937.column.ente.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXXP_581444",
                        'data-validation-code': "{{vc.viewState.QV_3162_24937.column.ente.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3162_24937.column.ente.format",
                        'k-decimals': "vc.viewState.QV_3162_24937.column.ente.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3162_24937.column.ente.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3162_24937.column.nameEnte = {
                title: 'ASSTS.LBL_ASSTS_NOMBRECNI_63306',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUIW_246444',
                element: []
            };
            $scope.vc.grids.QV_3162_24937.AT56_NAMEENET708 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3162_24937.column.nameEnte.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUIW_246444",
                        'data-validation-code': "{{vc.viewState.QV_3162_24937.column.nameEnte.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3162_24937.column.nameEnte.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3162_24937.column.saldo = {
                title: 'ASSTS.LBL_ASSTS_AHORROIID_58373',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMRB_451444',
                element: []
            };
            $scope.vc.grids.QV_3162_24937.AT12_SALDOONR708 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3162_24937.column.saldo.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMRB_451444",
                        'data-validation-code': "{{vc.viewState.QV_3162_24937.column.saldo.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3162_24937.column.saldo.format",
                        'k-decimals': "vc.viewState.QV_3162_24937.column.saldo.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3162_24937.column.saldo.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3162_24937.column.incentive = {
                title: 'ASSTS.LBL_ASSTS_INCENTIOO_69969',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNET_993444',
                element: []
            };
            $scope.vc.grids.QV_3162_24937.AT81_INCENTIV708 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3162_24937.column.incentive.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNET_993444",
                        'data-validation-code': "{{vc.viewState.QV_3162_24937.column.incentive.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3162_24937.column.incentive.format",
                        'k-decimals': "vc.viewState.QV_3162_24937.column.incentive.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3162_24937.column.incentive.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3162_24937.column.gain = {
                title: 'ASSTS.LBL_ASSTS_GANANCISA_44764',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXLE_128444',
                element: []
            };
            $scope.vc.grids.QV_3162_24937.AT79_GAINKWNC708 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3162_24937.column.gain.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXLE_128444",
                        'data-validation-code': "{{vc.viewState.QV_3162_24937.column.gain.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3162_24937.column.gain.format",
                        'k-decimals': "vc.viewState.QV_3162_24937.column.gain.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3162_24937.column.gain.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3162_24937.columns.push({
                    field: 'operation',
                    title: '{{vc.viewState.QV_3162_24937.column.operation.title|translate:vc.viewState.QV_3162_24937.column.operation.titleArgs}}',
                    width: $scope.vc.viewState.QV_3162_24937.column.operation.width,
                    format: $scope.vc.viewState.QV_3162_24937.column.operation.format,
                    editor: $scope.vc.grids.QV_3162_24937.AT83_OPERATNO708.control,
                    template: "<span ng-class='vc.viewState.QV_3162_24937.column.operation.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.operation, \"QV_3162_24937\", \"operation\"):kendo.toString(#=operation#, vc.viewState.QV_3162_24937.column.operation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3162_24937.column.operation.style",
                        "title": "{{vc.viewState.QV_3162_24937.column.operation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3162_24937.column.operation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3162_24937.columns.push({
                    field: 'ente',
                    title: '{{vc.viewState.QV_3162_24937.column.ente.title|translate:vc.viewState.QV_3162_24937.column.ente.titleArgs}}',
                    width: $scope.vc.viewState.QV_3162_24937.column.ente.width,
                    format: $scope.vc.viewState.QV_3162_24937.column.ente.format,
                    editor: $scope.vc.grids.QV_3162_24937.AT41_ENTEGQUO708.control,
                    template: "<span ng-class='vc.viewState.QV_3162_24937.column.ente.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.ente, \"QV_3162_24937\", \"ente\"):kendo.toString(#=ente#, vc.viewState.QV_3162_24937.column.ente.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3162_24937.column.ente.style",
                        "title": "{{vc.viewState.QV_3162_24937.column.ente.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3162_24937.column.ente.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3162_24937.columns.push({
                    field: 'nameEnte',
                    title: '{{vc.viewState.QV_3162_24937.column.nameEnte.title|translate:vc.viewState.QV_3162_24937.column.nameEnte.titleArgs}}',
                    width: $scope.vc.viewState.QV_3162_24937.column.nameEnte.width,
                    format: $scope.vc.viewState.QV_3162_24937.column.nameEnte.format,
                    editor: $scope.vc.grids.QV_3162_24937.AT56_NAMEENET708.control,
                    template: "<span ng-class='vc.viewState.QV_3162_24937.column.nameEnte.style' ng-bind='vc.getStringColumnFormat(dataItem.nameEnte, \"QV_3162_24937\", \"nameEnte\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3162_24937.column.nameEnte.style",
                        "title": "{{vc.viewState.QV_3162_24937.column.nameEnte.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3162_24937.column.nameEnte.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3162_24937.columns.push({
                    field: 'saldo',
                    title: '{{vc.viewState.QV_3162_24937.column.saldo.title|translate:vc.viewState.QV_3162_24937.column.saldo.titleArgs}}',
                    width: $scope.vc.viewState.QV_3162_24937.column.saldo.width,
                    format: $scope.vc.viewState.QV_3162_24937.column.saldo.format,
                    editor: $scope.vc.grids.QV_3162_24937.AT12_SALDOONR708.control,
                    template: "<span ng-class='vc.viewState.QV_3162_24937.column.saldo.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.saldo, \"QV_3162_24937\", \"saldo\"):kendo.toString(#=saldo#, vc.viewState.QV_3162_24937.column.saldo.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3162_24937.column.saldo.style",
                        "title": "{{vc.viewState.QV_3162_24937.column.saldo.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3162_24937.column.saldo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3162_24937.columns.push({
                    field: 'incentive',
                    title: '{{vc.viewState.QV_3162_24937.column.incentive.title|translate:vc.viewState.QV_3162_24937.column.incentive.titleArgs}}',
                    width: $scope.vc.viewState.QV_3162_24937.column.incentive.width,
                    format: $scope.vc.viewState.QV_3162_24937.column.incentive.format,
                    editor: $scope.vc.grids.QV_3162_24937.AT81_INCENTIV708.control,
                    template: "<span ng-class='vc.viewState.QV_3162_24937.column.incentive.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.incentive, \"QV_3162_24937\", \"incentive\"):kendo.toString(#=incentive#, vc.viewState.QV_3162_24937.column.incentive.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3162_24937.column.incentive.style",
                        "title": "{{vc.viewState.QV_3162_24937.column.incentive.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3162_24937.column.incentive.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3162_24937.columns.push({
                    field: 'gain',
                    title: '{{vc.viewState.QV_3162_24937.column.gain.title|translate:vc.viewState.QV_3162_24937.column.gain.titleArgs}}',
                    width: $scope.vc.viewState.QV_3162_24937.column.gain.width,
                    format: $scope.vc.viewState.QV_3162_24937.column.gain.format,
                    editor: $scope.vc.grids.QV_3162_24937.AT79_GAINKWNC708.control,
                    template: "<span ng-class='vc.viewState.QV_3162_24937.column.gain.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.gain, \"QV_3162_24937\", \"gain\"):kendo.toString(#=gain#, vc.viewState.QV_3162_24937.column.gain.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3162_24937.column.gain.style",
                        "title": "{{vc.viewState.QV_3162_24937.column.gain.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3162_24937.column.gain.hidden
                });
            }
            $scope.vc.viewState.QV_3162_24937.toolbar = {}
            $scope.vc.grids.QV_3162_24937.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-pdf" ng-click="grids.QV_3162_24937.saveAsPDF()" href="\\\#">Pdf</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_DETAILSAHOANJ_635_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_DETAILSAHOANJ_635_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TDETAILS_51_",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RJTELYUVM_49465",
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
                $scope.vc.render('VC_DETAILSAOH_471635');
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
    var cobisMainModule = cobis.createModule("VC_DETAILSAOH_471635", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_DETAILSAOH_471635", {
            templateUrl: "VC_DETAILSAOH_471635_FORM.html",
            controller: "VC_DETAILSAOH_471635_CTRL",
            label: "DetailsAho",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DETAILSAOH_471635?" + $.param(search);
            }
        });
        VC_DETAILSAOH_471635(cobisMainModule);
    }]);
} else {
    VC_DETAILSAOH_471635(cobisMainModule);
}