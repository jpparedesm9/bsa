//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.scanneddocuments = designerEvents.api.scanneddocuments || designer.dsgEvents();

function VC_SCANNEDDMO_244525(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_SCANNEDDMO_244525_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_SCANNEDDMO_244525_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CSTMR",
            subModuleId: "CSTMR",
            taskId: "T_CSTMRNSVOOQTG_525",
            taskVersion: "1.0.0",
            viewContainerId: "VC_SCANNEDDMO_244525",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRNSVOOQTG_525",
        designerEvents.api.scanneddocuments,
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
                vcName: 'VC_SCANNEDDMO_244525'
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
                    moduleId: 'CSTMR',
                    subModuleId: 'CSTMR',
                    taskId: 'T_CSTMRNSVOOQTG_525',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ScannedDocumentsDetail: "ScannedDocumentsDetail",
                    DocumentsUpload: "DocumentsUpload",
                    GeneralData: "GeneralData",
                    OriginalHeader: "OriginalHeader",
                    Context: "Context"
                },
                entities: {
                    ScannedDocumentsDetail: {
                        customerName: 'AT22_CUSTOMEM612',
                        typeRequest: 'AT35_TYPERESQ612',
                        uploaded: 'AT46_UPLOADDE612',
                        file: 'AT47_FILEOVTQ612',
                        processInstance: 'AT65_PROCESNA612',
                        extension: 'AT70_EXTENSIN612',
                        documentId: 'AT88_DOCUMEDI612',
                        customerId: 'AT97_CUSTOMIR612',
                        description: 'AT98_DESCRIPT612',
                        _pks: [],
                        _entityId: 'EN_SCANNEDCL_612',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DocumentsUpload: {
                        uploads: 'AT35_UPLOADSS493',
                        processInstance: 'AT36_PROCESES493',
                        clientId: 'AT59_CLIENTDI493',
                        _pks: [],
                        _entityId: 'EN_DOCUMENTO_493',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GeneralData: {
                        loanType: 'AT50_LOANTYPE827',
                        paymentFrecuencyName: 'AT58_PAYMENCU827',
                        productTypeName: 'AT58_PRODUCYP827',
                        clientId: 'AT60_CLIENTDD827',
                        symbolCurrency: 'AT62_SYMBOLEY827',
                        vinculado: 'AT63_VINCULAO827',
                        sectorNeg: 'AT82_SECTOREE827',
                        _pks: [],
                        _entityId: 'EN_GENERALAA_827',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OriginalHeader: {
                        currencyRequested: 'AT15_CURRENER498',
                        iDRequested: 'AT19_IDREQUET498',
                        term: 'AT24_TERMMYXW498',
                        subType: 'AT29_SUBTYPEE498',
                        amountAproved: 'AT30_AMOUNTPD498',
                        applicationNumber: 'AT43_APPLICNN498',
                        category: 'AT64_CATEGORY498',
                        amountRequested: 'AT71_AMOUNTEU498',
                        initialDate: 'AT71_INITIAEA498',
                        productType: 'AT73_PRODUCYY498',
                        operationNumber: 'AT75_OPERATNN498',
                        officerName: 'AT81_OFFICEAA498',
                        paymentFrequency: 'AT99_PAYMENYR498',
                        _pks: [],
                        _entityId: 'EN_ORIGINARE_498',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        flag1: 'AT15_APPLICTM215',
                        flag2: 'AT15_FLAG2FIG215',
                        flag3: 'AT19_FLAG3XYE215',
                        parents: 'AT25_PARENTSS215',
                        couple: 'AT33_COUPLEPS215',
                        married: 'AT41_MARRIEDD215',
                        minimumAge: 'AT41_MINIMUAG215',
                        accountIndividual: 'AT44_ACCOUNND215',
                        freeUnion: 'AT52_FREEUNNI215',
                        nameReport: 'AT52_NAMERERP215',
                        officeName: 'AT61_OFFICEAE215',
                        maximumAge: 'AT62_MAXIMUAA215',
                        son: 'AT70_SONFRKEM215',
                        defaultCountry: 'AT84_DEFAULYR215',
                        generateReport: 'AT85_GENERATP215',
                        renapo: 'AT89_RENAPOOT215',
                        printReport: 'AT90_PRINTRRT215',
                        _pks: [],
                        _entityId: 'EN_CREDITLBQ_215',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_SCANNELD_7463 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_SCANNELD_7463 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_SCANNELD_7463_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_SCANNELD_7463_filters;
                    parametersAux = {
                        customerId: filters.customerId,
                        processInstance: filters.processInstance,
                        typeRequest: filters.typeRequest
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SCANNEDCL_612',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_SCANNELD_7463',
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
                            this.parameters['typeRequest'] = this.filters.typeRequest;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_SCANNELD_7463_filters = {};
            var defaultValues = {
                ScannedDocumentsDetail: {},
                DocumentsUpload: {},
                GeneralData: {},
                OriginalHeader: {},
                Context: {}
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
                $scope.vc.execute("temporarySave", VC_SCANNEDDMO_244525, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_SCANNEDDMO_244525, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_SCANNEDDMO_244525, data, function() {});
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
            $scope.vc.viewState.VC_SCANNEDDMO_244525 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_SCANNEDDMO_244525",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_ZQLICWWAVH_682525",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LegalPersonHeader
            $scope.vc.createViewState({
                id: "VC_SAZFZHJVIG_183749",
                hasId: true,
                componentStyle: [],
                label: 'LegalPersonHeader',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1579
            $scope.vc.createViewState({
                id: "G_LEGALPEOEE_264688",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1579',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1852
            $scope.vc.createViewState({
                id: "G_LEGALPEARR_339688",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1852',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_LEGALPEARR_339688-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ScannedDocumentsDetail
            $scope.vc.createViewState({
                id: "VC_PZQVMRUMJQ_454966",
                hasId: true,
                componentStyle: [],
                label: 'ScannedDocumentsDetail',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1710
            $scope.vc.createViewState({
                id: "G_SCANNEDCIM_218611",
                hasId: true,
                componentStyle: [],
                label: 'Group1710',
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
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerId", 0)
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
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "documentId", '')
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "extension", '')
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerName", '')
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "processInstance", 0)
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
                            var queryId = 'Q_SCANNELD_7463';
                            var queryRequest = $scope.vc.getRequestQuery_Q_SCANNELD_7463();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7463_28553',
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
                        $scope.vc.gridAfterLeaveInLineRow('QV_7463_28553', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ScannedDocumentsDetail',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7463_28553', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                                    nameEntityGrid: 'ScannedDocumentsDetail'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_7463_28553', argsAfterLeave);
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
                        $("#QV_7463_28553").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_SCANNELD_7463 = $scope.vc.model.ScannedDocumentsDetail;
            $scope.vc.trackers.ScannedDocumentsDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ScannedDocumentsDetail);
            $scope.vc.model.ScannedDocumentsDetail.bind('change', function(e) {
                $scope.vc.trackers.ScannedDocumentsDetail.track(e);
            });
            $scope.vc.grids.QV_7463_28553 = {};
            $scope.vc.grids.QV_7463_28553.queryId = 'Q_SCANNELD_7463';
            $scope.vc.viewState.QV_7463_28553 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7463_28553.column = {};
            $scope.vc.grids.QV_7463_28553.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_7463_28553.events = {
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
                    $scope.vc.grids.QV_7463_28553.selectedRow = e.model;
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
                    $scope.vc.gridBeforeEnterInLineRow("QV_7463_28553", args, function() {
                        if (args.cancel) {
                            $("#QV_7463_28553").data("kendoExtGrid").cancelChanges();
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
                    $scope.vc.gridRowRendering("QV_7463_28553", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7463_28553");
                    $scope.vc.hideShowColumns("QV_7463_28553", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7463_28553 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7463_28553 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7463_28553.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7463_28553.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7463_28553.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7463_28553.column.description = {
                title: 'CSTMR.LBL_CSTMR_DOCUMENSS_43494',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGHR_415611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT98_DESCRIPT612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGHR_415611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.customerId = {
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
                componentId: 'VA_TEXTINPUTBOXQGR_507611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT97_CUSTOMIR612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQGR_507611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.customerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7463_28553.column.customerId.format",
                        'k-decimals': "vc.viewState.QV_7463_28553.column.customerId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.uploaded = {
                title: 'CSTMR.LBL_CSTMR_CARGADOUC_57638',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYWQ_841611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT46_UPLOADDE612 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_7463_28553.column.uploaded.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.file = {
                title: 'CSTMR.LBL_CSTMR_ARCHIVOYO_38473',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTFB_124611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT47_FILEOVTQ612 = {
                control: function(container, options) {
                    $scope.vc.viewState.QV_7463_28553.column.file.disabledUpload = false;
                    $scope.vc.uploaders.VA_TEXTINPUTBOXTFB_124611 = {
                        maxSizeInMB: 10,
                        relativePath: null,
                        confirmUpload: false,
                        visualAttributeModel: '',
                        queryViewId: 'QV_7463_28553',
                        gridFieldName: 'file',
                        fileUploadAPI: null
                    };
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.file.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "true",
                        'id': "VA_TEXTINPUTBOXTFB_124611",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.file.validationCode}}",
                        'class': "form-control"
                    });
                    var buttonUpload = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "vc.viewState.QV_7463_28553.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-mouseup': "vc.clickFileUploader('VA_TEXTINPUTBOXTFB_124611')",
                        'ng-mousedown': "vc.grids.QV_7463_28553.events.customRowClick($event, 'VA_TEXTINPUTBOXTFB_124611', 'ScannedDocumentsDetail', 'QV_7463_28553','DSG_UPLOAD_FILE_')"
                    });
                    var buttonSuccess = $('<button />', {
                        'class': "btn btn-primary btn-block",
                        'type': "button",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"
                    });
                    var buttonRemove = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-click': "vc.removeFile('VA_TEXTINPUTBOXTFB_124611')"
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
                        'ng-show': "vc.viewState.QV_7463_28553.column.file.disabledUpload"
                    });
                    var innerDivhide = $('<div/>', {
                        'ng-hide': "vc.viewState.QV_7463_28553.column.file.disabledUpload"
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
                        'name': "VA_TEXTINPUTBOXTFB_124611_gridUploader",
                        'id': "VA_TEXTINPUTBOXTFB_124611_gridUploader",
                        'type': "file"
                    }).kendoUpload({
                        'async': {
                            saveUrl: '${contextPath}/cobis/web/cobis-designer-engine-web/actions/fileupload?'
                        },
                        'class': "form-control",
                        'upload': function(e) {
                            $scope.vc.onFileUpload(e, options.model, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'select': function(e) {
                            $scope.vc.onFileSelect(e, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'success': function(e) {
                            $scope.vc.onSuccess(e, 'VA_TEXTINPUTBOXTFB_124611');
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
            $scope.vc.viewState.QV_7463_28553.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYWP_542611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT88_DOCUMEDI612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYWP_542611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSGM_136611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT70_EXTENSIN612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSGM_136611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.customerName = {
                title: 'customerName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCEB_498611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT22_CUSTOMEM612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCEB_498611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.processInstance = {
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
                componentId: 'VA_TEXTINPUTBOXBPC_698611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT65_PROCESNA612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBPC_698611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7463_28553.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_7463_28553.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.typeRequest = {
                title: 'typeRequest',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJXS_260611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT35_TYPERESQ612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.typeRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJXS_260611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.typeRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.typeRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7463_28553.column.description.title|translate:vc.viewState.QV_7463_28553.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.description.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.description.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT98_DESCRIPT612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7463_28553\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.description.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_7463_28553.column.customerId.title|translate:vc.viewState.QV_7463_28553.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.customerId.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.customerId.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT97_CUSTOMIR612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_7463_28553\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_7463_28553.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7463_28553.column.customerId.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_7463_28553.column.uploaded.title|translate:vc.viewState.QV_7463_28553.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.uploaded.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.uploaded.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7463_28553', 'uploaded', $scope.vc.grids.QV_7463_28553.AT46_UPLOADDE612.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7463_28553', 'uploaded', "<span ng-class='vc.viewState.QV_7463_28553.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_7463_28553\", \"uploaded\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.uploaded.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_7463_28553.column.file.title|translate:vc.viewState.QV_7463_28553.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.file.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.file.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT47_FILEOVTQ612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_7463_28553\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.file.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_7463_28553.column.documentId.title|translate:vc.viewState.QV_7463_28553.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.documentId.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.documentId.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT88_DOCUMEDI612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_7463_28553\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.documentId.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.documentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_7463_28553.column.extension.title|translate:vc.viewState.QV_7463_28553.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.extension.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.extension.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT70_EXTENSIN612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_7463_28553\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.extension.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_7463_28553.column.customerName.title|translate:vc.viewState.QV_7463_28553.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.customerName.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.customerName.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT22_CUSTOMEM612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_7463_28553\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.customerName.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_7463_28553.column.processInstance.title|translate:vc.viewState.QV_7463_28553.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.processInstance.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.processInstance.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT65_PROCESNA612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_7463_28553\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_7463_28553.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7463_28553.column.processInstance.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'typeRequest',
                    title: '{{vc.viewState.QV_7463_28553.column.typeRequest.title|translate:vc.viewState.QV_7463_28553.column.typeRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.typeRequest.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.typeRequest.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT35_TYPERESQ612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.typeRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.typeRequest, \"QV_7463_28553\", \"typeRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.typeRequest.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.typeRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.typeRequest.hidden
                });
            }
            $scope.vc.viewState.QV_7463_28553.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7463_28553.column.cmdEdition = {};
            $scope.vc.viewState.QV_7463_28553.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7463_28553.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_7463_28553.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7463_28553.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_SCANNEDCIM_218611.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7463_28553.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611)) {
                    $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611 = {};
                }
                $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.hidden = false;
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'VA_GRIDROWCOMMMNDD_972611',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNDD_972611",
                        entity: "ScannedDocumentsDetail",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmndd':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNDD_972611\", " + "vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.enabled || vc.viewState.G_SCANNEDCIM_218611.disabled' " + "data-ng-click = 'vc.grids.QV_7463_28553.events.customRowClick($event, \"VA_GRIDROWCOMMMNDD_972611\", \"#:entity#\", \"QV_7463_28553\")' " + "title = \"{{vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.hidden
                });
            }
            $scope.vc.viewState.QV_7463_28553.toolbar = {}
            $scope.vc.grids.QV_7463_28553.toolbar = [];
            $scope.vc.model.DocumentsUpload = {
                uploads: $scope.vc.channelDefaultValues("DocumentsUpload", "uploads"),
                processInstance: $scope.vc.channelDefaultValues("DocumentsUpload", "processInstance"),
                clientId: $scope.vc.channelDefaultValues("DocumentsUpload", "clientId")
            };
            //ViewState - Group: Group2644
            $scope.vc.createViewState({
                id: "G_SCANNEDDSD_789611",
                hasId: true,
                componentStyle: [],
                label: 'Group2644',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1195",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1669
            $scope.vc.createViewState({
                id: "G_SCANNEDOLM_531611",
                hasId: true,
                componentStyle: [],
                label: 'Group1669',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1422",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONILJIEMT_921611",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VALIDARTO_98546",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRNSVOOQTG_525_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRNSVOOQTG_525_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GeneralData = {
                loanType: $scope.vc.channelDefaultValues("GeneralData", "loanType"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("GeneralData", "paymentFrecuencyName"),
                productTypeName: $scope.vc.channelDefaultValues("GeneralData", "productTypeName"),
                clientId: $scope.vc.channelDefaultValues("GeneralData", "clientId"),
                symbolCurrency: $scope.vc.channelDefaultValues("GeneralData", "symbolCurrency"),
                vinculado: $scope.vc.channelDefaultValues("GeneralData", "vinculado"),
                sectorNeg: $scope.vc.channelDefaultValues("GeneralData", "sectorNeg")
            };
            $scope.vc.model.OriginalHeader = {
                currencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "currencyRequested"),
                iDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "iDRequested"),
                term: $scope.vc.channelDefaultValues("OriginalHeader", "term"),
                subType: $scope.vc.channelDefaultValues("OriginalHeader", "subType"),
                amountAproved: $scope.vc.channelDefaultValues("OriginalHeader", "amountAproved"),
                applicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "applicationNumber"),
                category: $scope.vc.channelDefaultValues("OriginalHeader", "category"),
                amountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "amountRequested"),
                initialDate: $scope.vc.channelDefaultValues("OriginalHeader", "initialDate"),
                productType: $scope.vc.channelDefaultValues("OriginalHeader", "productType"),
                operationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "operationNumber"),
                officerName: $scope.vc.channelDefaultValues("OriginalHeader", "officerName"),
                paymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "paymentFrequency")
            };
            $scope.vc.model.Context = {
                flag1: $scope.vc.channelDefaultValues("Context", "flag1"),
                flag2: $scope.vc.channelDefaultValues("Context", "flag2"),
                flag3: $scope.vc.channelDefaultValues("Context", "flag3"),
                parents: $scope.vc.channelDefaultValues("Context", "parents"),
                couple: $scope.vc.channelDefaultValues("Context", "couple"),
                married: $scope.vc.channelDefaultValues("Context", "married"),
                minimumAge: $scope.vc.channelDefaultValues("Context", "minimumAge"),
                accountIndividual: $scope.vc.channelDefaultValues("Context", "accountIndividual"),
                freeUnion: $scope.vc.channelDefaultValues("Context", "freeUnion"),
                nameReport: $scope.vc.channelDefaultValues("Context", "nameReport"),
                officeName: $scope.vc.channelDefaultValues("Context", "officeName"),
                maximumAge: $scope.vc.channelDefaultValues("Context", "maximumAge"),
                son: $scope.vc.channelDefaultValues("Context", "son"),
                defaultCountry: $scope.vc.channelDefaultValues("Context", "defaultCountry"),
                generateReport: $scope.vc.channelDefaultValues("Context", "generateReport"),
                renapo: $scope.vc.channelDefaultValues("Context", "renapo"),
                printReport: $scope.vc.channelDefaultValues("Context", "printReport")
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
                $scope.vc.render('VC_SCANNEDDMO_244525');
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
    var cobisMainModule = cobis.createModule("VC_SCANNEDDMO_244525", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_SCANNEDDMO_244525", {
            templateUrl: "VC_SCANNEDDMO_244525_FORM.html",
            controller: "VC_SCANNEDDMO_244525_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_SCANNEDDMO_244525?" + $.param(search);
            }
        });
        VC_SCANNEDDMO_244525(cobisMainModule);
    }]);
} else {
    VC_SCANNEDDMO_244525(cobisMainModule);
}