//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.loadexternaladvisor = designerEvents.api.loadexternaladvisor || designer.dsgEvents();

function VC_LOADEXTERA_441497(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LOADEXTERA_441497_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LOADEXTERA_441497_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CLCOL",
            subModuleId: "CLTVO",
            taskId: "T_CLCOLETZFPPIC_497",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LOADEXTERA_441497",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CLCOL/CLTVO/T_CLCOLETZFPPIC_497",
        designerEvents.api.loadexternaladvisor,
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
                vcName: 'VC_LOADEXTERA_441497'
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
                    moduleId: 'CLCOL',
                    subModuleId: 'CLTVO',
                    taskId: 'T_CLCOLETZFPPIC_497',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CollectiveProcessProgress: "CollectiveProcessProgress",
                    CollectiveAdvisor: "CollectiveAdvisor",
                    CollectiveAdvisorFile: "CollectiveAdvisorFile"
                },
                entities: {
                    CollectiveProcessProgress: {
                        progress: 'AT91_PROGRESS545',
                        _pks: [],
                        _entityId: 'EN_COLLECTEC_545',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CollectiveAdvisor: {
                        collective: 'AT15_COLLECTV485',
                        customerId: 'AT19_CUSTOMRR485',
                        observations: 'AT25_OBSERVSO485',
                        customerCell: 'AT30_CUSTOMLE485',
                        customerName: 'AT36_CLIENTME485',
                        externalAdvisor: 'AT50_EXTERNRV485',
                        idSecuencial: 'AT72_IDSECULA485',
                        customerAddress: 'AT93_CUSTOMRS485',
                        customerMail: 'AT97_CUSTOMRE485',
                        _pks: [],
                        _entityId: 'EN_COLLECTOV_485',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CollectiveAdvisorFile: {
                        ejecution: 'AT55_EJECUTIO440',
                        nameFile: 'AT76_NAMEFIEE440',
                        _pks: [],
                        _entityId: 'EN_COLLECTIA_440',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_COLLECRT_3718 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_COLLECRT_3718 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_COLLECRT_3718_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_COLLECRT_3718_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_COLLECTOV_485',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_COLLECRT_3718',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_COLLECRT_3718_filters = {};
            var defaultValues = {
                CollectiveProcessProgress: {},
                CollectiveAdvisor: {},
                CollectiveAdvisorFile: {}
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
                $scope.vc.execute("temporarySave", VC_LOADEXTERA_441497, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LOADEXTERA_441497, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LOADEXTERA_441497, data, function() {});
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
            $scope.vc.viewState.VC_LOADEXTERA_441497 = {
                style: []
            }
            $scope.vc.model.CollectiveAdvisorFile = {
                ejecution: $scope.vc.channelDefaultValues("CollectiveAdvisorFile", "ejecution"),
                nameFile: $scope.vc.channelDefaultValues("CollectiveAdvisorFile", "nameFile")
            };
            //ViewState - Group: Group1673
            $scope.vc.createViewState({
                id: "G_LOADEXTVDO_653757",
                hasId: true,
                componentStyle: [],
                label: 'Group1673',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CollectiveAdvisorFile, Attribute: nameFile
            $scope.vc.createViewState({
                id: "VA_1BNOXXDXEIKXBOP_815757",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_CARGARAHR_95357",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.viewState.VA_1BNOXXDXEIKXBOP_815757.disableUpload = false;
            $scope.vc.viewState.uploadVisible = true;
            $scope.vc.uploaders.VA_1BNOXXDXEIKXBOP_815757 = {
                maxSizeInMB: 10,
                relativePath: null,
                confirmUpload: false,
                visualAttributeModel: 'vc.model.CollectiveAdvisorFile.nameFile',
                fileUploadAPI: null
            };
            $scope.vc.createViewState({
                id: "VA_VABUTTONMZTUDER_769757",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_CARGARNQG_59092",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONQOPUGSB_200757",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_LIMPIAREZ_65308",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CollectiveProcessProgress = {
                progress: $scope.vc.channelDefaultValues("CollectiveProcessProgress", "progress")
            };
            //ViewState - Group: Group1684
            $scope.vc.createViewState({
                id: "G_LOADEXTLRO_415757",
                hasId: true,
                componentStyle: [],
                label: 'Group1684',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONXICAMDT_820757",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_PROCESARR_48223",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1328",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_604757",
                componentStyle: [],
                label: "CLCOL.LBL_CLCOL_PORCENTAR_13762",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_164757",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1572
            $scope.vc.createViewState({
                id: "G_LOADEXTLSS_819757",
                hasId: true,
                componentStyle: [],
                label: 'Group1572',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CollectiveAdvisor = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    idSecuencial: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "idSecuencial", 0)
                    },
                    collective: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "collective", '')
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "customerName", '')
                    },
                    customerId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "customerId", '')
                    },
                    customerAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "customerAddress", '')
                    },
                    customerCell: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "customerCell", '')
                    },
                    customerMail: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "customerMail", '')
                    },
                    externalAdvisor: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "externalAdvisor", '')
                    },
                    observations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CollectiveAdvisor", "observations", '')
                    }
                }
            });
            $scope.vc.model.CollectiveAdvisor = new kendo.data.DataSource({
                pageSize: 15,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_COLLECRT_3718';
                            var queryRequest = $scope.vc.getRequestQuery_Q_COLLECRT_3718();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3718_27394',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var grid = $('#QV_3718_27394').data('kendoExtGrid');
                                            var dataGridBeforeQuerying = grid.dataSource.data();
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                if (angular.isDefined(options.data.appendRecords) && options.data.appendRecords === true) {
                                                    if (result.length > 0) {
                                                        $scope.vc.viewState.QV_3718_27394.appendRecordsButton.enabled = true;
                                                    } else {
                                                        $scope.vc.viewState.QV_3718_27394.appendRecordsButton.enabled = false;
                                                    }
                                                    $.grep(grid.dataSource.view(), function(e) {
                                                        if (e.dirty === true) {
                                                            var dataItem = grid.dataSource.getByUid(e.uid)
                                                            grid.dataSource.remove(dataItem);
                                                        }
                                                    });
                                                    result = $.merge(dataGridBeforeQuerying, result);
                                                } else if (angular.isDefined($scope.vc.viewState.QV_3718_27394.appendRecordsButton.enabled) && $scope.vc.viewState.QV_3718_27394.appendRecordsButton.enabled === false) {
                                                    $scope.vc.viewState.QV_3718_27394.appendRecordsButton.enabled = true;
                                                }
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
                                            'pageSize': 15
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
                        var data = $scope.vc.model['CollectiveAdvisor'].data();
                        if (data.length == 1) {
                            $scope.vc.viewState.QV_3718_27394.appendRecordsButton.show = true;
                        }
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
                    model: $scope.vc.types.CollectiveAdvisor,
                    total: function(queryResults) {
                        var totalRecords = queryResults.length;
                        if (totalRecords === 0) {
                            $scope.vc.viewState.QV_3718_27394.appendRecordsButton.show = false;
                        } else {
                            $scope.vc.viewState.QV_3718_27394.appendRecordsButton.show = true;
                        }
                        return totalRecords;
                    }
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3718_27394").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_COLLECRT_3718 = $scope.vc.model.CollectiveAdvisor;
            $scope.vc.trackers.CollectiveAdvisor = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CollectiveAdvisor);
            $scope.vc.model.CollectiveAdvisor.bind('change', function(e) {
                $scope.vc.trackers.CollectiveAdvisor.track(e);
            });
            $scope.vc.grids.QV_3718_27394 = {};
            $scope.vc.grids.QV_3718_27394.queryId = 'Q_COLLECRT_3718';
            $scope.vc.viewState.QV_3718_27394 = {
                style: undefined,
                appendRecordsButton: {
                    show: true,
                    enabled: true
                }
            };
            $scope.vc.viewState.QV_3718_27394.column = {};
            $scope.vc.grids.QV_3718_27394.editable = false;
            $scope.vc.grids.QV_3718_27394.events = {
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
                    $scope.vc.trackers.CollectiveAdvisor.cancelTrackedChanges(e.model);
                    var data = $scope.vc.model['CollectiveAdvisor'].data();
                    if (data.length == 1) {
                        $scope.vc.viewState.QV_3718_27394.appendRecordsButton.show = false;
                    }
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3718_27394.selectedRow = e.model;
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_3718_27394', this.dataSource);
                },
                excel: {
                    fileName: 'QV_3718_27394.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_3718_27394.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_3718_27394");
                    $scope.vc.hideShowColumns("QV_3718_27394", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3718_27394.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3718_27394.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3718_27394.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3718_27394 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3718_27394 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isUndefined($scope.vc.grids.QV_3718_27394.nextRegisters) || $("#QV_3718_27394_appendRecordsButton").length == 0) {
                        $scope.vc.grids.QV_3718_27394.nextRegisters = angular.element(document.querySelector("#QV_3718_27394 .k-pager-wrap"));
                        var element = '&nbsp <button id="QV_3718_27394_appendRecordsButton" class="btn btn-default cb-btn-append-records" ' +
                            'ng-show="vc.viewState.QV_3718_27394.appendRecordsButton.show" ' +
                            'ng-disabled="!vc.viewState.QV_3718_27394.appendRecordsButton.enabled" ' +
                            'ng-click="vc.executeQueryAndAppendResults(vc.getRequestQuery_Q_COLLECRT_3718(),\'QV_3718_27394\')"><span class="glyphicon glyphicon-plus-sign"></span></button>';
                        $scope.vc.grids.QV_3718_27394.nextRegisters.append(element);
                        var appendRecButton = $("#QV_3718_27394_appendRecordsButton");
                        $compile($scope.vc.grids.QV_3718_27394.nextRegisters.contents())(appendRecButton.scope());
                        appendRecButton.scope().$apply();
                    } else {
                        if (dataView !== null) {
                            if (dataView.length == 0) {
                                $scope.vc.viewState.QV_3718_27394.appendRecordsButton.show = false;
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3718_27394.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3718_27394.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3718_27394.column.idSecuencial = {
                title: 'idSecuencial',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLVE_517757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT72_IDSECULA485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.idSecuencial.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLVE_517757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.idSecuencial.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3718_27394.column.idSecuencial.format",
                        'k-decimals': "vc.viewState.QV_3718_27394.column.idSecuencial.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.idSecuencial.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.collective = {
                title: 'CLCOL.LBL_CLCOL_COLECTIVV_59393',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKVB_847757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT15_COLLECTV485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.collective.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKVB_847757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.collective.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.collective.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.customerName = {
                title: 'CLCOL.LBL_CLCOL_NOMBRESDR_12041',
                titleArgs: {},
                tooltip: '',
                width: 500,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPKV_227757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT36_CLIENTME485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPKV_227757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.customerId = {
                title: 'CLCOL.LBL_CLCOL_IDDELCLCI_41026',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPQN_932757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT19_CUSTOMRR485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPQN_932757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.customerId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.customerAddress = {
                title: 'CLCOL.LBL_CLCOL_DIRECCIRO_17332',
                titleArgs: {},
                tooltip: '',
                width: 400,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBSR_937757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT93_CUSTOMRS485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.customerAddress.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBSR_937757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.customerAddress.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.customerAddress.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.customerCell = {
                title: 'CLCOL.LBL_CLCOL_CELULAREL_33268',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFYV_500757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT30_CUSTOMLE485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.customerCell.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFYV_500757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.customerCell.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.customerCell.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.customerMail = {
                title: 'CLCOL.LBL_CLCOL_CORREOEOO_72628',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNES_799757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT97_CUSTOMRE485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.customerMail.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNES_799757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.customerMail.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.customerMail.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.externalAdvisor = {
                title: 'CLCOL.LBL_CLCOL_ASESOREEA_92978',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFEE_986757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT50_EXTERNRV485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.externalAdvisor.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFEE_986757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.externalAdvisor.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.externalAdvisor.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3718_27394.column.observations = {
                title: 'CLCOL.LBL_CLCOL_OBSERVAOO_48603',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTNB_794757',
                element: []
            };
            $scope.vc.grids.QV_3718_27394.AT25_OBSERVSO485 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3718_27394.column.observations.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTNB_794757",
                        'data-validation-code': "{{vc.viewState.QV_3718_27394.column.observations.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3718_27394.column.observations.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'idSecuencial',
                    title: '{{vc.viewState.QV_3718_27394.column.idSecuencial.title|translate:vc.viewState.QV_3718_27394.column.idSecuencial.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.idSecuencial.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.idSecuencial.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT72_IDSECULA485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.idSecuencial.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.idSecuencial, \"QV_3718_27394\", \"idSecuencial\"):kendo.toString(#=idSecuencial#, vc.viewState.QV_3718_27394.column.idSecuencial.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3718_27394.column.idSecuencial.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.idSecuencial.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.idSecuencial.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'collective',
                    title: '{{vc.viewState.QV_3718_27394.column.collective.title|translate:vc.viewState.QV_3718_27394.column.collective.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.collective.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.collective.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT15_COLLECTV485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.collective.style' ng-bind='vc.getStringColumnFormat(dataItem.collective, \"QV_3718_27394\", \"collective\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.collective.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.collective.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.collective.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_3718_27394.column.customerName.title|translate:vc.viewState.QV_3718_27394.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.customerName.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.customerName.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT36_CLIENTME485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_3718_27394\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.customerName.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_3718_27394.column.customerId.title|translate:vc.viewState.QV_3718_27394.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.customerId.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.customerId.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT19_CUSTOMRR485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.customerId.style' ng-bind='vc.getStringColumnFormat(dataItem.customerId, \"QV_3718_27394\", \"customerId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.customerId.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'customerAddress',
                    title: '{{vc.viewState.QV_3718_27394.column.customerAddress.title|translate:vc.viewState.QV_3718_27394.column.customerAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.customerAddress.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.customerAddress.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT93_CUSTOMRS485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.customerAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.customerAddress, \"QV_3718_27394\", \"customerAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.customerAddress.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.customerAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.customerAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'customerCell',
                    title: '{{vc.viewState.QV_3718_27394.column.customerCell.title|translate:vc.viewState.QV_3718_27394.column.customerCell.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.customerCell.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.customerCell.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT30_CUSTOMLE485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.customerCell.style' ng-bind='vc.getStringColumnFormat(dataItem.customerCell, \"QV_3718_27394\", \"customerCell\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.customerCell.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.customerCell.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.customerCell.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'customerMail',
                    title: '{{vc.viewState.QV_3718_27394.column.customerMail.title|translate:vc.viewState.QV_3718_27394.column.customerMail.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.customerMail.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.customerMail.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT97_CUSTOMRE485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.customerMail.style' ng-bind='vc.getStringColumnFormat(dataItem.customerMail, \"QV_3718_27394\", \"customerMail\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.customerMail.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.customerMail.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.customerMail.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'externalAdvisor',
                    title: '{{vc.viewState.QV_3718_27394.column.externalAdvisor.title|translate:vc.viewState.QV_3718_27394.column.externalAdvisor.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.externalAdvisor.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.externalAdvisor.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT50_EXTERNRV485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.externalAdvisor.style' ng-bind='vc.getStringColumnFormat(dataItem.externalAdvisor, \"QV_3718_27394\", \"externalAdvisor\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.externalAdvisor.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.externalAdvisor.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.externalAdvisor.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3718_27394.columns.push({
                    field: 'observations',
                    title: '{{vc.viewState.QV_3718_27394.column.observations.title|translate:vc.viewState.QV_3718_27394.column.observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_3718_27394.column.observations.width,
                    format: $scope.vc.viewState.QV_3718_27394.column.observations.format,
                    editor: $scope.vc.grids.QV_3718_27394.AT25_OBSERVSO485.control,
                    template: "<span ng-class='vc.viewState.QV_3718_27394.column.observations.style' ng-bind='vc.getStringColumnFormat(dataItem.observations, \"QV_3718_27394\", \"observations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3718_27394.column.observations.style",
                        "title": "{{vc.viewState.QV_3718_27394.column.observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3718_27394.column.observations.hidden
                });
            }
            $scope.vc.viewState.QV_3718_27394.toolbar = {
                CEQV_201QV_3718_27394_509: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_3718_27394.toolbar = [{
                "name": "CEQV_201QV_3718_27394_509",
                "text": "{{'CLCOL.LBL_CLCOL_EXPORTARR_68400'|translate}}",
                "template": "<button id='CEQV_201QV_3718_27394_509' " + " ng-if='vc.viewState.QV_3718_27394.toolbar.CEQV_201QV_3718_27394_509.visible' " + "ng-disabled = 'vc.viewState.G_LOADEXTLSS_819757.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_3718_27394_509\",\"CollectiveAdvisor\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }, {
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_3718_27394.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CLCOLETZFPPIC_497_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CLCOLETZFPPIC_497_CANCEL",
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
                $scope.vc.render('VC_LOADEXTERA_441497');
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
    var cobisMainModule = cobis.createModule("VC_LOADEXTERA_441497", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CLCOL"]);
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
        $routeProvider.when("/VC_LOADEXTERA_441497", {
            templateUrl: "VC_LOADEXTERA_441497_FORM.html",
            controller: "VC_LOADEXTERA_441497_CTRL",
            labelId: "CLCOL.LBL_CLCOL_ASIGNACEE_59658",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CLCOL');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LOADEXTERA_441497?" + $.param(search);
            }
        });
        VC_LOADEXTERA_441497(cobisMainModule);
    }]);
} else {
    VC_LOADEXTERA_441497(cobisMainModule);
}