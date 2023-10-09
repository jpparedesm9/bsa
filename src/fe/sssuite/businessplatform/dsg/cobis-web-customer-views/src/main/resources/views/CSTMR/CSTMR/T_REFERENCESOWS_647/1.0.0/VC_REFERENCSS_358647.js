//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.referencesform = designerEvents.api.referencesform || designer.dsgEvents();

function VC_REFERENCSS_358647(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REFERENCSS_358647_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REFERENCSS_358647_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_REFERENCESOWS_647",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REFERENCSS_358647",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_REFERENCESOWS_647",
        designerEvents.api.referencesform,
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
                vcName: 'VC_REFERENCSS_358647'
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
                    taskId: 'T_REFERENCESOWS_647',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    References: "References",
                    CustomerTmpReferences: "CustomerTmpReferences"
                },
                entities: {
                    References: {
                        firstLastName: 'AT10_FIRSTLNT825',
                        officePhone: 'AT12_OFFICEEE825',
                        description: 'AT13_DESCRIPP825',
                        cellPhone: 'AT19_CELLPHEE825',
                        postalCode: 'AT36_POSTALED825',
                        country: 'AT37_COUNTRYY825',
                        municipality: 'AT39_MUNICIAP825',
                        state: 'AT42_STATEFJV825',
                        homePhone: 'AT46_HOMEPHNO825',
                        knownTime: 'AT48_KNOWNTMM825',
                        neighborhood: 'AT52_NEIGHBDD825',
                        email: 'AT58_EMAILOAJ825',
                        relationship: 'AT61_RELATIHO825',
                        customerCode: 'AT63_CUSTOMDD825',
                        colony: 'AT69_COLONYUJ825',
                        address: 'AT71_ADDRESSS825',
                        locations: 'AT72_LOCATINS825',
                        references: 'AT76_REFERECE825',
                        names: 'AT79_NAMESQJW825',
                        secondLastName: 'AT88_SECONDTM825',
                        numberOfReferences: 'AT97_NUMBERCC825',
                        street: 'AT98_STREETQD825',
                        _pks: [],
                        _entityId: 'EN_REFERENES_825',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CustomerTmpReferences: {
                        code: 'AT55_CODEFTEE385',
                        _pks: [],
                        _entityId: 'EN_CUSTOMEES_385',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_REFEREEN_7269 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REFEREEN_7269 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REFEREEN_7269_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REFEREEN_7269_filters;
                    parametersAux = {
                        customerCode: filters.customerCode
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REFERENES_825',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REFEREEN_7269',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['customerCode'] = this.filters.customerCode;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_REFEREEN_7269_filters = {};
            var defaultValues = {
                References: {},
                CustomerTmpReferences: {}
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
                $scope.vc.execute("temporarySave", VC_REFERENCSS_358647, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REFERENCSS_358647, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REFERENCSS_358647, data, function() {});
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
            $scope.vc.viewState.VC_REFERENCSS_358647 = {
                style: []
            }
            //ViewState - Group: GroupLayout1501
            $scope.vc.createViewState({
                id: "G_REFERENSES_691576",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1501',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2494
            $scope.vc.createViewState({
                id: "G_REFERENESE_949576",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group2494',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_REFERENESE_949576-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerTmpReferences = {
                code: $scope.vc.channelDefaultValues("CustomerTmpReferences", "code")
            };
            //ViewState - Group: Group2606
            $scope.vc.createViewState({
                id: "G_REFERENESE_254576",
                hasId: true,
                componentStyle: [],
                label: 'Group2606',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: CustomerTmpReferences, Attribute: code
            $scope.vc.createViewState({
                id: "VA_CODELGVLPDNYAPY_652576",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGODEET_21744",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONOKQWNLY_810576",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARAUU_89471",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group2992
            $scope.vc.createViewState({
                id: "G_REFERENECE_759576",
                hasId: true,
                componentStyle: [],
                label: 'Group2992',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.References = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    customerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "customerCode", 0)
                    },
                    names: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "names", '')
                    },
                    firstLastName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "firstLastName", '')
                    },
                    secondLastName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "secondLastName", '')
                    },
                    address: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "address", '')
                    },
                    homePhone: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "homePhone", '')
                    },
                    cellPhone: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "cellPhone", '')
                    },
                    officePhone: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "officePhone", '')
                    },
                    relationship: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "relationship", ''),
                        validation: {
                            relationshipRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "description", '')
                    },
                    references: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "references", 0)
                    },
                    street: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "street", '')
                    },
                    numberOfReferences: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "numberOfReferences", 0)
                    },
                    colony: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "colony", '')
                    },
                    locations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "locations", '')
                    },
                    municipality: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "municipality", '')
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "state", '')
                    },
                    postalCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "postalCode", '')
                    },
                    country: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "country", '')
                    },
                    knownTime: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "knownTime", 0)
                    },
                    neighborhood: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("References", "neighborhood", '')
                    },
                    email: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.References = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REFEREEN_7269();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
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
                            nameEntityGrid: 'References',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7269_22799', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.References
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7269_22799").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REFEREEN_7269 = $scope.vc.model.References;
            $scope.vc.trackers.References = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.References);
            $scope.vc.model.References.bind('change', function(e) {
                $scope.vc.trackers.References.track(e);
            });
            $scope.vc.grids.QV_7269_22799 = {};
            $scope.vc.grids.QV_7269_22799.queryId = 'Q_REFEREEN_7269';
            $scope.vc.viewState.QV_7269_22799 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7269_22799.column = {};
            $scope.vc.grids.QV_7269_22799.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_7269_22799.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.References(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_REFERENCESPPP_957",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_REFERENCPP_688957',
                        title: 'CSTMR.LBL_CSTMR_REFERENCS_45846',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7269_22799", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
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
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_REFERENCESPPP_957",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_REFERENCPP_688957',
                        title: 'CSTMR.LBL_CSTMR_REFERENCS_45846',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7269_22799", dialogParameters);
                },
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'References',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_7269_22799", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7269_22799");
                    $scope.vc.hideShowColumns("QV_7269_22799", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7269_22799.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7269_22799.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7269_22799.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7269_22799 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7269_22799 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7269_22799.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7269_22799.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7269_22799.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7269_22799.column.customerCode = {
                title: 'customerCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWNO_766576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.names = {
                title: 'CSTMR.LBL_CSTMR_NOMBRESOQ_57455',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXPV_532576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.firstLastName = {
                title: 'CSTMR.LBL_CSTMR_APELLIDSO_11522',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYGR_962576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.secondLastName = {
                title: 'secondLastName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVVH_740576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.address = {
                title: 'address',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUEJ_832576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.homePhone = {
                title: 'homePhone',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWXX_139576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.cellPhone = {
                title: 'cellPhone',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVZP_831576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.officePhone = {
                title: 'officePhone',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSKL_295576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.relationship = {
                title: 'CSTMR.LBL_CSTMR_PARENTESC_45165',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXWTW_267576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.description = {
                title: 'description',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWZP_846576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.references = {
                title: 'references',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLWL_959576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.street = {
                title: 'street',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDNMPGEC_150576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.numberOfReferences = {
                title: 'numberOfReferences',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXILL_990576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.colony = {
                title: 'colony',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPUA_830576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.locations = {
                title: 'locations',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIGC_521576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.municipality = {
                title: 'municipality',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOBT_529576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.state = {
                title: 'state',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNCJ_203576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.postalCode = {
                title: 'postalCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCQS_822576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.country = {
                title: 'country',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKEY_530576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.knownTime = {
                title: 'knownTime',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLJF_273576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.neighborhood = {
                title: 'neighborhood',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVJG_935576',
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.email = {
                title: 'email',
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
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'customerCode',
                    title: '{{vc.viewState.QV_7269_22799.column.customerCode.title|translate:vc.viewState.QV_7269_22799.column.customerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.customerCode.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.customerCode.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.customerCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerCode, \"QV_7269_22799\", \"customerCode\"):kendo.toString(#=customerCode#, vc.viewState.QV_7269_22799.column.customerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7269_22799.column.customerCode.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.customerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.customerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'names',
                    title: '{{vc.viewState.QV_7269_22799.column.names.title|translate:vc.viewState.QV_7269_22799.column.names.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.names.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.names.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.names.style' ng-bind='vc.getStringColumnFormat(dataItem.names, \"QV_7269_22799\", \"names\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.names.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.names.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.names.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'firstLastName',
                    title: '{{vc.viewState.QV_7269_22799.column.firstLastName.title|translate:vc.viewState.QV_7269_22799.column.firstLastName.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.firstLastName.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.firstLastName.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.firstLastName.style' ng-bind='vc.getStringColumnFormat(dataItem.firstLastName, \"QV_7269_22799\", \"firstLastName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.firstLastName.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.firstLastName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.firstLastName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'secondLastName',
                    title: '{{vc.viewState.QV_7269_22799.column.secondLastName.title|translate:vc.viewState.QV_7269_22799.column.secondLastName.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.secondLastName.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.secondLastName.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.secondLastName.style' ng-bind='vc.getStringColumnFormat(dataItem.secondLastName, \"QV_7269_22799\", \"secondLastName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.secondLastName.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.secondLastName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.secondLastName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'address',
                    title: '{{vc.viewState.QV_7269_22799.column.address.title|translate:vc.viewState.QV_7269_22799.column.address.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.address.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.address.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.address.style' ng-bind='vc.getStringColumnFormat(dataItem.address, \"QV_7269_22799\", \"address\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.address.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.address.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.address.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'homePhone',
                    title: '{{vc.viewState.QV_7269_22799.column.homePhone.title|translate:vc.viewState.QV_7269_22799.column.homePhone.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.homePhone.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.homePhone.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.homePhone.style' ng-bind='vc.getStringColumnFormat(dataItem.homePhone, \"QV_7269_22799\", \"homePhone\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.homePhone.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.homePhone.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.homePhone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'cellPhone',
                    title: '{{vc.viewState.QV_7269_22799.column.cellPhone.title|translate:vc.viewState.QV_7269_22799.column.cellPhone.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.cellPhone.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.cellPhone.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.cellPhone.style' ng-bind='vc.getStringColumnFormat(dataItem.cellPhone, \"QV_7269_22799\", \"cellPhone\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.cellPhone.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.cellPhone.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.cellPhone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'officePhone',
                    title: '{{vc.viewState.QV_7269_22799.column.officePhone.title|translate:vc.viewState.QV_7269_22799.column.officePhone.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.officePhone.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.officePhone.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.officePhone.style' ng-bind='vc.getStringColumnFormat(dataItem.officePhone, \"QV_7269_22799\", \"officePhone\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.officePhone.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.officePhone.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.officePhone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'relationship',
                    title: '{{vc.viewState.QV_7269_22799.column.relationship.title|translate:vc.viewState.QV_7269_22799.column.relationship.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.relationship.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.relationship.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.relationship.style' ng-bind='vc.getStringColumnFormat(dataItem.relationship, \"QV_7269_22799\", \"relationship\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.relationship.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.relationship.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.relationship.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7269_22799.column.description.title|translate:vc.viewState.QV_7269_22799.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.description.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.description.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7269_22799\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.description.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'references',
                    title: '{{vc.viewState.QV_7269_22799.column.references.title|translate:vc.viewState.QV_7269_22799.column.references.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.references.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.references.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.references.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.references, \"QV_7269_22799\", \"references\"):kendo.toString(#=references#, vc.viewState.QV_7269_22799.column.references.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7269_22799.column.references.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.references.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.references.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'street',
                    title: '{{vc.viewState.QV_7269_22799.column.street.title|translate:vc.viewState.QV_7269_22799.column.street.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.street.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.street.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.street.style' ng-bind='vc.getStringColumnFormat(dataItem.street, \"QV_7269_22799\", \"street\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.street.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.street.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.street.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'numberOfReferences',
                    title: '{{vc.viewState.QV_7269_22799.column.numberOfReferences.title|translate:vc.viewState.QV_7269_22799.column.numberOfReferences.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.numberOfReferences.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.numberOfReferences.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.numberOfReferences.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberOfReferences, \"QV_7269_22799\", \"numberOfReferences\"):kendo.toString(#=numberOfReferences#, vc.viewState.QV_7269_22799.column.numberOfReferences.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7269_22799.column.numberOfReferences.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.numberOfReferences.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.numberOfReferences.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'colony',
                    title: '{{vc.viewState.QV_7269_22799.column.colony.title|translate:vc.viewState.QV_7269_22799.column.colony.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.colony.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.colony.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.colony.style' ng-bind='vc.getStringColumnFormat(dataItem.colony, \"QV_7269_22799\", \"colony\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.colony.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.colony.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.colony.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'locations',
                    title: '{{vc.viewState.QV_7269_22799.column.locations.title|translate:vc.viewState.QV_7269_22799.column.locations.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.locations.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.locations.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.locations.style' ng-bind='vc.getStringColumnFormat(dataItem.locations, \"QV_7269_22799\", \"locations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.locations.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.locations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.locations.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'municipality',
                    title: '{{vc.viewState.QV_7269_22799.column.municipality.title|translate:vc.viewState.QV_7269_22799.column.municipality.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.municipality.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.municipality.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.municipality.style' ng-bind='vc.getStringColumnFormat(dataItem.municipality, \"QV_7269_22799\", \"municipality\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.municipality.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.municipality.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.municipality.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_7269_22799.column.state.title|translate:vc.viewState.QV_7269_22799.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.state.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.state.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_7269_22799\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.state.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'postalCode',
                    title: '{{vc.viewState.QV_7269_22799.column.postalCode.title|translate:vc.viewState.QV_7269_22799.column.postalCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.postalCode.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.postalCode.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.postalCode.style' ng-bind='vc.getStringColumnFormat(dataItem.postalCode, \"QV_7269_22799\", \"postalCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.postalCode.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.postalCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.postalCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'country',
                    title: '{{vc.viewState.QV_7269_22799.column.country.title|translate:vc.viewState.QV_7269_22799.column.country.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.country.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.country.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.country.style' ng-bind='vc.getStringColumnFormat(dataItem.country, \"QV_7269_22799\", \"country\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.country.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.country.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.country.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'knownTime',
                    title: '{{vc.viewState.QV_7269_22799.column.knownTime.title|translate:vc.viewState.QV_7269_22799.column.knownTime.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.knownTime.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.knownTime.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.knownTime.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.knownTime, \"QV_7269_22799\", \"knownTime\"):kendo.toString(#=knownTime#, vc.viewState.QV_7269_22799.column.knownTime.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7269_22799.column.knownTime.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.knownTime.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.knownTime.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'neighborhood',
                    title: '{{vc.viewState.QV_7269_22799.column.neighborhood.title|translate:vc.viewState.QV_7269_22799.column.neighborhood.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.neighborhood.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.neighborhood.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.neighborhood.style' ng-bind='vc.getStringColumnFormat(dataItem.neighborhood, \"QV_7269_22799\", \"neighborhood\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.neighborhood.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.neighborhood.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.neighborhood.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7269_22799.columns.push({
                    field: 'email',
                    title: '{{vc.viewState.QV_7269_22799.column.email.title|translate:vc.viewState.QV_7269_22799.column.email.titleArgs}}',
                    width: $scope.vc.viewState.QV_7269_22799.column.email.width,
                    format: $scope.vc.viewState.QV_7269_22799.column.email.format,
                    template: "<span ng-class='vc.viewState.QV_7269_22799.column.email.style' ng-bind='vc.getStringColumnFormat(dataItem.email, \"QV_7269_22799\", \"email\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7269_22799.column.email.style",
                        "title": "{{vc.viewState.QV_7269_22799.column.email.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7269_22799.column.email.hidden
                });
            }
            $scope.vc.viewState.QV_7269_22799.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_7269_22799.column.cmdEdition = {};
            $scope.vc.viewState.QV_7269_22799.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7269_22799.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "References",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_7269_22799.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7269_22799.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_REFERENECE_759576.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_7269_22799.events.customEdit($event, \"#:entity#\", grids.QV_7269_22799)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_7269_22799.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7269_22799.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_REFERENECE_759576.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7269_22799.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_7269_22799.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_7269_22799.toolbar = [{
                "name": "create",
                "entity": "References",
                "text": "",
                "template": "<button id = 'QV_7269_22799_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_7269_22799.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_REFERENECE_759576.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_7269_22799.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REFERENCESOWS_647_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REFERENCESOWS_647_CANCEL",
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
                $scope.vc.render('VC_REFERENCSS_358647');
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
    var cobisMainModule = cobis.createModule("VC_REFERENCSS_358647", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_REFERENCSS_358647", {
            templateUrl: "VC_REFERENCSS_358647_FORM.html",
            controller: "VC_REFERENCSS_358647_CTRL",
            labelId: "CSTMR.LBL_CSTMR_REFERENEE_89226",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REFERENCSS_358647?" + $.param(search);
            }
        });
        VC_REFERENCSS_358647(cobisMainModule);
    }]);
} else {
    VC_REFERENCSS_358647(cobisMainModule);
}