<!-- Designer Generator v 5.0.0.1626 - release SPR 2016-26 08/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskexecutivebonusinital = designerEvents.api.taskexecutivebonusinital || designer.dsgEvents();

function VC_XCUTL59_FEUEU_964(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_XCUTL59_FEUEU_964_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_XCUTL59_FEUEU_964_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_64_XCUTL59",
            taskVersion: "1.0.0",
            viewContainerId: "VC_XCUTL59_FEUEU_964",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_64_XCUTL59",
        designerEvents.api.taskexecutivebonusinital,
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
                vcName: 'VC_XCUTL59_FEUEU_964'
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
                    taskId: 'T_FLCRE_64_XCUTL59',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ExecutiveBonusDetails: "ExecutiveBonusDetails",
                    ExecutiveBonusHeader: "ExecutiveBonusHeader"
                },
                entities: {
                    ExecutiveBonusDetails: {
                        idCode: 'AT_CUT591IDCD38',
                        idCodeDetail: 'AT_CUT591CDDE04',
                        revised: 'AT_CUT591RVIS87',
                        idofficer: 'AT_CUT591DOER38',
                        officerName: 'AT_CUT591OENM29',
                        category: 'AT_CUT591ATGY27',
                        level: 'AT_CUT591LEVE93',
                        varA1: 'AT_CUT591VRA192',
                        varA2: 'AT_CUT591VRA274',
                        varB1: 'AT_CUT591ARB158',
                        varB2: 'AT_CUT591VAR252',
                        varC: 'AT_CUT591VARC13',
                        varD1: 'AT_CUT591VARD15',
                        varD2: 'AT_CUT591ARD262',
                        varE: 'AT_CUT591VARE39',
                        total: 'AT_CUT591OTAL55',
                        totalModifyExecutive: 'AT_CUT591TICE43',
                        observation: 'AT_CUT591SEVT12',
                        portfolioBalance: 'AT_CUT591POBC24',
                        customersNumbres: 'AT_CUT591TNMS03',
                        weightedArrears: 'AT_CUT591WDRS65',
                        viewNumbers: 'AT_CUT591WNME44',
                        customerRetention: 'AT_CUT591UENN23',
                        portfolioGrowth: 'AT_CUT591OTGR81',
                        increaseCustomers: 'AT_CUT591NROS74',
                        totalPrevious: 'AT_CUT591TOTI30',
                        totalModifiedMonthPrevious: 'AT_CUT591LFOE47',
                        _pks: [],
                        _entityId: 'EN_CUTESTILS591',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    ExecutiveBonusHeader: {
                        dateProcess: 'AT_ECU953TEOE52',
                        executive: 'AT_ECU953XEIE16',
                        idSupervisor: 'AT_ECU953ISVO12',
                        idCode: 'AT_ECU953IDOD09',
                        status: 'AT_ECU953STTS98',
                        applicationNumber: 'AT_ECU953INUB53',
                        userL: 'AT_ECU953USRL86',
                        _pks: [],
                        _entityId: 'EN_ECUTEOUER953',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.request.qr = {};
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QRYXUBON_8599 = {
                autoCrud: true
            };
            $scope.vc.queries.Q_QRYXUBON_8599 = new kendo.data.DataSource();
            $scope.vc.request.qr.Q_QRYXUBON_8599 = {
                mainEntityPk: {
                    entityId: 'EN_CUTESTILS591',
                    version: '1.0.0'
                },
                queryPk: {
                    queryId: 'Q_QRYXUBON_8599',
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
                ExecutiveBonusDetails: {},
                ExecutiveBonusHeader: {}
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
            $scope.vc.viewState.VC_XCUTL59_FEUEU_964 = {
                style: []
            }
            //ViewState - Group: Panel de Acordeón para ExecutiveBonusHeader
            $scope.vc.createViewState({
                id: "GR_EXECEBONUS69_53",
                hasId: true,
                componentStyle: "",
                label: 'Panel de Acorde\u00f3n para ExecutiveBonusHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ExecutiveBonusHeader = {
                dateProcess: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "dateProcess"),
                executive: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "executive"),
                idSupervisor: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "idSupervisor"),
                idCode: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "idCode"),
                status: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "status"),
                applicationNumber: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "applicationNumber"),
                userL: $scope.vc.channelDefaultValues("ExecutiveBonusHeader", "userL")
            };
            //ViewState - Group: Panel de Acordeón para ExecutiveBonusHeader
            $scope.vc.createViewState({
                id: "GR_EXECEBONUS69_97",
                hasId: true,
                componentStyle: "",
                label: 'Panel de Acorde\u00f3n para ExecutiveBonusHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExecutiveBonusHeader, Attribute: idCode
            $scope.vc.createViewState({
                id: "VA_EXECEBONUS6997_IDOD627",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ENTICAION_65975",
                label: "BUSIN.DLB_BUSIN_IDETFIAOR_85895",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExecutiveBonusHeader, Attribute: dateProcess
            $scope.vc.createViewState({
                id: "VA_EXECEBONUS6997_TEOE131",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ELCNAREHT_19883",
                label: "BUSIN.DLB_BUSIN_ELCNAREHT_19883",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_EXECEBONUS6997_TEOE131 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_EXECEBONUS6997_TEOE131', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_EXECEBONUS6997_TEOE131'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_EXECEBONUS6997_TEOE131");
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
            //ViewState - Entity: ExecutiveBonusHeader, Attribute: status
            $scope.vc.createViewState({
                id: "VA_EXECEBONUS6997_STTS975",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_STATUSUAS_80798",
                label: "BUSIN.DLB_BUSIN_STATUSUAS_80798",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_EXECEBONUS6997_STTS975 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_EXECEBONUS6997_STTS975', 'cr_estado_bono_ejec', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_EXECEBONUS6997_STTS975'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_EXECEBONUS6997_STTS975");
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
            //ViewState - Entity: ExecutiveBonusHeader, Attribute: applicationNumber
            $scope.vc.createViewState({
                id: "VA_EXECEBONUS6997_INUB587",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_EOSOLICID_11866",
                label: "BUSIN.DLB_BUSIN_EOSOLICID_11866",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Panel de Acordeón para ExecutiveBonusDetails
            $scope.vc.createViewState({
                id: "GR_EXECEBONUS69_55",
                hasId: true,
                componentStyle: "",
                label: 'Panel de Acorde\u00f3n para ExecutiveBonusDetails',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ExecutiveBonusDetails = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    officerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "officerName", '')
                    },
                    category: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "category", '')
                    },
                    level: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "level", '')
                    },
                    varA1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varA1", 0)
                    },
                    varA2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varA2", 0)
                    },
                    varB1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varB1", 0)
                    },
                    varB2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varB2", 0)
                    },
                    varC: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varC", 0)
                    },
                    varD1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varD1", 0)
                    },
                    varD2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varD2", 0)
                    },
                    varE: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "varE", 0)
                    },
                    total: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "total", 0)
                    },
                    totalModifyExecutive: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "totalModifyExecutive", 0)
                    },
                    totalPrevious: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "totalPrevious", 0)
                    },
                    observation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetails", "observation", '')
                    },
                    totalModifiedMonthPrevious: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.ExecutiveBonusDetails = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            $scope.vc.CRUDExecuteQuery('Q_QRYXUBON_8599', function(data) {
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ExecutiveBonusDetails',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QRYXU8599_55', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.ExecutiveBonusDetails
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QRYXU8599_55").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QRYXUBON_8599 = $scope.vc.model.ExecutiveBonusDetails;
            $scope.vc.trackers.ExecutiveBonusDetails = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ExecutiveBonusDetails);
            $scope.vc.model.ExecutiveBonusDetails.bind('change', function(e) {
                $scope.vc.trackers.ExecutiveBonusDetails.track(e);
            });
            $scope.vc.grids.QV_QRYXU8599_55 = {};
            $scope.vc.grids.QV_QRYXU8599_55.queryId = 'Q_QRYXUBON_8599';
            $scope.vc.viewState.QV_QRYXU8599_55 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column = {};
            $scope.vc.grids.QV_QRYXU8599_55.events = {
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
                    $scope.vc.trackers.ExecutiveBonusDetails.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QRYXU8599_55.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QRYXU8599_55");
                    var dataView = null;
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_QRYXU8599_55.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QRYXU8599_55.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_QRYXU8599_55.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "ExecutiveBonusDetails",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_QRYXU8599_55", args);
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
            $scope.vc.grids.QV_QRYXU8599_55.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QRYXU8599_55.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QRYXU8599_55.column.officerName = {
                title: 'BUSIN.DLB_BUSIN_OFFICERAT_46633',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_OFFICERAT_46633',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_OENM952',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591OENM29 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.officerName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_OFFICERAT_46633'|translate}}",
                        'id': "VA_EXECEBONUS6955_OENM952",
                        'maxlength': 200,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.officerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.officerName.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.officerName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.category = {
                title: 'BUSIN.DLB_BUSIN_CATEGORIA_76845',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CATEGORIA_76845',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_ATGY421',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_EXECEBONUS6955_ATGY421 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_EXECEBONUS6955_ATGY421_values)) {
                            $scope.vc.catalogs.VA_EXECEBONUS6955_ATGY421_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_EXECEBONUS6955_ATGY421',
                                'cr_categoria_oficial',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_EXECEBONUS6955_ATGY421'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_EXECEBONUS6955_ATGY421_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QRYXU8599_55", "VA_EXECEBONUS6955_ATGY421");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_EXECEBONUS6955_ATGY421_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QRYXU8599_55", "VA_EXECEBONUS6955_ATGY421");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591ATGY27 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.category.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CATEGORIA_76845'|translate}}",
                        'id': "VA_EXECEBONUS6955_ATGY421",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QRYXU8599_55.column.category.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_EXECEBONUS6955_ATGY421",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QRYXU8599_55.column.category.template",
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.category.validationCode}}",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.level = {
                title: 'BUSIN.DLB_BUSIN_LEVELDMBF_69891',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_LEVELDMBF_69891',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_LEVE193',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_EXECEBONUS6955_LEVE193 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_EXECEBONUS6955_LEVE193_values)) {
                            $scope.vc.catalogs.VA_EXECEBONUS6955_LEVE193_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_EXECEBONUS6955_LEVE193',
                                'cr_nivel_categoria',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_EXECEBONUS6955_LEVE193'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_EXECEBONUS6955_LEVE193_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QRYXU8599_55", "VA_EXECEBONUS6955_LEVE193");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_EXECEBONUS6955_LEVE193_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QRYXU8599_55", "VA_EXECEBONUS6955_LEVE193");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591LEVE93 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.level.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_LEVELDMBF_69891'|translate}}",
                        'id': "VA_EXECEBONUS6955_LEVE193",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QRYXU8599_55.column.level.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_EXECEBONUS6955_LEVE193",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QRYXU8599_55.column.level.template",
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.level.validationCode}}",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varA1 = {
                title: 'BUSIN.DLB_BUSIN_VARIABEA1_30974',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_VRA1630',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VRA192 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varA1.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_VRA1630",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varA1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varA1.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varA1.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varA1.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varA1.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varA2 = {
                title: 'BUSIN.DLB_BUSIN_ARIABLEA2_31550',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_VRA2510',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VRA274 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varA2.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_VRA2510",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varA2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varA2.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varA2.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varA2.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varA2.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varB1 = {
                title: 'BUSIN.DLB_BUSIN_VARIBLEB1_15090',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_ARB1754',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591ARB158 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varB1.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_ARB1754",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varB1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varB1.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varB1.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varB1.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varB1.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varB2 = {
                title: 'BUSIN.DLB_BUSIN_VARIABEB2_52644',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_VAR2769',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VAR252 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varB2.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_VAR2769",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varB2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varB2.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varB2.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varB2.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varB2.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varC = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEC_28318',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_VARC823',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VARC13 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varC.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_VARC823",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varC.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varC.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varC.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varC.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varC.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varD1 = {
                title: 'BUSIN.DLB_BUSIN_VRIABLED1_81349',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_VARD072',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VARD15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varD1.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_VARD072",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varD1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varD1.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varD1.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varD1.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varD1.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varD2 = {
                title: 'BUSIN.DLB_BUSIN_VARIABLED_10607',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_ARD2172',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591ARD262 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varD2.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_ARD2172",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varD2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varD2.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varD2.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varD2.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varD2.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.varE = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEE_42865',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_VARE052',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VARE39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varE.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_VARE052",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.varE.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.varE.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.varE.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.varE.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.varE.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.total = {
                title: 'BUSIN.DLB_BUSIN_TOTALDXTF_64369',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_OTAL883',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591OTAL55 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.total.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_OTAL883",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.total.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.total.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.total.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.total.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.total.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive = {
                title: 'BUSIN.DLB_BUSIN_TACCNECIV_69591',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_TICE093',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591TICE43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_TICE093",
                        'maxlength': 23,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.totalPrevious = {
                title: 'BUSIN.DLB_BUSIN_ALMSNTRIO_83013',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_TOTI062',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591TOTI30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.totalPrevious.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_TOTI062",
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.totalPrevious.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYXU8599_55.column.totalPrevious.format",
                        'k-decimals': "vc.viewState.QV_QRYXU8599_55.column.totalPrevious.decimals",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.totalPrevious.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.totalPrevious.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.observation = {
                title: 'BUSIN.DLB_BUSIN_OBSERVACI_93291',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EXECEBONUS6955_SEVT214',
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591SEVT12 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.observation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EXECEBONUS6955_SEVT214",
                        'maxlength': 250,
                        'data-validation-code': "{{vc.viewState.QV_QRYXU8599_55.column.observation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EXECEBONUS69_53,1",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.observation.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.observation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious = {
                title: 'totalModifyPreviousMonth',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591LFOE47 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.enabled",
                        'ng-class': "vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'officerName',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.officerName.title|translate:vc.viewState.QV_QRYXU8599_55.column.officerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.officerName.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.officerName.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591OENM29.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.officerName.element[dataItem.uid].style'>#if (officerName !== null) {# #=officerName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.officerName.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.officerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.officerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'category',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.category.title|translate:vc.viewState.QV_QRYXU8599_55.column.category.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.category.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.category.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591ATGY27.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.category.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_EXECEBONUS6955_ATGY421.get(dataItem.category).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.category.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.category.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.category.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'level',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.level.title|translate:vc.viewState.QV_QRYXU8599_55.column.level.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.level.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.level.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591LEVE93.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.level.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_EXECEBONUS6955_LEVE193.get(dataItem.level).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.level.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.level.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.level.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varA1',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varA1.title|translate:vc.viewState.QV_QRYXU8599_55.column.varA1.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varA1.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varA1.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VRA192.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varA1.element[dataItem.uid].style' ng-bind='kendo.toString(#=varA1#, vc.viewState.QV_QRYXU8599_55.column.varA1.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varA1.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varA1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varA1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varA2',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varA2.title|translate:vc.viewState.QV_QRYXU8599_55.column.varA2.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varA2.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varA2.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VRA274.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varA2.element[dataItem.uid].style' ng-bind='kendo.toString(#=varA2#, vc.viewState.QV_QRYXU8599_55.column.varA2.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varA2.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varA2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varA2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varB1',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varB1.title|translate:vc.viewState.QV_QRYXU8599_55.column.varB1.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varB1.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varB1.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591ARB158.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varB1.element[dataItem.uid].style' ng-bind='kendo.toString(#=varB1#, vc.viewState.QV_QRYXU8599_55.column.varB1.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varB1.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varB1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varB1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varB2',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varB2.title|translate:vc.viewState.QV_QRYXU8599_55.column.varB2.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varB2.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varB2.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VAR252.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varB2.element[dataItem.uid].style' ng-bind='kendo.toString(#=varB2#, vc.viewState.QV_QRYXU8599_55.column.varB2.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varB2.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varB2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varB2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varC',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varC.title|translate:vc.viewState.QV_QRYXU8599_55.column.varC.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varC.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varC.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VARC13.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varC.element[dataItem.uid].style' ng-bind='kendo.toString(#=varC#, vc.viewState.QV_QRYXU8599_55.column.varC.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varC.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varC.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varC.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varD1',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varD1.title|translate:vc.viewState.QV_QRYXU8599_55.column.varD1.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varD1.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varD1.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VARD15.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varD1.element[dataItem.uid].style' ng-bind='kendo.toString(#=varD1#, vc.viewState.QV_QRYXU8599_55.column.varD1.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varD1.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varD1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varD1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varD2',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varD2.title|translate:vc.viewState.QV_QRYXU8599_55.column.varD2.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varD2.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varD2.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591ARD262.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varD2.element[dataItem.uid].style' ng-bind='kendo.toString(#=varD2#, vc.viewState.QV_QRYXU8599_55.column.varD2.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varD2.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varD2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varD2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'varE',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.varE.title|translate:vc.viewState.QV_QRYXU8599_55.column.varE.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.varE.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.varE.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591VARE39.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.varE.element[dataItem.uid].style' ng-bind='kendo.toString(#=varE#, vc.viewState.QV_QRYXU8599_55.column.varE.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.varE.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.varE.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.varE.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'total',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.total.title|translate:vc.viewState.QV_QRYXU8599_55.column.total.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.total.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.total.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591OTAL55.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.total.element[dataItem.uid].style' ng-bind='kendo.toString(#=total#, vc.viewState.QV_QRYXU8599_55.column.total.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.total.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.total.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.total.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'totalModifyExecutive',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.title|translate:vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591TICE43.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.element[dataItem.uid].style' ng-bind='kendo.toString(#=totalModifyExecutive#, vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifyExecutive.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'totalPrevious',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.totalPrevious.title|translate:vc.viewState.QV_QRYXU8599_55.column.totalPrevious.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.totalPrevious.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.totalPrevious.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591TOTI30.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.totalPrevious.element[dataItem.uid].style' ng-bind='kendo.toString(#=totalPrevious#, vc.viewState.QV_QRYXU8599_55.column.totalPrevious.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.totalPrevious.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.totalPrevious.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.totalPrevious.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'observation',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.observation.title|translate:vc.viewState.QV_QRYXU8599_55.column.observation.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.observation.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.observation.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591SEVT12.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.observation.element[dataItem.uid].style'>#if (observation !== null) {# #=observation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.observation.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.observation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.observation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                    field: 'totalModifiedMonthPrevious',
                    title: '{{vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.title|translate:vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.width,
                    format: $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.format,
                    editor: $scope.vc.grids.QV_QRYXU8599_55.AT_CUT591LFOE47.control,
                    template: "<span ng-class='vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.element[dataItem.uid].style' ng-bind='kendo.toString(#=totalModifiedMonthPrevious#, vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.style",
                        "title": "{{vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QRYXU8599_55.column.totalModifiedMonthPrevious.hidden
                });
            }
            $scope.vc.viewState.QV_QRYXU8599_55.column.edit = {
                element: []
            };
            $scope.vc.grids.QV_QRYXU8599_55.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_QRYXU8599_55.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_QRYXU8599_55.toolbar = {}
            $scope.vc.grids.QV_QRYXU8599_55.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_64_XCUTL59_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_64_XCUTL59_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Process
            $scope.vc.createViewState({
                id: "CM_XCUTL59OCS87",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PROCESARL_81050",
                label: "BUSIN.DLB_BUSIN_PROCESARL_81050",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_EXECEBONUS6955_ATGY421.read();
                    $scope.vc.catalogs.VA_EXECEBONUS6955_LEVE193.read();
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
                $scope.vc.render('VC_XCUTL59_FEUEU_964');
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
    var cobisMainModule = cobis.createModule("VC_XCUTL59_FEUEU_964", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_XCUTL59_FEUEU_964", {
            templateUrl: "VC_XCUTL59_FEUEU_964_FORM.html",
            controller: "VC_XCUTL59_FEUEU_964_CTRL",
            label: "formExecutiveBonus",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_XCUTL59_FEUEU_964?" + $.param(search);
            }
        });
        VC_XCUTL59_FEUEU_964(cobisMainModule);
    }]);
} else {
    VC_XCUTL59_FEUEU_964(cobisMainModule);
}