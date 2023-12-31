//Designer Generator v 6.4.0.1 - SPR 2018-10 18/05/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.querydocumentshistory = designerEvents.api.querydocumentshistory || designer.dsgEvents();

function VC_CREDITDOUE_237252(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CREDITDOUE_237252_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CREDITDOUE_237252_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSNMDWVMHP_252",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CREDITDOUE_237252",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSNMDWVMHP_252",
        designerEvents.api.querydocumentshistory,
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
                vcName: 'VC_CREDITDOUE_237252'
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
                    taskId: 'T_ASSTSNMDWVMHP_252',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    QueryDocumentHistory: "QueryDocumentHistory"
                },
                entities: {
                    QueryDocumentHistory: {
                        uploaded: 'AT22_UPLOADDE280',
                        extension: 'AT33_EXTENSNI280',
                        file: 'AT41_FILEJBGI280',
                        customerId: 'AT43_CUSTOMRD280',
                        processInstance: 'AT53_PROCESIE280',
                        documentVersion: 'AT59_VERSIONN280',
                        folder: 'AT64_FOLDERKU280',
                        dateVersion: 'AT74_DATEVERS280',
                        description: 'AT85_DESCRINO280',
                        documentId: 'AT92_DOCUMETD280',
                        groupId: 'AT97_GROUPIDD280',
                        _pks: [],
                        _entityId: 'EN_DOCUMENYI_280',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DOCUMEHR_9834 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DOCUMEHR_9834 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DOCUMEHR_9834_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DOCUMEHR_9834_filters;
                    parametersAux = {
                        description: filters.description,
                        customerId: filters.customerId,
                        processInstance: filters.processInstance,
                        groupId: filters.groupId,
                        extension: filters.extension,
                        documentId: filters.documentId,
                        dateVersion: filters.dateVersion,
                        folder: filters.folder
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DOCUMENYI_280',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DOCUMEHR_9834',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['description'] = this.filters.description;
                            this.parameters['customerId'] = this.filters.customerId;
                            this.parameters['processInstance'] = this.filters.processInstance;
                            this.parameters['groupId'] = this.filters.groupId;
                            this.parameters['extension'] = this.filters.extension;
                            this.parameters['documentId'] = this.filters.documentId;
                            this.parameters['dateVersion'] = this.filters.dateVersion;
                            this.parameters['folder'] = this.filters.folder;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DOCUMEHR_9834_filters = {};
            var defaultValues = {
                QueryDocumentHistory: {}
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
                $scope.vc.execute("temporarySave", VC_CREDITDOUE_237252, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CREDITDOUE_237252, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CREDITDOUE_237252, data, function() {});
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
            $scope.vc.viewState.VC_CREDITDOUE_237252 = {
                style: []
            }
            //ViewState - Group: Group1710
            $scope.vc.createViewState({
                id: "G_CREDITDCCS_357376",
                hasId: true,
                componentStyle: [],
                label: 'Group1710',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QueryDocumentHistory = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "description", '')
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "customerId", 0)
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "processInstance", 0)
                    },
                    file: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "file", '')
                    },
                    uploaded: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "uploaded", '')
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "extension", '')
                    },
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "documentId", '')
                    },
                    dateVersion: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "dateVersion", new Date())
                    },
                    documentVersion: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "documentVersion", '')
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentHistory", "groupId", 0)
                    },
                    folder: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.QueryDocumentHistory = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DOCUMEHR_9834';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DOCUMEHR_9834();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9834_40050',
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
                    model: $scope.vc.types.QueryDocumentHistory
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9834_40050").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DOCUMEHR_9834 = $scope.vc.model.QueryDocumentHistory;
            $scope.vc.trackers.QueryDocumentHistory = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QueryDocumentHistory);
            $scope.vc.model.QueryDocumentHistory.bind('change', function(e) {
                $scope.vc.trackers.QueryDocumentHistory.track(e);
            });
            $scope.vc.grids.QV_9834_40050 = {};
            $scope.vc.grids.QV_9834_40050.queryId = 'Q_DOCUMEHR_9834';
            $scope.vc.viewState.QV_9834_40050 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9834_40050.column = {};
            $scope.vc.grids.QV_9834_40050.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_9834_40050.events = {
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
                    $scope.vc.trackers.QueryDocumentHistory.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9834_40050.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'QueryDocumentHistory',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_9834_40050", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9834_40050");
                    $scope.vc.hideShowColumns("QV_9834_40050", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9834_40050.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9834_40050.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9834_40050.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9834_40050 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9834_40050 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_9834_40050.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9834_40050.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9834_40050.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9834_40050.column.description = {
                title: 'description',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUCJ_187376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT85_DESCRINO280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUCJ_187376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.customerId = {
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
                componentId: 'VA_TEXTINPUTBOXISB_944376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT43_CUSTOMRD280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXISB_944376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.customerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9834_40050.column.customerId.format",
                        'k-decimals': "vc.viewState.QV_9834_40050.column.customerId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.processInstance = {
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
                componentId: 'VA_TEXTINPUTBOXBDA_275376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT53_PROCESIE280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBDA_275376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9834_40050.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_9834_40050.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.file = {
                title: 'file',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXICT_522376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT41_FILEJBGI280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.file.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXICT_522376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.file.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.file.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.uploaded = {
                title: 'uploaded',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTMH_728376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT22_UPLOADDE280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.uploaded.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTMH_728376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.uploaded.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.uploaded.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAHA_602376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT33_EXTENSNI280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAHA_602376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYHD_526376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT92_DOCUMETD280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYHD_526376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.dateVersion = {
                title: 'ASSTS.LBL_ASSTS_FECHAQWBP_23514',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDBTAXCR_437376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT74_DATEVERS280 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.dateVersion.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDBTAXCR_437376",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.dateVersion.validationCode}}",
                        'ng-class': "vc.viewState.QV_9834_40050.column.dateVersion.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.documentVersion = {
                title: 'ASSTS.LBL_ASSTS_VERSINWYZ_59167',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZZB_709376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT59_VERSIONN280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.documentVersion.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZZB_709376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.documentVersion.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.documentVersion.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.groupId = {
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
                componentId: 'VA_TEXTINPUTBOXMTC_398376',
                element: []
            };
            $scope.vc.grids.QV_9834_40050.AT97_GROUPIDD280 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9834_40050.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMTC_398376",
                        'data-validation-code': "{{vc.viewState.QV_9834_40050.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9834_40050.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_9834_40050.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9834_40050.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9834_40050.column.folder = {
                title: 'folder',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_9834_40050.column.description.title|translate:vc.viewState.QV_9834_40050.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.description.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.description.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT85_DESCRINO280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_9834_40050\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.description.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_9834_40050.column.customerId.title|translate:vc.viewState.QV_9834_40050.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.customerId.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.customerId.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT43_CUSTOMRD280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_9834_40050\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_9834_40050.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9834_40050.column.customerId.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_9834_40050.column.processInstance.title|translate:vc.viewState.QV_9834_40050.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.processInstance.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.processInstance.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT53_PROCESIE280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_9834_40050\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_9834_40050.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9834_40050.column.processInstance.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_9834_40050.column.file.title|translate:vc.viewState.QV_9834_40050.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.file.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.file.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT41_FILEJBGI280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_9834_40050\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.file.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_9834_40050.column.uploaded.title|translate:vc.viewState.QV_9834_40050.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.uploaded.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.uploaded.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT22_UPLOADDE280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_9834_40050\", \"uploaded\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.uploaded.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_9834_40050.column.extension.title|translate:vc.viewState.QV_9834_40050.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.extension.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.extension.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT33_EXTENSNI280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_9834_40050\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.extension.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_9834_40050.column.documentId.title|translate:vc.viewState.QV_9834_40050.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.documentId.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.documentId.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT92_DOCUMETD280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_9834_40050\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.documentId.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.documentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'dateVersion',
                    title: '{{vc.viewState.QV_9834_40050.column.dateVersion.title|translate:vc.viewState.QV_9834_40050.column.dateVersion.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.dateVersion.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.dateVersion.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT74_DATEVERS280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.dateVersion.style'>#=((dateVersion !== null) ? kendo.toString(dateVersion, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.dateVersion.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.dateVersion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.dateVersion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'documentVersion',
                    title: '{{vc.viewState.QV_9834_40050.column.documentVersion.title|translate:vc.viewState.QV_9834_40050.column.documentVersion.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.documentVersion.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.documentVersion.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT59_VERSIONN280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.documentVersion.style' ng-bind='vc.getStringColumnFormat(dataItem.documentVersion, \"QV_9834_40050\", \"documentVersion\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9834_40050.column.documentVersion.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.documentVersion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.documentVersion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9834_40050.column.groupId.title|translate:vc.viewState.QV_9834_40050.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9834_40050.column.groupId.width,
                    format: $scope.vc.viewState.QV_9834_40050.column.groupId.format,
                    editor: $scope.vc.grids.QV_9834_40050.AT97_GROUPIDD280.control,
                    template: "<span ng-class='vc.viewState.QV_9834_40050.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9834_40050\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9834_40050.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9834_40050.column.groupId.style",
                        "title": "{{vc.viewState.QV_9834_40050.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.groupId.hidden
                });
            }
            $scope.vc.viewState.QV_9834_40050.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_9834_40050.column.cmdEdition = {};
            $scope.vc.viewState.QV_9834_40050.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_9834_40050.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_9834_40050.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9834_40050.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_CREDITDCCS_357376.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_9834_40050.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376)) {
                    $scope.vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376 = {};
                }
                $scope.vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376.hidden = false;
                $scope.vc.grids.QV_9834_40050.columns.push({
                    field: 'VA_GRIDROWCOMMMDNA_321376',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMDNA_321376",
                        entity: "QueryDocumentHistory",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmdna':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMDNA_321376\", " + "vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376.enabled || vc.viewState.G_CREDITDCCS_357376.disabled' " + "data-ng-click = 'vc.grids.QV_9834_40050.events.customRowClick($event, \"VA_GRIDROWCOMMMDNA_321376\", \"#:entity#\", \"QV_9834_40050\")' " + "title = \"{{vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_9834_40050.column.VA_GRIDROWCOMMMDNA_321376.hidden
                });
            }
            $scope.vc.viewState.QV_9834_40050.toolbar = {}
            $scope.vc.grids.QV_9834_40050.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSNMDWVMHP_252_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSNMDWVMHP_252_CANCEL",
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
                $scope.vc.render('VC_CREDITDOUE_237252');
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
    var cobisMainModule = cobis.createModule("VC_CREDITDOUE_237252", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_CREDITDOUE_237252", {
            templateUrl: "VC_CREDITDOUE_237252_FORM.html",
            controller: "VC_CREDITDOUE_237252_CTRL",
            labelId: "ASSTS.LBL_ASSTS_HISTORIDS_94743",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CREDITDOUE_237252?" + $.param(search);
            }
        });
        VC_CREDITDOUE_237252(cobisMainModule);
    }]);
} else {
    VC_CREDITDOUE_237252(cobisMainModule);
}