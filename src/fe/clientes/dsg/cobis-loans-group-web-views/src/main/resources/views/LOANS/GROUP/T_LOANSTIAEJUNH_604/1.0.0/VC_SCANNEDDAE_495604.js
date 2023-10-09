//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.scanneddocumentsdetail = designerEvents.api.scanneddocumentsdetail || designer.dsgEvents();

function VC_SCANNEDDAE_495604(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_SCANNEDDAE_495604_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_SCANNEDDAE_495604_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANSTIAEJUNH_604",
            taskVersion: "1.0.0",
            viewContainerId: "VC_SCANNEDDAE_495604",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_LOANSTIAEJUNH_604",
        designerEvents.api.scanneddocumentsdetail,
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
                vcName: 'VC_SCANNEDDAE_495604'
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
                    taskId: 'T_LOANSTIAEJUNH_604',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ScannedDocumentsDetail: "ScannedDocumentsDetail",
                    ScannedDocuments: "ScannedDocuments"
                },
                entities: {
                    ScannedDocumentsDetail: {
                        groupId: 'AT17_GROUPIDD651',
                        description: 'AT46_DESCRINI651',
                        customerId: 'AT54_CUSTOMRD651',
                        documentId: 'AT61_DOCUMENI651',
                        uploaded: 'AT65_UPLOADEE651',
                        typeRequest: 'AT67_TYPERETQ651',
                        processInstance: 'AT94_PROCESAS651',
                        extension: 'AT98_EXTENSNN651',
                        file: 'AT98_FILECWLB651',
                        _pks: [],
                        _entityId: 'EN_SCANNEDDO_651',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ScannedDocuments: {
                        groupId: 'AT12_GROUPIDD977',
                        typeRequest: 'AT24_TYPERETQ977',
                        customerId: 'AT42_CUSTOMER977',
                        members: 'AT97_MEMBERSS977',
                        applicationNumber: 'AT99_APPLICON977',
                        _pks: [],
                        _entityId: 'EN_DEBTORTAZ_977',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_SCANNEDD_6397 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_SCANNEDD_6397 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_SCANNEDD_6397_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_SCANNEDD_6397_filters;
                    parametersAux = {
                        customerId: filters.customerId,
                        groupId: filters.groupId,
                        processInstance: filters.processInstance,
                        typeRequest: filters.typeRequest
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SCANNEDDO_651',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_SCANNEDD_6397',
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
                            this.parameters['groupId'] = this.filters.groupId;
                            this.parameters['processInstance'] = this.filters.processInstance;
                            this.parameters['typeRequest'] = this.filters.typeRequest;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_SCANNEDD_6397_filters = {};
            var defaultValues = {
                ScannedDocumentsDetail: {},
                ScannedDocuments: {}
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
                $scope.vc.execute("temporarySave", VC_SCANNEDDAE_495604, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_SCANNEDDAE_495604, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_SCANNEDDAE_495604, data, function() {});
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
            $scope.vc.viewState.VC_SCANNEDDAE_495604 = {
                style: []
            }
            //ViewState - Group: Group1847
            $scope.vc.createViewState({
                id: "G_SCANNEDMIO_591904",
                hasId: true,
                componentStyle: [],
                label: 'Group1847',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ScannedDocumentsDetail = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "description", '')
                    },
                    uploaded: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "uploaded", '')
                    },
                    file: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "file", '')
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerId", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "groupId", 0)
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "processInstance", 0)
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "extension", '')
                    },
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "documentId", '')
                    },
                    typeRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "typeRequest", '')
                    }
                }
            });
            $scope.vc.model.ScannedDocumentsDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_SCANNEDD_6397';
                            var queryRequest = $scope.vc.getRequestQuery_Q_SCANNEDD_6397();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6397_58590',
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
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Insert,
                            nameEntityGrid: 'ScannedDocumentsDetail'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_6397_58590', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ScannedDocumentsDetail',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6397_58590', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                                    nameEntityGrid: 'ScannedDocumentsDetail'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_6397_58590', argsAfterLeave);
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
                    model: $scope.vc.types.ScannedDocumentsDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6397_58590").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_SCANNEDD_6397 = $scope.vc.model.ScannedDocumentsDetail;
            $scope.vc.trackers.ScannedDocumentsDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ScannedDocumentsDetail);
            $scope.vc.model.ScannedDocumentsDetail.bind('change', function(e) {
                $scope.vc.trackers.ScannedDocumentsDetail.track(e);
            });
            $scope.vc.grids.QV_6397_58590 = {};
            $scope.vc.grids.QV_6397_58590.queryId = 'Q_SCANNEDD_6397';
            $scope.vc.viewState.QV_6397_58590 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6397_58590.column = {};
            $scope.vc.grids.QV_6397_58590.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_6397_58590.events = {
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
                    $scope.vc.trackers.ScannedDocumentsDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6397_58590.selectedRow = e.model;
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
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'ScannedDocumentsDetail',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_6397_58590", args, function() {
                        if (args.cancel) {
                            $("#QV_6397_58590").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'ScannedDocumentsDetail',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_6397_58590", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_6397_58590");
                    $scope.vc.hideShowColumns("QV_6397_58590", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6397_58590.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6397_58590.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6397_58590.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6397_58590 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6397_58590 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_6397_58590.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6397_58590.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6397_58590.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6397_58590.column.description = {
                title: 'LOANS.LBL_LOANS_DOCUMENOT_89129',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJFX_289904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT46_DESCRINI651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJFX_289904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.uploaded = {
                title: 'LOANS.LBL_LOANS_CARGADOMC_42766',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSON_931904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT65_UPLOADEE651 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_6397_58590.column.uploaded.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.file = {
                title: 'LOANS.LBL_LOANS_ARCHIVOSR_58260',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLEM_317904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT98_FILECWLB651 = {
                control: function(container, options) {
                    $scope.vc.viewState.QV_6397_58590.column.file.disabledUpload = false;
                    $scope.vc.uploaders.VA_TEXTINPUTBOXLEM_317904 = {
                        maxSizeInMB: 10,
                        relativePath: null,
                        confirmUpload: false,
                        visualAttributeModel: '',
                        queryViewId: 'QV_6397_58590',
                        gridFieldName: 'file',
                        fileUploadAPI: null
                    };
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.file.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-readonly': "true",
                        'id': "VA_TEXTINPUTBOXLEM_317904",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.file.validationCode}}",
                        'class': "form-control"
                    });
                    var buttonUpload = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "vc.viewState.QV_6397_58590.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_6397_58590.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-mouseup': "vc.clickFileUploader('VA_TEXTINPUTBOXLEM_317904')",
                        'ng-mousedown': "vc.grids.QV_6397_58590.events.customRowClick($event, 'VA_TEXTINPUTBOXLEM_317904', 'ScannedDocumentsDetail', 'QV_6397_58590','DSG_UPLOAD_FILE_')"
                    });
                    var buttonSuccess = $('<button />', {
                        'class': "btn btn-primary btn-block",
                        'type': "button",
                        'ng-class': "vc.viewState.QV_6397_58590.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"
                    });
                    var buttonRemove = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_6397_58590.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-click': "vc.removeFile('VA_TEXTINPUTBOXLEM_317904')"
                    });
                    var divRow = $('<div/>', {
                        'class': "input-group"
                    });
                    var innerDivRow = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var innerDivRow1 = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var innerDivShow = $('<div/>', {
                        'ng-show': "vc.viewState.QV_6397_58590.column.file.disabledUpload"
                    });
                    var innerDivhide = $('<div/>', {
                        'ng-hide': "vc.viewState.QV_6397_58590.column.file.disabledUpload"
                    });
                    var spanImageUpload = $('<span />', {
                        'class': "glyphicon glyphicon-paperclip"
                    });
                    var spanImageRemove = $('<span />', {
                        'class': "glyphicon glyphicon-remove-circle"
                    });
                    var spanImageSuccess = $('<span />', {
                        'class': "glyphicon glyphicon-ok"
                    });
                    spanImageUpload.appendTo(buttonUpload);
                    buttonUpload.appendTo(innerDivhide);
                    innerDivhide.appendTo(innerDivRow);
                    spanImageSuccess.appendTo(buttonSuccess);
                    buttonSuccess.appendTo(innerDivShow);
                    innerDivShow.appendTo(innerDivRow);
                    spanImageRemove.appendTo(buttonRemove);
                    buttonRemove.appendTo(innerDivRow1);
                    textInput.appendTo(divRow);
                    innerDivRow.appendTo(divRow);
                    innerDivRow1.appendTo(divRow);
                    divRow.appendTo(container);
                    var textInputFile = $('<input />', {
                        'name': "VA_TEXTINPUTBOXLEM_317904_gridUploader",
                        'id': "VA_TEXTINPUTBOXLEM_317904_gridUploader",
                        'type': "file"
                    }).kendoUpload({
                        'async': {
                            saveUrl: '${contextPath}/cobis/web/cobis-designer-engine-web/actions/fileupload?'
                        },
                        'class': "form-control",
                        'upload': function(e) {
                            $scope.vc.onFileUpload(e, options.model, 'VA_TEXTINPUTBOXLEM_317904');
                        },
                        'select': function(e) {
                            $scope.vc.onFileSelect(e, 'VA_TEXTINPUTBOXLEM_317904');
                        },
                        'success': function(e) {
                            $scope.vc.onSuccess(e, 'VA_TEXTINPUTBOXLEM_317904');
                        },
                        'multiple': false
                    });
                    var divRowUp = $('<div/>', {
                        'ng-hide': true
                    });
                    textInputFile.appendTo(divRowUp);
                    divRowUp.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.customerId = {
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
                componentId: 'VA_TEXTINPUTBOXHPP_701904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT54_CUSTOMRD651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHPP_701904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.customerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6397_58590.column.customerId.format",
                        'k-decimals': "vc.viewState.QV_6397_58590.column.customerId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.groupId = {
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
                componentId: 'VA_TEXTINPUTBOXNYC_310904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT17_GROUPIDD651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNYC_310904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6397_58590.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_6397_58590.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.processInstance = {
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
                componentId: 'VA_TEXTINPUTBOXEXX_736904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT94_PROCESAS651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEXX_736904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6397_58590.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_6397_58590.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZWS_128904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT98_EXTENSNN651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZWS_128904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXINQ_706904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT61_DOCUMENI651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXINQ_706904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6397_58590.column.typeRequest = {
                title: 'typeRequest',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVPC_673904',
                element: []
            };
            $scope.vc.grids.QV_6397_58590.AT67_TYPERETQ651 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6397_58590.column.typeRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVPC_673904",
                        'data-validation-code': "{{vc.viewState.QV_6397_58590.column.typeRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6397_58590.column.typeRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_6397_58590.column.description.title|translate:vc.viewState.QV_6397_58590.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.description.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.description.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT46_DESCRINI651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_6397_58590\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6397_58590.column.description.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_6397_58590.column.uploaded.title|translate:vc.viewState.QV_6397_58590.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.uploaded.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.uploaded.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6397_58590', 'uploaded', $scope.vc.grids.QV_6397_58590.AT65_UPLOADEE651.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6397_58590', 'uploaded', "<span ng-class='vc.viewState.QV_6397_58590.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_6397_58590\", \"uploaded\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6397_58590.column.uploaded.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_6397_58590.column.file.title|translate:vc.viewState.QV_6397_58590.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.file.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.file.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT98_FILECWLB651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_6397_58590\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6397_58590.column.file.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_6397_58590.column.customerId.title|translate:vc.viewState.QV_6397_58590.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.customerId.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.customerId.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT54_CUSTOMRD651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_6397_58590\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_6397_58590.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6397_58590.column.customerId.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_6397_58590.column.groupId.title|translate:vc.viewState.QV_6397_58590.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.groupId.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.groupId.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT17_GROUPIDD651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_6397_58590\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_6397_58590.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6397_58590.column.groupId.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_6397_58590.column.processInstance.title|translate:vc.viewState.QV_6397_58590.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.processInstance.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.processInstance.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT94_PROCESAS651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_6397_58590\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_6397_58590.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6397_58590.column.processInstance.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_6397_58590.column.extension.title|translate:vc.viewState.QV_6397_58590.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.extension.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.extension.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT98_EXTENSNN651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_6397_58590\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6397_58590.column.extension.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_6397_58590.column.documentId.title|translate:vc.viewState.QV_6397_58590.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.documentId.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.documentId.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT61_DOCUMENI651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_6397_58590\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6397_58590.column.documentId.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.documentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'typeRequest',
                    title: '{{vc.viewState.QV_6397_58590.column.typeRequest.title|translate:vc.viewState.QV_6397_58590.column.typeRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_6397_58590.column.typeRequest.width,
                    format: $scope.vc.viewState.QV_6397_58590.column.typeRequest.format,
                    editor: $scope.vc.grids.QV_6397_58590.AT67_TYPERETQ651.control,
                    template: "<span ng-class='vc.viewState.QV_6397_58590.column.typeRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.typeRequest, \"QV_6397_58590\", \"typeRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6397_58590.column.typeRequest.style",
                        "title": "{{vc.viewState.QV_6397_58590.column.typeRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.typeRequest.hidden
                });
            }
            $scope.vc.viewState.QV_6397_58590.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_6397_58590.column.cmdEdition = {};
            $scope.vc.viewState.QV_6397_58590.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_6397_58590.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_6397_58590.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6397_58590.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_SCANNEDMIO_591904.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_6397_58590.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904)) {
                    $scope.vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904 = {};
                }
                $scope.vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904.hidden = false;
                $scope.vc.grids.QV_6397_58590.columns.push({
                    field: 'VA_GRIDROWCOMMMAAD_760904',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMAAD_760904",
                        entity: "ScannedDocumentsDetail",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmaad':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMAAD_760904\", " + "vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904.enabled || vc.viewState.G_SCANNEDMIO_591904.disabled' " + "data-ng-click = 'vc.grids.QV_6397_58590.events.customRowClick($event, \"VA_GRIDROWCOMMMAAD_760904\", \"#:entity#\", \"QV_6397_58590\")' " + "title = \"{{vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_6397_58590.column.VA_GRIDROWCOMMMAAD_760904.hidden
                });
            }
            $scope.vc.viewState.QV_6397_58590.toolbar = {}
            $scope.vc.grids.QV_6397_58590.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSTIAEJUNH_604_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSTIAEJUNH_604_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ScannedDocuments = {
                groupId: $scope.vc.channelDefaultValues("ScannedDocuments", "groupId"),
                typeRequest: $scope.vc.channelDefaultValues("ScannedDocuments", "typeRequest"),
                customerId: $scope.vc.channelDefaultValues("ScannedDocuments", "customerId"),
                members: $scope.vc.channelDefaultValues("ScannedDocuments", "members"),
                applicationNumber: $scope.vc.channelDefaultValues("ScannedDocuments", "applicationNumber")
            };
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
                $scope.vc.render('VC_SCANNEDDAE_495604');
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
    var cobisMainModule = cobis.createModule("VC_SCANNEDDAE_495604", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_SCANNEDDAE_495604", {
            templateUrl: "VC_SCANNEDDAE_495604_FORM.html",
            controller: "VC_SCANNEDDAE_495604_CTRL",
            label: "ScannedDocumentsDetail",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_SCANNEDDAE_495604?" + $.param(search);
            }
        });
        VC_SCANNEDDAE_495604(cobisMainModule);
    }]);
} else {
    VC_SCANNEDDAE_495604(cobisMainModule);
}