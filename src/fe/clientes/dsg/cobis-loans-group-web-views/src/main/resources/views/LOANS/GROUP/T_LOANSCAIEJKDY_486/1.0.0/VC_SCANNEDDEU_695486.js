//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.scanneddocuments = designerEvents.api.scanneddocuments || designer.dsgEvents();

function VC_SCANNEDDEU_695486(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_SCANNEDDEU_695486_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_SCANNEDDEU_695486_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANSCAIEJKDY_486",
            taskVersion: "1.0.0",
            viewContainerId: "VC_SCANNEDDEU_695486",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_LOANSCAIEJKDY_486",
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
                vcName: 'VC_SCANNEDDEU_695486'
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
                    taskId: 'T_LOANSCAIEJKDY_486',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ScannedDocuments: "ScannedDocuments",
                    UploadedDocuments: "UploadedDocuments",
                    Group: "Group",
                    Credit: "Credit"
                },
                entities: {
                    ScannedDocuments: {
                        groupId: 'AT12_GROUPIDD977',
                        customerId: 'AT42_CUSTOMER977',
                        members: 'AT97_MEMBERSS977',
                        applicationNumber: 'AT99_APPLICON977',
                        _pks: [],
                        _entityId: 'EN_DEBTORTAZ_977',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    UploadedDocuments: {
                        processInstance: 'AT20_PROCESEI469',
                        uploads: 'AT35_UPLOADSS469',
                        groupId: 'AT68_GROUPIDD469',
                        _pks: [],
                        _entityId: 'EN_UPLOADECU_469',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Group: {
                        hasGroupAccount: 'AT18_HASGROOA452',
                        meetingAddress: 'AT24_MEETINSD452',
                        nextVisitDate: 'AT28_NEXTVIAA452',
                        state: 'AT34_STATENKY452',
                        titular2Name: 'AT36_TITULARN452',
                        groupOffice: 'AT42_GROUPOFE452',
                        titularClient2: 'AT44_TITULAIE452',
                        userName: 'AT44_USERNAMM452',
                        addressMember: 'AT49_ADDRESSS452',
                        day: 'AT52_DAYBKCTB452',
                        constitutionDate: 'AT58_CONSTIAI452',
                        updateGroup: 'AT61_UPDATEPR452',
                        nameGroup: 'AT63_NAMEGROU452',
                        cycleNumber: 'AT65_CYCLENEU452',
                        payment: 'AT65_PAYMENTT452',
                        groupAccount: 'AT66_GROUPATO452',
                        otherPlace: 'AT67_OTHERPAC452',
                        titularClient1: 'AT70_TITULAEE452',
                        operation: 'AT71_OPERATIN452',
                        time: 'AT77_TIMEBDBX452',
                        code: 'AT87_CODEJXPZ452',
                        titular1Name: 'AT87_TITULAR1452',
                        hasIndividualAccount: 'AT90_HASINDAT452',
                        officer: 'AT91_OFFICERR452',
                        _pks: [],
                        _entityId: 'EN_GROUPWBWL_452',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Credit: {
                        office: 'AT11_OFFICEGM386',
                        subtype: 'AT26_SUBTYPEE386',
                        linked: 'AT37_LINKEDMA386',
                        term: 'AT40_TERMUMMV386',
                        category: 'AT42_CATEGORY386',
                        businessSector: 'AT45_BUSINESC386',
                        officeName: 'AT45_OFFICEAN386',
                        operationNumber: 'AT48_OPERATNI386',
                        customerId: 'AT63_CUSTOMIR386',
                        applicationNumber: 'AT65_APPLICUR386',
                        approvedAmount: 'AT70_APPROVMO386',
                        nemonicCurrency: 'AT70_MNEMONER386',
                        nameActivity: 'AT71_NAMEACIY386',
                        percentageWarranty: 'AT71_PERCENWA386',
                        paymentFrecuencyName: 'AT75_PAYMENEE386',
                        creditCode: 'AT76_CREDITCC386',
                        productType: 'AT85_PRODUCTP386',
                        amountRequested: 'AT87_AMOUNTEE386',
                        warrantyAmount: 'AT90_WARRANUT386',
                        paymentFrecuency: 'AT94_PAYMENEE386',
                        _pks: [],
                        _entityId: 'EN_CREDITAUT_386',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DEBTORJD_1763 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DEBTORJD_1763 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DEBTORJD_1763_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DEBTORJD_1763_filters;
                    parametersAux = {
                        groupId: filters.groupId,
                        applicationNumber: filters.applicationNumber
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DEBTORTAZ_977',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DEBTORJD_1763',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['groupId'] = this.filters.groupId;
                            this.parameters['applicationNumber'] = this.filters.applicationNumber;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DEBTORJD_1763_filters = {};
            var defaultValues = {
                ScannedDocuments: {},
                UploadedDocuments: {},
                Group: {},
                Credit: {}
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
                $scope.vc.execute("temporarySave", VC_SCANNEDDEU_695486, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_SCANNEDDEU_695486, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_SCANNEDDEU_695486, data, function() {});
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
            $scope.vc.viewState.VC_SCANNEDDEU_695486 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_SCANNEDDEU_695486",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PGMLATICRP_856486",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: HeaderGroup
            $scope.vc.createViewState({
                id: "VC_LQUZTMTNNT_257728",
                hasId: true,
                componentStyle: [],
                label: 'HeaderGroup',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1894
            $scope.vc.createViewState({
                id: "G_HEADERGUOP_223993",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1894',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_HEADERGUOP_223993-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ScannedDocuments
            $scope.vc.createViewState({
                id: "VC_RMXKWTYEJE_804614",
                hasId: true,
                componentStyle: [],
                label: 'ScannedDocuments',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1211
            $scope.vc.createViewState({
                id: "G_SCANNEDMNS_453539",
                hasId: true,
                componentStyle: [],
                label: 'Group1211',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ScannedDocuments = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    members: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocuments", "members", '')
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocuments", "groupId", 0)
                    },
                    applicationNumber: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.ScannedDocuments = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DEBTORJD_1763';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DEBTORJD_1763();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_1763_79525',
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
                    model: $scope.vc.types.ScannedDocuments
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1763_79525").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DEBTORJD_1763 = $scope.vc.model.ScannedDocuments;
            $scope.vc.trackers.ScannedDocuments = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ScannedDocuments);
            $scope.vc.model.ScannedDocuments.bind('change', function(e) {
                $scope.vc.trackers.ScannedDocuments.track(e);
                $scope.vc.grids.QV_1763_79525.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_1763_79525 = {};
            $scope.vc.grids.QV_1763_79525.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_1763_79525) && expandedRowUidActual !== expandedRowUid_QV_1763_79525) {
                    var gridWidget = $('#QV_1763_79525').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_1763_79525 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_1763_79525 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_1763_79525 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_1763_79525);
                }
                expandedRowUid_QV_1763_79525 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_1763_79525', args);
                if (angular.isDefined($scope.vc.grids.QV_1763_79525.view)) {
                    $scope.vc.grids.QV_1763_79525.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_1763_79525.customView)) {
                    $scope.vc.grids.QV_1763_79525.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_1763_79525'/>"
            };
            $scope.vc.grids.QV_1763_79525.queryId = 'Q_DEBTORJD_1763';
            $scope.vc.viewState.QV_1763_79525 = {
                style: 'cb-grid-detail-arrow-bottom'
            };
            $scope.vc.viewState.QV_1763_79525.column = {};
            var expandedRowUid_QV_1763_79525;
            $scope.vc.grids.QV_1763_79525.editable = false;
            $scope.vc.grids.QV_1763_79525.events = {
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
                    $scope.vc.trackers.ScannedDocuments.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1763_79525.selectedRow = e.model;
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
                    $scope.vc.grids.QV_1763_79525.events.moveRowDetailIcon(e);
                    $scope.vc.grids.QV_1763_79525.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
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
                    var numColumnsVisible = $("#QV_1763_79525 > .k-grid-header colgroup col").length;
                    var diff = numColumns - numColumnsVisible;
                    index = grid.element.find("th.k-header[data-role='droptarget']").index();
                    if (index != -1) {
                        $("#QV_1763_79525 th.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("th", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_1763_79525 td.k-hierarchy-cell").each(function() {
                            $(this).insertAfter($("td", this.parentNode).eq(grid.columns.length));
                        });
                        $("#QV_1763_79525 .k-hierarchy-col").each(function() {
                            $(this).insertAfter($("col", this.parentNode).eq(grid.columns.length - diff));
                        });
                    } else {
                        index = grid.tbody.find('tr:first>td:last').index();
                        if (index === -1) {
                            index = grid.element.find('tr>th:last').index();
                        }
                        if (index > 0) {
                            $("#QV_1763_79525 .k-hierarchy-cell").each(function() {
                                var element = $(this).siblings().eq(index - 1);
                                if (angular.isDefined(element) && angular.isDefined(element[0])) {
                                    $(this).insertAfter(element);
                                }
                            });
                            $("#QV_1763_79525 .k-hierarchy-col").each(function() {
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
                            nameEntityGrid: "ScannedDocuments",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_1763_79525", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_1763_79525", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.grids.QV_1763_79525.events.moveRowDetailIcon(e);
                    $scope.vc.gridDataBound("QV_1763_79525");
                    $scope.vc.hideShowColumns("QV_1763_79525", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1763_79525.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1763_79525.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1763_79525.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1763_79525 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1763_79525 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_1763_79525.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_1763_79525 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                },
                detailExpand: function(e) {
                    $(e.detailRow.find(".k-hierarchy-cell")).insertAfter($("td:last", e.detailRow));
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1763_79525.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1763_79525.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1763_79525.column.members = {
                title: 'LOANS.LBL_LOANS_INTEGRANE_36500',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGPP_616539',
                element: []
            };
            $scope.vc.grids.QV_1763_79525.AT97_MEMBERSS977 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1763_79525.column.members.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGPP_616539",
                        'data-validation-code': "{{vc.viewState.QV_1763_79525.column.members.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1763_79525.column.members.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1763_79525.column.groupId = {
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
                componentId: 'VA_TEXTINPUTBOXIOA_140539',
                element: []
            };
            $scope.vc.grids.QV_1763_79525.AT12_GROUPIDD977 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1763_79525.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIOA_140539",
                        'data-validation-code': "{{vc.viewState.QV_1763_79525.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1763_79525.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_1763_79525.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1763_79525.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1763_79525.column.applicationNumber = {
                title: 'applicationNumber',
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
                $scope.vc.grids.QV_1763_79525.columns.push({
                    field: 'members',
                    title: '{{vc.viewState.QV_1763_79525.column.members.title|translate:vc.viewState.QV_1763_79525.column.members.titleArgs}}',
                    width: $scope.vc.viewState.QV_1763_79525.column.members.width,
                    format: $scope.vc.viewState.QV_1763_79525.column.members.format,
                    editor: $scope.vc.grids.QV_1763_79525.AT97_MEMBERSS977.control,
                    template: "<span ng-class='vc.viewState.QV_1763_79525.column.members.style' ng-bind='vc.getStringColumnFormat(dataItem.members, \"QV_1763_79525\", \"members\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1763_79525.column.members.style",
                        "title": "{{vc.viewState.QV_1763_79525.column.members.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1763_79525.column.members.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_1763_79525.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_1763_79525.column.groupId.title|translate:vc.viewState.QV_1763_79525.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_1763_79525.column.groupId.width,
                    format: $scope.vc.viewState.QV_1763_79525.column.groupId.format,
                    editor: $scope.vc.grids.QV_1763_79525.AT12_GROUPIDD977.control,
                    template: "<span ng-class='vc.viewState.QV_1763_79525.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_1763_79525\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_1763_79525.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1763_79525.column.groupId.style",
                        "title": "{{vc.viewState.QV_1763_79525.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1763_79525.column.groupId.hidden
                });
            }
            $scope.vc.viewState.QV_1763_79525.toolbar = {}
            $scope.vc.grids.QV_1763_79525.toolbar = [];
            $scope.vc.model.UploadedDocuments = {
                processInstance: $scope.vc.channelDefaultValues("UploadedDocuments", "processInstance"),
                uploads: $scope.vc.channelDefaultValues("UploadedDocuments", "uploads"),
                groupId: $scope.vc.channelDefaultValues("UploadedDocuments", "groupId")
            };
            //ViewState - Group: Group1862
            $scope.vc.createViewState({
                id: "G_SCANNEDEST_604539",
                hasId: true,
                componentStyle: [],
                label: 'Group1862',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONJQYRZQE_653539",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_VERIFICCT_86654",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSCAIEJKDY_486_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSCAIEJKDY_486_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TLOANSCA_SL0",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_VERIFICCT_86654",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Group = {
                hasGroupAccount: $scope.vc.channelDefaultValues("Group", "hasGroupAccount"),
                meetingAddress: $scope.vc.channelDefaultValues("Group", "meetingAddress"),
                nextVisitDate: $scope.vc.channelDefaultValues("Group", "nextVisitDate"),
                state: $scope.vc.channelDefaultValues("Group", "state"),
                titular2Name: $scope.vc.channelDefaultValues("Group", "titular2Name"),
                groupOffice: $scope.vc.channelDefaultValues("Group", "groupOffice"),
                titularClient2: $scope.vc.channelDefaultValues("Group", "titularClient2"),
                userName: $scope.vc.channelDefaultValues("Group", "userName"),
                addressMember: $scope.vc.channelDefaultValues("Group", "addressMember"),
                day: $scope.vc.channelDefaultValues("Group", "day"),
                constitutionDate: $scope.vc.channelDefaultValues("Group", "constitutionDate"),
                updateGroup: $scope.vc.channelDefaultValues("Group", "updateGroup"),
                nameGroup: $scope.vc.channelDefaultValues("Group", "nameGroup"),
                cycleNumber: $scope.vc.channelDefaultValues("Group", "cycleNumber"),
                payment: $scope.vc.channelDefaultValues("Group", "payment"),
                groupAccount: $scope.vc.channelDefaultValues("Group", "groupAccount"),
                otherPlace: $scope.vc.channelDefaultValues("Group", "otherPlace"),
                titularClient1: $scope.vc.channelDefaultValues("Group", "titularClient1"),
                operation: $scope.vc.channelDefaultValues("Group", "operation"),
                time: $scope.vc.channelDefaultValues("Group", "time"),
                code: $scope.vc.channelDefaultValues("Group", "code"),
                titular1Name: $scope.vc.channelDefaultValues("Group", "titular1Name"),
                hasIndividualAccount: $scope.vc.channelDefaultValues("Group", "hasIndividualAccount"),
                officer: $scope.vc.channelDefaultValues("Group", "officer")
            };
            $scope.vc.model.Credit = {
                office: $scope.vc.channelDefaultValues("Credit", "office"),
                subtype: $scope.vc.channelDefaultValues("Credit", "subtype"),
                linked: $scope.vc.channelDefaultValues("Credit", "linked"),
                term: $scope.vc.channelDefaultValues("Credit", "term"),
                category: $scope.vc.channelDefaultValues("Credit", "category"),
                businessSector: $scope.vc.channelDefaultValues("Credit", "businessSector"),
                officeName: $scope.vc.channelDefaultValues("Credit", "officeName"),
                operationNumber: $scope.vc.channelDefaultValues("Credit", "operationNumber"),
                customerId: $scope.vc.channelDefaultValues("Credit", "customerId"),
                applicationNumber: $scope.vc.channelDefaultValues("Credit", "applicationNumber"),
                approvedAmount: $scope.vc.channelDefaultValues("Credit", "approvedAmount"),
                nemonicCurrency: $scope.vc.channelDefaultValues("Credit", "nemonicCurrency"),
                nameActivity: $scope.vc.channelDefaultValues("Credit", "nameActivity"),
                percentageWarranty: $scope.vc.channelDefaultValues("Credit", "percentageWarranty"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("Credit", "paymentFrecuencyName"),
                creditCode: $scope.vc.channelDefaultValues("Credit", "creditCode"),
                productType: $scope.vc.channelDefaultValues("Credit", "productType"),
                amountRequested: $scope.vc.channelDefaultValues("Credit", "amountRequested"),
                warrantyAmount: $scope.vc.channelDefaultValues("Credit", "warrantyAmount"),
                paymentFrecuency: $scope.vc.channelDefaultValues("Credit", "paymentFrecuency")
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
                $scope.vc.render('VC_SCANNEDDEU_695486');
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
    var cobisMainModule = cobis.createModule("VC_SCANNEDDEU_695486", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_SCANNEDDEU_695486", {
            templateUrl: "VC_SCANNEDDEU_695486_FORM.html",
            controller: "VC_SCANNEDDEU_695486_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_SCANNEDDEU_695486?" + $.param(search);
            }
        });
        VC_SCANNEDDEU_695486(cobisMainModule);
    }]);
} else {
    VC_SCANNEDDEU_695486(cobisMainModule);
}