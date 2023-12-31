//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.businessform = designerEvents.api.businessform || designer.dsgEvents();

function VC_BUSINESSPR_115114(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_BUSINESSPR_115114_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_BUSINESSPR_115114_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_BUSINESSFMWNQ_114",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BUSINESSPR_115114",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_BUSINESSFMWNQ_114",
        designerEvents.api.businessform,
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
                vcName: 'VC_BUSINESSPR_115114'
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
                    taskId: 'T_BUSINESSFMWNQ_114',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Business: "Business",
                    CustomerTmpBusiness: "CustomerTmpBusiness"
                },
                entities: {
                    Business: {
                        colony: 'AT11_COLONYKL830',
                        customerCode: 'AT13_CUSTOMER830',
                        phone: 'AT13_PHONEWJC830',
                        economicActivity: 'AT14_ECONOMVA830',
                        street: 'AT17_STREETFK830',
                        economicActivityDesc: 'AT22_ECONOMVC830',
                        typeLocal: 'AT22_TYPELOAC830',
                        mountlyIncomes: 'AT27_MOUNTLEO830',
                        areEntrepreneur: 'AT35_AREENTPE830',
                        numberOfBusiness: 'AT46_NUMBERSI830',
                        postalCode: 'AT48_POSTALCE830',
                        timeBusinessAddress: 'AT53_TIMEBUES830',
                        state: 'AT60_STATEHSX830',
                        timeActivity: 'AT61_TIMEACYI830',
                        resources: 'AT72_RESOUREC830',
                        country: 'AT73_COUNTRYY830',
                        code: 'AT77_CODESODR830',
                        municipality: 'AT78_MUNICILL830',
                        dateBusiness: 'AT82_CREDITAA830',
                        creditDestination: 'AT87_CREDITIO830',
                        turnaround: 'AT90_TURNARDO830',
                        locations: 'AT91_LOCATIOO830',
                        names: 'AT98_NAMESVED830',
                        _pks: [],
                        _entityId: 'EN_BUSINESSS_830',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CustomerTmpBusiness: {
                        code: 'AT51_CODEUXLP105',
                        _pks: [],
                        _entityId: 'EN_CUSTOMEIR_105',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_BUSINESS_6359 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_BUSINESS_6359 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_BUSINESS_6359_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_BUSINESS_6359_filters;
                    parametersAux = {
                        code: filters.code
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_BUSINESSS_830',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_BUSINESS_6359',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['code'] = this.filters.code;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_BUSINESS_6359_filters = {};
            var defaultValues = {
                Business: {},
                CustomerTmpBusiness: {}
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
                $scope.vc.execute("temporarySave", VC_BUSINESSPR_115114, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_BUSINESSPR_115114, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_BUSINESSPR_115114, data, function() {});
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
            $scope.vc.viewState.VC_BUSINESSPR_115114 = {
                style: []
            }
            //ViewState - Group: GroupLayout1591
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_687304",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1591',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2643
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_428304",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group2643',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_428304-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerTmpBusiness = {
                code: $scope.vc.channelDefaultValues("CustomerTmpBusiness", "code")
            };
            //ViewState - Group: Group1257
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_972304",
                hasId: true,
                componentStyle: [],
                label: 'Group1257',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: CustomerTmpBusiness, Attribute: code
            $scope.vc.createViewState({
                id: "VA_CODEZGXWKDYWYYB_648304",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGODEET_21744",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONJPSJYQV_906304",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARAUU_89471",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2122
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_110304",
                hasId: true,
                componentStyle: [],
                label: 'Group2122',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Business = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    names: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "names", '')
                    },
                    economicActivityDesc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "economicActivityDesc", '')
                    },
                    timeActivity: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "timeActivity", 0)
                    },
                    timeBusinessAddress: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "timeBusinessAddress", 0),
                        validation: {
                            timeBusinessAddressRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    typeLocal: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "typeLocal", '')
                    },
                    resources: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "resources", '')
                    },
                    creditDestination: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "creditDestination", ''),
                        validation: {
                            creditDestinationRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    code: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "code", 0)
                    },
                    customerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "customerCode", 0)
                    },
                    economicActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "economicActivity", '')
                    },
                    turnaround: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "turnaround", '')
                    },
                    dateBusiness: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "dateBusiness", new Date())
                    },
                    street: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "street", '')
                    },
                    numberOfBusiness: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "numberOfBusiness", 0)
                    },
                    colony: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "colony", '')
                    },
                    locations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "locations", '')
                    },
                    municipality: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "municipality", '')
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "state", '')
                    },
                    postalCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "postalCode", '')
                    },
                    country: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "country", '')
                    },
                    areEntrepreneur: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "areEntrepreneur", false)
                    },
                    phone: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "phone", '')
                    },
                    mountlyIncomes: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "mountlyIncomes", 0)
                    }
                }
            });
            $scope.vc.model.Business = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_BUSINESS_6359';
                            var queryRequest = $scope.vc.getRequestQuery_Q_BUSINESS_6359();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6359_40398',
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Business',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6359_40398', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Business
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6359_40398").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_BUSINESS_6359 = $scope.vc.model.Business;
            $scope.vc.trackers.Business = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Business);
            $scope.vc.model.Business.bind('change', function(e) {
                $scope.vc.trackers.Business.track(e);
            });
            $scope.vc.grids.QV_6359_40398 = {};
            $scope.vc.grids.QV_6359_40398.queryId = 'Q_BUSINESS_6359';
            $scope.vc.viewState.QV_6359_40398 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6359_40398.column = {};
            $scope.vc.grids.QV_6359_40398.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_6359_40398.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Business(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_BUSINESSPOPPU_722",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_BUSINESSPP_740722',
                        title: 'CSTMR.LBL_CSTMR_NEGOCIOSS_45525',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_6359_40398", dialogParameters);
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
                        taskId: "T_BUSINESSPOPPU_722",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_BUSINESSPP_740722',
                        title: 'CSTMR.LBL_CSTMR_NEGOCIOSS_45525',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_6359_40398", dialogParameters);
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
                        nameEntityGrid: 'Business',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_6359_40398", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_6359_40398");
                    $scope.vc.hideShowColumns("QV_6359_40398", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6359_40398.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6359_40398.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6359_40398.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6359_40398 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6359_40398 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_6359_40398.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6359_40398.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6359_40398.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6359_40398.column.names = {
                title: 'CSTMR.LBL_CSTMR_NOMBREDEC_62486',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYD_971304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc = {
                title: 'CSTMR.LBL_CSTMR_ACTIVIDAA_39121',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYOY_865304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.timeActivity = {
                title: 'CSTMR.LBL_CSTMR_TIEMPODAA_42945',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCQL_755304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXCQL_755304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXCQL_755304',
                            'cl_referencia_tiempo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXCQL_755304'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress = {
                title: 'CSTMR.LBL_CSTMR_TIEMPOAOA_58383',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVKC_396304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXVKC_396304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXVKC_396304',
                            'cl_referencia_tiempo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXVKC_396304'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_6359_40398.column.typeLocal = {
                title: 'CSTMR.LBL_CSTMR_TIPODELAL_16702',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTMW_911304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXTMW_911304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXTMW_911304',
                            'cr_tipo_local',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXTMW_911304'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_6359_40398.column.resources = {
                title: 'CSTMR.LBL_CSTMR_CONQUPARS_17584',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXIK_422304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXXIK_422304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXXIK_422304',
                            'cl_recursos_credito',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXXIK_422304'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_6359_40398.column.creditDestination = {
                title: 'CSTMR.LBL_CSTMR_DESTINOTR_63871',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXYPK_251304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXYPK_251304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXYPK_251304',
                            'cl_destino_credito',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXYPK_251304'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_6359_40398.column.code = {
                title: 'code',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXETM_971304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.customerCode = {
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
                componentId: 'VA_TEXTINPUTBOXEWA_952304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.economicActivity = {
                title: 'CSTMR.LBL_CSTMR_ACTIVIDAA_39121',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCLL_749304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.turnaround = {
                title: 'CSTMR.LBL_CSTMR_GIROQYDVN_82921',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKWD_921304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.dateBusiness = {
                title: 'CSTMR.LBL_CSTMR_DESTINOTT_68123',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAEX_607304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.street = {
                title: 'street',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNWN_620304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness = {
                title: 'numberOfBusiness',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCUG_754304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.colony = {
                title: 'colony',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFNC_288304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.locations = {
                title: 'locations',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTTR_701304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.municipality = {
                title: 'municipality',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOZC_256304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.state = {
                title: 'state',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKBN_306304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.postalCode = {
                title: 'postalCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSQX_574304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.country = {
                title: 'country',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFSJ_501304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur = {
                title: 'CSTMR.LBL_CSTMR_ESEMPRENO_47778',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXEKDYYHM_687304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.phone = {
                title: 'phone',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWKG_843304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes = {
                title: 'mountlyIncomes',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMWQ_593304',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'names',
                    title: '{{vc.viewState.QV_6359_40398.column.names.title|translate:vc.viewState.QV_6359_40398.column.names.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.names.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.names.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.names.style' ng-bind='vc.getStringColumnFormat(dataItem.names, \"QV_6359_40398\", \"names\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.names.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.names.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.names.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'economicActivityDesc',
                    title: '{{vc.viewState.QV_6359_40398.column.economicActivityDesc.title|translate:vc.viewState.QV_6359_40398.column.economicActivityDesc.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.economicActivityDesc.style' ng-bind='vc.getStringColumnFormat(dataItem.economicActivityDesc, \"QV_6359_40398\", \"economicActivityDesc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.economicActivityDesc.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.economicActivityDesc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'timeActivity',
                    title: '{{vc.viewState.QV_6359_40398.column.timeActivity.title|translate:vc.viewState.QV_6359_40398.column.timeActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.timeActivity.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.timeActivity.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.timeActivity.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXCQL_755304.get(dataItem.timeActivity).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.timeActivity.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.timeActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.timeActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'timeBusinessAddress',
                    title: '{{vc.viewState.QV_6359_40398.column.timeBusinessAddress.title|translate:vc.viewState.QV_6359_40398.column.timeBusinessAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.timeBusinessAddress.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXVKC_396304.get(dataItem.timeBusinessAddress).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.timeBusinessAddress.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.timeBusinessAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'typeLocal',
                    title: '{{vc.viewState.QV_6359_40398.column.typeLocal.title|translate:vc.viewState.QV_6359_40398.column.typeLocal.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.typeLocal.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.typeLocal.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.typeLocal.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXTMW_911304.get(dataItem.typeLocal).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.typeLocal.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.typeLocal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.typeLocal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'resources',
                    title: '{{vc.viewState.QV_6359_40398.column.resources.title|translate:vc.viewState.QV_6359_40398.column.resources.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.resources.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.resources.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.resources.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXXIK_422304.get(dataItem.resources).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.resources.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.resources.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.resources.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'creditDestination',
                    title: '{{vc.viewState.QV_6359_40398.column.creditDestination.title|translate:vc.viewState.QV_6359_40398.column.creditDestination.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.creditDestination.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.creditDestination.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.creditDestination.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXYPK_251304.get(dataItem.creditDestination).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.creditDestination.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.creditDestination.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.creditDestination.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'code',
                    title: '{{vc.viewState.QV_6359_40398.column.code.title|translate:vc.viewState.QV_6359_40398.column.code.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.code.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.code.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.code.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.code, \"QV_6359_40398\", \"code\"):kendo.toString(#=code#, vc.viewState.QV_6359_40398.column.code.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.code.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.code.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.code.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'customerCode',
                    title: '{{vc.viewState.QV_6359_40398.column.customerCode.title|translate:vc.viewState.QV_6359_40398.column.customerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.customerCode.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.customerCode.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.customerCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerCode, \"QV_6359_40398\", \"customerCode\"):kendo.toString(#=customerCode#, vc.viewState.QV_6359_40398.column.customerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.customerCode.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.customerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.customerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'economicActivity',
                    title: '{{vc.viewState.QV_6359_40398.column.economicActivity.title|translate:vc.viewState.QV_6359_40398.column.economicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.economicActivity.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.economicActivity.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.economicActivity.style' ng-bind='vc.getStringColumnFormat(dataItem.economicActivity, \"QV_6359_40398\", \"economicActivity\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.economicActivity.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.economicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.economicActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'turnaround',
                    title: '{{vc.viewState.QV_6359_40398.column.turnaround.title|translate:vc.viewState.QV_6359_40398.column.turnaround.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.turnaround.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.turnaround.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.turnaround.style' ng-bind='vc.getStringColumnFormat(dataItem.turnaround, \"QV_6359_40398\", \"turnaround\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.turnaround.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.turnaround.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.turnaround.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'dateBusiness',
                    title: '{{vc.viewState.QV_6359_40398.column.dateBusiness.title|translate:vc.viewState.QV_6359_40398.column.dateBusiness.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.dateBusiness.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.dateBusiness.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.dateBusiness.style'>#=((dateBusiness !== null) ? kendo.toString(dateBusiness, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.dateBusiness.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.dateBusiness.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.dateBusiness.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'street',
                    title: '{{vc.viewState.QV_6359_40398.column.street.title|translate:vc.viewState.QV_6359_40398.column.street.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.street.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.street.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.street.style' ng-bind='vc.getStringColumnFormat(dataItem.street, \"QV_6359_40398\", \"street\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.street.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.street.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.street.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'numberOfBusiness',
                    title: '{{vc.viewState.QV_6359_40398.column.numberOfBusiness.title|translate:vc.viewState.QV_6359_40398.column.numberOfBusiness.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.numberOfBusiness.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberOfBusiness, \"QV_6359_40398\", \"numberOfBusiness\"):kendo.toString(#=numberOfBusiness#, vc.viewState.QV_6359_40398.column.numberOfBusiness.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.numberOfBusiness.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.numberOfBusiness.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'colony',
                    title: '{{vc.viewState.QV_6359_40398.column.colony.title|translate:vc.viewState.QV_6359_40398.column.colony.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.colony.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.colony.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.colony.style' ng-bind='vc.getStringColumnFormat(dataItem.colony, \"QV_6359_40398\", \"colony\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.colony.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.colony.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.colony.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'locations',
                    title: '{{vc.viewState.QV_6359_40398.column.locations.title|translate:vc.viewState.QV_6359_40398.column.locations.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.locations.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.locations.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.locations.style' ng-bind='vc.getStringColumnFormat(dataItem.locations, \"QV_6359_40398\", \"locations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.locations.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.locations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.locations.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'municipality',
                    title: '{{vc.viewState.QV_6359_40398.column.municipality.title|translate:vc.viewState.QV_6359_40398.column.municipality.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.municipality.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.municipality.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.municipality.style' ng-bind='vc.getStringColumnFormat(dataItem.municipality, \"QV_6359_40398\", \"municipality\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.municipality.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.municipality.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.municipality.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_6359_40398.column.state.title|translate:vc.viewState.QV_6359_40398.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.state.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.state.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_6359_40398\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.state.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'postalCode',
                    title: '{{vc.viewState.QV_6359_40398.column.postalCode.title|translate:vc.viewState.QV_6359_40398.column.postalCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.postalCode.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.postalCode.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.postalCode.style' ng-bind='vc.getStringColumnFormat(dataItem.postalCode, \"QV_6359_40398\", \"postalCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.postalCode.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.postalCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.postalCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'country',
                    title: '{{vc.viewState.QV_6359_40398.column.country.title|translate:vc.viewState.QV_6359_40398.column.country.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.country.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.country.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.country.style' ng-bind='vc.getStringColumnFormat(dataItem.country, \"QV_6359_40398\", \"country\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.country.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.country.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.country.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'areEntrepreneur',
                    title: '{{vc.viewState.QV_6359_40398.column.areEntrepreneur.title|translate:vc.viewState.QV_6359_40398.column.areEntrepreneur.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur.format,
                    template: "<input name='areEntrepreneur' type='checkbox' value='#=areEntrepreneur#' #=areEntrepreneur?checked='checked':''# disabled='disabled' data-bind='value:areEntrepreneur' ng-class='vc.viewState.QV_6359_40398.column.areEntrepreneur.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.areEntrepreneur.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.areEntrepreneur.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'phone',
                    title: '{{vc.viewState.QV_6359_40398.column.phone.title|translate:vc.viewState.QV_6359_40398.column.phone.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.phone.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.phone.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.phone.style' ng-bind='vc.getStringColumnFormat(dataItem.phone, \"QV_6359_40398\", \"phone\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.phone.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.phone.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.phone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'mountlyIncomes',
                    title: '{{vc.viewState.QV_6359_40398.column.mountlyIncomes.title|translate:vc.viewState.QV_6359_40398.column.mountlyIncomes.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.mountlyIncomes.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.mountlyIncomes, \"QV_6359_40398\", \"mountlyIncomes\"):kendo.toString(#=mountlyIncomes#, vc.viewState.QV_6359_40398.column.mountlyIncomes.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.mountlyIncomes.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.mountlyIncomes.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes.hidden
                });
            }
            $scope.vc.viewState.QV_6359_40398.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.cmdEdition = {};
            $scope.vc.viewState.QV_6359_40398.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_6359_40398.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Business",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_6359_40398.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6359_40398.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_BUSINESSSS_110304.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_6359_40398.events.customEdit($event, \"#:entity#\", grids.QV_6359_40398)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_6359_40398.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6359_40398.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_BUSINESSSS_110304.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_6359_40398.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_6359_40398.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_6359_40398.toolbar = [{
                "name": "create",
                "entity": "Business",
                "text": "",
                "template": "<button id = 'QV_6359_40398_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_6359_40398.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_BUSINESSSS_110304.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_6359_40398.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BUSINESSFMWNQ_114_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BUSINESSFMWNQ_114_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXCQL_755304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXVKC_396304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXTMW_911304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXXIK_422304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXYPK_251304.read();
                }
            });
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
                $scope.vc.render('VC_BUSINESSPR_115114');
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
    var cobisMainModule = cobis.createModule("VC_BUSINESSPR_115114", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_BUSINESSPR_115114", {
            templateUrl: "VC_BUSINESSPR_115114_FORM.html",
            controller: "VC_BUSINESSPR_115114_CTRL",
            labelId: "CSTMR.LBL_CSTMR_MANTENIID_22029",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_BUSINESSPR_115114?" + $.param(search);
            }
        });
        VC_BUSINESSPR_115114(cobisMainModule);
    }]);
} else {
    VC_BUSINESSPR_115114(cobisMainModule);
}