//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.querydocumentsbyfilter = designerEvents.api.querydocumentsbyfilter || designer.dsgEvents();

function VC_DOCUMENTLI_842821(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DOCUMENTLI_842821_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DOCUMENTLI_842821_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSIFBOZBRX_821",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DOCUMENTLI_842821",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSIFBOZBRX_821",
        designerEvents.api.querydocumentsbyfilter,
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
                vcName: 'VC_DOCUMENTLI_842821'
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
                    taskId: 'T_ASSTSIFBOZBRX_821',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    HeaderQueryDocuments: "HeaderQueryDocuments",
                    ResultQueryByFilter: "ResultQueryByFilter"
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
                    ResultQueryByFilter: {
                        clientType: 'AT12_CLIENTEE148',
                        groupId: 'AT18_GROUPIDD148',
                        documentType: 'AT31_DOCUMEPY148',
                        entryDate: 'AT34_ENTRYDEA148',
                        documentName: 'AT50_DOCUMENE148',
                        folder: 'AT52_FOLDERMF148',
                        extension: 'AT56_EXTENSOI148',
                        codDocumentType: 'AT57_CODDOCUE148',
                        procedureNumber: 'AT69_PROCEDMR148',
                        clientGroupName: 'AT70_CLIENTRN148',
                        clientId: 'AT75_CLIENTID148',
                        processId: 'AT82_PROCESSD148',
                        showRecentDocument: 'AT84_SHOWRENE148',
                        showDocumentHistory: 'AT87_SHOWDOUT148',
                        loanNumber: 'AT95_LOANNUMR148',
                        _pks: [],
                        _entityId: 'EN_RESULTBTI_148',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_SCANNEDNC_732',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_RESULTBTI_148',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT44_IDCLIENT732',
                        attributeIdFk: 'AT75_CLIENTID148'
                    }, {
                        attributeIdPk: 'AT78_DOCUMEPY732',
                        attributeIdFk: 'AT57_CODDOCUE148'
                    }, {
                        attributeIdPk: 'AT55_CLIENTPY732',
                        attributeIdFk: 'AT12_CLIENTEE148'
                    }, {
                        attributeIdPk: 'AT70_LOANENKU732',
                        attributeIdFk: 'AT95_LOANNUMR148'
                    }, {
                        attributeIdPk: 'AT64_TRAMITEE732',
                        attributeIdFk: 'AT69_PROCEDMR148'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_RESULTYR_9784 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_RESULTYR_9784 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RESULTYR_9784_filters)) {
                    parametersAux = {
                        loanNumber: $scope.vc.model.HeaderQueryDocuments.loan,
                        clientType: $scope.vc.model.HeaderQueryDocuments.clientType,
                        procedureNumber: $scope.vc.model.HeaderQueryDocuments.procedure,
                        codDocumentType: $scope.vc.model.HeaderQueryDocuments.documentType,
                        clientId: $scope.vc.model.HeaderQueryDocuments.clientId
                    };
                } else {
                    var filters = $scope.vc.queries.Q_RESULTYR_9784_filters;
                    parametersAux = {
                        loanNumber: filters.loanNumber,
                        documentType: filters.documentType,
                        clientType: filters.clientType,
                        procedureNumber: filters.procedureNumber,
                        codDocumentType: filters.codDocumentType,
                        clientId: filters.clientId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RESULTBTI_148',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RESULTYR_9784',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['loanNumber'] = $scope.vc.model.HeaderQueryDocuments.loan;
                            this.parameters['clientType'] = $scope.vc.model.HeaderQueryDocuments.clientType;
                            this.parameters['procedureNumber'] = $scope.vc.model.HeaderQueryDocuments.procedure;
                            this.parameters['codDocumentType'] = $scope.vc.model.HeaderQueryDocuments.documentType;
                            this.parameters['clientId'] = $scope.vc.model.HeaderQueryDocuments.clientId;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['loanNumber'] = this.filters.loanNumber;
                            this.parameters['documentType'] = this.filters.documentType;
                            this.parameters['clientType'] = this.filters.clientType;
                            this.parameters['procedureNumber'] = this.filters.procedureNumber;
                            this.parameters['codDocumentType'] = this.filters.codDocumentType;
                            this.parameters['clientId'] = this.filters.clientId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_RESULTYR_9784_filters = {};
            var defaultValues = {
                HeaderQueryDocuments: {},
                ResultQueryByFilter: {}
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
                $scope.vc.execute("temporarySave", VC_DOCUMENTLI_842821, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DOCUMENTLI_842821, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DOCUMENTLI_842821, data, function() {});
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
            $scope.vc.viewState.VC_DOCUMENTLI_842821 = {
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
            //ViewState - Group: Group1378
            $scope.vc.createViewState({
                id: "G_DOCUMENITI_420698",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FILTROSUO_42877",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: clientId
            $scope.vc.createViewState({
                id: "VA_CLIENTIDBZOEDEE_140698",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: loan
            $scope.vc.createViewState({
                id: "VA_LOANRLDFBBEUFOT_824698",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRSTAMONN_80975",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: procedure
            $scope.vc.createViewState({
                id: "VA_PROCEDURENUYDXU_600698",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TRMITESSF_56882",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_DOCUMENTTYPEVHQ_629698",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPODOCNU_92045",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTTYPEVHQ_629698 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_DOCUMENTTYPEVHQ_629698', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTTYPEVHQ_629698'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTTYPEVHQ_629698");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONVBESOQY_879698",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_RESULTYR_9784',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1155
            $scope.vc.createViewState({
                id: "G_DOCUMENIIB_227698",
                hasId: true,
                componentStyle: [],
                label: 'Group1155',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ResultQueryByFilter = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    clientGroupName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "clientGroupName", '')
                    },
                    loanNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.loan
                        }
                    },
                    showRecentDocument: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "showRecentDocument", false)
                    },
                    showDocumentHistory: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "showDocumentHistory", false)
                    },
                    documentType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "documentType", '')
                    },
                    processId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "processId", 0)
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "extension", '')
                    },
                    entryDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "entryDate", new Date())
                    },
                    procedureNumber: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.procedure
                        }
                    },
                    folder: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "folder", '')
                    },
                    documentName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "documentName", '')
                    },
                    codDocumentType: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.documentType
                        }
                    },
                    clientId: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.clientId
                        }
                    },
                    clientType: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.clientType
                        }
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ResultQueryByFilter", "groupId", 0)
                    }
                }
            });
            $scope.vc.model.ResultQueryByFilter = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_RESULTYR_9784';
                            var queryRequest = $scope.vc.getRequestQuery_Q_RESULTYR_9784();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9784_36547',
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
                    model: $scope.vc.types.ResultQueryByFilter
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9784_36547").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RESULTYR_9784 = $scope.vc.model.ResultQueryByFilter;
            $scope.vc.trackers.ResultQueryByFilter = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ResultQueryByFilter);
            $scope.vc.model.ResultQueryByFilter.bind('change', function(e) {
                $scope.vc.trackers.ResultQueryByFilter.track(e);
            });
            $scope.vc.grids.QV_9784_36547 = {};
            $scope.vc.grids.QV_9784_36547.queryId = 'Q_RESULTYR_9784';
            $scope.vc.viewState.QV_9784_36547 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9784_36547.column = {};
            $scope.vc.grids.QV_9784_36547.editable = false;
            $scope.vc.grids.QV_9784_36547.events = {
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
                    $scope.vc.trackers.ResultQueryByFilter.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9784_36547.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_9784_36547");
                    $scope.vc.hideShowColumns("QV_9784_36547", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9784_36547.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9784_36547.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9784_36547.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9784_36547 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9784_36547 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9784_36547.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9784_36547.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9784_36547.column.clientGroupName = {
                title: 'ASSTS.LBL_ASSTS_NOMBRECUO_29319',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGTB_612698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT70_CLIENTRN148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.clientGroupName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGTB_612698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.clientGroupName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.clientGroupName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.loanNumber = {
                title: 'ASSTS.LBL_ASSTS_NMEROPRMT_83640',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJSV_761698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT95_LOANNUMR148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.loanNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJSV_761698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.loanNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.loanNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.showRecentDocument = {
                title: 'ASSTS.LBL_ASSTS_VERDOCUMI_36981',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXOLYSJLW_960698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT84_SHOWRENE148 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.showRecentDocument.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_CHECKBOXOLYSJLW_960698",
                        'ng-class': 'vc.viewState.QV_9784_36547.column.showRecentDocument.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.showDocumentHistory = {
                title: 'ASSTS.LBL_ASSTS_VERHISTOR_50100',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXPUSKQAL_746698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT87_SHOWDOUT148 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.showDocumentHistory.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_CHECKBOXPUSKQAL_746698",
                        'ng-class': 'vc.viewState.QV_9784_36547.column.showDocumentHistory.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.documentType = {
                title: 'ASSTS.LBL_ASSTS_TIPODOCNU_92045',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVGS_587698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT31_DOCUMEPY148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.documentType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVGS_587698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.documentType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.documentType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.processId = {
                title: 'processId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQCD_523698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT82_PROCESSD148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.processId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQCD_523698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.processId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9784_36547.column.processId.format",
                        'k-decimals': "vc.viewState.QV_9784_36547.column.processId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.processId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOAU_147698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT56_EXTENSOI148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOAU_147698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.entryDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAINOG_18676',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDCYTWTC_839698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT34_ENTRYDEA148 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.entryDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDCYTWTC_839698",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.entryDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_9784_36547.column.entryDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.procedureNumber = {
                title: 'ASSTS.LBL_ASSTS_TRMITESSF_56882',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWXL_715698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT69_PROCEDMR148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.procedureNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWXL_715698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.procedureNumber.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9784_36547.column.procedureNumber.format",
                        'k-decimals': "vc.viewState.QV_9784_36547.column.procedureNumber.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.procedureNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.folder = {
                title: 'folder',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBDO_624698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT52_FOLDERMF148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.folder.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBDO_624698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.folder.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.folder.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.documentName = {
                title: 'documentName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFBG_872698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT50_DOCUMENE148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.documentName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFBG_872698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.documentName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.documentName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.codDocumentType = {
                title: 'codDocumentType',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCTY_246698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT57_CODDOCUE148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.codDocumentType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCTY_246698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.codDocumentType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.codDocumentType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.clientId = {
                title: 'clientId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMQA_524698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT75_CLIENTID148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.clientId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMQA_524698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.clientId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9784_36547.column.clientId.format",
                        'k-decimals': "vc.viewState.QV_9784_36547.column.clientId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.clientId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.clientType = {
                title: 'clientType',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMQU_899698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT12_CLIENTEE148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.clientType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMQU_899698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.clientType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.clientType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9784_36547.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGRI_246698',
                element: []
            };
            $scope.vc.grids.QV_9784_36547.AT18_GROUPIDD148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9784_36547.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGRI_246698",
                        'data-validation-code': "{{vc.viewState.QV_9784_36547.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9784_36547.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_9784_36547.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9784_36547.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'clientGroupName',
                    title: '{{vc.viewState.QV_9784_36547.column.clientGroupName.title|translate:vc.viewState.QV_9784_36547.column.clientGroupName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.clientGroupName.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.clientGroupName.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT70_CLIENTRN148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.clientGroupName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientGroupName, \"QV_9784_36547\", \"clientGroupName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.clientGroupName.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.clientGroupName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.clientGroupName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'loanNumber',
                    title: '{{vc.viewState.QV_9784_36547.column.loanNumber.title|translate:vc.viewState.QV_9784_36547.column.loanNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.loanNumber.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.loanNumber.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT95_LOANNUMR148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.loanNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.loanNumber, \"QV_9784_36547\", \"loanNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.loanNumber.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.loanNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.loanNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'showRecentDocument',
                    title: '{{vc.viewState.QV_9784_36547.column.showRecentDocument.title|translate:vc.viewState.QV_9784_36547.column.showRecentDocument.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.showRecentDocument.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.showRecentDocument.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT84_SHOWRENE148.control,
                    template: "<input name='showRecentDocument' type='checkbox' value='#=showRecentDocument#' #=showRecentDocument?checked='checked':''# disabled='disabled' data-bind='value:showRecentDocument' ng-class='vc.viewState.QV_9784_36547.column.showRecentDocument.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.showRecentDocument.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.showRecentDocument.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.showRecentDocument.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'showDocumentHistory',
                    title: '{{vc.viewState.QV_9784_36547.column.showDocumentHistory.title|translate:vc.viewState.QV_9784_36547.column.showDocumentHistory.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.showDocumentHistory.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.showDocumentHistory.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT87_SHOWDOUT148.control,
                    template: "<input name='showDocumentHistory' type='checkbox' value='#=showDocumentHistory#' #=showDocumentHistory?checked='checked':''# disabled='disabled' data-bind='value:showDocumentHistory' ng-class='vc.viewState.QV_9784_36547.column.showDocumentHistory.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.showDocumentHistory.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.showDocumentHistory.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.showDocumentHistory.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'documentType',
                    title: '{{vc.viewState.QV_9784_36547.column.documentType.title|translate:vc.viewState.QV_9784_36547.column.documentType.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.documentType.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.documentType.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT31_DOCUMEPY148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.documentType.style' ng-bind='vc.getStringColumnFormat(dataItem.documentType, \"QV_9784_36547\", \"documentType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.documentType.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.documentType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.documentType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'processId',
                    title: '{{vc.viewState.QV_9784_36547.column.processId.title|translate:vc.viewState.QV_9784_36547.column.processId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.processId.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.processId.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT82_PROCESSD148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.processId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processId, \"QV_9784_36547\", \"processId\"):kendo.toString(#=processId#, vc.viewState.QV_9784_36547.column.processId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9784_36547.column.processId.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.processId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.processId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_9784_36547.column.extension.title|translate:vc.viewState.QV_9784_36547.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.extension.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.extension.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT56_EXTENSOI148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_9784_36547\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.extension.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'entryDate',
                    title: '{{vc.viewState.QV_9784_36547.column.entryDate.title|translate:vc.viewState.QV_9784_36547.column.entryDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.entryDate.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.entryDate.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT34_ENTRYDEA148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.entryDate.style'>#=((entryDate !== null) ? kendo.toString(entryDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.entryDate.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.entryDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.entryDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'procedureNumber',
                    title: '{{vc.viewState.QV_9784_36547.column.procedureNumber.title|translate:vc.viewState.QV_9784_36547.column.procedureNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.procedureNumber.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.procedureNumber.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT69_PROCEDMR148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.procedureNumber.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.procedureNumber, \"QV_9784_36547\", \"procedureNumber\"):kendo.toString(#=procedureNumber#, vc.viewState.QV_9784_36547.column.procedureNumber.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9784_36547.column.procedureNumber.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.procedureNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.procedureNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'folder',
                    title: '{{vc.viewState.QV_9784_36547.column.folder.title|translate:vc.viewState.QV_9784_36547.column.folder.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.folder.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.folder.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT52_FOLDERMF148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.folder.style' ng-bind='vc.getStringColumnFormat(dataItem.folder, \"QV_9784_36547\", \"folder\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.folder.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.folder.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.folder.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'documentName',
                    title: '{{vc.viewState.QV_9784_36547.column.documentName.title|translate:vc.viewState.QV_9784_36547.column.documentName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.documentName.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.documentName.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT50_DOCUMENE148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.documentName.style' ng-bind='vc.getStringColumnFormat(dataItem.documentName, \"QV_9784_36547\", \"documentName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.documentName.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.documentName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.documentName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'codDocumentType',
                    title: '{{vc.viewState.QV_9784_36547.column.codDocumentType.title|translate:vc.viewState.QV_9784_36547.column.codDocumentType.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.codDocumentType.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.codDocumentType.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT57_CODDOCUE148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.codDocumentType.style' ng-bind='vc.getStringColumnFormat(dataItem.codDocumentType, \"QV_9784_36547\", \"codDocumentType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.codDocumentType.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.codDocumentType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.codDocumentType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'clientId',
                    title: '{{vc.viewState.QV_9784_36547.column.clientId.title|translate:vc.viewState.QV_9784_36547.column.clientId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.clientId.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.clientId.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT75_CLIENTID148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.clientId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.clientId, \"QV_9784_36547\", \"clientId\"):kendo.toString(#=clientId#, vc.viewState.QV_9784_36547.column.clientId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9784_36547.column.clientId.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.clientId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.clientId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'clientType',
                    title: '{{vc.viewState.QV_9784_36547.column.clientType.title|translate:vc.viewState.QV_9784_36547.column.clientType.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.clientType.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.clientType.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT12_CLIENTEE148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.clientType.style' ng-bind='vc.getStringColumnFormat(dataItem.clientType, \"QV_9784_36547\", \"clientType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9784_36547.column.clientType.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.clientType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.clientType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9784_36547.column.groupId.title|translate:vc.viewState.QV_9784_36547.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9784_36547.column.groupId.width,
                    format: $scope.vc.viewState.QV_9784_36547.column.groupId.format,
                    editor: $scope.vc.grids.QV_9784_36547.AT18_GROUPIDD148.control,
                    template: "<span ng-class='vc.viewState.QV_9784_36547.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9784_36547\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9784_36547.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9784_36547.column.groupId.style",
                        "title": "{{vc.viewState.QV_9784_36547.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698)) {
                    $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698 = {};
                }
                $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698.hidden = false;
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'VA_GRIDROWCOMMMNAD_831698',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNAD_831698",
                        entity: "ResultQueryByFilter",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmnad':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNAD_831698\", " + "vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698.enabled || vc.viewState.G_DOCUMENIIB_227698.disabled' " + "data-ng-click = 'vc.grids.QV_9784_36547.events.customRowClick($event, \"VA_GRIDROWCOMMMNAD_831698\", \"#:entity#\", \"QV_9784_36547\")' " + "title = \"{{vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNAD_831698.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698)) {
                    $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698 = {};
                }
                $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698.hidden = false;
                $scope.vc.grids.QV_9784_36547.columns.push({
                    field: 'VA_GRIDROWCOMMMNNA_455698',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNNA_455698",
                        entity: "ResultQueryByFilter",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmnna':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNNA_455698\", " + "vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698.enabled || vc.viewState.G_DOCUMENIIB_227698.disabled' " + "data-ng-click = 'vc.grids.QV_9784_36547.events.customRowClick($event, \"VA_GRIDROWCOMMMNNA_455698\", \"#:entity#\", \"QV_9784_36547\")' " + "title = \"{{vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_9784_36547.column.VA_GRIDROWCOMMMNNA_455698.hidden
                });
            }
            $scope.vc.viewState.QV_9784_36547.toolbar = {}
            $scope.vc.grids.QV_9784_36547.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSIFBOZBRX_821_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSIFBOZBRX_821_CANCEL",
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
                $scope.vc.render('VC_DOCUMENTLI_842821');
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
    var cobisMainModule = cobis.createModule("VC_DOCUMENTLI_842821", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_DOCUMENTLI_842821", {
            templateUrl: "VC_DOCUMENTLI_842821_FORM.html",
            controller: "VC_DOCUMENTLI_842821_CTRL",
            labelId: "ASSTS.LBL_ASSTS_BSQUEDALO_44156",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DOCUMENTLI_842821?" + $.param(search);
            }
        });
        VC_DOCUMENTLI_842821(cobisMainModule);
    }]);
} else {
    VC_DOCUMENTLI_842821(cobisMainModule);
}