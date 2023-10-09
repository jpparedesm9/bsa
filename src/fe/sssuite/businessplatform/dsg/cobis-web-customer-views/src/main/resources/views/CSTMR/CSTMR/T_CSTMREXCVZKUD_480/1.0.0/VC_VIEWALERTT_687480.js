//Designer Generator v 6.3.6 - release SPR 2018-04 28/02/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.viewalertsform = designerEvents.api.viewalertsform || designer.dsgEvents();

function VC_VIEWALERTT_687480(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_VIEWALERTT_687480_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_VIEWALERTT_687480_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CSTMREXCVZKUD_480",
            taskVersion: "1.0.0",
            viewContainerId: "VC_VIEWALERTT_687480",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMREXCVZKUD_480",
        designerEvents.api.viewalertsform,
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
                vcName: 'VC_VIEWALERTT_687480'
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
                    taskId: 'T_CSTMREXCVZKUD_480',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    HeaderWarningRisk: "HeaderWarningRisk",
                    WarningRisk: "WarningRisk"
                },
                entities: {
                    HeaderWarningRisk: {
                        startDate: 'AT29_STARTDEE788',
                        finishDate: 'AT68_FINISHEE788',
                        typeAlert: 'AT85_TYPEALEE788',
                        _pks: [],
                        _entityId: 'EN_HEADERWKR_788',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarningRisk: {
                        observations: 'AT10_OBSERVIT699',
                        riskLevel: 'AT12_RISKLEEL699',
                        customerCode: 'AT16_CUSTOMDE699',
                        office: 'AT18_OFFICEUF699',
                        alertType: 'AT23_ALERTTYY699',
                        consultDate: 'AT23_CONSULDE699',
                        amount: 'AT24_AMOUNTYB699',
                        operationType: 'AT32_OPERATOE699',
                        contract: 'AT33_CONTRACT699',
                        productType: 'AT38_PRODUCPY699',
                        stage: 'AT40_STAGEYYM699',
                        customerName: 'AT41_CUSTOMEE699',
                        etiquet: 'AT46_ETIQUETT699',
                        groupName: 'AT48_GROUPNME699',
                        dictatesDate: 'AT54_DICTATAD699',
                        customerRFC: 'AT58_CUSTOMRR699',
                        listType: 'AT67_LISTTYEE699',
                        alertDate: 'AT69_ALERTDAE699',
                        alertCode: 'AT79_ALERTCED699',
                        generateReports: 'AT81_GENERAEE699',
                        operationDate: 'AT82_OPERATOD699',
                        reportDate: 'AT88_REPORTTA699',
                        group: 'AT90_GROUPTBS699',
                        statusAlert: 'AT98_STATUSRE699',
                        _pks: [],
                        _entityId: 'EN_WARNINGRI_699',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_HEADERWKR_788',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_WARNINGRI_699',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT85_TYPEALEE788',
                        attributeIdFk: 'AT67_LISTTYEE699'
                    }, {
                        attributeIdPk: 'AT68_FINISHEE788',
                        attributeIdFk: 'AT23_CONSULDE699'
                    }, {
                        attributeIdPk: 'AT29_STARTDEE788',
                        attributeIdFk: 'AT69_ALERTDAE699'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_WARNINGK_3983 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_WARNINGK_3983 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_WARNINGK_3983_filters)) {
                    parametersAux = {
                        listType: $scope.vc.model.HeaderWarningRisk.typeAlert,
                        alertDate: $scope.vc.model.HeaderWarningRisk.startDate,
                        consultDate: $scope.vc.model.HeaderWarningRisk.finishDate
                    };
                } else {
                    var filters = $scope.vc.queries.Q_WARNINGK_3983_filters;
                    parametersAux = {
                        listType: filters.listType,
                        alertDate: filters.alertDate,
                        consultDate: filters.consultDate
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_WARNINGRI_699',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_WARNINGK_3983',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['listType'] = $scope.vc.model.HeaderWarningRisk.typeAlert;
                            this.parameters['alertDate'] = $scope.vc.model.HeaderWarningRisk.startDate;
                            this.parameters['consultDate'] = $scope.vc.model.HeaderWarningRisk.finishDate;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['listType'] = this.filters.listType;
                            this.parameters['alertDate'] = this.filters.alertDate;
                            this.parameters['consultDate'] = this.filters.consultDate;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_WARNINGK_3983_filters = {};
            var defaultValues = {
                HeaderWarningRisk: {},
                WarningRisk: {}
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
                $scope.vc.execute("temporarySave", VC_VIEWALERTT_687480, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_VIEWALERTT_687480, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_VIEWALERTT_687480, data, function() {});
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
            $scope.vc.viewState.VC_VIEWALERTT_687480 = {
                style: []
            }
            $scope.vc.model.HeaderWarningRisk = {
                startDate: $scope.vc.channelDefaultValues("HeaderWarningRisk", "startDate"),
                finishDate: $scope.vc.channelDefaultValues("HeaderWarningRisk", "finishDate"),
                typeAlert: $scope.vc.channelDefaultValues("HeaderWarningRisk", "typeAlert")
            };
            //ViewState - Group: Group1267
            $scope.vc.createViewState({
                id: "G_VIEWALETRS_371760",
                hasId: true,
                componentStyle: [],
                label: 'Group1267',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderWarningRisk, Attribute: startDate
            $scope.vc.createViewState({
                id: "VA_1YBAWQZVSWXAQOX_338760",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHAINIO_21965",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderWarningRisk, Attribute: finishDate
            $scope.vc.createViewState({
                id: "VA_2RGUZPZNPBRBAIO_984760",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHAFINN_38547",
                validationCode: 4,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2808",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderWarningRisk, Attribute: typeAlert
            $scope.vc.createViewState({
                id: "VA_3MKPEVSIZZHVRMB_837760",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOOPEIC_98092",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_3MKPEVSIZZHVRMB_837760 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_3MKPEVSIZZHVRMB_837760', 'cl_alertas_tlista', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_3MKPEVSIZZHVRMB_837760'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_3MKPEVSIZZHVRMB_837760");
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
            $scope.vc.createViewState({
                id: "Spacer2908",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONNUZBDYR_446760",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARPCE_34160",
                queryId: 'Q_WARNINGK_3983',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1187
            $scope.vc.createViewState({
                id: "G_VIEWALESTT_324760",
                hasId: true,
                componentStyle: [],
                label: 'Group1187',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.WarningRisk = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    alertCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "alertCode", 0),
                        validation: {
                            alertCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    office: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "office", '')
                    },
                    group: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "group", '')
                    },
                    groupName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "groupName", '')
                    },
                    customerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "customerCode", 0)
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "customerName", '')
                    },
                    customerRFC: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "customerRFC", '')
                    },
                    contract: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "contract", '')
                    },
                    productType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "productType", '')
                    },
                    listType: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderWarningRisk.typeAlert
                        }
                    },
                    consultDate: {
                        type: "date",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderWarningRisk.finishDate
                        }
                    },
                    alertDate: {
                        type: "date",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.HeaderWarningRisk.startDate
                        }
                    },
                    operationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "operationDate", new Date())
                    },
                    dictatesDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "dictatesDate", new Date())
                    },
                    reportDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "reportDate", new Date())
                    },
                    riskLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "riskLevel", '')
                    },
                    etiquet: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "etiquet", '')
                    },
                    stage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "stage", '')
                    },
                    alertType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "alertType", '')
                    },
                    operationType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "operationType", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "amount", 0)
                    },
                    statusAlert: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "statusAlert", '')
                    },
                    observations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "observations", '')
                    },
                    generateReports: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarningRisk", "generateReports", '')
                    }
                }
            });
            $scope.vc.model.WarningRisk = new kendo.data.DataSource({
                pageSize: 25,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_WARNINGK_3983';
                            var queryRequest = $scope.vc.getRequestQuery_Q_WARNINGK_3983();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3983_71432',
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
                                            'pageSize': 25
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
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Insert,
                            nameEntityGrid: 'WarningRisk'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_3983_71432', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'WarningRisk',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_3983_71432', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                                    nameEntityGrid: 'WarningRisk'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_3983_71432', argsAfterLeave);
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
                    model: $scope.vc.types.WarningRisk
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3983_71432").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_WARNINGK_3983 = $scope.vc.model.WarningRisk;
            $scope.vc.trackers.WarningRisk = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.WarningRisk);
            $scope.vc.model.WarningRisk.bind('change', function(e) {
                $scope.vc.trackers.WarningRisk.track(e);
            });
            $scope.vc.grids.QV_3983_71432 = {};
            $scope.vc.grids.QV_3983_71432.queryId = 'Q_WARNINGK_3983';
            $scope.vc.viewState.QV_3983_71432 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3983_71432.column = {};
            $scope.vc.grids.QV_3983_71432.editable = {
                mode: 'inline',
            };
            $scope.vc.grids.QV_3983_71432.events = {
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
                        taskId: "T_CSTMRVFHHHDDJ_341",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_VIEWALERES_934341',
                        title: 'CSTMR.LBL_CSTMR_EDITAROAB_29013',
                        size: 'md'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_3983_71432", dialogParameters);
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
                        nameEntityGrid: 'WarningRisk',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_3983_71432", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_3983_71432");
                    $scope.vc.hideShowColumns("QV_3983_71432", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3983_71432.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3983_71432.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3983_71432.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3983_71432 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3983_71432 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_3983_71432.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3983_71432.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3983_71432.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3983_71432.column.alertCode = {
                title: 'CSTMR.LBL_CSTMR_CDIGOXSPA_62229',
                titleArgs: {},
                tooltip: '',
                width: 75,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "#####",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXJXM_859760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.office = {
                title: 'CSTMR.LBL_CSTMR_SUCURSALL_84584',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYDF_740760',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXYDF_740760 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXYDF_740760',
                            'cl_oficina',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXYDF_740760'];
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
            $scope.vc.viewState.QV_3983_71432.column.group = {
                title: 'CSTMR.LBL_CSTMR_GRUPOLTEO_59049',
                titleArgs: {},
                tooltip: '',
                width: 75,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAQY_659760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.groupName = {
                title: 'CSTMR.LBL_CSTMR_NOMBREDOE_65038',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRCS_385760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.customerCode = {
                title: 'CSTMR.LBL_CSTMR_CDIGOCLNE_10968',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFRM_710760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.customerName = {
                title: 'CSTMR.LBL_CSTMR_NOMBREDLE_32680',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQVT_735760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.customerRFC = {
                title: 'CSTMR.LBL_CSTMR_RFCCGUEPZ_59640',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXWW_675760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.contract = {
                title: 'CSTMR.LBL_CSTMR_CONTRATOO_43641',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWTC_733760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.productType = {
                title: 'CSTMR.LBL_CSTMR_TIPOPRODD_73868',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPXA_672760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.listType = {
                title: 'CSTMR.LBL_CSTMR_TIPOLISTA_17556',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKFW_501760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.consultDate = {
                title: 'CSTMR.LBL_CSTMR_FECHADTWY_31751',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDDQVOLN_331760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.alertDate = {
                title: 'CSTMR.LBL_CSTMR_FECHAALRE_71097',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDIPUFMJ_657760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.operationDate = {
                title: 'CSTMR.LBL_CSTMR_FECHAOPRC_77084',
                titleArgs: {},
                tooltip: '',
                width: 170,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDNVYCNY_101760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.dictatesDate = {
                title: 'CSTMR.LBL_CSTMR_FECHADITA_99278',
                titleArgs: {},
                tooltip: '',
                width: 170,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDXBIRHA_608760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.reportDate = {
                title: 'CSTMR.LBL_CSTMR_FECHAREPP_53187',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDFRKYAZ_628760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.riskLevel = {
                title: 'CSTMR.LBL_CSTMR_NIVELRISE_12098',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIIB_706760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.etiquet = {
                title: 'CSTMR.LBL_CSTMR_ETIQUETAA_56083',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWUC_757760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.stage = {
                title: 'CSTMR.LBL_CSTMR_ESCENARII_55664',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZXE_258760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.alertType = {
                title: 'CSTMR.LBL_CSTMR_TIPOALEAA_17044',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNZX_699760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.operationType = {
                title: 'CSTMR.LBL_CSTMR_TIPOOPERR_94414',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLFQ_818760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.amount = {
                title: 'CSTMR.LBL_CSTMR_MONTOGYAQ_68531',
                titleArgs: {},
                tooltip: '',
                width: 170,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNCE_504760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.statusAlert = {
                title: 'CSTMR.LBL_CSTMR_ESTATUSQO_78542',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBZI_516760',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXBZI_516760 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXBZI_516760',
                            'cl_estado_alerta',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXBZI_516760'];
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
            $scope.vc.viewState.QV_3983_71432.column.observations = {
                title: 'CSTMR.LBL_CSTMR_OBSERVACE_30841',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWBE_947760',
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.generateReports = {
                title: 'CSTMR.LBL_CSTMR_GENERAROP_81309',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGAZ_428760',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXGAZ_428760 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXGAZ_428760.data([{
                code: 'S',
                value: 'SI'
            }, {
                code: 'N',
                value: 'NO'
            }]);
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'alertCode',
                    title: '{{vc.viewState.QV_3983_71432.column.alertCode.title|translate:vc.viewState.QV_3983_71432.column.alertCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.alertCode.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.alertCode.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.alertCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.alertCode, \"QV_3983_71432\", \"alertCode\"):kendo.toString(#=alertCode#, vc.viewState.QV_3983_71432.column.alertCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3983_71432.column.alertCode.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.alertCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.alertCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'office',
                    title: '{{vc.viewState.QV_3983_71432.column.office.title|translate:vc.viewState.QV_3983_71432.column.office.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.office.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.office.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.office.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXYDF_740760.get(dataItem.office).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.office.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.office.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.office.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'group',
                    title: '{{vc.viewState.QV_3983_71432.column.group.title|translate:vc.viewState.QV_3983_71432.column.group.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.group.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.group.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.group.style' ng-bind='vc.getStringColumnFormat(dataItem.group, \"QV_3983_71432\", \"group\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.group.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.group.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.group.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'groupName',
                    title: '{{vc.viewState.QV_3983_71432.column.groupName.title|translate:vc.viewState.QV_3983_71432.column.groupName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.groupName.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.groupName.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.groupName.style' ng-bind='vc.getStringColumnFormat(dataItem.groupName, \"QV_3983_71432\", \"groupName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.groupName.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.groupName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.groupName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'customerCode',
                    title: '{{vc.viewState.QV_3983_71432.column.customerCode.title|translate:vc.viewState.QV_3983_71432.column.customerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.customerCode.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.customerCode.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.customerCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerCode, \"QV_3983_71432\", \"customerCode\"):kendo.toString(#=customerCode#, vc.viewState.QV_3983_71432.column.customerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3983_71432.column.customerCode.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.customerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.customerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_3983_71432.column.customerName.title|translate:vc.viewState.QV_3983_71432.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.customerName.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.customerName.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_3983_71432\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.customerName.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'customerRFC',
                    title: '{{vc.viewState.QV_3983_71432.column.customerRFC.title|translate:vc.viewState.QV_3983_71432.column.customerRFC.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.customerRFC.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.customerRFC.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.customerRFC.style' ng-bind='vc.getStringColumnFormat(dataItem.customerRFC, \"QV_3983_71432\", \"customerRFC\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.customerRFC.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.customerRFC.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.customerRFC.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'contract',
                    title: '{{vc.viewState.QV_3983_71432.column.contract.title|translate:vc.viewState.QV_3983_71432.column.contract.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.contract.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.contract.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.contract.style' ng-bind='vc.getStringColumnFormat(dataItem.contract, \"QV_3983_71432\", \"contract\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.contract.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.contract.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.contract.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'productType',
                    title: '{{vc.viewState.QV_3983_71432.column.productType.title|translate:vc.viewState.QV_3983_71432.column.productType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.productType.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.productType.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.productType.style' ng-bind='vc.getStringColumnFormat(dataItem.productType, \"QV_3983_71432\", \"productType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.productType.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.productType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.productType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'listType',
                    title: '{{vc.viewState.QV_3983_71432.column.listType.title|translate:vc.viewState.QV_3983_71432.column.listType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.listType.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.listType.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.listType.style' ng-bind='vc.getStringColumnFormat(dataItem.listType, \"QV_3983_71432\", \"listType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.listType.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.listType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.listType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'consultDate',
                    title: '{{vc.viewState.QV_3983_71432.column.consultDate.title|translate:vc.viewState.QV_3983_71432.column.consultDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.consultDate.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.consultDate.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.consultDate.style'>#=((consultDate !== null) ? kendo.toString(consultDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.consultDate.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.consultDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.consultDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'alertDate',
                    title: '{{vc.viewState.QV_3983_71432.column.alertDate.title|translate:vc.viewState.QV_3983_71432.column.alertDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.alertDate.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.alertDate.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.alertDate.style'>#=((alertDate !== null) ? kendo.toString(alertDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.alertDate.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.alertDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.alertDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'operationDate',
                    title: '{{vc.viewState.QV_3983_71432.column.operationDate.title|translate:vc.viewState.QV_3983_71432.column.operationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.operationDate.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.operationDate.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.operationDate.style'>#=((operationDate !== null) ? kendo.toString(operationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.operationDate.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.operationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.operationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'dictatesDate',
                    title: '{{vc.viewState.QV_3983_71432.column.dictatesDate.title|translate:vc.viewState.QV_3983_71432.column.dictatesDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.dictatesDate.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.dictatesDate.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.dictatesDate.style'>#=((dictatesDate !== null) ? kendo.toString(dictatesDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.dictatesDate.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.dictatesDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.dictatesDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'reportDate',
                    title: '{{vc.viewState.QV_3983_71432.column.reportDate.title|translate:vc.viewState.QV_3983_71432.column.reportDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.reportDate.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.reportDate.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.reportDate.style'>#=((reportDate !== null) ? kendo.toString(reportDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.reportDate.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.reportDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.reportDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'riskLevel',
                    title: '{{vc.viewState.QV_3983_71432.column.riskLevel.title|translate:vc.viewState.QV_3983_71432.column.riskLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.riskLevel.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.riskLevel.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.riskLevel.style' ng-bind='vc.getStringColumnFormat(dataItem.riskLevel, \"QV_3983_71432\", \"riskLevel\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.riskLevel.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.riskLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.riskLevel.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'etiquet',
                    title: '{{vc.viewState.QV_3983_71432.column.etiquet.title|translate:vc.viewState.QV_3983_71432.column.etiquet.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.etiquet.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.etiquet.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.etiquet.style' ng-bind='vc.getStringColumnFormat(dataItem.etiquet, \"QV_3983_71432\", \"etiquet\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.etiquet.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.etiquet.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.etiquet.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'stage',
                    title: '{{vc.viewState.QV_3983_71432.column.stage.title|translate:vc.viewState.QV_3983_71432.column.stage.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.stage.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.stage.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.stage.style' ng-bind='vc.getStringColumnFormat(dataItem.stage, \"QV_3983_71432\", \"stage\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.stage.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.stage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.stage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'alertType',
                    title: '{{vc.viewState.QV_3983_71432.column.alertType.title|translate:vc.viewState.QV_3983_71432.column.alertType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.alertType.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.alertType.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.alertType.style' ng-bind='vc.getStringColumnFormat(dataItem.alertType, \"QV_3983_71432\", \"alertType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.alertType.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.alertType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.alertType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'operationType',
                    title: '{{vc.viewState.QV_3983_71432.column.operationType.title|translate:vc.viewState.QV_3983_71432.column.operationType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.operationType.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.operationType.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.operationType.style' ng-bind='vc.getStringColumnFormat(dataItem.operationType, \"QV_3983_71432\", \"operationType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.operationType.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.operationType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.operationType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_3983_71432.column.amount.title|translate:vc.viewState.QV_3983_71432.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.amount.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.amount.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_3983_71432\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_3983_71432.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3983_71432.column.amount.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.amount.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'statusAlert',
                    title: '{{vc.viewState.QV_3983_71432.column.statusAlert.title|translate:vc.viewState.QV_3983_71432.column.statusAlert.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.statusAlert.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.statusAlert.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.statusAlert.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXBZI_516760.get(dataItem.statusAlert).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.statusAlert.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.statusAlert.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.statusAlert.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'observations',
                    title: '{{vc.viewState.QV_3983_71432.column.observations.title|translate:vc.viewState.QV_3983_71432.column.observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.observations.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.observations.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.observations.style' ng-bind='vc.getStringColumnFormat(dataItem.observations, \"QV_3983_71432\", \"observations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.observations.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.observations.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3983_71432.columns.push({
                    field: 'generateReports',
                    title: '{{vc.viewState.QV_3983_71432.column.generateReports.title|translate:vc.viewState.QV_3983_71432.column.generateReports.titleArgs}}',
                    width: $scope.vc.viewState.QV_3983_71432.column.generateReports.width,
                    format: $scope.vc.viewState.QV_3983_71432.column.generateReports.format,
                    template: "<span ng-class='vc.viewState.QV_3983_71432.column.generateReports.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXGAZ_428760.get(dataItem.generateReports).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3983_71432.column.generateReports.style",
                        "title": "{{vc.viewState.QV_3983_71432.column.generateReports.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3983_71432.column.generateReports.hidden
                });
            }
            $scope.vc.viewState.QV_3983_71432.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_3983_71432.column.cmdEdition = {};
            $scope.vc.viewState.QV_3983_71432.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_3983_71432.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "WarningRisk",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_3983_71432.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_3983_71432.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_VIEWALESTT_324760.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_3983_71432.events.customEdit($event, \"#:entity#\", grids.QV_3983_71432)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_3983_71432.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_3983_71432.toolbar = {}
            $scope.vc.grids.QV_3983_71432.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMREXCVZKUD_480_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMREXCVZKUD_480_CANCEL",
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
                    $scope.vc.catalogs.VA_TEXTINPUTBOXYDF_740760.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXBZI_516760.read();
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
                $scope.vc.render('VC_VIEWALERTT_687480');
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
    var cobisMainModule = cobis.createModule("VC_VIEWALERTT_687480", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_VIEWALERTT_687480", {
            templateUrl: "VC_VIEWALERTT_687480_FORM.html",
            controller: "VC_VIEWALERTT_687480_CTRL",
            labelId: "CSTMR.LBL_CSTMR_ALERTARIO_91611",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_VIEWALERTT_687480?" + $.param(search);
            }
        });
        VC_VIEWALERTT_687480(cobisMainModule);
    }]);
} else {
    VC_VIEWALERTT_687480(cobisMainModule);
}