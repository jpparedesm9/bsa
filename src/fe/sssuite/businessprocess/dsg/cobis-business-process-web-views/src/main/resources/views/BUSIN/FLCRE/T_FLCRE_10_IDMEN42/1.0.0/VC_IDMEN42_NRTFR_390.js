<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.infocredmanagement = designerEvents.api.infocredmanagement || designer.dsgEvents();

function VC_IDMEN42_NRTFR_390(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_IDMEN42_NRTFR_390_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_IDMEN42_NRTFR_390_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_10_IDMEN42",
            taskVersion: "1.0.0",
            viewContainerId: "VC_IDMEN42_NRTFR_390",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_10_IDMEN42",
        designerEvents.api.infocredmanagement,
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
                vcName: 'VC_IDMEN42_NRTFR_390'
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
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_10_IDMEN42',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    InfocredItem: "InfocredItem",
                    InfocredHeader: "InfocredHeader"
                },
                entities: {
                    InfocredItem: {
                        Code: 'AT_INF251TEOD39',
                        CustomerCode: 'AT_INF251STOC81',
                        Date: 'AT_INF251DATE03',
                        Official: 'AT_INF251CIAL87',
                        ExpirationDate: 'AT_INF251PRTE51',
                        LoanOrRequest: 'AT_INF251ANUS43',
                        Workstation: 'AT_INF251OTAN35',
                        Role: 'AT_INF251ROLE95',
                        _pks: [],
                        _entityId: 'EN_INFOREDIT251',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    InfocredHeader: {
                        CustomerId: 'AT_INF260CTME27',
                        CustomerName: 'AT_INF260CTOM95',
                        ExpirationDate: 'AT_INF260EIRT18',
                        Count: 'AT_INF260COUN65',
                        AssociateTo: 'AT_INF260TYPE25',
                        ExistsLoanId: 'AT_INF260RUSI31',
                        AssociateWith: 'AT_INF260SCAP79',
                        NewLoanId: 'AT_INF260ANCK80',
                        NewRequestId: 'AT_INF260WEEI96',
                        NewLoanCode: 'AT_INF260EWNO77',
                        Role: 'AT_INF260ROLE49',
                        Out_HasManySimilar: 'AT_INF260MIMA95',
                        Out_SimilarList: 'AT_INF260ONTL63',
                        Out_Source: 'AT_INF260OUTC02',
                        Out_Role: 'AT_INF260OROL00',
                        Out_RequestIdLoanId: 'AT_INF260ESIO38',
                        _pks: [],
                        _entityId: 'EN_INFOREDHD260',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ODTEQERY_9197 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_ODTEQERY_9197 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_ODTEQERY_9197 = {
                mainEntityPk: {
                    entityId: 'EN_INFOREDIT251',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_ODTEQERY_9197',
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
                InfocredItem: {},
                InfocredHeader: {}
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
            $scope.vc.viewState.VC_IDMEN42_NRTFR_390 = {
                style: []
            }
            //ViewState - Container: InfocredManagementForm
            $scope.vc.createViewState({
                id: "VC_IDMEN42_NRTFR_390",
                hasId: true,
                componentStyle: "",
                label: 'InfocredManagementForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Panel para InfocredManagementView
            $scope.vc.createViewState({
                id: "VC_IDMEN42_NPAAI_825",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EDRPOTSED_79268",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor
            $scope.vc.createViewState({
                id: "GR_CEDNAGMTIE21_17",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.InfocredHeader = {
                CustomerId: $scope.vc.channelDefaultValues("InfocredHeader", "CustomerId"),
                CustomerName: $scope.vc.channelDefaultValues("InfocredHeader", "CustomerName"),
                ExpirationDate: $scope.vc.channelDefaultValues("InfocredHeader", "ExpirationDate"),
                Count: $scope.vc.channelDefaultValues("InfocredHeader", "Count"),
                AssociateTo: $scope.vc.channelDefaultValues("InfocredHeader", "AssociateTo"),
                ExistsLoanId: $scope.vc.channelDefaultValues("InfocredHeader", "ExistsLoanId"),
                AssociateWith: $scope.vc.channelDefaultValues("InfocredHeader", "AssociateWith"),
                NewLoanId: $scope.vc.channelDefaultValues("InfocredHeader", "NewLoanId"),
                NewRequestId: $scope.vc.channelDefaultValues("InfocredHeader", "NewRequestId"),
                NewLoanCode: $scope.vc.channelDefaultValues("InfocredHeader", "NewLoanCode"),
                Role: $scope.vc.channelDefaultValues("InfocredHeader", "Role"),
                Out_HasManySimilar: $scope.vc.channelDefaultValues("InfocredHeader", "Out_HasManySimilar"),
                Out_SimilarList: $scope.vc.channelDefaultValues("InfocredHeader", "Out_SimilarList"),
                Out_Source: $scope.vc.channelDefaultValues("InfocredHeader", "Out_Source"),
                Out_Role: $scope.vc.channelDefaultValues("InfocredHeader", "Out_Role"),
                Out_RequestIdLoanId: $scope.vc.channelDefaultValues("InfocredHeader", "Out_RequestIdLoanId")
            };
            //ViewState - Group: Pestaña para InfocredHeader
            $scope.vc.createViewState({
                id: "GR_CEDNAGMTIE21_08",
                hasId: true,
                componentStyle: "",
                label: 'Pesta\u00f1a para InfocredHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: CustomerName
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2108_CTOM392",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CLIENTZXD_06072",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: ExpirationDate
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2108_EIRT835",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOTOADINF_06914",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: Count
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2108_COUN308",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: CustomerId
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2108_CTME537",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BUSCARGJN_88350",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: AssociateTo
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2108_0000798",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LIMPIARXK_60736",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Pestaña para Asociar Reporte
            $scope.vc.createViewState({
                id: "GR_CEDNAGMTIE21_05",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PTEIOCRED_97562",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: AssociateTo
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2105_TYPE927",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASOCIARAP_49067",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CEDNAGMTIE2105_TYPE927 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CEDNAGMTIE2105_TYPE927', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CEDNAGMTIE2105_TYPE927'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CEDNAGMTIE2105_TYPE927");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: InfocredHeader, Attribute: ExistsLoanId
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2105_RUSI719",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PRAONESAD_73374",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CEDNAGMTIE2105_RUSI719 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CEDNAGMTIE2105_RUSI719', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CEDNAGMTIE2105_RUSI719'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CEDNAGMTIE2105_RUSI719");
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: InfocredHeader, Attribute: AssociateWith
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2105_SCAP360",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASOIARCON_61707",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_CEDNAGMTIE2105_SCAP360 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'O',
                            value: 'Operaci\u00f3n'
                        }, {
                            code: 'T',
                            value: 'Tr\u00e1mite'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_CEDNAGMTIE2105_SCAP360 !== "undefined") {}
            //ViewState - Entity: InfocredHeader, Attribute: NewLoanCode
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2105_ANCK440",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NRODEARCN_23846",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: NewRequestId
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2105_WEEI096",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CREDITCOD_87389",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: CustomerName
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2106_0000557",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InfocredHeader, Attribute: CustomerId
            $scope.vc.createViewState({
                id: "VA_CEDNAGMTIE2106_0000307",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ESRARINOD_66891",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Pestaña para Grid de Consulta Infocred]
            $scope.vc.createViewState({
                id: "GR_CEDNAGMTIE21_07",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_HISTIOEPE_14075",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.InfocredItem = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Date: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredItem", "Date", '')
                    },
                    Official: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredItem", "Official", '')
                    },
                    ExpirationDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredItem", "ExpirationDate", '')
                    },
                    LoanOrRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredItem", "LoanOrRequest", '')
                    },
                    Role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredItem", "Role", '')
                    },
                    Workstation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InfocredItem", "Workstation", '')
                    },
                    Code: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.InfocredItem = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_ODTEQERY_9197', function(data) {
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
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.InfocredItem
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ODTEQ9197_14").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ODTEQERY_9197 = $scope.vc.model.InfocredItem;
            $scope.vc.trackers.InfocredItem = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.InfocredItem);
            $scope.vc.model.InfocredItem.bind('change', function(e) {
                $scope.vc.trackers.InfocredItem.track(e);
            });
            $scope.vc.grids.QV_ODTEQ9197_14 = {};
            $scope.vc.grids.QV_ODTEQ9197_14.queryId = 'Q_ODTEQERY_9197';
            $scope.vc.viewState.QV_ODTEQ9197_14 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column = {};
            $scope.vc.grids.QV_ODTEQ9197_14.events = {
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
                cancel: function(e) {
                    $scope.vc.trackers.InfocredItem.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ODTEQ9197_14.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_ODTEQ9197_14");
                    var dataView = null;
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_ODTEQ9197_14.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ODTEQ9197_14.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ODTEQ9197_14.column.Date = {
                title: 'BUSIN.DLB_BUSIN_ECHADNUTA_66896',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CEDNAGMTIE2107_DATE657',
                element: []
            };
            $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251DATE03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Date.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CEDNAGMTIE2107_DATE657",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_ODTEQ9197_14.column.Date.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_CEDNAGMTIE21_17,2",
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Date.enabled",
                        'ng-class': "vc.viewState.QV_ODTEQ9197_14.column.Date.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column.Official = {
                title: 'BUSIN.DLB_BUSIN_OFFICIALR_02742',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CEDNAGMTIE2107_CIAL111',
                element: []
            };
            $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251CIAL87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Official.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CEDNAGMTIE2107_CIAL111",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ODTEQ9197_14.column.Official.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_CEDNAGMTIE21_17,2",
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Official.enabled",
                        'ng-class': "vc.viewState.QV_ODTEQ9197_14.column.Official.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate = {
                title: 'BUSIN.DLB_BUSIN_AESDECORE_80847',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CEDNAGMTIE2107_PRTE746',
                element: []
            };
            $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251PRTE51 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CEDNAGMTIE2107_PRTE746",
                        'maxlength': 7,
                        'data-validation-code': "{{vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_CEDNAGMTIE21_17,2",
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.enabled",
                        'ng-class': "vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest = {
                title: 'BUSIN.DLB_BUSIN_RSLCUOERC_87777',
                titleArgs: {},
                tooltip: '',
                width: 170,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CEDNAGMTIE2107_ANUS811',
                element: []
            };
            $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251ANUS43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CEDNAGMTIE2107_ANUS811",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_CEDNAGMTIE21_17,2",
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.enabled",
                        'ng-class': "vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column.Role = {
                title: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                titleArgs: {},
                tooltip: '',
                width: 160,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CEDNAGMTIE2107_ROLE431',
                element: []
            };
            $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251ROLE95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Role.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CEDNAGMTIE2107_ROLE431",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_ODTEQ9197_14.column.Role.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_CEDNAGMTIE21_17,2",
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Role.enabled",
                        'ng-class': "vc.viewState.QV_ODTEQ9197_14.column.Role.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column.Workstation = {
                title: 'BUSIN.DLB_BUSIN_TERMINALT_09551',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CEDNAGMTIE2107_OTAN700',
                element: []
            };
            $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251OTAN35 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Workstation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CEDNAGMTIE2107_OTAN700",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_ODTEQ9197_14.column.Workstation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_CEDNAGMTIE21_17,2",
                        'ng-disabled': "!vc.viewState.QV_ODTEQ9197_14.column.Workstation.enabled",
                        'ng-class': "vc.viewState.QV_ODTEQ9197_14.column.Workstation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ODTEQ9197_14.column.Code = {
                title: 'Code',
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
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    field: 'Date',
                    title: '{{vc.viewState.QV_ODTEQ9197_14.column.Date.title|translate:vc.viewState.QV_ODTEQ9197_14.column.Date.titleArgs}}',
                    width: $scope.vc.viewState.QV_ODTEQ9197_14.column.Date.width,
                    format: $scope.vc.viewState.QV_ODTEQ9197_14.column.Date.format,
                    editor: $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251DATE03.control,
                    template: "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.Date.element[dataItem.uid].style'>#if (Date !== null) {# #=Date# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ODTEQ9197_14.column.Date.style",
                        "title": "{{vc.viewState.QV_ODTEQ9197_14.column.Date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ODTEQ9197_14.column.Date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    field: 'Official',
                    title: '{{vc.viewState.QV_ODTEQ9197_14.column.Official.title|translate:vc.viewState.QV_ODTEQ9197_14.column.Official.titleArgs}}',
                    width: $scope.vc.viewState.QV_ODTEQ9197_14.column.Official.width,
                    format: $scope.vc.viewState.QV_ODTEQ9197_14.column.Official.format,
                    editor: $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251CIAL87.control,
                    template: "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.Official.element[dataItem.uid].style'>#if (Official !== null) {# #=Official# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ODTEQ9197_14.column.Official.style",
                        "title": "{{vc.viewState.QV_ODTEQ9197_14.column.Official.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ODTEQ9197_14.column.Official.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    field: 'ExpirationDate',
                    title: '{{vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.title|translate:vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.width,
                    format: $scope.vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.format,
                    editor: $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251PRTE51.control,
                    template: "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.element[dataItem.uid].style'>#if (ExpirationDate !== null) {# #=ExpirationDate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.style",
                        "title": "{{vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ODTEQ9197_14.column.ExpirationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    field: 'LoanOrRequest',
                    title: '{{vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.title|translate:vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.width,
                    format: $scope.vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.format,
                    editor: $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251ANUS43.control,
                    template: "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.element[dataItem.uid].style'>#if (LoanOrRequest !== null) {# #=LoanOrRequest# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.style",
                        "title": "{{vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ODTEQ9197_14.column.LoanOrRequest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    field: 'Role',
                    title: '{{vc.viewState.QV_ODTEQ9197_14.column.Role.title|translate:vc.viewState.QV_ODTEQ9197_14.column.Role.titleArgs}}',
                    width: $scope.vc.viewState.QV_ODTEQ9197_14.column.Role.width,
                    format: $scope.vc.viewState.QV_ODTEQ9197_14.column.Role.format,
                    editor: $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251ROLE95.control,
                    template: "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.Role.element[dataItem.uid].style'>#if (Role !== null) {# #=Role# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ODTEQ9197_14.column.Role.style",
                        "title": "{{vc.viewState.QV_ODTEQ9197_14.column.Role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ODTEQ9197_14.column.Role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    field: 'Workstation',
                    title: '{{vc.viewState.QV_ODTEQ9197_14.column.Workstation.title|translate:vc.viewState.QV_ODTEQ9197_14.column.Workstation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ODTEQ9197_14.column.Workstation.width,
                    format: $scope.vc.viewState.QV_ODTEQ9197_14.column.Workstation.format,
                    editor: $scope.vc.grids.QV_ODTEQ9197_14.AT_INF251OTAN35.control,
                    template: "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.Workstation.element[dataItem.uid].style'>#if (Workstation !== null) {# #=Workstation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ODTEQ9197_14.column.Workstation.style",
                        "title": "{{vc.viewState.QV_ODTEQ9197_14.column.Workstation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ODTEQ9197_14.column.Workstation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_ODTEQ9197_14.column.VA_CEDNAGMTIE2107_TEOD048 = {
                    tooltip: 'BUSIN.DLB_BUSIN_PTEIOCRED_97562',
                    imageId: 'glyphicon glyphicon-print',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                };
                $scope.vc.grids.QV_ODTEQ9197_14.columns.push({
                    command: {
                        name: "VA_CEDNAGMTIE2107_TEOD048",
                        entity: "InfocredItem",
                        text: "{{'DSGNR.SYS_DSGNR_LBLESTETQ_00024'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'cb-btn-custom-imprimir':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_CEDNAGMTIE2107_TEOD048\", " + "vc.viewState.QV_ODTEQ9197_14.column.VA_CEDNAGMTIE2107_TEOD048.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_ODTEQ9197_14.column.VA_CEDNAGMTIE2107_TEOD048.enabled' " + "data-ng-click = 'vc.grids.QV_ODTEQ9197_14.events.customRowClick($event, \"VA_CEDNAGMTIE2107_TEOD048\", \"#:entity#\", \"QV_ODTEQ9197_14\")' " + "title = \"{{vc.viewState.QV_ODTEQ9197_14.column.VA_CEDNAGMTIE2107_TEOD048.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_ODTEQ9197_14.column.VA_CEDNAGMTIE2107_TEOD048.imageId'></span>" + "</a>"
                    },
                    width: 30,
                    attributes: {
                        "class": "btn-toolbar"
                    }
                });
            }
            $scope.vc.viewState.QV_ODTEQ9197_14.toolbar = {}
            $scope.vc.grids.QV_ODTEQ9197_14.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_10_IDMEN42_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_10_IDMEN42_CANCEL",
                componentStyle: "",
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
                    $scope.vc.catalogs.VA_CEDNAGMTIE2105_SCAP360.read();
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
                $scope.vc.render('VC_IDMEN42_NRTFR_390');
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
    var cobisMainModule = cobis.createModule("VC_IDMEN42_NRTFR_390", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_IDMEN42_NRTFR_390", {
            templateUrl: "VC_IDMEN42_NRTFR_390_FORM.html",
            controller: "VC_IDMEN42_NRTFR_390_CTRL",
            label: "InfocredManagementForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_IDMEN42_NRTFR_390?" + $.param(search);
            }
        });
        VC_IDMEN42_NRTFR_390(cobisMainModule);
    }]);
} else {
    VC_IDMEN42_NRTFR_390(cobisMainModule);
}