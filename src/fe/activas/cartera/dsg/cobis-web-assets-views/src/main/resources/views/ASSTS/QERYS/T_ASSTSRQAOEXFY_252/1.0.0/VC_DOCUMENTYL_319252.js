//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.querydocumentscycle = designerEvents.api.querydocumentscycle || designer.dsgEvents();

function VC_DOCUMENTYL_319252(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DOCUMENTYL_319252_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DOCUMENTYL_319252_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSRQAOEXFY_252",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DOCUMENTYL_319252",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSRQAOEXFY_252",
        designerEvents.api.querydocumentscycle,
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
                vcName: 'VC_DOCUMENTYL_319252'
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
                    taskId: 'T_ASSTSRQAOEXFY_252',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    HeaderQueryDocuments: "HeaderQueryDocuments",
                    QueryDocumentsCycle: "QueryDocumentsCycle"
                },
                entities: {
                    HeaderQueryDocuments: {
                        groupName: 'AT42_GROUPNEE732',
                        clientId: 'AT44_IDCLIENT732',
                        clientType: 'AT55_CLIENTPY732',
                        groupId: 'AT56_IDGROUPP732',
                        procedure: 'AT64_TRAMITEE732',
                        loan: 'AT70_LOANENKU732',
                        documentType: 'AT78_DOCUMEPY732',
                        clientName: 'AT96_CLIENTMN732',
                        _pks: [],
                        _entityId: 'EN_SCANNEDNC_732',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QueryDocumentsCycle: {
                        procedure: 'AT27_ROCEDUER548',
                        loan: 'AT30_LOANZGXM548',
                        processInstance: 'AT34_PROCESNN548',
                        groupId: 'AT43_GROUPIDD548',
                        groupCycle: 'AT56_GROUPCLC548',
                        groupCycleDetail: 'AT58_GROUPCAE548',
                        _pks: [],
                        _entityId: 'EN_DOCUMENTS_548',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_SCANNEDNC_732',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_DOCUMENTS_548',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT56_IDGROUPP732',
                        attributeIdFk: 'AT43_GROUPIDD548'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DOCUMETN_9533 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DOCUMETN_9533 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DOCUMETN_9533_filters)) {
                    parametersAux = {
                        groupId: $scope.vc.model.HeaderQueryDocuments.groupId
                    };
                } else {
                    var filters = $scope.vc.queries.Q_DOCUMETN_9533_filters;
                    parametersAux = {
                        groupId: filters.groupId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DOCUMENTS_548',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DOCUMETN_9533',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['groupId'] = $scope.vc.model.HeaderQueryDocuments.groupId;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['groupId'] = this.filters.groupId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DOCUMETN_9533_filters = {};
            var defaultValues = {
                HeaderQueryDocuments: {},
                QueryDocumentsCycle: {}
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
                $scope.vc.execute("temporarySave", VC_DOCUMENTYL_319252, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DOCUMENTYL_319252, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DOCUMENTYL_319252, data, function() {});
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
            $scope.vc.viewState.VC_DOCUMENTYL_319252 = {
                style: []
            }
            $scope.vc.model.HeaderQueryDocuments = {
                groupName: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "groupName"),
                clientId: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "clientId"),
                clientType: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "clientType"),
                groupId: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "groupId"),
                procedure: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "procedure"),
                loan: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "loan"),
                documentType: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "documentType"),
                clientName: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "clientName")
            };
            //ViewState - Group: Group1152
            $scope.vc.createViewState({
                id: "G_DOCUMENLEL_423645",
                hasId: true,
                componentStyle: [],
                label: 'Group1152',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: clientName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXFVY_775645",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: groupName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHUA_684645",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GRUPOOBAY_84995",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: loan
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLVP_311645",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRSTAMOCV_96028",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: procedure
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKOK_630645",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TRMITESSF_56882",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONEFJJEWA_981645",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_DOCUMETN_9533',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1833
            $scope.vc.createViewState({
                id: "G_DOCUMENCTC_801645",
                hasId: true,
                componentStyle: [],
                label: 'Group1833',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QueryDocumentsCycle = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.groupId
                        }
                    },
                    loan: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsCycle", "loan", '')
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsCycle", "processInstance", 0)
                    },
                    procedure: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsCycle", "procedure", 0)
                    },
                    groupCycle: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsCycle", "groupCycle", 0)
                    },
                    groupCycleDetail: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsCycle", "groupCycleDetail", '')
                    }
                }
            });
            $scope.vc.model.QueryDocumentsCycle = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DOCUMETN_9533';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DOCUMETN_9533();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9533_13855',
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
                                            'pageSize': 20
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
                    model: $scope.vc.types.QueryDocumentsCycle
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9533_13855").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DOCUMETN_9533 = $scope.vc.model.QueryDocumentsCycle;
            $scope.vc.trackers.QueryDocumentsCycle = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QueryDocumentsCycle);
            $scope.vc.model.QueryDocumentsCycle.bind('change', function(e) {
                $scope.vc.trackers.QueryDocumentsCycle.track(e);
                $scope.vc.grids.QV_9533_13855.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_9533_13855 = {};
            $scope.vc.grids.QV_9533_13855.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_9533_13855) && expandedRowUidActual !== expandedRowUid_QV_9533_13855) {
                    var gridWidget = $('#QV_9533_13855').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_9533_13855 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_9533_13855 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_9533_13855 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_9533_13855);
                }
                expandedRowUid_QV_9533_13855 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_9533_13855', args);
                if (angular.isDefined($scope.vc.grids.QV_9533_13855.view)) {
                    $scope.vc.grids.QV_9533_13855.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_9533_13855.customView)) {
                    $scope.vc.grids.QV_9533_13855.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_9533_13855'/>"
            };
            $scope.vc.grids.QV_9533_13855.queryId = 'Q_DOCUMETN_9533';
            $scope.vc.viewState.QV_9533_13855 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9533_13855.column = {};
            var expandedRowUid_QV_9533_13855;
            $scope.vc.grids.QV_9533_13855.editable = false;
            $scope.vc.grids.QV_9533_13855.events = {
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
                    $scope.vc.trackers.QueryDocumentsCycle.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9533_13855.selectedRow = e.model;
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
                    $scope.vc.grids.QV_9533_13855.events.moveRowDetailIcon(e);
                    $scope.vc.grids.QV_9533_13855.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                moveRowDetailIcon: function(e) {
                    var index;
                    var grid = e.sender;
                    grid.tbody.on('mousedown', 'a,button,input[type="button"],td.k-hierarchy-cell', function(evnt) {
                        evnt.stopImmediatePropagation();
                        evnt.stopPropagation();
                    });
                    var numColumns = grid.columns.length + 1; //se suma uno por el detalle de grid
                    var numColumnsVisible = $("#QV_9533_13855 > .k-grid-header colgroup col").length;
                    var diff = numColumns - numColumnsVisible;
                    index = grid.element.find("th.k-header[data-role='droptarget']").index();
                    if (index != -1) {
                        $("#QV_9533_13855 th.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("th", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_9533_13855 td.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("td", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_9533_13855 .k-hierarchy-col").each(function() {
                            $(this).insertAfter($("col", this.parentNode).eq(grid.columns.length - diff));
                        });
                    } else {
                        index = grid.tbody.find('tr:first>td:last').index();
                        if (index === -1) {
                            index = grid.element.find('tr>th:last').index();
                        }
                        if (index > 0) {
                            $("#QV_9533_13855 .k-hierarchy-cell").each(function() {
                                var element = $(this).siblings().eq(index - 1);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                            $("#QV_9533_13855 .k-hierarchy-col").each(function() {
                                var element = $(this).siblings().eq(index - 1 - diff);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                        }
                    }
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "QueryDocumentsCycle",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_9533_13855", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_9533_13855", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.grids.QV_9533_13855.events.moveRowDetailIcon(e);
                    $scope.vc.gridDataBound("QV_9533_13855");
                    $scope.vc.hideShowColumns("QV_9533_13855", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9533_13855.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9533_13855.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9533_13855.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9533_13855 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9533_13855 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_9533_13855.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_9533_13855 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                },
                detailExpand: function(e) {
                    if (angular.isDefined(e.detailRow) && $(e.detailRow[0].cells).length > 1) {
                        $(e.detailRow[0].cells[0]).remove();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9533_13855.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9533_13855.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9533_13855.column.groupId = {
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
                componentId: 'VA_TEXTINPUTBOXHXI_378645',
                element: []
            };
            $scope.vc.grids.QV_9533_13855.AT43_GROUPIDD548 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9533_13855.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHXI_378645",
                        'data-validation-code': "{{vc.viewState.QV_9533_13855.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9533_13855.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_9533_13855.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9533_13855.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9533_13855.column.loan = {
                title: 'loan',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAYT_372645',
                element: []
            };
            $scope.vc.grids.QV_9533_13855.AT30_LOANZGXM548 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9533_13855.column.loan.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAYT_372645",
                        'data-validation-code': "{{vc.viewState.QV_9533_13855.column.loan.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9533_13855.column.loan.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9533_13855.column.processInstance = {
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
                componentId: 'VA_TEXTINPUTBOXNKQ_472645',
                element: []
            };
            $scope.vc.grids.QV_9533_13855.AT34_PROCESNN548 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9533_13855.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNKQ_472645",
                        'data-validation-code': "{{vc.viewState.QV_9533_13855.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9533_13855.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_9533_13855.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9533_13855.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9533_13855.column.procedure = {
                title: 'procedure',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWQY_932645',
                element: []
            };
            $scope.vc.grids.QV_9533_13855.AT27_ROCEDUER548 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9533_13855.column.procedure.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWQY_932645",
                        'data-validation-code': "{{vc.viewState.QV_9533_13855.column.procedure.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9533_13855.column.procedure.format",
                        'k-decimals': "vc.viewState.QV_9533_13855.column.procedure.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9533_13855.column.procedure.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9533_13855.column.groupCycle = {
                title: 'ASSTS.LBL_ASSTS_CICLOGRAL_66352',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWZA_525645',
                element: []
            };
            $scope.vc.grids.QV_9533_13855.AT56_GROUPCLC548 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9533_13855.column.groupCycle.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.None,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9533_13855.column.groupCycleDetail = {
                title: 'ASSTS.LBL_ASSTS_CICLOGRAL_66352',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFTZ_975645',
                element: []
            };
            $scope.vc.grids.QV_9533_13855.AT58_GROUPCAE548 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9533_13855.column.groupCycleDetail.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9533_13855.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9533_13855.column.groupId.title|translate:vc.viewState.QV_9533_13855.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9533_13855.column.groupId.width,
                    format: $scope.vc.viewState.QV_9533_13855.column.groupId.format,
                    editor: $scope.vc.grids.QV_9533_13855.AT43_GROUPIDD548.control,
                    template: "<span ng-class='vc.viewState.QV_9533_13855.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9533_13855\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9533_13855.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9533_13855.column.groupId.style",
                        "title": "{{vc.viewState.QV_9533_13855.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9533_13855.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9533_13855.columns.push({
                    field: 'loan',
                    title: '{{vc.viewState.QV_9533_13855.column.loan.title|translate:vc.viewState.QV_9533_13855.column.loan.titleArgs}}',
                    width: $scope.vc.viewState.QV_9533_13855.column.loan.width,
                    format: $scope.vc.viewState.QV_9533_13855.column.loan.format,
                    editor: $scope.vc.grids.QV_9533_13855.AT30_LOANZGXM548.control,
                    template: "<span ng-class='vc.viewState.QV_9533_13855.column.loan.style' ng-bind='vc.getStringColumnFormat(dataItem.loan, \"QV_9533_13855\", \"loan\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9533_13855.column.loan.style",
                        "title": "{{vc.viewState.QV_9533_13855.column.loan.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9533_13855.column.loan.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9533_13855.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_9533_13855.column.processInstance.title|translate:vc.viewState.QV_9533_13855.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_9533_13855.column.processInstance.width,
                    format: $scope.vc.viewState.QV_9533_13855.column.processInstance.format,
                    editor: $scope.vc.grids.QV_9533_13855.AT34_PROCESNN548.control,
                    template: "<span ng-class='vc.viewState.QV_9533_13855.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_9533_13855\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_9533_13855.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9533_13855.column.processInstance.style",
                        "title": "{{vc.viewState.QV_9533_13855.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9533_13855.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9533_13855.columns.push({
                    field: 'procedure',
                    title: '{{vc.viewState.QV_9533_13855.column.procedure.title|translate:vc.viewState.QV_9533_13855.column.procedure.titleArgs}}',
                    width: $scope.vc.viewState.QV_9533_13855.column.procedure.width,
                    format: $scope.vc.viewState.QV_9533_13855.column.procedure.format,
                    editor: $scope.vc.grids.QV_9533_13855.AT27_ROCEDUER548.control,
                    template: "<span ng-class='vc.viewState.QV_9533_13855.column.procedure.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.procedure, \"QV_9533_13855\", \"procedure\"):kendo.toString(#=procedure#, vc.viewState.QV_9533_13855.column.procedure.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9533_13855.column.procedure.style",
                        "title": "{{vc.viewState.QV_9533_13855.column.procedure.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9533_13855.column.procedure.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9533_13855.columns.push({
                    field: 'groupCycle',
                    title: '{{vc.viewState.QV_9533_13855.column.groupCycle.title|translate:vc.viewState.QV_9533_13855.column.groupCycle.titleArgs}}',
                    width: $scope.vc.viewState.QV_9533_13855.column.groupCycle.width,
                    format: $scope.vc.viewState.QV_9533_13855.column.groupCycle.format,
                    editor: $scope.vc.grids.QV_9533_13855.AT56_GROUPCLC548.control,
                    template: "<span ng-class='vc.viewState.QV_9533_13855.column.groupCycle.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupCycle, \"QV_9533_13855\", \"groupCycle\"):kendo.toString(#=groupCycle#, vc.viewState.QV_9533_13855.column.groupCycle.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9533_13855.column.groupCycle.style",
                        "title": "{{vc.viewState.QV_9533_13855.column.groupCycle.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9533_13855.column.groupCycle.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9533_13855.columns.push({
                    field: 'groupCycleDetail',
                    title: '{{vc.viewState.QV_9533_13855.column.groupCycleDetail.title|translate:vc.viewState.QV_9533_13855.column.groupCycleDetail.titleArgs}}',
                    width: $scope.vc.viewState.QV_9533_13855.column.groupCycleDetail.width,
                    format: $scope.vc.viewState.QV_9533_13855.column.groupCycleDetail.format,
                    editor: $scope.vc.grids.QV_9533_13855.AT58_GROUPCAE548.control,
                    template: "<span ng-class='vc.viewState.QV_9533_13855.column.groupCycleDetail.style' ng-bind='vc.getStringColumnFormat(dataItem.groupCycleDetail, \"QV_9533_13855\", \"groupCycleDetail\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9533_13855.column.groupCycleDetail.style",
                        "title": "{{vc.viewState.QV_9533_13855.column.groupCycleDetail.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9533_13855.column.groupCycleDetail.hidden
                });
            }
            $scope.vc.viewState.QV_9533_13855.toolbar = {}
            $scope.vc.grids.QV_9533_13855.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSRQAOEXFY_252_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSRQAOEXFY_252_CANCEL",
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
                $scope.vc.render('VC_DOCUMENTYL_319252');
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
    var cobisMainModule = cobis.createModule("VC_DOCUMENTYL_319252", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_DOCUMENTYL_319252", {
            templateUrl: "VC_DOCUMENTYL_319252_FORM.html",
            controller: "VC_DOCUMENTYL_319252_CTRL",
            labelId: "ASSTS.LBL_ASSTS_BSQUEDAGU_62538",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DOCUMENTYL_319252?" + $.param(search);
            }
        });
        VC_DOCUMENTYL_319252(cobisMainModule);
    }]);
} else {
    VC_DOCUMENTYL_319252(cobisMainModule);
}