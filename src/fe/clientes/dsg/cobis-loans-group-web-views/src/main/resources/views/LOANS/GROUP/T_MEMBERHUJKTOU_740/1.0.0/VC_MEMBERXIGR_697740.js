//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.memberform = designerEvents.api.memberform || designer.dsgEvents();

function VC_MEMBERXIGR_697740(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MEMBERXIGR_697740_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MEMBERXIGR_697740_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_MEMBERHUJKTOU_740",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MEMBERXIGR_697740",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_MEMBERHUJKTOU_740",
        designerEvents.api.memberform,
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
                vcName: 'VC_MEMBERXIGR_697740'
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
                    taskId: 'T_MEMBERHUJKTOU_740',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Member: "Member"
                },
                entities: {
                    Member: {
                        customerId: 'AT13_CUSTOMDE444',
                        qualification: 'AT16_QUALIFCA444',
                        hasIndividualAccountAux: 'AT17_HASINDUC444',
                        membershipDate: 'AT17_MEMBERIT444',
                        points: 'AT19_POINTSIA444',
                        savingVoluntary: 'AT20_SAVINGTY444',
                        groupId: 'AT27_GROUPIDD444',
                        state: 'AT29_STATEVDB444',
                        creditCode: 'AT40_CREDITCE444',
                        role: 'AT43_ROLEQVSE444',
                        riskLevel: 'AT45_RISKLEVE444',
                        qualificationId: 'AT49_QUALIFIN444',
                        secuential: 'AT51_SECUENIT444',
                        roleId: 'AT64_ROLEDPKV444',
                        level: 'AT65_LEVELGWK444',
                        checkRenapo: 'AT66_CHECKRPN444',
                        disconnectionDate: 'AT74_DISCONOI444',
                        ctaIndividual: 'AT77_CTAINDAA444',
                        numberCyclePersonGroup: 'AT85_NUMBERSO444',
                        stateId: 'AT91_STATEIDD444',
                        operation: 'AT92_OPERATIO444',
                        meetingPlace: 'AT94_MEETINAA444',
                        customer: 'AT96_CUSTOMER444',
                        _pks: [],
                        _entityId: 'EN_MEMBERWLM_444',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_MEMBERZI_7978 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_MEMBERZI_7978 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MEMBERZI_7978_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MEMBERZI_7978_filters;
                    parametersAux = {
                        groupId: filters.groupId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MEMBERWLM_444',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MEMBERZI_7978',
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
                        }
                    }
                }
            };
            $scope.vc.queries.Q_MEMBERZI_7978_filters = {};
            var defaultValues = {
                Member: {}
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
                $scope.vc.execute("temporarySave", VC_MEMBERXIGR_697740, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MEMBERXIGR_697740, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MEMBERXIGR_697740, data, function() {});
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
            $scope.vc.viewState.VC_MEMBERXIGR_697740 = {
                style: []
            }
            //ViewState - Group: Group1357
            $scope.vc.createViewState({
                id: "G_MEMBERIDUM_459848",
                hasId: true,
                componentStyle: [],
                label: 'Group1357',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Member = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "secuential", 0),
                        validation: {
                            secuentialRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "customerId", 0),
                        validation: {
                            customerIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    customer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "customer", '')
                    },
                    role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "role", '')
                    },
                    checkRenapo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "checkRenapo", '')
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "state", '')
                    },
                    qualification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "qualification", '')
                    },
                    savingVoluntary: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "savingVoluntary", 0)
                    },
                    meetingPlace: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "meetingPlace", '')
                    },
                    qualificationId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "qualificationId", ''),
                        validation: {
                            qualificationIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    riskLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Member", "riskLevel", '')
                    },
                    groupId: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Member = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_MEMBERZI_7978';
                            var queryRequest = $scope.vc.getRequestQuery_Q_MEMBERZI_7978();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7978_25243',
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
                            nameEntityGrid: 'Member',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7978_25243', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Member
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7978_25243").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MEMBERZI_7978 = $scope.vc.model.Member;
            $scope.vc.trackers.Member = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Member);
            $scope.vc.model.Member.bind('change', function(e) {
                $scope.vc.trackers.Member.track(e);
            });
            $scope.vc.grids.QV_7978_25243 = {};
            $scope.vc.grids.QV_7978_25243.queryId = 'Q_MEMBERZI_7978';
            $scope.vc.viewState.QV_7978_25243 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7978_25243.column = {};
            $scope.vc.grids.QV_7978_25243.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_7978_25243.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Member(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "LOANS",
                        subModuleId: "GROUP",
                        taskId: "T_MEMBERQZIZWFM_852",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MEMBERLFPC_722852',
                        title: 'LOANS.LBL_LOANS_INTEGRANE_36500',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7978_25243", dialogParameters);
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
                        moduleId: "LOANS",
                        subModuleId: "GROUP",
                        taskId: "T_MEMBERQZIZWFM_852",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MEMBERLFPC_722852',
                        title: 'LOANS.LBL_LOANS_INTEGRANE_36500',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_7978_25243", dialogParameters);
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
                        nameEntityGrid: 'Member',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_7978_25243", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7978_25243");
                    $scope.vc.hideShowColumns("QV_7978_25243", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7978_25243.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7978_25243.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7978_25243.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7978_25243 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7978_25243 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7978_25243.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7978_25243.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7978_25243.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7978_25243.column.secuential = {
                title: 'LOANS.LBL_LOANS_SECUENCII_16384',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXJUD_372848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.customerId = {
                title: 'LOANS.LBL_LOANS_IDCLIENEE_21093',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXUBZ_786848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.customer = {
                title: 'LOANS.LBL_LOANS_CLIENTEMZ_77659',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUEX_348848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.role = {
                title: 'LOANS.LBL_LOANS_ROLOSKZGW_63791',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHNF_499848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.checkRenapo = {
                title: 'LOANS.LBL_LOANS_RENAPOBAV_65578',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEYR_376848',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXEYR_376848 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXEYR_376848',
                            'cl_respuesta_renapo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXEYR_376848'];
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
            $scope.vc.viewState.QV_7978_25243.column.state = {
                title: 'LOANS.LBL_LOANS_ESTADOIKH_14850',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTLH_430848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.qualification = {
                title: 'LOANS.LBL_LOANS_NIVELDERI_38662',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXIW_997848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.savingVoluntary = {
                title: 'savingVoluntary',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFSC_118848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.meetingPlace = {
                title: 'meetingPlace',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJPQ_319848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.qualificationId = {
                title: 'LOANS.LBL_LOANS_BURCRDIOT_58082',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXNGX_485848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.riskLevel = {
                title: 'LOANS.LBL_LOANS_NIVELRIGS_61993',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCGW_716848',
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.groupId = {
                title: 'groupId',
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
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_7978_25243.column.secuential.title|translate:vc.viewState.QV_7978_25243.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.secuential.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.secuential.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.secuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_7978_25243\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_7978_25243.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7978_25243.column.secuential.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_7978_25243.column.customerId.title|translate:vc.viewState.QV_7978_25243.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.customerId.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.customerId.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_7978_25243\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_7978_25243.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7978_25243.column.customerId.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'customer',
                    title: '{{vc.viewState.QV_7978_25243.column.customer.title|translate:vc.viewState.QV_7978_25243.column.customer.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.customer.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.customer.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.customer.style' ng-bind='vc.getStringColumnFormat(dataItem.customer, \"QV_7978_25243\", \"customer\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.customer.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.customer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.customer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'role',
                    title: '{{vc.viewState.QV_7978_25243.column.role.title|translate:vc.viewState.QV_7978_25243.column.role.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.role.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.role.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.role.style' ng-bind='vc.getStringColumnFormat(dataItem.role, \"QV_7978_25243\", \"role\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.role.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'checkRenapo',
                    title: '{{vc.viewState.QV_7978_25243.column.checkRenapo.title|translate:vc.viewState.QV_7978_25243.column.checkRenapo.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.checkRenapo.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.checkRenapo.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.checkRenapo.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXEYR_376848.get(dataItem.checkRenapo).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.checkRenapo.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.checkRenapo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.checkRenapo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_7978_25243.column.state.title|translate:vc.viewState.QV_7978_25243.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.state.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.state.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_7978_25243\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.state.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'qualification',
                    title: '{{vc.viewState.QV_7978_25243.column.qualification.title|translate:vc.viewState.QV_7978_25243.column.qualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.qualification.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.qualification.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.qualification.style' ng-bind='vc.getStringColumnFormat(dataItem.qualification, \"QV_7978_25243\", \"qualification\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.qualification.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.qualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.qualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'savingVoluntary',
                    title: '{{vc.viewState.QV_7978_25243.column.savingVoluntary.title|translate:vc.viewState.QV_7978_25243.column.savingVoluntary.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.savingVoluntary.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.savingVoluntary.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.savingVoluntary.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.savingVoluntary, \"QV_7978_25243\", \"savingVoluntary\"):kendo.toString(#=savingVoluntary#, vc.viewState.QV_7978_25243.column.savingVoluntary.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7978_25243.column.savingVoluntary.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.savingVoluntary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.savingVoluntary.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'meetingPlace',
                    title: '{{vc.viewState.QV_7978_25243.column.meetingPlace.title|translate:vc.viewState.QV_7978_25243.column.meetingPlace.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.meetingPlace.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.meetingPlace.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.meetingPlace.style' ng-bind='vc.getStringColumnFormat(dataItem.meetingPlace, \"QV_7978_25243\", \"meetingPlace\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.meetingPlace.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.meetingPlace.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.meetingPlace.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'qualificationId',
                    title: '{{vc.viewState.QV_7978_25243.column.qualificationId.title|translate:vc.viewState.QV_7978_25243.column.qualificationId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.qualificationId.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.qualificationId.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.qualificationId.style' ng-bind='vc.getStringColumnFormat(dataItem.qualificationId, \"QV_7978_25243\", \"qualificationId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.qualificationId.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.qualificationId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.qualificationId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'riskLevel',
                    title: '{{vc.viewState.QV_7978_25243.column.riskLevel.title|translate:vc.viewState.QV_7978_25243.column.riskLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_7978_25243.column.riskLevel.width,
                    format: $scope.vc.viewState.QV_7978_25243.column.riskLevel.format,
                    template: "<span ng-class='vc.viewState.QV_7978_25243.column.riskLevel.style' ng-bind='vc.getStringColumnFormat(dataItem.riskLevel, \"QV_7978_25243\", \"riskLevel\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7978_25243.column.riskLevel.style",
                        "title": "{{vc.viewState.QV_7978_25243.column.riskLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.riskLevel.hidden
                });
            }
            $scope.vc.viewState.QV_7978_25243.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_7978_25243.column.cmdEdition = {};
            $scope.vc.viewState.QV_7978_25243.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7978_25243.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Member",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_7978_25243.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7978_25243.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_MEMBERIDUM_459848.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customEdit($event, \"#:entity#\", grids.QV_7978_25243)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_7978_25243.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7978_25243.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_MEMBERIDUM_459848.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7978_25243.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848 = {
                    tooltip: '',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848)) {
                    $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848 = {};
                }
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.hidden = false;
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'VA_GRIDROWCOMMMAAA_212848',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMAAA_212848",
                        entity: "Member",
                        text: "{{'LOANS.LBL_LOANS_RELACINBA_97272'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmaaa':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMAAA_212848\", " + "vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.enabled || vc.viewState.G_MEMBERIDUM_459848.disabled' " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customRowClick($event, \"VA_GRIDROWCOMMMAAA_212848\", \"#:entity#\", \"QV_7978_25243\")' " + "title = \"{{vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.tooltip|translate}}\" " + "href = '\\#'>" + "#: text #" + "</a>"
                    },
                    width: 150,
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMAAA_212848.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848 = {
                    tooltip: '',
                    imageId: 'fa fa-search',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848)) {
                    $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848 = {};
                }
                $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.hidden = false;
                $scope.vc.grids.QV_7978_25243.columns.push({
                    field: 'VA_GRIDROWCOMMMNNA_977848',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNNA_977848",
                        entity: "Member",
                        text: "{{'LOANS.LBL_LOANS_LUPABHFLY_45644'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'cb-btn-custom-vagridrowcommmnna':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNNA_977848\", " + "vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.enabled || vc.viewState.G_MEMBERIDUM_459848.disabled' " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customRowClick($event, \"VA_GRIDROWCOMMMNNA_977848\", \"#:entity#\", \"QV_7978_25243\")' " + "title = \"{{vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.imageId'></span>" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7978_25243.column.VA_GRIDROWCOMMMNNA_977848.hidden
                });
            }
            $scope.vc.viewState.QV_7978_25243.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_7978_25243.toolbar = [{
                "name": "create",
                "entity": "Member",
                "text": "",
                "template": "<button id = 'QV_7978_25243_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_7978_25243.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_MEMBERIDUM_459848.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_7978_25243.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_MEMBERHUJKTOU_740_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_MEMBERHUJKTOU_740_CANCEL",
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
                    $scope.vc.catalogs.VA_TEXTINPUTBOXEYR_376848.read();
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
                $scope.vc.render('VC_MEMBERXIGR_697740');
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
    var cobisMainModule = cobis.createModule("VC_MEMBERXIGR_697740", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_MEMBERXIGR_697740", {
            templateUrl: "VC_MEMBERXIGR_697740_FORM.html",
            controller: "VC_MEMBERXIGR_697740_CTRL",
            label: "MemberForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MEMBERXIGR_697740?" + $.param(search);
            }
        });
        VC_MEMBERXIGR_697740(cobisMainModule);
    }]);
} else {
    VC_MEMBERXIGR_697740(cobisMainModule);
}