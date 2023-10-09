//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.documentgrid = designerEvents.api.documentgrid || designer.dsgEvents();

function VC_DOCUMENTDD_249541(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DOCUMENTDD_249541_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DOCUMENTDD_249541_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BMTRC",
            subModuleId: "TRNSC",
            taskId: "T_BMTRCNYSSKGHD_541",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DOCUMENTDD_249541",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BMTRC/TRNSC/T_BMTRCNYSSKGHD_541",
        designerEvents.api.documentgrid,
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
                vcName: 'VC_DOCUMENTDD_249541'
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
                    moduleId: 'BMTRC',
                    subModuleId: 'TRNSC',
                    taskId: 'T_BMTRCNYSSKGHD_541',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Document: "Document"
                },
                entities: {
                    Document: {
                        documentId: 'AT15_DOCUMETN179',
                        description: 'AT16_DESCRITO179',
                        enableEditing: 'AT26_ENABLEDT179',
                        folder: 'AT34_FOLDERCM179',
                        customerId: 'AT41_CUSTOMID179',
                        processInstance: 'AT44_PROCESSE179',
                        groupId: 'AT71_GROUPIDD179',
                        file: 'AT85_FILEOMEE179',
                        extension: 'AT86_EXTENSIO179',
                        uploaded: 'AT88_UPLOADGJ179',
                        _pks: [],
                        _entityId: 'EN_DOCUMENTT_179',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DOCUMENN_7504 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DOCUMENN_7504 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DOCUMENN_7504_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DOCUMENN_7504_filters;
                    parametersAux = {
                        customerId: filters.customerId,
                        processInstance: filters.processInstance,
                        groupId: filters.groupId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DOCUMENTT_179',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DOCUMENN_7504',
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
                            this.parameters['processInstance'] = this.filters.processInstance;
                            this.parameters['groupId'] = this.filters.groupId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DOCUMENN_7504_filters = {};
            var defaultValues = {
                Document: {}
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
                $scope.vc.execute("temporarySave", VC_DOCUMENTDD_249541, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DOCUMENTDD_249541, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DOCUMENTDD_249541, data, function() {});
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
            $scope.vc.viewState.VC_DOCUMENTDD_249541 = {
                style: []
            }
            //ViewState - Group: Group1814
            $scope.vc.createViewState({
                id: "G_DOCUMENTGD_169731",
                hasId: true,
                componentStyle: [],
                label: 'Group1814',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Document = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "description", '')
                    },
                    uploaded: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "uploaded", '')
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "customerId", 0)
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "processInstance", 0)
                    },
                    file: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "file", '')
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "groupId", 0)
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "extension", '')
                    },
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Document", "documentId", '')
                    }
                }
            });
            $scope.vc.model.Document = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DOCUMENN_7504';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DOCUMENN_7504();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7504_88001',
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
                    model: $scope.vc.types.Document
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7504_88001").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DOCUMENN_7504 = $scope.vc.model.Document;
            $scope.vc.trackers.Document = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Document);
            $scope.vc.model.Document.bind('change', function(e) {
                $scope.vc.trackers.Document.track(e);
            });
            $scope.vc.grids.QV_7504_88001 = {};
            $scope.vc.grids.QV_7504_88001.queryId = 'Q_DOCUMENN_7504';
            $scope.vc.viewState.QV_7504_88001 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7504_88001.column = {};
            $scope.vc.grids.QV_7504_88001.editable = false;
            $scope.vc.grids.QV_7504_88001.events = {
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
                    $scope.vc.trackers.Document.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7504_88001.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7504_88001");
                    $scope.vc.hideShowColumns("QV_7504_88001", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7504_88001.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7504_88001.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7504_88001.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7504_88001 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7504_88001 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7504_88001.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7504_88001.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7504_88001.column.description = {
                title: 'BMTRC.LBL_BMTRC_DESCRIPIN_60662',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIZU_918731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT16_DESCRITO179 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_7504_88001.column.description.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.uploaded = {
                title: 'BMTRC.LBL_BMTRC_CARGADOOU_95683',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQRK_970731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT88_UPLOADGJ179 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_7504_88001.column.uploaded.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.customerId = {
                title: 'customerId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYAY_785731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT41_CUSTOMID179 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7504_88001.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYAY_785731",
                        'data-validation-code': "{{vc.viewState.QV_7504_88001.column.customerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7504_88001.column.customerId.format",
                        'k-decimals': "vc.viewState.QV_7504_88001.column.customerId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7504_88001.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.processInstance = {
                title: 'processInstance',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPNF_609731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT44_PROCESSE179 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7504_88001.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPNF_609731",
                        'data-validation-code': "{{vc.viewState.QV_7504_88001.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7504_88001.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_7504_88001.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7504_88001.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.file = {
                title: 'file',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYDB_380731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT85_FILEOMEE179 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7504_88001.column.file.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYDB_380731",
                        'data-validation-code': "{{vc.viewState.QV_7504_88001.column.file.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7504_88001.column.file.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTJM_194731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT71_GROUPIDD179 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7504_88001.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTJM_194731",
                        'data-validation-code': "{{vc.viewState.QV_7504_88001.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7504_88001.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_7504_88001.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7504_88001.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYFJ_185731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT86_EXTENSIO179 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7504_88001.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYFJ_185731",
                        'data-validation-code': "{{vc.viewState.QV_7504_88001.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7504_88001.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7504_88001.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVXC_361731',
                element: []
            };
            $scope.vc.grids.QV_7504_88001.AT15_DOCUMETN179 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7504_88001.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVXC_361731",
                        'data-validation-code': "{{vc.viewState.QV_7504_88001.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7504_88001.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7504_88001.column.description.title|translate:vc.viewState.QV_7504_88001.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.description.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.description.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT16_DESCRITO179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7504_88001\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7504_88001.column.description.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_7504_88001.column.uploaded.title|translate:vc.viewState.QV_7504_88001.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.uploaded.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.uploaded.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7504_88001', 'uploaded', $scope.vc.grids.QV_7504_88001.AT88_UPLOADGJ179.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7504_88001', 'uploaded', "<span ng-class='vc.viewState.QV_7504_88001.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_7504_88001\", \"uploaded\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7504_88001.column.uploaded.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_7504_88001.column.customerId.title|translate:vc.viewState.QV_7504_88001.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.customerId.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.customerId.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT41_CUSTOMID179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_7504_88001\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_7504_88001.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7504_88001.column.customerId.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_7504_88001.column.processInstance.title|translate:vc.viewState.QV_7504_88001.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.processInstance.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.processInstance.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT44_PROCESSE179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_7504_88001\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_7504_88001.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7504_88001.column.processInstance.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_7504_88001.column.file.title|translate:vc.viewState.QV_7504_88001.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.file.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.file.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT85_FILEOMEE179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_7504_88001\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7504_88001.column.file.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_7504_88001.column.groupId.title|translate:vc.viewState.QV_7504_88001.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.groupId.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.groupId.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT71_GROUPIDD179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_7504_88001\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_7504_88001.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7504_88001.column.groupId.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_7504_88001.column.extension.title|translate:vc.viewState.QV_7504_88001.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.extension.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.extension.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT86_EXTENSIO179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_7504_88001\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7504_88001.column.extension.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_7504_88001.column.documentId.title|translate:vc.viewState.QV_7504_88001.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7504_88001.column.documentId.width,
                    format: $scope.vc.viewState.QV_7504_88001.column.documentId.format,
                    editor: $scope.vc.grids.QV_7504_88001.AT15_DOCUMETN179.control,
                    template: "<span ng-class='vc.viewState.QV_7504_88001.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_7504_88001\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7504_88001.column.documentId.style",
                        "title": "{{vc.viewState.QV_7504_88001.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.documentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731)) {
                    $scope.vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731 = {};
                }
                $scope.vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731.hidden = false;
                $scope.vc.grids.QV_7504_88001.columns.push({
                    field: 'VA_GRIDROWCOMMMNAN_389731',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNAN_389731",
                        entity: "Document",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmnan':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNAN_389731\", " + "vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731.enabled || vc.viewState.G_DOCUMENTGD_169731.disabled' " + "data-ng-click = 'vc.grids.QV_7504_88001.events.customRowClick($event, \"VA_GRIDROWCOMMMNAN_389731\", \"#:entity#\", \"QV_7504_88001\")' " + "title = \"{{vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7504_88001.column.VA_GRIDROWCOMMMNAN_389731.hidden
                });
            }
            $scope.vc.viewState.QV_7504_88001.toolbar = {}
            $scope.vc.grids.QV_7504_88001.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BMTRCNYSSKGHD_541_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BMTRCNYSSKGHD_541_CANCEL",
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
                $scope.vc.render('VC_DOCUMENTDD_249541');
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
    var cobisMainModule = cobis.createModule("VC_DOCUMENTDD_249541", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BMTRC"]);
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
        $routeProvider.when("/VC_DOCUMENTDD_249541", {
            templateUrl: "VC_DOCUMENTDD_249541_FORM.html",
            controller: "VC_DOCUMENTDD_249541_CTRL",
            label: "DocumentGrid",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BMTRC');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DOCUMENTDD_249541?" + $.param(search);
            }
        });
        VC_DOCUMENTDD_249541(cobisMainModule);
    }]);
} else {
    VC_DOCUMENTDD_249541(cobisMainModule);
}