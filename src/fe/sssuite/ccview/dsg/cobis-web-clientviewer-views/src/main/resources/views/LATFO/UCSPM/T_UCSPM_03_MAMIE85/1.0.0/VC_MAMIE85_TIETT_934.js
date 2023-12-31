<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskdtomaintaining = designerEvents.api.taskdtomaintaining || designer.dsgEvents();

function VC_MAMIE85_TIETT_934(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MAMIE85_TIETT_934_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MAMIE85_TIETT_934_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)
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
            moduleId: "LATFO",
            subModuleId: "UCSPM",
            taskId: "T_UCSPM_03_MAMIE85",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MAMIE85_TIETT_934",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LATFO/UCSPM/T_UCSPM_03_MAMIE85",
        designerEvents.api.taskdtomaintaining,
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
                vcName: 'VC_MAMIE85_TIETT_934'
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
                    moduleId: 'LATFO',
                    subModuleId: 'UCSPM',
                    taskId: 'T_UCSPM_03_MAMIE85',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DTOS: "DTOS",
                    VccProperties: "VccProperties"
                },
                entities: {
                    DTOS: {
                        mnemonic: 'AT_VCC773NNIC24',
                        isList: 'AT_VCC773ILIS60',
                        parent: 'AT_VCC773DAET08',
                        serIdFk: 'AT_VCC773IDFK41',
                        name: 'AT_VCC773ONAE12',
                        dtoId: 'AT_VCC773DTOI22',
                        description: 'AT_VCC773TEIT99',
                        text: 'AT_VCC773DOET74',
                        order: 'AT_VCC773DRER76',
                        parentName: 'AT_VCC773PAME64',
                        _pks: ['dtoId'],
                        _entityId: 'EN_VCCDTOSKF773',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VccProperties: {
                        proId: 'AT_PRP986PRID36',
                        dtoId: 'AT_PRP986TODK34',
                        name: 'AT_PRP986PNAE74',
                        text: 'AT_PRP986REXT29',
                        primaryKey: 'AT_PRP986PRAR85',
                        grouping: 'AT_PRP986GRUI56',
                        detailSection: 'AT_PRP986PASN06',
                        visibleSumaryDetail: 'AT_PRP986PIBE26',
                        visibleSumaryGroup: 'AT_PRP986PISO66',
                        filterInProcess: 'AT_PRP986FNOS88',
                        width: 'AT_PRP986PRWH44',
                        format: 'AT_PRP986PORM08',
                        type: 'AT_PRP986RTYE93',
                        style: 'AT_PRP986PRTE80',
                        order: 'AT_PRP986ORER11',
                        _pks: ['proId', 'dtoId'],
                        _entityId: 'EN_PRPERTES1986',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CPROPRES_6239 = {
                autoCrud: false
            };
            $scope.vc.queries.Q_CPROPRES_6239 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_CPROPRES_6239 = {
                mainEntityPk: {
                    entityId: 'EN_PRPERTES1986',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_CPROPRES_6239',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {};
                    }
                }
            };
            defaultValues = {
                DTOS: {},
                VccProperties: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (en in defaultValues) {
                    if (en == entityName) {
                        for (att in defaultValues[en]) {
                            if (att == attributeName) {
                                for (ch in defaultValues[en][att]) {
                                    if (ch == channel) {
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
            }
            $scope.vc.executeCRUDQuery = function(queryId, loadInModel) {
                var queryRequest = $scope.vc.request.qr[queryId];
                return $scope.vc.CRUDExecuteQueryId(queryRequest, loadInModel);
            }
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                }
                $scope.vc.execute("temporarySave", null, data, function(response) {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    console.log("readTemporaryData");
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    }
                    return $scope.vc.executeService("readTemporaryData", null, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", null, data, function(response) {});
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
            $scope.vc.viewState.VC_MAMIE85_TIETT_934 = {
                style: []
            }
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_PROPIDADES79_04",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.DTOS = {
                mnemonic: $scope.vc.channelDefaultValues("DTOS", "mnemonic"),
                isList: $scope.vc.channelDefaultValues("DTOS", "isList"),
                parent: $scope.vc.channelDefaultValues("DTOS", "parent"),
                serIdFk: $scope.vc.channelDefaultValues("DTOS", "serIdFk"),
                name: $scope.vc.channelDefaultValues("DTOS", "name"),
                dtoId: $scope.vc.channelDefaultValues("DTOS", "dtoId"),
                description: $scope.vc.channelDefaultValues("DTOS", "description"),
                text: $scope.vc.channelDefaultValues("DTOS", "text"),
                order: $scope.vc.channelDefaultValues("DTOS", "order"),
                parentName: $scope.vc.channelDefaultValues("DTOS", "parentName")
            };
            //ViewState - Group: Panel Plegable para DTOS
            $scope.vc.createViewState({
                id: "GR_PROPIDADES79_05",
                hasId: true,
                componentStyle: "",
                label: "LATFO.DLB_LATFO_DTOKSHLDQ_70777",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: dtoId
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_DTOI169",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_IDRLTXGMO_15078",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: serIdFk
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_IDFK413",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_SERVICEVS_78854",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: mnemonic
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_NNIC819",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_NEMNICOIC_77766",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: name
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_ONAE584",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_NOMBREZKS_99987",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: text
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_DOET544",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_ETIQUETAX_59182",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: description
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_TEIT556",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_DESCRICIN_61951",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: parentName
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_DAET661",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_PADREBZVH_45785",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: isList
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_ILIS392",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_LISTARSXI_99267",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DTOS, Attribute: order
            $scope.vc.createViewState({
                id: "VA_PROPIDADES7905_DRER357",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_ORDENXQSF_38775",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel Plegable para VccProperties
            $scope.vc.createViewState({
                id: "GR_PROPIDADES79_06",
                hasId: true,
                componentStyle: "",
                label: "LATFO.DLB_LATFO_PROIEDDES_27826",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.VccProperties = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    name: {
                        type: "string",
                        editable: true
                    },
                    width: {
                        type: "string",
                        editable: true
                    },
                    type: {
                        type: "string",
                        editable: true
                    },
                    order: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.VccProperties = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CPROPRES_6239';
                            var queryRequest = $scope.vc.request.qr[queryId];
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_CPROP6239_58',
                                    queryRequest.queryPk.queryId,
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'VccProperties',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_CPROP6239_58', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
                            if (!args.cancel) {
                                options.success(args.row);
                            } else {
                                options.error(new Error('DeletingError'));
                            }
                        });
                        // end block
                    }
                },
                schema: {
                    model: $scope.vc.types.VccProperties
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_CPROP6239_58").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CPROPRES_6239 = $scope.vc.model.VccProperties;
            $scope.vc.trackers.VccProperties = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VccProperties);
            $scope.vc.model.VccProperties.bind('change', function(e) {
                $scope.vc.trackers.VccProperties.track(e);
            });
            $scope.vc.grids.QV_CPROP6239_58 = {};
            $scope.vc.grids.QV_CPROP6239_58.queryId = 'Q_CPROPRES_6239';
            $scope.vc.viewState.QV_CPROP6239_58 = {
                style: undefined
            };
            $scope.vc.viewState.QV_CPROP6239_58.column = {};
            $scope.vc.grids.QV_CPROP6239_58.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.VccProperties(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "LATFO",
                        subModuleId: "UCSPM",
                        taskId: "T_UCSPM_03_MAMIE85",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MAMIE85_ETMAN_558',
                        title: 'LATFO.DLB_LATFO_TOPROPERT_49716'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_CPROP6239_58", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    $scope.vc.grids.QV_CPROP6239_58.selectedRow = dataItem;
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "LATFO",
                        subModuleId: "UCSPM",
                        taskId: "T_UCSPM_03_MAMIE85",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MAMIE85_ETMAN_558',
                        title: 'LATFO.DLB_LATFO_TOPROPERT_49716'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_CPROP6239_58", dialogParameters);
                },
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_CPROP6239_58");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_CPROP6239_58.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_CPROP6239_58.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_CPROP6239_58.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "VccProperties",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_CPROP6239_58", args);
                        if (!$scope.$root) {
                            if (e.sender.$angular_scope.$$phase !== '$apply' && e.sender.$angular_scope.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        } else {
                            if ($scope.$root.$$phase !== '$apply' && $scope.$root.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_CPROP6239_58.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_CPROP6239_58.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_CPROP6239_58.column.name = {
                title: 'LATFO.DLB_LATFO_NAMEPKVWT_37716',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_CPROP6239_58.column.width = {
                title: 'LATFO.DLB_LATFO_WIDTHJBIG_82636',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_CPROP6239_58.column.type = {
                title: 'LATFO.DLB_LATFO_TYPERJPHW_61500',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_CPROP6239_58.column.order = {
                title: 'LATFO.DLB_LATFO_ORDERRKHX_04081',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_CPROP6239_58.columns.push({
                    field: 'name',
                    title: '{{vc.viewState.QV_CPROP6239_58.column.name.title|translate:vc.viewState.QV_CPROP6239_58.column.name.titleArgs}}',
                    width: $scope.vc.viewState.QV_CPROP6239_58.column.name.width,
                    format: $scope.vc.viewState.QV_CPROP6239_58.column.name.format,
                    template: "<span ng-class='vc.viewState.QV_CPROP6239_58.column.name.element[dataItem.uid].style'>#if (name !== null) {# #=name# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_CPROP6239_58.column.name.style",
                        "title": "{{vc.viewState.QV_CPROP6239_58.column.name.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_CPROP6239_58.column.name.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_CPROP6239_58.columns.push({
                    field: 'width',
                    title: '{{vc.viewState.QV_CPROP6239_58.column.width.title|translate:vc.viewState.QV_CPROP6239_58.column.width.titleArgs}}',
                    width: $scope.vc.viewState.QV_CPROP6239_58.column.width.width,
                    format: $scope.vc.viewState.QV_CPROP6239_58.column.width.format,
                    template: "<span ng-class='vc.viewState.QV_CPROP6239_58.column.width.element[dataItem.uid].style'>#if (width !== null) {# #=width# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_CPROP6239_58.column.width.style",
                        "title": "{{vc.viewState.QV_CPROP6239_58.column.width.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_CPROP6239_58.column.width.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_CPROP6239_58.columns.push({
                    field: 'type',
                    title: '{{vc.viewState.QV_CPROP6239_58.column.type.title|translate:vc.viewState.QV_CPROP6239_58.column.type.titleArgs}}',
                    width: $scope.vc.viewState.QV_CPROP6239_58.column.type.width,
                    format: $scope.vc.viewState.QV_CPROP6239_58.column.type.format,
                    template: "<span ng-class='vc.viewState.QV_CPROP6239_58.column.type.element[dataItem.uid].style'>#if (type !== null) {# #=type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_CPROP6239_58.column.type.style",
                        "title": "{{vc.viewState.QV_CPROP6239_58.column.type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_CPROP6239_58.column.type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_CPROP6239_58.columns.push({
                    field: 'order',
                    title: '{{vc.viewState.QV_CPROP6239_58.column.order.title|translate:vc.viewState.QV_CPROP6239_58.column.order.titleArgs}}',
                    width: $scope.vc.viewState.QV_CPROP6239_58.column.order.width,
                    format: $scope.vc.viewState.QV_CPROP6239_58.column.order.format,
                    template: "<span ng-class='vc.viewState.QV_CPROP6239_58.column.order.element[dataItem.uid].style' ng-bind='kendo.toString(#=order#, vc.viewState.QV_CPROP6239_58.column.order.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_CPROP6239_58.column.order.style",
                        "title": "{{vc.viewState.QV_CPROP6239_58.column.order.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_CPROP6239_58.column.order.hidden
                });
            }
            $scope.vc.viewState.QV_CPROP6239_58.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_CPROP6239_58.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_CPROP6239_58.columns.push({
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "VccProperties",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_CPROP6239_58.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.GR_PROPIDADES79_06.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_CPROP6239_58.events.customEdit($event, \"#:entity#\", grids.QV_CPROP6239_58)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_CPROP6239_58.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_CPROP6239_58.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_CPROP6239_58.toolbar = [{
                "name": "create",
                "entity": "VccProperties",
                "text": "",
                "template": "<button id = 'QV_CPROP6239_58_CUSTOM_CREATE' class = 'btn btn-default cb-grid-image-button' " + "ng-show = 'vc.viewState.QV_CPROP6239_58.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_PROPIDADES79_06.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_CPROP6239_58.events.customCreate($event, \"#:entity#\")'> " + "<span class='glyphicon glyphicon-plus-sign'></span></button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_UCSPM_03_MAMIE85_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_UCSPM_03_MAMIE85_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Aceptar
            $scope.vc.createViewState({
                id: "CM_MAMIE85CET66",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_ACEPTAREL_26125",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_MAMIE85CLR24",
                componentStyle: "",
                label: "LATFO.DLB_LATFO_CANCELVZT_56717",
                haslabelArgs: true,
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
                $scope.vc.render('VC_MAMIE85_TIETT_934');
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
    var cobisMainModule = cobis.createModule("VC_MAMIE85_TIETT_934", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LATFO"]);
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
        $routeProvider.when("/VC_MAMIE85_TIETT_934", {
            templateUrl: "VC_MAMIE85_TIETT_934_FORM.html",
            controller: "VC_MAMIE85_TIETT_934_CTRL",
            label: "DTO Maintaining",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LATFO');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MAMIE85_TIETT_934?" + $.param(search);
            }
        });
        VC_MAMIE85_TIETT_934(cobisMainModule);
    }]);
} else {
    VC_MAMIE85_TIETT_934(cobisMainModule);
}