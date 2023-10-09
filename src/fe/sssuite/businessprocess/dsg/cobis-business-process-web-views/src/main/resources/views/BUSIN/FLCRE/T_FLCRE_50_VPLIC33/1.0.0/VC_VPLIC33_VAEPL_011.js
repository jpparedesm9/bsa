<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.variablepolicy = designerEvents.api.variablepolicy || designer.dsgEvents();

function VC_VPLIC33_VAEPL_011(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_VPLIC33_VAEPL_011_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_VPLIC33_VAEPL_011_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_50_VPLIC33",
            taskVersion: "1.0.0",
            viewContainerId: "VC_VPLIC33_VAEPL_011",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_50_VPLIC33",
        designerEvents.api.variablepolicy,
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
                vcName: 'VC_VPLIC33_VAEPL_011'
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
                    taskId: 'T_FLCRE_50_VPLIC33',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    VariableExceptions: "VariableExceptions",
                    VariablePolicy: "VariablePolicy"
                },
                entities: {
                    VariableExceptions: {
                        VariableName: 'AT_ABL836RABM62',
                        VariableValue: 'AT_ABL836VBLE29',
                        VariableRule: 'AT_ABL836LELE47',
                        VariableDescription: 'AT_ABL836RSCP88',
                        _pks: [],
                        _entityId: 'EN_ABLEECPTO836',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VariablePolicy: {
                        VariableName: 'AT_VAR396ILEA09',
                        VariableValue: 'AT_VAR396VILV60',
                        VariableRule: 'AT_VAR396ALRL41',
                        VariableDescription: 'AT_VAR396BSCT95',
                        _pks: [],
                        _entityId: 'EN_VARBLEPCY396',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_UEVRBPOC_5831 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_UEVRBPOC_5831 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_UEVRBPOC_5831 = {
                mainEntityPk: {
                    entityId: 'EN_VARBLEPCY396',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_UEVRBPOC_5831',
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
            $scope.vc.queryProperties.Q_EAIBLEEP_2309 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_EAIBLEEP_2309 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_EAIBLEEP_2309 = {
                mainEntityPk: {
                    entityId: 'EN_ABLEECPTO836',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_EAIBLEEP_2309',
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
                VariableExceptions: {},
                VariablePolicy: {}
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
            $scope.vc.viewState.VC_VPLIC33_VAEPL_011 = {
                style: []
            }
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VARABLOIYW12_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.VariablePolicy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    },
                    VariableDescription: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.VariablePolicy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_UEVRBPOC_5831', function(data) {
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
                    model: $scope.vc.types.VariablePolicy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UEVRB5831_12").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UEVRBPOC_5831 = $scope.vc.model.VariablePolicy;
            $scope.vc.trackers.VariablePolicy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariablePolicy);
            $scope.vc.model.VariablePolicy.bind('change', function(e) {
                $scope.vc.trackers.VariablePolicy.track(e);
            });
            $scope.vc.grids.QV_UEVRB5831_12 = {};
            $scope.vc.grids.QV_UEVRB5831_12.queryId = 'Q_UEVRBPOC_5831';
            $scope.vc.viewState.QV_UEVRB5831_12 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column = {};
            $scope.vc.grids.QV_UEVRB5831_12.events = {
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
                    $scope.vc.trackers.VariablePolicy.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UEVRB5831_12.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UEVRB5831_12");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UEVRB5831_12.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UEVRB5831_12.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396ILEA09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396VILV60 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396BSCT95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableDescription.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableName.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396ILEA09.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableName.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableValue.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396VILV60.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableDescription',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableDescription.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396BSCT95.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableDescription.element[dataItem.uid].style'>#if (VariableDescription !== null) {# #=VariableDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableDescription.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.hidden
                });
            }
            $scope.vc.viewState.QV_UEVRB5831_12.toolbar = {}
            $scope.vc.grids.QV_UEVRB5831_12.toolbar = [];
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VARABLOIYW12_04",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.VariableExceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    },
                    VariableDescription: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.VariableExceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_EAIBLEEP_2309', function(data) {
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
                    model: $scope.vc.types.VariableExceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_EAIBL2309_87").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EAIBLEEP_2309 = $scope.vc.model.VariableExceptions;
            $scope.vc.trackers.VariableExceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariableExceptions);
            $scope.vc.model.VariableExceptions.bind('change', function(e) {
                $scope.vc.trackers.VariableExceptions.track(e);
            });
            $scope.vc.grids.QV_EAIBL2309_87 = {};
            $scope.vc.grids.QV_EAIBL2309_87.queryId = 'Q_EAIBLEEP_2309';
            $scope.vc.viewState.QV_EAIBL2309_87 = {
                style: undefined
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column = {};
            $scope.vc.grids.QV_EAIBL2309_87.events = {
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
                    $scope.vc.trackers.VariableExceptions.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_EAIBL2309_87.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_EAIBL2309_87");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_EAIBL2309_87.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RSCP88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableDescription.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableName.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableName.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableDescription',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableDescription.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RSCP88.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableDescription.element[dataItem.uid].style'>#if (VariableDescription !== null) {# #=VariableDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableDescription.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.hidden
                });
            }
            $scope.vc.viewState.QV_EAIBL2309_87.toolbar = {}
            $scope.vc.grids.QV_EAIBL2309_87.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_50_VPLIC33_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_50_VPLIC33_CANCEL",
                componentStyle: "",
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
                $scope.vc.render('VC_VPLIC33_VAEPL_011');
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
    var cobisMainModule = cobis.createModule("VC_VPLIC33_VAEPL_011", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_VPLIC33_VAEPL_011", {
            templateUrl: "VC_VPLIC33_VAEPL_011_FORM.html",
            controller: "VC_VPLIC33_VAEPL_011_CTRL",
            label: "VariablePolicy",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_VPLIC33_VAEPL_011?" + $.param(search);
            }
        });
        VC_VPLIC33_VAEPL_011(cobisMainModule);
    }]);
} else {
    VC_VPLIC33_VAEPL_011(cobisMainModule);
}