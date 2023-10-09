<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tasksearcheconomicactivity = designerEvents.api.tasksearcheconomicactivity || designer.dsgEvents();

function VC_CCOVI89_AECIT_172(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CCOVI89_AECIT_172_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CCOVI89_AECIT_172_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_00_CCOVI89",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CCOVI89_AECIT_172",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_00_CCOVI89",
        designerEvents.api.tasksearcheconomicactivity,
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
                vcName: 'VC_CCOVI89_AECIT_172'
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
                    taskId: 'T_FLCRE_00_CCOVI89',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    economicActivity: "economicActivity",
                    economicActivityFilter: "economicActivityFilter"
                },
                entities: {
                    economicActivity: {
                        codeEconomicActivity: 'AT_CNO771EEOI57',
                        sector: 'AT_CNO771SETR24',
                        subSector: 'AT_CNO771USET12',
                        economicActivity: 'AT_CNO771ENAI25',
                        ecSubActivity: 'AT_CNO771ESCY21',
                        clarificationFIE: 'AT_CNO771ATIO24',
                        codeSubActivity: 'AT_CNO771ODSY22',
                        codeSector: 'AT_CNO771DCTO30',
                        codeSubsector: 'AT_CNO771OSUC09',
                        _pks: [],
                        _entityId: 'EN_CNOMACIVI771',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    economicActivityFilter: {
                        economicSector: 'AT_MCA182CNTO56',
                        economicSubSector: 'AT_MCA182ECIS23',
                        economicActivity: 'AT_MCA182OMVT71',
                        economicSubActivity: 'AT_MCA182OBAY38',
                        clarificationFie: 'AT_MCA182CLTI45',
                        _pks: [],
                        _entityId: 'EN_MCACTIVTY182',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ECONCATI_3050 = {
                autoCrud: false
            };
            $scope.vc.queries.Q_ECONCATI_3050 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_ECONCATI_3050 = {
                mainEntityPk: {
                    entityId: 'EN_CNOMACIVI771',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_ECONCATI_3050',
                    version: '1.0.0'
                },
                parameters: {},
                filters: {},
                updateParameters: function() {
                    if ($.isEmptyObject(this.filters)) {
                        this.parameters = {};
                    } else {
                        this.parameters = {
                            sector: this.filters.sector,
                            subsector: this.filters.subsector,
                            actividadEconomica: this.filters.actividadEconomica,
                            subactividadEconomica: this.filters.subactividadEconomica,
                            AclaracionFIE: this.filters.AclaracionFIE,
                            codigoSubactividad: this.filters.codigoSubactividad,
                            codigoSectorEc: this.filters.codigoSectorEc,
                            codigoSubsectorEc: this.filters.codigoSubsectorEc,
                            codigoActividadEc: this.filters.codigoActividadEc
                        };
                    }
                }
            };
            defaultValues = {
                economicActivity: {},
                economicActivityFilter: {}
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
            $scope.vc.viewState.VC_CCOVI89_AECIT_172 = {
                style: []
            }
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_SEOOICIIIW10_02",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.economicActivityFilter = {
                economicSector: $scope.vc.channelDefaultValues("economicActivityFilter", "economicSector"),
                economicSubSector: $scope.vc.channelDefaultValues("economicActivityFilter", "economicSubSector"),
                economicActivity: $scope.vc.channelDefaultValues("economicActivityFilter", "economicActivity"),
                economicSubActivity: $scope.vc.channelDefaultValues("economicActivityFilter", "economicSubActivity"),
                clarificationFie: $scope.vc.channelDefaultValues("economicActivityFilter", "clarificationFie")
            };
            //ViewState - Group:
            $scope.vc.createViewState({
                id: "GR_SEOOICIIIW10_04",
                hasId: true,
                componentStyle: "",
                label: ' ',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: economicActivityFilter, Attribute: economicSector
            $scope.vc.createViewState({
                id: "VA_SEOOICIIIW1004_CNTO877",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SECOEOMIC_22874",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SEOOICIIIW1004_CNTO877 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SEOOICIIIW1004_CNTO877', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SEOOICIIIW1004_CNTO877'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SEOOICIIIW1004_CNTO877");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: economicActivityFilter, Attribute: economicSubSector
            $scope.vc.createViewState({
                id: "VA_SEOOICIIIW1004_ECIS128",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SSECOEOMO_44400",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SEOOICIIIW1004_ECIS128 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SEOOICIIIW1004_ECIS128', 'cl_subsector_ec', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SEOOICIIIW1004_ECIS128'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SEOOICIIIW1004_ECIS128");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: economicActivityFilter, Attribute: economicActivity
            $scope.vc.createViewState({
                id: "VA_SEOOICIIIW1004_OMVT623",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIVDECOIA_60481",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: economicActivityFilter, Attribute: economicSubActivity
            $scope.vc.createViewState({
                id: "VA_SEOOICIIIW1004_OBAY109",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CIIADCMIC_02730",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: economicActivityFilter, Attribute: clarificationFie
            $scope.vc.createViewState({
                id: "VA_SEOOICIIIW1004_CLTI565",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ALARACIFI_82775",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_SEOOICIIIW1004_0000044",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BUSCARGJN_88350",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group:
            $scope.vc.createViewState({
                id: "GR_SEOOICIIIW10_05",
                hasId: true,
                componentStyle: "",
                label: ' ',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.economicActivity = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    sector: {
                        type: "string",
                        editable: true
                    },
                    subSector: {
                        type: "string",
                        editable: true
                    },
                    economicActivity: {
                        type: "string",
                        editable: true
                    },
                    ecSubActivity: {
                        type: "string",
                        editable: true
                    },
                    clarificationFIE: {
                        type: "string",
                        editable: true
                    },
                    codeSubActivity: {
                        type: "string",
                        editable: true
                    },
                    codeSector: {
                        type: "string",
                        editable: true
                    },
                    codeSubsector: {
                        type: "string",
                        editable: true
                    },
                    codeEconomicActivity: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.economicActivity = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_ECONCATI_3050';
                            var queryRequest = $scope.vc.request.qr[queryId];
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_ECONC3050_94',
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
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.economicActivity
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ECONC3050_94").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ECONCATI_3050 = $scope.vc.model.economicActivity;
            $scope.vc.trackers.economicActivity = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.economicActivity);
            $scope.vc.model.economicActivity.bind('change', function(e) {
                $scope.vc.trackers.economicActivity.track(e);
            });
            $scope.vc.grids.QV_ECONC3050_94 = {};
            $scope.vc.grids.QV_ECONC3050_94.queryId = 'Q_ECONCATI_3050';
            $scope.vc.viewState.QV_ECONC3050_94 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ECONC3050_94.column = {};
            $scope.vc.grids.QV_ECONC3050_94.events = {
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
                    $scope.vc.trackers.economicActivity.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ECONC3050_94.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_ECONC3050_94");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_ECONC3050_94.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_ECONC3050_94.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_ECONC3050_94.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "economicActivity",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_ECONC3050_94", args);
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
            $scope.vc.grids.QV_ECONC3050_94.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ECONC3050_94.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ECONC3050_94.column.sector = {
                title: 'sector',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771SETR24 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 250,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.sector.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.sector.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.subSector = {
                title: 'subsector',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771USET12 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 250,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.subSector.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.subSector.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.economicActivity = {
                title: 'actividadEconomica',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ENAI25 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 250,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.economicActivity.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.economicActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.ecSubActivity = {
                title: 'subactividadEconomica',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ESCY21 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 250,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.ecSubActivity.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.ecSubActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.clarificationFIE = {
                title: 'AclaracionFIE',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ATIO24 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 250,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.clarificationFIE.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.clarificationFIE.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.codeSubActivity = {
                title: 'codigoSubactividad',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ODSY22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.codeSubActivity.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.codeSubActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.codeSector = {
                title: 'codigoSectorEc',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771DCTO30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.codeSector.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.codeSector.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.codeSubsector = {
                title: 'codigoSubsectorEc',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771OSUC09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.codeSubsector.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.codeSubsector.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity = {
                title: 'codigoActividadEc',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ECONC3050_94.AT_CNO771EEOI57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.enabled",
                        'ng-class': "vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'sector',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.sector.title|translate:vc.viewState.QV_ECONC3050_94.column.sector.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.sector.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.sector.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771SETR24.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.sector.element[dataItem.uid].style'>#if (sector !== null) {# #=sector# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.sector.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.sector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.sector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'subSector',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.subSector.title|translate:vc.viewState.QV_ECONC3050_94.column.subSector.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.subSector.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.subSector.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771USET12.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.subSector.element[dataItem.uid].style'>#if (subSector !== null) {# #=subSector# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.subSector.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.subSector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.subSector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'economicActivity',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.economicActivity.title|translate:vc.viewState.QV_ECONC3050_94.column.economicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.economicActivity.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.economicActivity.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ENAI25.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.economicActivity.element[dataItem.uid].style'>#if (economicActivity !== null) {# #=economicActivity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.economicActivity.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.economicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.economicActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'ecSubActivity',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.ecSubActivity.title|translate:vc.viewState.QV_ECONC3050_94.column.ecSubActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.ecSubActivity.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.ecSubActivity.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ESCY21.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.ecSubActivity.element[dataItem.uid].style'>#if (ecSubActivity !== null) {# #=ecSubActivity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.ecSubActivity.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.ecSubActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.ecSubActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'clarificationFIE',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.clarificationFIE.title|translate:vc.viewState.QV_ECONC3050_94.column.clarificationFIE.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.clarificationFIE.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.clarificationFIE.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ATIO24.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.clarificationFIE.element[dataItem.uid].style'>#if (clarificationFIE !== null) {# #=clarificationFIE# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.clarificationFIE.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.clarificationFIE.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.clarificationFIE.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'codeSubActivity',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.codeSubActivity.title|translate:vc.viewState.QV_ECONC3050_94.column.codeSubActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.codeSubActivity.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.codeSubActivity.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771ODSY22.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.codeSubActivity.element[dataItem.uid].style'>#if (codeSubActivity !== null) {# #=codeSubActivity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.codeSubActivity.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.codeSubActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.codeSubActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'codeSector',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.codeSector.title|translate:vc.viewState.QV_ECONC3050_94.column.codeSector.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.codeSector.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.codeSector.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771DCTO30.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.codeSector.element[dataItem.uid].style'>#if (codeSector !== null) {# #=codeSector# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.codeSector.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.codeSector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.codeSector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'codeSubsector',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.codeSubsector.title|translate:vc.viewState.QV_ECONC3050_94.column.codeSubsector.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.codeSubsector.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.codeSubsector.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771OSUC09.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.codeSubsector.element[dataItem.uid].style'>#if (codeSubsector !== null) {# #=codeSubsector# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.codeSubsector.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.codeSubsector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.codeSubsector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECONC3050_94.columns.push({
                    field: 'codeEconomicActivity',
                    title: '{{vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.title|translate:vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.width,
                    format: $scope.vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.format,
                    editor: $scope.vc.grids.QV_ECONC3050_94.AT_CNO771EEOI57.control,
                    template: "<span ng-class='vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.element[dataItem.uid].style'>#if (codeEconomicActivity !== null) {# #=codeEconomicActivity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.style",
                        "title": "{{vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECONC3050_94.column.codeEconomicActivity.hidden
                });
            }
            $scope.vc.viewState.QV_ECONC3050_94.toolbar = {}
            $scope.vc.grids.QV_ECONC3050_94.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_00_CCOVI89_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_00_CCOVI89_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Buscar
            $scope.vc.createViewState({
                id: "CM_CCOVI89USA97",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BUSCARGJN_88350",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_CCOVI89NAR83",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
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
                $scope.vc.render('VC_CCOVI89_AECIT_172');
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
    var cobisMainModule = cobis.createModule("VC_CCOVI89_AECIT_172", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_CCOVI89_AECIT_172", {
            templateUrl: "VC_CCOVI89_AECIT_172_FORM.html",
            controller: "VC_CCOVI89_AECIT_172_CTRL",
            labelId: "BUSIN.DLB_BUSIN_BSQCIDANM_37626",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CCOVI89_AECIT_172?" + $.param(search);
            }
        });
        VC_CCOVI89_AECIT_172(cobisMainModule);
    }]);
} else {
    VC_CCOVI89_AECIT_172(cobisMainModule);
}