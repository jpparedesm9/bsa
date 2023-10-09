//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.querydocuments = designerEvents.api.querydocuments || designer.dsgEvents();

function VC_DOCUMENTSS_852411(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DOCUMENTSS_852411_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DOCUMENTSS_852411_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSNTIMXUPV_411",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DOCUMENTSS_852411",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSNTIMXUPV_411",
        designerEvents.api.querydocuments,
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
                vcName: 'VC_DOCUMENTSS_852411'
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
                    taskId: 'T_ASSTSNTIMXUPV_411',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    HeaderQueryDocuments: "HeaderQueryDocuments",
                    QueryDocumentCredit: "QueryDocumentCredit",
                    QueryDocumentsGrid: "QueryDocumentsGrid"
                },
                entities: {
                    HeaderQueryDocuments: {
                        groupName: 'AT42_GROUPNEE732',
                        clientId: 'AT44_IDCLIENT732',
                        groupId: 'AT56_IDGROUPP732',
                        procedure: 'AT64_TRAMITEE732',
                        loan: 'AT70_LOANENKU732',
                        clientName: 'AT96_CLIENTMN732',
                        _pks: [],
                        _entityId: 'EN_SCANNEDNC_732',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QueryDocumentCredit: {
                        extension: 'AT21_EXTENSIN771',
                        folder: 'AT23_FOLDERVI771',
                        enableEditing: 'AT40_ENABLENI771',
                        file: 'AT41_FILEVVHR771',
                        description: 'AT53_DESCRINO771',
                        uploaded: 'AT61_UPLOADEE771',
                        groupId: 'AT74_GROUPIDD771',
                        documentId: 'AT83_DOCUMETN771',
                        processInstance: 'AT87_PROCESNN771',
                        customerId: 'AT95_CUSTOMDR771',
                        _pks: [],
                        _entityId: 'EN_CREDITDTT_771',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QueryDocumentsGrid: {
                        procedure: 'AT15_PROCEDEE644',
                        isGroup: 'AT27_ISGROUPP644',
                        bank: 'AT31_BANKXBMM644',
                        loan: 'AT45_LOANYHRY644',
                        processInstance: 'AT50_PROCESNT644',
                        groupId: 'AT65_IDGROUPP644',
                        clientName: 'AT68_CLIENTMM644',
                        clientId: 'AT93_IDCLIENN644',
                        groupName: 'AT96_GROUPNAM644',
                        _pks: [],
                        _entityId: 'EN_DOCUMENTI_644',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_SCANNEDNC_732',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_DOCUMENTI_644',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT64_TRAMITEE732',
                        attributeIdFk: 'AT15_PROCEDEE644'
                    }, {
                        attributeIdPk: 'AT70_LOANENKU732',
                        attributeIdFk: 'AT45_LOANYHRY644'
                    }, {
                        attributeIdPk: 'AT56_IDGROUPP732',
                        attributeIdFk: 'AT65_IDGROUPP644'
                    }, {
                        attributeIdPk: 'AT44_IDCLIENT732',
                        attributeIdFk: 'AT93_IDCLIENN644'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DOCUMETD_9888 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DOCUMETD_9888 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DOCUMETD_9888_filters)) {
                    parametersAux = {
                        procedure: $scope.vc.model.HeaderQueryDocuments.procedure,
                        groupId: $scope.vc.model.HeaderQueryDocuments.groupId,
                        clientId: $scope.vc.model.HeaderQueryDocuments.clientId,
                        loan: $scope.vc.model.HeaderQueryDocuments.loan
                    };
                } else {
                    var filters = $scope.vc.queries.Q_DOCUMETD_9888_filters;
                    parametersAux = {
                        procedure: filters.procedure,
                        groupId: filters.groupId,
                        clientId: filters.clientId,
                        loan: filters.loan,
                        bank: filters.bank
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DOCUMENTI_644',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DOCUMETD_9888',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['procedure'] = $scope.vc.model.HeaderQueryDocuments.procedure;
                            this.parameters['groupId'] = $scope.vc.model.HeaderQueryDocuments.groupId;
                            this.parameters['clientId'] = $scope.vc.model.HeaderQueryDocuments.clientId;
                            this.parameters['loan'] = $scope.vc.model.HeaderQueryDocuments.loan;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['procedure'] = this.filters.procedure;
                            this.parameters['groupId'] = this.filters.groupId;
                            this.parameters['clientId'] = this.filters.clientId;
                            this.parameters['loan'] = this.filters.loan;
                            this.parameters['bank'] = this.filters.bank;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DOCUMETD_9888_filters = {};
            $scope.vc.queryProperties.Q_DOCUMETN_5385 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DOCUMETN_5385 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DOCUMETN_5385_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DOCUMETN_5385_filters;
                    parametersAux = {
                        processInstance: filters.processInstance,
                        groupId: filters.groupId,
                        customerId: filters.customerId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CREDITDTT_771',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DOCUMETN_5385',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['processInstance'] = this.filters.processInstance;
                            this.parameters['groupId'] = this.filters.groupId;
                            this.parameters['customerId'] = this.filters.customerId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DOCUMETN_5385_filters = {};
            var defaultValues = {
                HeaderQueryDocuments: {},
                QueryDocumentCredit: {},
                QueryDocumentsGrid: {}
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
                $scope.vc.execute("temporarySave", VC_DOCUMENTSS_852411, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DOCUMENTSS_852411, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DOCUMENTSS_852411, data, function() {});
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
            $scope.vc.viewState.VC_DOCUMENTSS_852411 = {
                style: []
            }
            $scope.vc.model.HeaderQueryDocuments = {
                groupName: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "groupName"),
                clientId: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "clientId"),
                groupId: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "groupId"),
                procedure: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "procedure"),
                loan: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "loan"),
                clientName: $scope.vc.channelDefaultValues("HeaderQueryDocuments", "clientName")
            };
            //ViewState - Group: Group1472
            $scope.vc.createViewState({
                id: "G_DOCUMENSSS_356273",
                hasId: true,
                componentStyle: [],
                label: 'Group1472',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "o1819",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2706",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: clientName
            $scope.vc.createViewState({
                id: "VA_CLIENTNAMEKVNFS_105273",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: groupName
            $scope.vc.createViewState({
                id: "VA_GROUPNAMESGBTSG_671273",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GRUPOOBAY_84995",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: loan
            $scope.vc.createViewState({
                id: "VA_LOANJCWSDUZDVBY_433273",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRSTAMOCV_96028",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderQueryDocuments, Attribute: procedure
            $scope.vc.createViewState({
                id: "VA_TRAMITEEYNPZOKI_520273",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TRMITESSF_56882",
                format: "#####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONRLGUJMS_186273",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_DOCUMETD_9888',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2325
            $scope.vc.createViewState({
                id: "G_DOCUMENTSS_890273",
                hasId: true,
                componentStyle: [],
                label: 'Group2325',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QueryDocumentCredit = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "description", '')
                    },
                    uploaded: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "uploaded", '')
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "processInstance", 0)
                    },
                    file: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "file", '')
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "groupId", 0)
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "extension", '')
                    },
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentCredit", "documentId", '')
                    },
                    customerId: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.QueryDocumentCredit = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DOCUMETN_5385';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DOCUMETN_5385();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5385_46042',
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
                            nameEntityGrid: 'QueryDocumentCredit'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_5385_46042', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'QueryDocumentCredit',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5385_46042', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                                    nameEntityGrid: 'QueryDocumentCredit'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_5385_46042', argsAfterLeave);
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
                    model: $scope.vc.types.QueryDocumentCredit
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5385_46042").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DOCUMETN_5385 = $scope.vc.model.QueryDocumentCredit;
            $scope.vc.trackers.QueryDocumentCredit = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QueryDocumentCredit);
            $scope.vc.model.QueryDocumentCredit.bind('change', function(e) {
                $scope.vc.trackers.QueryDocumentCredit.track(e);
            });
            $scope.vc.grids.QV_5385_46042 = {};
            $scope.vc.grids.QV_5385_46042.queryId = 'Q_DOCUMETN_5385';
            $scope.vc.viewState.QV_5385_46042 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5385_46042.column = {};
            $scope.vc.grids.QV_5385_46042.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_5385_46042.events = {
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
                    $scope.vc.trackers.QueryDocumentCredit.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_5385_46042.selectedRow = e.model;
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
                        nameEntityGrid: 'QueryDocumentCredit',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_5385_46042", args, function() {
                        if (args.cancel) {
                            $("#QV_5385_46042").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'QueryDocumentCredit',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_5385_46042", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_5385_46042");
                    $scope.vc.hideShowColumns("QV_5385_46042", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5385_46042.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5385_46042.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5385_46042.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5385_46042 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5385_46042 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_5385_46042.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5385_46042.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5385_46042.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5385_46042.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPII_28027',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRSL_736273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT53_DESCRINO771 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_5385_46042.column.description.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5385_46042.column.uploaded = {
                title: 'ASSTS.LBL_ASSTS_CARGADOHB_45201',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRLG_350273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT61_UPLOADEE771 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_5385_46042.column.uploaded.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5385_46042.column.processInstance = {
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
                componentId: 'VA_TEXTINPUTBOXCDE_704273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT87_PROCESNN771 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5385_46042.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCDE_704273",
                        'data-validation-code': "{{vc.viewState.QV_5385_46042.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5385_46042.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_5385_46042.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5385_46042.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5385_46042.column.file = {
                title: 'ASSTS.LBL_ASSTS_ARCHIVOXP_13194',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSYD_837273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT41_FILEVVHR771 = {
                control: function(container, options) {
                    $scope.vc.viewState.QV_5385_46042.column.file.disabledUpload = false;
                    $scope.vc.uploaders.VA_TEXTINPUTBOXSYD_837273 = {
                        maxSizeInMB: 10,
                        relativePath: null,
                        confirmUpload: false,
                        visualAttributeModel: '',
                        queryViewId: 'QV_5385_46042',
                        gridFieldName: 'file',
                        fileUploadAPI: null
                    };
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5385_46042.column.file.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "true",
                        'id': "VA_TEXTINPUTBOXSYD_837273",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_5385_46042.column.file.validationCode}}",
                        'class': "form-control"
                    });
                    var buttonUpload = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "vc.viewState.QV_5385_46042.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_5385_46042.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-mouseup': "vc.clickFileUploader('VA_TEXTINPUTBOXSYD_837273')",
                        'ng-mousedown': "vc.grids.QV_5385_46042.events.customRowClick($event, 'VA_TEXTINPUTBOXSYD_837273', 'QueryDocumentCredit', 'QV_5385_46042','DSG_UPLOAD_FILE_')"
                    });
                    var buttonSuccess = $('<button />', {
                        'class': "btn btn-primary btn-block",
                        'type': "button",
                        'ng-class': "vc.viewState.QV_5385_46042.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"
                    });
                    var buttonRemove = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!vc.viewState.QV_5385_46042.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_5385_46042.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-click': "vc.removeFile('VA_TEXTINPUTBOXSYD_837273')"
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
                        'ng-show': "vc.viewState.QV_5385_46042.column.file.disabledUpload"
                    });
                    var innerDivhide = $('<div/>', {
                        'ng-hide': "vc.viewState.QV_5385_46042.column.file.disabledUpload"
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
                        'name': "VA_TEXTINPUTBOXSYD_837273_gridUploader",
                        'id': "VA_TEXTINPUTBOXSYD_837273_gridUploader",
                        'type': "file"
                    }).kendoUpload({
                        'async': {
                            saveUrl: '${contextPath}/cobis/web/cobis-designer-engine-web/actions/fileupload?'
                        },
                        'class': "form-control",
                        'upload': function(e) {
                            $scope.vc.onFileUpload(e, options.model, 'VA_TEXTINPUTBOXSYD_837273');
                        },
                        'select': function(e) {
                            $scope.vc.onFileSelect(e, 'VA_TEXTINPUTBOXSYD_837273');
                        },
                        'success': function(e) {
                            $scope.vc.onSuccess(e, 'VA_TEXTINPUTBOXSYD_837273');
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
            $scope.vc.viewState.QV_5385_46042.column.groupId = {
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
                componentId: 'VA_TEXTINPUTBOXIJF_819273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT74_GROUPIDD771 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5385_46042.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIJF_819273",
                        'data-validation-code': "{{vc.viewState.QV_5385_46042.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5385_46042.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_5385_46042.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5385_46042.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5385_46042.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRQG_731273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT21_EXTENSIN771 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5385_46042.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRQG_731273",
                        'data-validation-code': "{{vc.viewState.QV_5385_46042.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5385_46042.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5385_46042.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBDX_388273',
                element: []
            };
            $scope.vc.grids.QV_5385_46042.AT83_DOCUMETN771 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5385_46042.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBDX_388273",
                        'data-validation-code': "{{vc.viewState.QV_5385_46042.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5385_46042.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5385_46042.column.customerId = {
                title: 'customerId',
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
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_5385_46042.column.description.title|translate:vc.viewState.QV_5385_46042.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.description.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.description.format,
                    editor: $scope.vc.grids.QV_5385_46042.AT53_DESCRINO771.control,
                    template: "<span ng-class='vc.viewState.QV_5385_46042.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_5385_46042\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5385_46042.column.description.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_5385_46042.column.uploaded.title|translate:vc.viewState.QV_5385_46042.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.uploaded.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.uploaded.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_5385_46042', 'uploaded', $scope.vc.grids.QV_5385_46042.AT61_UPLOADEE771.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_5385_46042', 'uploaded', "<span ng-class='vc.viewState.QV_5385_46042.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_5385_46042\", \"uploaded\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5385_46042.column.uploaded.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_5385_46042.column.processInstance.title|translate:vc.viewState.QV_5385_46042.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.processInstance.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.processInstance.format,
                    editor: $scope.vc.grids.QV_5385_46042.AT87_PROCESNN771.control,
                    template: "<span ng-class='vc.viewState.QV_5385_46042.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_5385_46042\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_5385_46042.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5385_46042.column.processInstance.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_5385_46042.column.file.title|translate:vc.viewState.QV_5385_46042.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.file.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.file.format,
                    editor: $scope.vc.grids.QV_5385_46042.AT41_FILEVVHR771.control,
                    template: "<span ng-class='vc.viewState.QV_5385_46042.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_5385_46042\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5385_46042.column.file.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_5385_46042.column.groupId.title|translate:vc.viewState.QV_5385_46042.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.groupId.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.groupId.format,
                    editor: $scope.vc.grids.QV_5385_46042.AT74_GROUPIDD771.control,
                    template: "<span ng-class='vc.viewState.QV_5385_46042.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_5385_46042\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_5385_46042.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5385_46042.column.groupId.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_5385_46042.column.extension.title|translate:vc.viewState.QV_5385_46042.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.extension.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.extension.format,
                    editor: $scope.vc.grids.QV_5385_46042.AT21_EXTENSIN771.control,
                    template: "<span ng-class='vc.viewState.QV_5385_46042.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_5385_46042\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5385_46042.column.extension.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_5385_46042.column.documentId.title|translate:vc.viewState.QV_5385_46042.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_5385_46042.column.documentId.width,
                    format: $scope.vc.viewState.QV_5385_46042.column.documentId.format,
                    editor: $scope.vc.grids.QV_5385_46042.AT83_DOCUMETN771.control,
                    template: "<span ng-class='vc.viewState.QV_5385_46042.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_5385_46042\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5385_46042.column.documentId.style",
                        "title": "{{vc.viewState.QV_5385_46042.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.documentId.hidden
                });
            }
            $scope.vc.viewState.QV_5385_46042.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5385_46042.column.cmdEdition = {};
            $scope.vc.viewState.QV_5385_46042.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_5385_46042.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_5385_46042.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5385_46042.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_DOCUMENTSS_890273.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_5385_46042.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273)) {
                    $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273 = {};
                }
                $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273.hidden = false;
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'VA_GRIDROWCOMMMAAD_737273',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMAAD_737273",
                        entity: "QueryDocumentCredit",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmaad':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMAAD_737273\", " + "vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273.enabled || vc.viewState.G_DOCUMENTSS_890273.disabled' " + "data-ng-click = 'vc.grids.QV_5385_46042.events.customRowClick($event, \"VA_GRIDROWCOMMMAAD_737273\", \"#:entity#\", \"QV_5385_46042\")' " + "title = \"{{vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMAAD_737273.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273)) {
                    $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273 = {};
                }
                $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273.hidden = false;
                $scope.vc.grids.QV_5385_46042.columns.push({
                    field: 'VA_GRIDROWCOMMMDDD_584273',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMDDD_584273",
                        entity: "QueryDocumentCredit",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmddd':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMDDD_584273\", " + "vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273.enabled || vc.viewState.G_DOCUMENTSS_890273.disabled' " + "data-ng-click = 'vc.grids.QV_5385_46042.events.customRowClick($event, \"VA_GRIDROWCOMMMDDD_584273\", \"#:entity#\", \"QV_5385_46042\")' " + "title = \"{{vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_5385_46042.column.VA_GRIDROWCOMMMDDD_584273.hidden
                });
            }
            $scope.vc.viewState.QV_5385_46042.toolbar = {}
            $scope.vc.grids.QV_5385_46042.toolbar = [];
            //ViewState - Group: Group1777
            $scope.vc.createViewState({
                id: "G_DOCUMENSSS_770273",
                hasId: true,
                componentStyle: [],
                label: 'Group1777',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORVGIV_932273",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2356
            $scope.vc.createViewState({
                id: "G_DOCUMENTTS_255273",
                hasId: true,
                componentStyle: [],
                label: 'Group2356',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QueryDocumentsGrid = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    clientName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsGrid", "clientName", '')
                    },
                    loan: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.loan
                        }
                    },
                    procedure: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.procedure
                        }
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.groupId
                        }
                    },
                    clientId: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderQueryDocuments.clientId
                        }
                    },
                    groupName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsGrid", "groupName", '')
                    },
                    bank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsGrid", "bank", '')
                    },
                    isGroup: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QueryDocumentsGrid", "isGroup", '')
                    }
                }
            });
            $scope.vc.model.QueryDocumentsGrid = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DOCUMETD_9888';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DOCUMETD_9888();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9888_36569',
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
                    model: $scope.vc.types.QueryDocumentsGrid
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9888_36569").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DOCUMETD_9888 = $scope.vc.model.QueryDocumentsGrid;
            $scope.vc.trackers.QueryDocumentsGrid = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QueryDocumentsGrid);
            $scope.vc.model.QueryDocumentsGrid.bind('change', function(e) {
                $scope.vc.trackers.QueryDocumentsGrid.track(e);
                $scope.vc.grids.QV_9888_36569.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_9888_36569 = {};
            $scope.vc.grids.QV_9888_36569.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_9888_36569) && expandedRowUidActual !== expandedRowUid_QV_9888_36569) {
                    var gridWidget = $('#QV_9888_36569').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_9888_36569 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_9888_36569 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_9888_36569 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_9888_36569);
                }
                expandedRowUid_QV_9888_36569 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_9888_36569', args);
                if (angular.isDefined($scope.vc.grids.QV_9888_36569.view)) {
                    $scope.vc.grids.QV_9888_36569.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_9888_36569.customView)) {
                    $scope.vc.grids.QV_9888_36569.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_9888_36569'/>"
            };
            $scope.vc.grids.QV_9888_36569.queryId = 'Q_DOCUMETD_9888';
            $scope.vc.viewState.QV_9888_36569 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9888_36569.column = {};
            var expandedRowUid_QV_9888_36569;
            $scope.vc.grids.QV_9888_36569.editable = false;
            $scope.vc.grids.QV_9888_36569.events = {
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
                    $scope.vc.trackers.QueryDocumentsGrid.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9888_36569.selectedRow = e.model;
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
                    $scope.vc.grids.QV_9888_36569.events.moveRowDetailIcon(e);
                    $scope.vc.grids.QV_9888_36569.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
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
                    var numColumnsVisible = $("#QV_9888_36569 > .k-grid-header colgroup col").length;
                    var diff = numColumns - numColumnsVisible;
                    index = grid.element.find("th.k-header[data-role='droptarget']").index();
                    if (index != -1) {
                        $("#QV_9888_36569 th.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("th", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_9888_36569 td.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("td", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_9888_36569 .k-hierarchy-col").each(function() {
                            $(this).insertAfter($("col", this.parentNode).eq(grid.columns.length - diff));
                        });
                    } else {
                        index = grid.tbody.find('tr:first>td:last').index();
                        if (index === -1) {
                            index = grid.element.find('tr>th:last').index();
                        }
                        if (index > 0) {
                            $("#QV_9888_36569 .k-hierarchy-cell").each(function() {
                                var element = $(this).siblings().eq(index - 1);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                            $("#QV_9888_36569 .k-hierarchy-col").each(function() {
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
                            nameEntityGrid: "QueryDocumentsGrid",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_9888_36569", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_9888_36569", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.grids.QV_9888_36569.events.moveRowDetailIcon(e);
                    $scope.vc.gridDataBound("QV_9888_36569");
                    $scope.vc.hideShowColumns("QV_9888_36569", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9888_36569.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9888_36569.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9888_36569.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9888_36569 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9888_36569 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_9888_36569.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_9888_36569 tr.k-detail-row td.k-detail-cell > div')).scope();
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
            $scope.vc.grids.QV_9888_36569.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9888_36569.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9888_36569.column.clientName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREULS_81822',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUUY_437273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT68_CLIENTMM644 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9888_36569.column.clientName.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.loan = {
                title: 'ASSTS.LBL_ASSTS_PRSTAMOCV_96028',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFXH_927273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT45_LOANYHRY644 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9888_36569.column.loan.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.procedure = {
                title: 'ASSTS.LBL_ASSTS_TRMITESSF_56882',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGAR_322273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT15_PROCEDEE644 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9888_36569.column.procedure.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.groupId = {
                title: 'ASSTS.LBL_ASSTS_IDGRUPOWS_82505',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNIB_114273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT65_IDGROUPP644 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9888_36569.column.groupId.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.clientId = {
                title: 'ASSTS.LBL_ASSTS_IDCLIENTT_49211',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFJX_219273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT93_IDCLIENN644 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9888_36569.column.clientId.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.groupName = {
                title: 'groupName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHUN_590273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT96_GROUPNAM644 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9888_36569.column.groupName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHUN_590273",
                        'data-validation-code': "{{vc.viewState.QV_9888_36569.column.groupName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9888_36569.column.groupName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.bank = {
                title: 'bank',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXGP_132273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT31_BANKXBMM644 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9888_36569.column.bank.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXGP_132273",
                        'data-validation-code': "{{vc.viewState.QV_9888_36569.column.bank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9888_36569.column.bank.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9888_36569.column.isGroup = {
                title: 'ASSTS.LBL_ASSTS_ESGRUPALL_56584',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXHA_889273',
                element: []
            };
            $scope.vc.grids.QV_9888_36569.AT27_ISGROUPP644 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9888_36569.column.isGroup.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'clientName',
                    title: '{{vc.viewState.QV_9888_36569.column.clientName.title|translate:vc.viewState.QV_9888_36569.column.clientName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.clientName.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.clientName.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT68_CLIENTMM644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.clientName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientName, \"QV_9888_36569\", \"clientName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9888_36569.column.clientName.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.clientName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.clientName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'loan',
                    title: '{{vc.viewState.QV_9888_36569.column.loan.title|translate:vc.viewState.QV_9888_36569.column.loan.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.loan.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.loan.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT45_LOANYHRY644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.loan.style' ng-bind='vc.getStringColumnFormat(dataItem.loan, \"QV_9888_36569\", \"loan\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9888_36569.column.loan.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.loan.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.loan.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'procedure',
                    title: '{{vc.viewState.QV_9888_36569.column.procedure.title|translate:vc.viewState.QV_9888_36569.column.procedure.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.procedure.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.procedure.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT15_PROCEDEE644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.procedure.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.procedure, \"QV_9888_36569\", \"procedure\"):kendo.toString(#=procedure#, vc.viewState.QV_9888_36569.column.procedure.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9888_36569.column.procedure.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.procedure.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.procedure.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9888_36569.column.groupId.title|translate:vc.viewState.QV_9888_36569.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.groupId.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.groupId.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT65_IDGROUPP644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9888_36569\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9888_36569.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9888_36569.column.groupId.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'clientId',
                    title: '{{vc.viewState.QV_9888_36569.column.clientId.title|translate:vc.viewState.QV_9888_36569.column.clientId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.clientId.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.clientId.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT93_IDCLIENN644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.clientId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.clientId, \"QV_9888_36569\", \"clientId\"):kendo.toString(#=clientId#, vc.viewState.QV_9888_36569.column.clientId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9888_36569.column.clientId.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.clientId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.clientId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'groupName',
                    title: '{{vc.viewState.QV_9888_36569.column.groupName.title|translate:vc.viewState.QV_9888_36569.column.groupName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.groupName.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.groupName.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT96_GROUPNAM644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.groupName.style' ng-bind='vc.getStringColumnFormat(dataItem.groupName, \"QV_9888_36569\", \"groupName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9888_36569.column.groupName.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.groupName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.groupName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'bank',
                    title: '{{vc.viewState.QV_9888_36569.column.bank.title|translate:vc.viewState.QV_9888_36569.column.bank.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.bank.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.bank.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT31_BANKXBMM644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.bank.style' ng-bind='vc.getStringColumnFormat(dataItem.bank, \"QV_9888_36569\", \"bank\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9888_36569.column.bank.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.bank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.bank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9888_36569.columns.push({
                    field: 'isGroup',
                    title: '{{vc.viewState.QV_9888_36569.column.isGroup.title|translate:vc.viewState.QV_9888_36569.column.isGroup.titleArgs}}',
                    width: $scope.vc.viewState.QV_9888_36569.column.isGroup.width,
                    format: $scope.vc.viewState.QV_9888_36569.column.isGroup.format,
                    editor: $scope.vc.grids.QV_9888_36569.AT27_ISGROUPP644.control,
                    template: "<span ng-class='vc.viewState.QV_9888_36569.column.isGroup.style' ng-bind='vc.getStringColumnFormat(dataItem.isGroup, \"QV_9888_36569\", \"isGroup\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9888_36569.column.isGroup.style",
                        "title": "{{vc.viewState.QV_9888_36569.column.isGroup.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9888_36569.column.isGroup.hidden
                });
            }
            $scope.vc.viewState.QV_9888_36569.toolbar = {}
            $scope.vc.grids.QV_9888_36569.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSNTIMXUPV_411_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSNTIMXUPV_411_CANCEL",
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
                $scope.vc.render('VC_DOCUMENTSS_852411');
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
    var cobisMainModule = cobis.createModule("VC_DOCUMENTSS_852411", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_DOCUMENTSS_852411", {
            templateUrl: "VC_DOCUMENTSS_852411_FORM.html",
            controller: "VC_DOCUMENTSS_852411_CTRL",
            label: "QueryDocuments",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DOCUMENTSS_852411?" + $.param(search);
            }
        });
        VC_DOCUMENTSS_852411(cobisMainModule);
    }]);
} else {
    VC_DOCUMENTSS_852411(cobisMainModule);
}