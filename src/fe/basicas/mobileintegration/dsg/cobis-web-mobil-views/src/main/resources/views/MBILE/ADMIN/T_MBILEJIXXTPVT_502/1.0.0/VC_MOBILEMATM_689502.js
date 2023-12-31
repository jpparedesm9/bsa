//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.mobilemanagementform = designerEvents.api.mobilemanagementform || designer.dsgEvents();

function VC_MOBILEMATM_689502(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MOBILEMATM_689502_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MOBILEMATM_689502_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "MBILE",
            subModuleId: "ADMIN",
            taskId: "T_MBILEJIXXTPVT_502",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MOBILEMATM_689502",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/MBILE/ADMIN/T_MBILEJIXXTPVT_502",
        designerEvents.api.mobilemanagementform,
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
                vcName: 'VC_MOBILEMATM_689502'
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
                    moduleId: 'MBILE',
                    subModuleId: 'ADMIN',
                    taskId: 'T_MBILEJIXXTPVT_502',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Mobile: "Mobile",
                    MobileFilter: "MobileFilter"
                },
                entities: {
                    Mobile: {
                        imei: 'AT17_IMEIMLNJ124',
                        macAddress: 'AT17_MACADDRE124',
                        deviceStatus: 'AT20_DEVICEAT124',
                        alias: 'AT21_ALIASBEJ124',
                        registrationDate: 'AT23_REGISTAT124',
                        official: 'AT26_OFFICIAL124',
                        allowUpdate: 'AT53_ALLOWUTD124',
                        registrationUser: 'AT58_REGISTEO124',
                        officialDescription: 'AT72_OFFICIII124',
                        type: 'AT77_TYPEMOIB124',
                        code: 'AT78_CODEOHPX124',
                        deviceStatusDescription: 'AT97_DEVICERT124',
                        typeDescription: 'AT99_TYPEDEOP124',
                        _pks: ['code'],
                        _entityId: 'EN_MOBILEMMS_124',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    MobileFilter: {
                        official: 'AT12_USUARIOO971',
                        imei: 'AT63_IMEIRQZA971',
                        _pks: [],
                        _entityId: 'EN_MOBILEFLE_971',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_MOBILEFLE_971',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_MOBILEMMS_124',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT63_IMEIRQZA971',
                        attributeIdFk: 'AT17_IMEIMLNJ124'
                    }, {
                        attributeIdPk: 'AT12_USUARIOO971',
                        attributeIdFk: 'AT26_OFFICIAL124'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_MOBILEVP_5973 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_MOBILEVP_5973 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MOBILEVP_5973_filters)) {
                    parametersAux = {
                        imei: $scope.vc.model.MobileFilter.imei,
                        official: $scope.vc.model.MobileFilter.official
                    };
                } else {
                    var filters = $scope.vc.queries.Q_MOBILEVP_5973_filters;
                    parametersAux = {
                        imei: filters.imei,
                        official: filters.official
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MOBILEMMS_124',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MOBILEVP_5973',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['imei'] = $scope.vc.model.MobileFilter.imei;
                            this.parameters['official'] = $scope.vc.model.MobileFilter.official;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['imei'] = this.filters.imei;
                            this.parameters['official'] = this.filters.official;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_MOBILEVP_5973_filters = {};
            var defaultValues = {
                Mobile: {},
                MobileFilter: {}
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
                $scope.vc.execute("temporarySave", VC_MOBILEMATM_689502, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MOBILEMATM_689502, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MOBILEMATM_689502, data, function() {});
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
            $scope.vc.viewState.VC_MOBILEMATM_689502 = {
                style: []
            }
            $scope.vc.model.MobileFilter = {
                official: $scope.vc.channelDefaultValues("MobileFilter", "official"),
                imei: $scope.vc.channelDefaultValues("MobileFilter", "imei")
            };
            //ViewState - Group: Group1866
            $scope.vc.createViewState({
                id: "G_MOBILEMGET_690846",
                hasId: true,
                componentStyle: [],
                label: 'Group1866',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MobileFilter, Attribute: imei
            $scope.vc.createViewState({
                id: "VA_IMEIAEKQXXNWVIA_490846",
                componentStyle: [],
                label: "MBILE.LBL_MBILE_IMEICLAUE_21297",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MobileFilter, Attribute: official
            $scope.vc.createViewState({
                id: "VA_USUARIOWWQAXUFI_984846",
                componentStyle: [],
                label: "MBILE.LBL_MBILE_OFICIALWJ_74908",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_USUARIOWWQAXUFI_984846 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_USUARIOWWQAXUFI_984846', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_USUARIOWWQAXUFI_984846'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            maxRecords: 20,
                            filterType: 'startswith'
                        }, 0);
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
                id: "VA_VABUTTONHYTZHBK_204846",
                componentStyle: [],
                label: "MBILE.LBL_MBILE_BUSCAREOA_82277",
                queryId: 'Q_MOBILEVP_5973',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1823
            $scope.vc.createViewState({
                id: "G_MOBILEMANE_244846",
                hasId: true,
                componentStyle: [],
                label: 'Group1823',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Mobile = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    officialDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "officialDescription", '')
                    },
                    typeDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "typeDescription", '')
                    },
                    imei: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.MobileFilter.imei
                        }
                    },
                    macAddress: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "macAddress", ''),
                        validation: {
                            macAddressRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    alias: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "alias", '')
                    },
                    deviceStatusDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "deviceStatusDescription", '')
                    },
                    official: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.MobileFilter.official
                        },
                        validation: {
                            officialRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    registrationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "registrationDate", new Date())
                    },
                    type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "type", ''),
                        validation: {
                            typeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    code: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "code", 0),
                        validation: {
                            codeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    registrationUser: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "registrationUser", '')
                    },
                    deviceStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "deviceStatus", '')
                    },
                    allowUpdate: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Mobile", "allowUpdate", false)
                    }
                }
            });
            $scope.vc.model.Mobile = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_MOBILEVP_5973';
                            var queryRequest = $scope.vc.getRequestQuery_Q_MOBILEVP_5973();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5973_95309',
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
                            nameEntityGrid: 'Mobile',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_5973_95309', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Mobile
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5973_95309").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MOBILEVP_5973 = $scope.vc.model.Mobile;
            $scope.vc.trackers.Mobile = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Mobile);
            $scope.vc.model.Mobile.bind('change', function(e) {
                $scope.vc.trackers.Mobile.track(e);
            });
            $scope.vc.grids.QV_5973_95309 = {};
            $scope.vc.grids.QV_5973_95309.queryId = 'Q_MOBILEVP_5973';
            $scope.vc.viewState.QV_5973_95309 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5973_95309.column = {};
            $scope.vc.grids.QV_5973_95309.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_5973_95309.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Mobile(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "MBILE",
                        subModuleId: "ADMIN",
                        taskId: "T_MBILEKTPCSLCM_549",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MOBILEPOPP_688549',
                        title: 'MBILE.LBL_MBILE_DISPOSIOV_19334',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_5973_95309", dialogParameters);
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
                        moduleId: "MBILE",
                        subModuleId: "ADMIN",
                        taskId: "T_MBILEKTPCSLCM_549",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_MOBILEPOPP_688549',
                        title: 'MBILE.LBL_MBILE_DISPOSIOV_19334',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_5973_95309", dialogParameters);
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_5973_95309");
                    $scope.vc.hideShowColumns("QV_5973_95309", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5973_95309.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5973_95309.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5973_95309.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5973_95309 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5973_95309 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5973_95309.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5973_95309.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5973_95309.column.officialDescription = {
                title: 'MBILE.LBL_MBILE_OFICIALWJ_74908',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFJY_463846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.typeDescription = {
                title: 'MBILE.LBL_MBILE_TIPODISII_27083',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNTO_728846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.imei = {
                title: 'MBILE.LBL_MBILE_IMEICLAUE_21297',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJWB_292846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.macAddress = {
                title: 'MBILE.LBL_MBILE_MACADDRSE_57169',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXPFA_319846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.alias = {
                title: 'alias',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDPZ_919846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.deviceStatusDescription = {
                title: 'MBILE.LBL_MBILE_ESTADODIV_92411',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYGC_474846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.official = {
                title: 'MBILE.LBL_MBILE_OFICIALWJ_74908',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXOSS_478846',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXOSS_478846 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.viewState.QV_5973_95309.column.registrationDate = {
                title: 'registrationDate',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDLYMSUS_480846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.type = {
                title: 'MBILE.LBL_MBILE_TIPODISII_27083',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXXEK_761846',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXXEK_761846 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXXEK_761846',
                            'si_tipo_movil',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXXEK_761846'];
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
            $scope.vc.viewState.QV_5973_95309.column.code = {
                title: 'MBILE.LBL_MBILE_CDIGOMMXB_42257',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXXYK_311846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.registrationUser = {
                title: 'registrationUser',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTSH_268846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.deviceStatus = {
                title: 'deviceStatus',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIYQ_543846',
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.allowUpdate = {
                title: 'allowUpdate',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKBZ_671846',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'officialDescription',
                    title: '{{vc.viewState.QV_5973_95309.column.officialDescription.title|translate:vc.viewState.QV_5973_95309.column.officialDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.officialDescription.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.officialDescription.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.officialDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.officialDescription, \"QV_5973_95309\", \"officialDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.officialDescription.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.officialDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.officialDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'typeDescription',
                    title: '{{vc.viewState.QV_5973_95309.column.typeDescription.title|translate:vc.viewState.QV_5973_95309.column.typeDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.typeDescription.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.typeDescription.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.typeDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.typeDescription, \"QV_5973_95309\", \"typeDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.typeDescription.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.typeDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.typeDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'imei',
                    title: '{{vc.viewState.QV_5973_95309.column.imei.title|translate:vc.viewState.QV_5973_95309.column.imei.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.imei.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.imei.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.imei.style' ng-bind='vc.getStringColumnFormat(dataItem.imei, \"QV_5973_95309\", \"imei\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.imei.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.imei.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.imei.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'macAddress',
                    title: '{{vc.viewState.QV_5973_95309.column.macAddress.title|translate:vc.viewState.QV_5973_95309.column.macAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.macAddress.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.macAddress.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.macAddress.style' ng-bind='vc.getStringColumnFormat(dataItem.macAddress, \"QV_5973_95309\", \"macAddress\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.macAddress.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.macAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.macAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'alias',
                    title: '{{vc.viewState.QV_5973_95309.column.alias.title|translate:vc.viewState.QV_5973_95309.column.alias.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.alias.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.alias.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.alias.style' ng-bind='vc.getStringColumnFormat(dataItem.alias, \"QV_5973_95309\", \"alias\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.alias.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.alias.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.alias.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'deviceStatusDescription',
                    title: '{{vc.viewState.QV_5973_95309.column.deviceStatusDescription.title|translate:vc.viewState.QV_5973_95309.column.deviceStatusDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.deviceStatusDescription.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.deviceStatusDescription.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.deviceStatusDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.deviceStatusDescription, \"QV_5973_95309\", \"deviceStatusDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.deviceStatusDescription.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.deviceStatusDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.deviceStatusDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'official',
                    title: '{{vc.viewState.QV_5973_95309.column.official.title|translate:vc.viewState.QV_5973_95309.column.official.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.official.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.official.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.official.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXOSS_478846.get(dataItem.official).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.official.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.official.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.official.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'registrationDate',
                    title: '{{vc.viewState.QV_5973_95309.column.registrationDate.title|translate:vc.viewState.QV_5973_95309.column.registrationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.registrationDate.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.registrationDate.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.registrationDate.style'>#=((registrationDate !== null) ? kendo.toString(registrationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.registrationDate.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.registrationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.registrationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'type',
                    title: '{{vc.viewState.QV_5973_95309.column.type.title|translate:vc.viewState.QV_5973_95309.column.type.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.type.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.type.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.type.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXXEK_761846.get(dataItem.type).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.type.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'code',
                    title: '{{vc.viewState.QV_5973_95309.column.code.title|translate:vc.viewState.QV_5973_95309.column.code.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.code.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.code.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.code.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.code, \"QV_5973_95309\", \"code\"):kendo.toString(#=code#, vc.viewState.QV_5973_95309.column.code.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5973_95309.column.code.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.code.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.code.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'registrationUser',
                    title: '{{vc.viewState.QV_5973_95309.column.registrationUser.title|translate:vc.viewState.QV_5973_95309.column.registrationUser.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.registrationUser.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.registrationUser.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.registrationUser.style' ng-bind='vc.getStringColumnFormat(dataItem.registrationUser, \"QV_5973_95309\", \"registrationUser\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.registrationUser.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.registrationUser.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.registrationUser.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'deviceStatus',
                    title: '{{vc.viewState.QV_5973_95309.column.deviceStatus.title|translate:vc.viewState.QV_5973_95309.column.deviceStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.deviceStatus.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.deviceStatus.format,
                    template: "<span ng-class='vc.viewState.QV_5973_95309.column.deviceStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.deviceStatus, \"QV_5973_95309\", \"deviceStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.deviceStatus.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.deviceStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.deviceStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'allowUpdate',
                    title: '{{vc.viewState.QV_5973_95309.column.allowUpdate.title|translate:vc.viewState.QV_5973_95309.column.allowUpdate.titleArgs}}',
                    width: $scope.vc.viewState.QV_5973_95309.column.allowUpdate.width,
                    format: $scope.vc.viewState.QV_5973_95309.column.allowUpdate.format,
                    template: "<input name='allowUpdate' type='checkbox' value='#=allowUpdate#' #=allowUpdate?checked='checked':''# disabled='disabled' data-bind='value:allowUpdate' ng-class='vc.viewState.QV_5973_95309.column.allowUpdate.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5973_95309.column.allowUpdate.style",
                        "title": "{{vc.viewState.QV_5973_95309.column.allowUpdate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.allowUpdate.hidden
                });
            }
            $scope.vc.viewState.QV_5973_95309.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5973_95309.column.cmdEdition = {};
            $scope.vc.viewState.QV_5973_95309.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_5973_95309.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Mobile",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_5973_95309.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_5973_95309.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_MOBILEMANE_244846.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_5973_95309.events.customEdit($event, \"#:entity#\", grids.QV_5973_95309)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_5973_95309.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846 = {
                    tooltip: '',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846)) {
                    $scope.vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846 = {};
                }
                $scope.vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846.hidden = false;
                $scope.vc.grids.QV_5973_95309.columns.push({
                    field: 'VA_GRIDROWCOMMMNAN_851846',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNAN_851846",
                        entity: "Mobile",
                        text: "{{'MBILE.LBL_MBILE_SINCRONIA_75738'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmnan':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNAN_851846\", " + "vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846.enabled || vc.viewState.G_MOBILEMANE_244846.disabled' " + "data-ng-click = 'vc.grids.QV_5973_95309.events.customRowClick($event, \"VA_GRIDROWCOMMMNAN_851846\", \"#:entity#\", \"QV_5973_95309\")' " + "title = \"{{vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846.tooltip|translate}}\" " + "href = '\\#'>" + "#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_5973_95309.column.VA_GRIDROWCOMMMNAN_851846.hidden
                });
            }
            $scope.vc.viewState.QV_5973_95309.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_5973_95309.toolbar = [{
                "name": "create",
                "entity": "Mobile",
                "text": "",
                "template": "<button id = 'QV_5973_95309_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_5973_95309.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_MOBILEMANE_244846.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_5973_95309.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_MBILEJIXXTPVT_502_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_MBILEJIXXTPVT_502_CANCEL",
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
                    $scope.vc.catalogs.VA_TEXTINPUTBOXXEK_761846.read();
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
                $scope.vc.render('VC_MOBILEMATM_689502');
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
    var cobisMainModule = cobis.createModule("VC_MOBILEMATM_689502", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "MBILE"]);
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
        $routeProvider.when("/VC_MOBILEMATM_689502", {
            templateUrl: "VC_MOBILEMATM_689502_FORM.html",
            controller: "VC_MOBILEMATM_689502_CTRL",
            labelId: "MBILE.LBL_MBILE_ADMINISIS_40091",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('MBILE');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MOBILEMATM_689502?" + $.param(search);
            }
        });
        VC_MOBILEMATM_689502(cobisMainModule);
    }]);
} else {
    VC_MOBILEMATM_689502(cobisMainModule);
}