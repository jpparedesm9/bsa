//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.authorizationtransferform = designerEvents.api.authorizationtransferform || designer.dsgEvents();

function VC_AUTHORIZOS_306259(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AUTHORIZOS_306259_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AUTHORIZOS_306259_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CSTMRTVGMFYGK_259",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AUTHORIZOS_306259",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRTVGMFYGK_259",
        designerEvents.api.authorizationtransferform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_AUTHORIZOS_306259'
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
                    taskId: 'T_CSTMRTVGMFYGK_259',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    TransferRequest: "TransferRequest",
                    AuthorizationTransferRequest: "AuthorizationTransferRequest"
                },
                entities: {
                    TransferRequest: {
                        officialOriginId: 'AT25_OFFICIDI439',
                        descriptionCause: 'AT27_DESCRISC439',
                        idCause: 'AT28_IDCAUSEE439',
                        isGroup: 'AT50_ISGROUPP439',
                        officeOriginId: 'AT51_OFFICEII439',
                        officeDestinationId: 'AT69_OFFICENO439',
                        officialDestinationId: 'AT72_OFFICIDI439',
                        _pks: [],
                        _entityId: 'EN_TRANSFEEU_439',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AuthorizationTransferRequest: {
                        transferReason: 'AT14_DETAILPA435',
                        officialOrg: 'AT15_OFFICIGR435',
                        officialDes: 'AT17_OFFICIAL435',
                        dateRequest: 'AT23_DATERETT435',
                        idRolOfficial: 'AT27_IDROLOFI435',
                        endDateRequest: 'AT33_ENDDATUE435',
                        idRequest: 'AT33_IDREQUSE435',
                        isChecked: 'AT48_ISCHECEE435',
                        idOffice: 'AT54_IDOFFIEC435',
                        loginOfficial: 'AT55_LOGINOCL435',
                        rolOfficial: 'AT72_ROLOFFIA435',
                        nameOfficial: 'AT73_NAMEOFLF435',
                        typeRequest: 'AT82_TYPEREEE435',
                        rejectionReason: 'AT89_REJECTII435',
                        _pks: [],
                        _entityId: 'EN_AUTHORITE_435',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_TRANSFEEU_439',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_AUTHORITE_435',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '1',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT51_OFFICEII439',
                        attributeIdFk: 'AT54_IDOFFIEC435'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_AUTHORRN_8174 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_AUTHORRN_8174 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AUTHORRN_8174_filters)) {
                    parametersAux = {
                        idOffice: $scope.vc.model.TransferRequest.officeOriginId
                    };
                } else {
                    var filters = $scope.vc.queries.Q_AUTHORRN_8174_filters;
                    parametersAux = {
                        idOffice: filters.idOffice
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_AUTHORITE_435',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AUTHORRN_8174',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['idOffice'] = $scope.vc.model.TransferRequest.officeOriginId;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['idOffice'] = this.filters.idOffice;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_AUTHORRN_8174_filters = {};
            $scope.vc.queryProperties.Q_OFFICERJ_1253 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_OFFICERJ_1253 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_OFFICERJ_1253_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_OFFICERJ_1253_filters;
                    parametersAux = {
                        idOffice: filters.idOffice
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OFFICEGPI_129',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_OFFICERJ_1253',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['idOffice'] = this.filters.idOffice;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_OFFICERJ_1253_filters = {};
            var defaultValues = {
                TransferRequest: {},
                AuthorizationTransferRequest: {}
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
                $scope.vc.execute("temporarySave", VC_AUTHORIZOS_306259, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_AUTHORIZOS_306259, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_AUTHORIZOS_306259, data, function() {});
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
            $scope.vc.viewState.VC_AUTHORIZOS_306259 = {
                style: []
            }
            $scope.vc.model.TransferRequest = {
                officialOriginId: $scope.vc.channelDefaultValues("TransferRequest", "officialOriginId"),
                descriptionCause: $scope.vc.channelDefaultValues("TransferRequest", "descriptionCause"),
                idCause: $scope.vc.channelDefaultValues("TransferRequest", "idCause"),
                isGroup: $scope.vc.channelDefaultValues("TransferRequest", "isGroup"),
                officeOriginId: $scope.vc.channelDefaultValues("TransferRequest", "officeOriginId"),
                officeDestinationId: $scope.vc.channelDefaultValues("TransferRequest", "officeDestinationId"),
                officialDestinationId: $scope.vc.channelDefaultValues("TransferRequest", "officialDestinationId")
            };
            //ViewState - Group: Group1936
            $scope.vc.createViewState({
                id: "G_AUTHORIFNT_918576",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ORIGENPCB_70247",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TransferRequest, Attribute: officeOriginId
            $scope.vc.createViewState({
                id: "VA_OFFICEDESTINOTO_355576",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OFICINAPT_59565",
                queryId: 'Q_OFFICERJ_1253',
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.queries.Q_OFFICERJ_1253 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var requestQuery = $scope.vc.getRequestQuery_Q_OFFICERJ_1253();
                        if (angular.isDefined($scope.vc.afterInitData)) {
                            $scope.vc.executeQuery('VA_OFFICEDESTINOTO_355576', requestQuery, 'EN_OFFICEGPI_129', false, function(response) {
                                if (response.success) {
                                    if (angular.isDefined(response.data['RESULTQ_OFFICERJ_1253']) && !$.isEmptyObject(response.data['RESULTQ_OFFICERJ_1253'])) {
                                        options.success(response.data['RESULTQ_OFFICERJ_1253']);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error([]);
                                }
                                $scope.vc.setComboBoxDefaultValue("VA_OFFICEDESTINOTO_355576");
                            }, null, options.data.filter, 0);
                        } else {
                            options.success([]);
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICEDESTINOTO_355576");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "idOffice"
                    }
                }
            });
            $scope.vc.queryProperties.Q_OFFICERJ_1253.columnIdForList = 'idOffice';
            $scope.vc.queryProperties.Q_OFFICERJ_1253.columnValueForList = 'nameOffice';
            $scope.vc.createViewState({
                id: "VA_VABUTTONPYOQZXV_362576",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARPCE_34160",
                queryId: 'Q_AUTHORRN_8174',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2385
            $scope.vc.createViewState({
                id: "G_AUTHORIARI_332576",
                hasId: true,
                componentStyle: [],
                label: 'Group2385',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AuthorizationTransferRequest = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    idRequest: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "idRequest", 0)
                    },
                    nameOfficial: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "nameOfficial", '')
                    },
                    loginOfficial: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "loginOfficial", '')
                    },
                    rolOfficial: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "rolOfficial", '')
                    },
                    idRolOfficial: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "idRolOfficial", 0)
                    },
                    typeRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "typeRequest", '')
                    },
                    dateRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "dateRequest", '')
                    },
                    endDateRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "endDateRequest", '')
                    },
                    transferReason: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "transferReason", '')
                    },
                    officialOrg: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "officialOrg", '')
                    },
                    officialDes: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "officialDes", '')
                    },
                    isChecked: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "isChecked", false)
                    },
                    rejectionReason: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AuthorizationTransferRequest", "rejectionReason", '')
                    },
                    idOffice: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TransferRequest.officeOriginId
                        }
                    }
                }
            });
            $scope.vc.model.AuthorizationTransferRequest = new kendo.data.DataSource({
                pageSize: 25,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_AUTHORRN_8174';
                            var queryRequest = $scope.vc.getRequestQuery_Q_AUTHORRN_8174();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8174_44016',
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
                                            'pageSize': 25
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
                    model: $scope.vc.types.AuthorizationTransferRequest
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8174_44016").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AUTHORRN_8174 = $scope.vc.model.AuthorizationTransferRequest;
            $scope.vc.trackers.AuthorizationTransferRequest = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AuthorizationTransferRequest);
            $scope.vc.model.AuthorizationTransferRequest.bind('change', function(e) {
                $scope.vc.trackers.AuthorizationTransferRequest.track(e);
                $scope.vc.grids.QV_8174_44016.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_8174_44016 = {};
            $scope.vc.grids.QV_8174_44016.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_8174_44016) && expandedRowUidActual !== expandedRowUid_QV_8174_44016) {
                    var gridWidget = $('#QV_8174_44016').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_8174_44016 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_8174_44016 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_8174_44016 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_8174_44016);
                }
                expandedRowUid_QV_8174_44016 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_8174_44016', args);
                if (angular.isDefined($scope.vc.grids.QV_8174_44016.view)) {
                    $scope.vc.grids.QV_8174_44016.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_8174_44016.customView)) {
                    $scope.vc.grids.QV_8174_44016.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_8174_44016'/>"
            };
            $scope.vc.grids.QV_8174_44016.queryId = 'Q_AUTHORRN_8174';
            $scope.vc.viewState.QV_8174_44016 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8174_44016.column = {};
            var expandedRowUid_QV_8174_44016;
            $scope.vc.grids.QV_8174_44016.editable = false;
            $scope.vc.grids.QV_8174_44016.events = {
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
                    $scope.vc.trackers.AuthorizationTransferRequest.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8174_44016.selectedRow = e.model;
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
                    $scope.vc.grids.QV_8174_44016.events.moveRowDetailIcon(e);
                    $scope.vc.grids.QV_8174_44016.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
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
                    var numColumnsVisible = $("#QV_8174_44016 > .k-grid-header colgroup col").length;
                    var diff = numColumns - numColumnsVisible;
                    index = grid.element.find("th.k-header[data-role='droptarget']").index();
                    if (index != -1) {
                        $("#QV_8174_44016 th.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("th", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_8174_44016 td.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("td", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_8174_44016 .k-hierarchy-col").each(function() {
                            $(this).insertAfter($("col", this.parentNode).eq(grid.columns.length - diff));
                        });
                    } else {
                        index = grid.tbody.find('tr:first>td:last').index();
                        if (index === -1) {
                            index = grid.element.find('tr>th:last').index();
                        }
                        if (index > 0) {
                            $("#QV_8174_44016 .k-hierarchy-cell").each(function() {
                                var element = $(this).siblings().eq(index - 1);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                            $("#QV_8174_44016 .k-hierarchy-col").each(function() {
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
                            nameEntityGrid: "AuthorizationTransferRequest",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_8174_44016", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_8174_44016", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.grids.QV_8174_44016.events.moveRowDetailIcon(e);
                    $scope.vc.gridDataBound("QV_8174_44016");
                    $scope.vc.hideShowColumns("QV_8174_44016", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8174_44016.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8174_44016.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8174_44016.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8174_44016 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8174_44016 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_8174_44016.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_8174_44016 tr.k-detail-row td.k-detail-cell > div')).scope();
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
            $scope.vc.grids.QV_8174_44016.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8174_44016.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8174_44016.column.idRequest = {
                title: 'CSTMR.LBL_CSTMR_IDLYODHAH_45086',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZFI_193576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT33_IDREQUSE435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.idRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZFI_193576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.idRequest.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8174_44016.column.idRequest.format",
                        'k-decimals': "vc.viewState.QV_8174_44016.column.idRequest.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.idRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.nameOfficial = {
                title: 'CSTMR.LBL_CSTMR_NOMBRESTI_26590',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWSB_513576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT73_NAMEOFLF435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.nameOfficial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWSB_513576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.nameOfficial.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.nameOfficial.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.loginOfficial = {
                title: 'loginOfficial',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSXW_623576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT55_LOGINOCL435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.loginOfficial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSXW_623576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.loginOfficial.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.loginOfficial.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.rolOfficial = {
                title: 'CSTMR.LBL_CSTMR_ROLHERWRS_28226',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUIZ_814576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT72_ROLOFFIA435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.rolOfficial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUIZ_814576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.rolOfficial.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.rolOfficial.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.idRolOfficial = {
                title: 'idRolOfficial',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTSQ_837576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT27_IDROLOFI435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.idRolOfficial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTSQ_837576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.idRolOfficial.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8174_44016.column.idRolOfficial.format",
                        'k-decimals': "vc.viewState.QV_8174_44016.column.idRolOfficial.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.idRolOfficial.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.typeRequest = {
                title: 'CSTMR.LBL_CSTMR_TIPOSOLII_44225',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUXW_470576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT82_TYPEREEE435 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_8174_44016.column.typeRequest.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.dateRequest = {
                title: 'CSTMR.LBL_CSTMR_FECHASOUI_33426',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWDY_262576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT23_DATERETT435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.dateRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWDY_262576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.dateRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.dateRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.endDateRequest = {
                title: 'CSTMR.LBL_CSTMR_VIGENTESS_32361',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCKR_160576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT33_ENDDATUE435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.endDateRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCKR_160576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.endDateRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.endDateRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.transferReason = {
                title: 'CSTMR.LBL_CSTMR_DETALLEVF_66522',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGCN_522576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT14_DETAILPA435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.transferReason.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGCN_522576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.transferReason.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.transferReason.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.officialOrg = {
                title: 'CSTMR.LBL_CSTMR_OFICINAIE_84390',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKZM_234576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT15_OFFICIGR435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.officialOrg.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKZM_234576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.officialOrg.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.officialOrg.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.officialDes = {
                title: 'CSTMR.LBL_CSTMR_OFICINASN_72636',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWMF_440576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT17_OFFICIAL435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.officialDes.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWMF_440576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.officialDes.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.officialDes.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.isChecked = {
                title: 'CSTMR.LBL_CSTMR_SELECCIAA_21296',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXFCIBUWJ_653576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT48_ISCHECEE435 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.isChecked.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXFCIBUWJ_653576",
                        'ng-class': 'vc.viewState.QV_8174_44016.column.isChecked.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.rejectionReason = {
                title: 'rejectionReason',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLVZ_924576',
                element: []
            };
            $scope.vc.grids.QV_8174_44016.AT89_REJECTII435 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8174_44016.column.rejectionReason.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLVZ_924576",
                        'data-validation-code': "{{vc.viewState.QV_8174_44016.column.rejectionReason.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8174_44016.column.rejectionReason.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8174_44016.column.idOffice = {
                title: 'idOffice',
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
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'idRequest',
                    title: '{{vc.viewState.QV_8174_44016.column.idRequest.title|translate:vc.viewState.QV_8174_44016.column.idRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.idRequest.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.idRequest.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT33_IDREQUSE435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.idRequest.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.idRequest, \"QV_8174_44016\", \"idRequest\"):kendo.toString(#=idRequest#, vc.viewState.QV_8174_44016.column.idRequest.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8174_44016.column.idRequest.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.idRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.idRequest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'nameOfficial',
                    title: '{{vc.viewState.QV_8174_44016.column.nameOfficial.title|translate:vc.viewState.QV_8174_44016.column.nameOfficial.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.nameOfficial.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.nameOfficial.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT73_NAMEOFLF435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.nameOfficial.style' ng-bind='vc.getStringColumnFormat(dataItem.nameOfficial, \"QV_8174_44016\", \"nameOfficial\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.nameOfficial.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.nameOfficial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.nameOfficial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'loginOfficial',
                    title: '{{vc.viewState.QV_8174_44016.column.loginOfficial.title|translate:vc.viewState.QV_8174_44016.column.loginOfficial.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.loginOfficial.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.loginOfficial.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT55_LOGINOCL435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.loginOfficial.style' ng-bind='vc.getStringColumnFormat(dataItem.loginOfficial, \"QV_8174_44016\", \"loginOfficial\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.loginOfficial.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.loginOfficial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.loginOfficial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'rolOfficial',
                    title: '{{vc.viewState.QV_8174_44016.column.rolOfficial.title|translate:vc.viewState.QV_8174_44016.column.rolOfficial.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.rolOfficial.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.rolOfficial.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT72_ROLOFFIA435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.rolOfficial.style' ng-bind='vc.getStringColumnFormat(dataItem.rolOfficial, \"QV_8174_44016\", \"rolOfficial\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.rolOfficial.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.rolOfficial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.rolOfficial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'idRolOfficial',
                    title: '{{vc.viewState.QV_8174_44016.column.idRolOfficial.title|translate:vc.viewState.QV_8174_44016.column.idRolOfficial.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.idRolOfficial.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.idRolOfficial.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT27_IDROLOFI435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.idRolOfficial.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.idRolOfficial, \"QV_8174_44016\", \"idRolOfficial\"):kendo.toString(#=idRolOfficial#, vc.viewState.QV_8174_44016.column.idRolOfficial.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8174_44016.column.idRolOfficial.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.idRolOfficial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.idRolOfficial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'typeRequest',
                    title: '{{vc.viewState.QV_8174_44016.column.typeRequest.title|translate:vc.viewState.QV_8174_44016.column.typeRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.typeRequest.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.typeRequest.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT82_TYPEREEE435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.typeRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.typeRequest, \"QV_8174_44016\", \"typeRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.typeRequest.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.typeRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.typeRequest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'dateRequest',
                    title: '{{vc.viewState.QV_8174_44016.column.dateRequest.title|translate:vc.viewState.QV_8174_44016.column.dateRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.dateRequest.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.dateRequest.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT23_DATERETT435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.dateRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.dateRequest, \"QV_8174_44016\", \"dateRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.dateRequest.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.dateRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.dateRequest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'endDateRequest',
                    title: '{{vc.viewState.QV_8174_44016.column.endDateRequest.title|translate:vc.viewState.QV_8174_44016.column.endDateRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.endDateRequest.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.endDateRequest.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT33_ENDDATUE435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.endDateRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.endDateRequest, \"QV_8174_44016\", \"endDateRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.endDateRequest.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.endDateRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.endDateRequest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'transferReason',
                    title: '{{vc.viewState.QV_8174_44016.column.transferReason.title|translate:vc.viewState.QV_8174_44016.column.transferReason.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.transferReason.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.transferReason.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT14_DETAILPA435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.transferReason.style' ng-bind='vc.getStringColumnFormat(dataItem.transferReason, \"QV_8174_44016\", \"transferReason\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.transferReason.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.transferReason.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.transferReason.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'officialOrg',
                    title: '{{vc.viewState.QV_8174_44016.column.officialOrg.title|translate:vc.viewState.QV_8174_44016.column.officialOrg.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.officialOrg.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.officialOrg.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT15_OFFICIGR435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.officialOrg.style' ng-bind='vc.getStringColumnFormat(dataItem.officialOrg, \"QV_8174_44016\", \"officialOrg\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.officialOrg.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.officialOrg.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.officialOrg.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'officialDes',
                    title: '{{vc.viewState.QV_8174_44016.column.officialDes.title|translate:vc.viewState.QV_8174_44016.column.officialDes.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.officialDes.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.officialDes.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT17_OFFICIAL435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.officialDes.style' ng-bind='vc.getStringColumnFormat(dataItem.officialDes, \"QV_8174_44016\", \"officialDes\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.officialDes.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.officialDes.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.officialDes.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'isChecked',
                    title: '{{vc.viewState.QV_8174_44016.column.isChecked.title|translate:vc.viewState.QV_8174_44016.column.isChecked.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.isChecked.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.isChecked.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_8174_44016', 'isChecked', $scope.vc.grids.QV_8174_44016.AT48_ISCHECEE435.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_8174_44016', 'isChecked', "<input name='isChecked' type='checkbox' value='#=isChecked#' #=isChecked?checked='checked':''# disabled='disabled' data-bind='value:isChecked' ng-class='vc.viewState.QV_8174_44016.column.isChecked.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.isChecked.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.isChecked.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.isChecked.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_8174_44016.columns.push({
                    field: 'rejectionReason',
                    title: '{{vc.viewState.QV_8174_44016.column.rejectionReason.title|translate:vc.viewState.QV_8174_44016.column.rejectionReason.titleArgs}}',
                    width: $scope.vc.viewState.QV_8174_44016.column.rejectionReason.width,
                    format: $scope.vc.viewState.QV_8174_44016.column.rejectionReason.format,
                    editor: $scope.vc.grids.QV_8174_44016.AT89_REJECTII435.control,
                    template: "<span ng-class='vc.viewState.QV_8174_44016.column.rejectionReason.style' ng-bind='vc.getStringColumnFormat(dataItem.rejectionReason, \"QV_8174_44016\", \"rejectionReason\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8174_44016.column.rejectionReason.style",
                        "title": "{{vc.viewState.QV_8174_44016.column.rejectionReason.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8174_44016.column.rejectionReason.hidden
                });
            }
            $scope.vc.viewState.QV_8174_44016.toolbar = {
                CEQV_201QV_8174_44016_748: {
                    visible: true
                },
                CEQV_201QV_8174_44016_953: {
                    visible: true
                },
                CEQV_201QV_8174_44016_987: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_8174_44016.toolbar = [{
                "name": "CEQV_201QV_8174_44016_748",
                "text": "{{'CSTMR.LBL_CSTMR_SELECCIAA_21296'|translate}}",
                "template": "<button id='CEQV_201QV_8174_44016_748' " + " ng-if='vc.viewState.QV_8174_44016.toolbar.CEQV_201QV_8174_44016_748.visible' " + "ng-disabled = 'vc.viewState.G_AUTHORIARI_332576.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_8174_44016_748\",\"AuthorizationTransferRequest\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }, {
                "name": "CEQV_201QV_8174_44016_953",
                "template": "<button id='CEQV_201QV_8174_44016_953' " + " ng-if='vc.viewState.QV_8174_44016.toolbar.CEQV_201QV_8174_44016_953.visible' " + "ng-disabled = 'vc.viewState.G_AUTHORIARI_332576.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_8174_44016_953\",\"AuthorizationTransferRequest\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-square'></span></button>"
            }, {
                "name": "CEQV_201QV_8174_44016_987",
                "template": "<button id='CEQV_201QV_8174_44016_987' " + " ng-if='vc.viewState.QV_8174_44016.toolbar.CEQV_201QV_8174_44016_987.visible' " + "ng-disabled = 'vc.viewState.G_AUTHORIARI_332576.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_8174_44016_987\",\"AuthorizationTransferRequest\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-check-square'></span></button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRTVGMFYGK_259_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRTVGMFYGK_259_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TCSTMRTV_C7T",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_AUTHORIRA_85933",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TCSTMRTV_R2T",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RECHAZARR_96315",
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
                $scope.vc.render('VC_AUTHORIZOS_306259');
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
    var cobisMainModule = cobis.createModule("VC_AUTHORIZOS_306259", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_AUTHORIZOS_306259", {
            templateUrl: "VC_AUTHORIZOS_306259_FORM.html",
            controller: "VC_AUTHORIZOS_306259_CTRL",
            labelId: "CSTMR.LBL_CSTMR_AUTORIZCS_18565",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AUTHORIZOS_306259?" + $.param(search);
            }
        });
        VC_AUTHORIZOS_306259(cobisMainModule);
    }]);
} else {
    VC_AUTHORIZOS_306259(cobisMainModule);
}