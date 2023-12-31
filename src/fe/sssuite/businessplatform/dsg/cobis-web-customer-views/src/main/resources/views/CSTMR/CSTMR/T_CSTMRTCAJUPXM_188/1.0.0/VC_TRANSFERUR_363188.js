//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.transferrequestform = designerEvents.api.transferrequestform || designer.dsgEvents();

function VC_TRANSFERUR_363188(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TRANSFERUR_363188_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TRANSFERUR_363188_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CSTMRTCAJUPXM_188",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TRANSFERUR_363188",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRTCAJUPXM_188",
        designerEvents.api.transferrequestform,
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
                vcName: 'VC_TRANSFERUR_363188'
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
                    taskId: 'T_CSTMRTCAJUPXM_188',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    TransferRequest: "TransferRequest",
                    CustomerTransferRequest: "CustomerTransferRequest"
                },
                entities: {
                    TransferRequest: {
                        officialOriginId: 'AT25_OFFICIDI439',
                        descriptionCause: 'AT27_DESCRISC439',
                        idCause: 'AT28_IDCAUSEE439',
                        isAll: 'AT36_ISALLQVB439',
                        isGroup: 'AT50_ISGROUPP439',
                        officeOriginId: 'AT51_OFFICEII439',
                        officeDestinationId: 'AT69_OFFICENO439',
                        officialDestinationId: 'AT72_OFFICIDI439',
                        marketType: 'AT82_MARKETEP439',
                        _pks: [],
                        _entityId: 'EN_TRANSFEEU_439',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CustomerTransferRequest: {
                        customerName: 'AT12_CUSTOMEM869',
                        isChecked: 'AT15_ISCHECKD869',
                        customerId: 'AT53_CUSTOMER869',
                        creditAmount: 'AT56_CREDITMT869',
                        marketType: 'AT61_MARKETEE869',
                        isGroup: 'AT69_ISGROUPP869',
                        cicles: 'AT71_CICLESAG869',
                        officeId: 'AT73_OFFICEDI869',
                        officialId: 'AT74_OFFICIII869',
                        weeksDelay: 'AT78_WEEKSDYY869',
                        registrationDate: 'AT80_REGISTRO869',
                        lastUpdateDate: 'AT82_LASTUPTT869',
                        customerStatus: 'AT95_CUSTOMTT869',
                        _pks: [],
                        _entityId: 'EN_CUSTOMENE_869',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_TRANSFEEU_439',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_CUSTOMENE_869',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '1',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT82_MARKETEP439',
                        attributeIdFk: 'AT61_MARKETEE869'
                    }, {
                        attributeIdPk: 'AT25_OFFICIDI439',
                        attributeIdFk: 'AT74_OFFICIII869'
                    }, {
                        attributeIdPk: 'AT51_OFFICEII439',
                        attributeIdFk: 'AT73_OFFICEDI869'
                    }, {
                        attributeIdPk: 'AT50_ISGROUPP439',
                        attributeIdFk: 'AT69_ISGROUPP869'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_OFFICERJ_1253 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_OFFICERJ_1253 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_OFFICERJ_1253_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_OFFICERJ_1253_filters;
                    parametersAux = {
                        idOffice: filters.idOffice
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OFFICEGPI_129',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_OFFICERJ_1253',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['idOffice'] = this.filters.idOffice;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_OFFICERJ_1253_filters = {};
            $scope.vc.queryProperties.Q_OFFICILA_1541 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_OFFICILA_1541 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_OFFICILA_1541_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_OFFICILA_1541_filters;
                    parametersAux = {
                        idOffice: filters.idOffice
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OFFICIALL_467',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_OFFICILA_1541',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['idOffice'] = this.filters.idOffice;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_OFFICILA_1541_filters = {};
            $scope.vc.queryProperties.Q_CUSTOMNS_9850 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CUSTOMNS_9850 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CUSTOMNS_9850_filters)) {
                    parametersAux = {
                        officialId: $scope.vc.model.TransferRequest.officialOriginId,
                        officeId: $scope.vc.model.TransferRequest.officeOriginId,
                        isGroup: $scope.vc.model.TransferRequest.isGroup,
                        marketType: $scope.vc.model.TransferRequest.marketType
                    };
                } else {
                    var filters = $scope.vc.queries.Q_CUSTOMNS_9850_filters;
                    parametersAux = {
                        officialId: filters.officialId,
                        officeId: filters.officeId,
                        isGroup: filters.isGroup,
                        marketType: filters.marketType
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CUSTOMENE_869',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CUSTOMNS_9850',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['officialId'] = $scope.vc.model.TransferRequest.officialOriginId;
                            this.parameters['officeId'] = $scope.vc.model.TransferRequest.officeOriginId;
                            this.parameters['isGroup'] = $scope.vc.model.TransferRequest.isGroup;
                            this.parameters['marketType'] = $scope.vc.model.TransferRequest.marketType;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['officialId'] = this.filters.officialId;
                            this.parameters['officeId'] = this.filters.officeId;
                            this.parameters['isGroup'] = this.filters.isGroup;
                            this.parameters['marketType'] = this.filters.marketType;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_CUSTOMNS_9850_filters = {};
            var defaultValues = {
                TransferRequest: {},
                CustomerTransferRequest: {}
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
                $scope.vc.execute("temporarySave", VC_TRANSFERUR_363188, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_TRANSFERUR_363188, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_TRANSFERUR_363188, data, function() {});
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
            $scope.vc.viewState.VC_TRANSFERUR_363188 = {
                style: []
            }
            //ViewState - Group: GroupLayout1723
            $scope.vc.createViewState({
                id: "G_TRANSFEREE_414231",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1723',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.TransferRequest = {
                officialOriginId: $scope.vc.channelDefaultValues("TransferRequest", "officialOriginId"),
                descriptionCause: $scope.vc.channelDefaultValues("TransferRequest", "descriptionCause"),
                idCause: $scope.vc.channelDefaultValues("TransferRequest", "idCause"),
                isAll: $scope.vc.channelDefaultValues("TransferRequest", "isAll"),
                isGroup: $scope.vc.channelDefaultValues("TransferRequest", "isGroup"),
                officeOriginId: $scope.vc.channelDefaultValues("TransferRequest", "officeOriginId"),
                officeDestinationId: $scope.vc.channelDefaultValues("TransferRequest", "officeDestinationId"),
                officialDestinationId: $scope.vc.channelDefaultValues("TransferRequest", "officialDestinationId"),
                marketType: $scope.vc.channelDefaultValues("TransferRequest", "marketType")
            };
            //ViewState - Group: Group1295
            $scope.vc.createViewState({
                id: "G_TRANSFEQSR_926231",
                hasId: true,
                componentStyle: [],
                label: 'Group1295',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TransferRequest, Attribute: isGroup
            $scope.vc.createViewState({
                id: "VA_ISGROUPLIZMPQWJ_431231",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SELECCIEO_12860",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_ISGROUPLIZMPQWJ_431231 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: $filter('translate')('CSTMR.LBL_CSTMR_GRUPORXXT_65182')
                        }, {
                            code: 'N',
                            value: $filter('translate')('CSTMR.LBL_CSTMR_PROSPECOC_35376')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_ISGROUPLIZMPQWJ_431231 !== "undefined") {}
            //ViewState - Entity: TransferRequest, Attribute: isAll
            $scope.vc.createViewState({
                id: "VA_ISALLNMRJFGEEEH_511231",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TODOSHODG_18418",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1216
            $scope.vc.createViewState({
                id: "G_TRANSFESEE_497231",
                hasId: true,
                componentStyle: [],
                label: 'Group1216',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TransferRequest, Attribute: marketType
            $scope.vc.createViewState({
                id: "VA_MARKETTYPEMWHWP_950231",
                componentStyle: [],
                tooltip: "CSTMR.LBL_CSTMR_TIPOMERDO_18900",
                label: "CSTMR.LBL_CSTMR_TIPOMERDO_18900",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_MARKETTYPEMWHWP_950231 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_MARKETTYPEMWHWP_950231', 'cl_tipo_mercado', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_MARKETTYPEMWHWP_950231'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_MARKETTYPEMWHWP_950231");
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
            //ViewState - Group: Group2668
            $scope.vc.createViewState({
                id: "G_TRANSFEURE_920231",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ORIGENPCB_70247",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TransferRequest, Attribute: officeOriginId
            $scope.vc.createViewState({
                id: "VA_OFFICEORIGINDII_127231",
                componentStyle: [],
                tooltip: "CSTMR.LBL_CSTMR_OFICINAPT_59565",
                label: "CSTMR.LBL_CSTMR_OFICINAPT_59565",
                queryId: 'Q_OFFICERJ_1253',
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.queries.Q_OFFICERJ_1253 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var requestQuery = $scope.vc.getRequestQuery_Q_OFFICERJ_1253();
                        if (angular.isDefined($scope.vc.afterInitData)) {
                            $scope.vc.executeQuery('VA_OFFICEORIGINDII_127231', requestQuery, 'EN_OFFICEGPI_129', false, function(response) {
                                if (response.success) {
                                    if (angular.isDefined(response.data['RESULTQ_OFFICERJ_1253']) && !$.isEmptyObject(response.data['RESULTQ_OFFICERJ_1253'])) {
                                        options.success(response.data['RESULTQ_OFFICERJ_1253']);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error([]);
                                }
                                $scope.vc.setComboBoxDefaultValue("VA_OFFICEORIGINDII_127231");
                            }, null, options.data.filter, 0);
                        } else {
                            options.success([]);
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICEORIGINDII_127231");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "idOffice"
                    }
                }
            });
            $scope.vc.queryProperties.Q_OFFICERJ_1253.columnIdForList = 'idOffice';
            $scope.vc.queryProperties.Q_OFFICERJ_1253.columnValueForList = 'nameOffice';
            //ViewState - Entity: TransferRequest, Attribute: officialOriginId
            $scope.vc.createViewState({
                id: "VA_OFFICIALORIGIII_648231",
                componentStyle: [],
                tooltip: "CSTMR.LBL_CSTMR_EMPLEADOO_25518",
                label: "CSTMR.LBL_CSTMR_EMPLEADOO_25518",
                queryId: 'Q_OFFICILA_1541',
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.queries.Q_OFFICILA_1541_VA_OFFICIALORIGIII_648231 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var requestQuery = $scope.vc.getRequestQuery_Q_OFFICILA_1541();
                        if (angular.isDefined(options.data.filter) && options.data.filter.filters.length === 1) {
                            requestQuery.filters = {
                                idOffice: options.data.filter.filters[0].value
                            };
                        } else if (angular.isDefined(options.data.filter) && options.data.filter.filters.length > 1) {
                            var component = $('#VA_OFFICIALORIGIII_648231');
                            var kendoComponent = component.data('kendoExtComboBox') || component.data('kendoExtDropDownList'),
                                filter;
                            angular.forEach(options.data.filter.filters, function(item, index) {
                                if ((item.field === kendoComponent.options.dataValueField || item.field === 'parentId')) {
                                    filter = item.value;
                                }
                            });
                            requestQuery.filters = {
                                idOffice: filter
                            };
                        }
                        if (angular.isDefined($scope.vc.afterInitData)) {
                            $scope.vc.executeQuery('VA_OFFICIALORIGIII_648231', requestQuery, 'EN_OFFICIALL_467', false, function(response) {
                                if (response.success) {
                                    if (angular.isDefined(response.data['RESULTQ_OFFICILA_1541']) && !$.isEmptyObject(response.data['RESULTQ_OFFICILA_1541'])) {
                                        options.success(response.data['RESULTQ_OFFICILA_1541']);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error([]);
                                }
                                $scope.vc.setComboBoxDefaultValue("VA_OFFICIALORIGIII_648231");
                            }, null, options.data.filter, 0);
                        } else {
                            options.success([]);
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICIALORIGIII_648231");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "usernameOfficial"
                    }
                }
            });
            $scope.vc.queryProperties.Q_OFFICILA_1541.columnIdForList = 'usernameOfficial';
            $scope.vc.queryProperties.Q_OFFICILA_1541.columnValueForList = 'nameOfficial';
            //ViewState - Group: Group2757
            $scope.vc.createViewState({
                id: "G_TRANSFERRT_103231",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DESTINOYF_54890",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TransferRequest, Attribute: officeDestinationId
            $scope.vc.createViewState({
                id: "VA_OFFICEDESTINAIN_779231",
                componentStyle: [],
                tooltip: "CSTMR.LBL_CSTMR_OFICINAPT_59565",
                label: "CSTMR.LBL_CSTMR_OFICINAPT_59565",
                queryId: 'Q_OFFICERJ_1253',
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.queries.Q_OFFICERJ_1253 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var requestQuery = $scope.vc.getRequestQuery_Q_OFFICERJ_1253();
                        if (angular.isDefined($scope.vc.afterInitData)) {
                            $scope.vc.executeQuery('VA_OFFICEDESTINAIN_779231', requestQuery, 'EN_OFFICEGPI_129', false, function(response) {
                                if (response.success) {
                                    if (angular.isDefined(response.data['RESULTQ_OFFICERJ_1253']) && !$.isEmptyObject(response.data['RESULTQ_OFFICERJ_1253'])) {
                                        options.success(response.data['RESULTQ_OFFICERJ_1253']);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error([]);
                                }
                                $scope.vc.setComboBoxDefaultValue("VA_OFFICEDESTINAIN_779231");
                            }, null, options.data.filter, 0);
                        } else {
                            options.success([]);
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICEDESTINAIN_779231");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "idOffice"
                    }
                }
            });
            $scope.vc.queryProperties.Q_OFFICERJ_1253.columnIdForList = 'idOffice';
            $scope.vc.queryProperties.Q_OFFICERJ_1253.columnValueForList = 'nameOffice';
            //ViewState - Entity: TransferRequest, Attribute: officialDestinationId
            $scope.vc.createViewState({
                id: "VA_OFFICIALDESTDNN_244231",
                componentStyle: [],
                tooltip: "CSTMR.LBL_CSTMR_EMPLEADOO_25518",
                label: "CSTMR.LBL_CSTMR_EMPLEADOO_25518",
                queryId: 'Q_OFFICILA_1541',
                validationCode: 96,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.queries.Q_OFFICILA_1541_VA_OFFICIALDESTDNN_244231 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var requestQuery = $scope.vc.getRequestQuery_Q_OFFICILA_1541();
                        if (angular.isDefined(options.data.filter) && options.data.filter.filters.length === 1) {
                            requestQuery.filters = {
                                idOffice: options.data.filter.filters[0].value
                            };
                        } else if (angular.isDefined(options.data.filter) && options.data.filter.filters.length > 1) {
                            var component = $('#VA_OFFICIALDESTDNN_244231');
                            var kendoComponent = component.data('kendoExtComboBox') || component.data('kendoExtDropDownList'),
                                filter;
                            angular.forEach(options.data.filter.filters, function(item, index) {
                                if ((item.field === kendoComponent.options.dataValueField || item.field === 'parentId')) {
                                    filter = item.value;
                                }
                            });
                            requestQuery.filters = {
                                idOffice: filter
                            };
                        }
                        if (angular.isDefined($scope.vc.afterInitData)) {
                            $scope.vc.executeQuery('VA_OFFICIALDESTDNN_244231', requestQuery, 'EN_OFFICIALL_467', false, function(response) {
                                if (response.success) {
                                    if (angular.isDefined(response.data['RESULTQ_OFFICILA_1541']) && !$.isEmptyObject(response.data['RESULTQ_OFFICILA_1541'])) {
                                        options.success(response.data['RESULTQ_OFFICILA_1541']);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error([]);
                                }
                                $scope.vc.setComboBoxDefaultValue("VA_OFFICIALDESTDNN_244231");
                            }, null, options.data.filter, 0);
                        } else {
                            options.success([]);
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICIALDESTDNN_244231");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "usernameOfficial"
                    }
                }
            });
            $scope.vc.queryProperties.Q_OFFICILA_1541.columnIdForList = 'usernameOfficial';
            $scope.vc.queryProperties.Q_OFFICILA_1541.columnValueForList = 'nameOfficial';
            //ViewState - Entity: TransferRequest, Attribute: idCause
            $scope.vc.createViewState({
                id: "VA_IDCAUSEQFBLDBCT_306231",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_MOTIVOKRN_30415",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_IDCAUSEQFBLDBCT_306231 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_IDCAUSEQFBLDBCT_306231', 'cr_motivo_traspaso', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_IDCAUSEQFBLDBCT_306231'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_IDCAUSEQFBLDBCT_306231");
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
            //ViewState - Entity: TransferRequest, Attribute: descriptionCause
            $scope.vc.createViewState({
                id: "VA_DESCRIPTIONCSAA_539231",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESPECIFME_15243",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONNDNEWLJ_594231",
                componentStyle: [],
                imageId: "",
                label: "CSTMR.LBL_CSTMR_BUSCARPCE_34160",
                queryId: 'Q_CUSTOMNS_9850',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2744
            $scope.vc.createViewState({
                id: "G_TRANSFERUR_637231",
                hasId: true,
                componentStyle: [],
                label: 'Group2744',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CustomerTransferRequest = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "customerId", 0)
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "customerName", '')
                    },
                    registrationDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "registrationDate", '')
                    },
                    lastUpdateDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "lastUpdateDate", '')
                    },
                    customerStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "customerStatus", '')
                    },
                    cicles: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "cicles", 0)
                    },
                    creditAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "creditAmount", 0)
                    },
                    weeksDelay: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "weeksDelay", '')
                    },
                    isChecked: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerTransferRequest", "isChecked", false)
                    },
                    officialId: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TransferRequest.officialOriginId
                        }
                    },
                    officeId: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TransferRequest.officeOriginId
                        }
                    },
                    isGroup: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TransferRequest.isGroup
                        }
                    },
                    marketType: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.TransferRequest.marketType
                        }
                    }
                }
            });
            $scope.vc.model.CustomerTransferRequest = new kendo.data.DataSource({
                pageSize: 25,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CUSTOMNS_9850';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CUSTOMNS_9850();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9850_34524',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var grid = $('#QV_9850_34524').data('kendoExtGrid');
                                            var dataGridBeforeQuerying = grid.dataSource.data();
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                if (angular.isDefined(options.data.appendRecords) && options.data.appendRecords === true) {
                                                    if (result.length > 0) {
                                                        $scope.vc.viewState.QV_9850_34524.appendRecordsButton.enabled = true;
                                                    } else {
                                                        $scope.vc.viewState.QV_9850_34524.appendRecordsButton.enabled = false;
                                                    }
                                                    $.grep(grid.dataSource.view(), function(e) {
                                                        if (e.dirty === true) {
                                                            var dataItem = grid.dataSource.getByUid(e.uid)
                                                            grid.dataSource.remove(dataItem);
                                                        }
                                                    });
                                                    result = $.merge(dataGridBeforeQuerying, result);
                                                } else if (angular.isDefined($scope.vc.viewState.QV_9850_34524.appendRecordsButton.enabled) && $scope.vc.viewState.QV_9850_34524.appendRecordsButton.enabled === false) {
                                                    $scope.vc.viewState.QV_9850_34524.appendRecordsButton.enabled = true;
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
                        var data = $scope.vc.model['CustomerTransferRequest'].data();
                        if (data.length == 1) {
                            $scope.vc.viewState.QV_9850_34524.appendRecordsButton.show = true;
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
                    model: $scope.vc.types.CustomerTransferRequest,
                    total: function(queryResults) {
                        var totalRecords = queryResults.length;
                        if (totalRecords === 0) {
                            $scope.vc.viewState.QV_9850_34524.appendRecordsButton.show = false;
                        } else {
                            $scope.vc.viewState.QV_9850_34524.appendRecordsButton.show = true;
                        }
                        return totalRecords;
                    }
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9850_34524").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CUSTOMNS_9850 = $scope.vc.model.CustomerTransferRequest;
            $scope.vc.trackers.CustomerTransferRequest = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CustomerTransferRequest);
            $scope.vc.model.CustomerTransferRequest.bind('change', function(e) {
                $scope.vc.trackers.CustomerTransferRequest.track(e);
            });
            $scope.vc.grids.QV_9850_34524 = {};
            $scope.vc.grids.QV_9850_34524.queryId = 'Q_CUSTOMNS_9850';
            $scope.vc.viewState.QV_9850_34524 = {
                style: undefined,
                appendRecordsButton: {
                    show: true,
                    enabled: true
                }
            };
            $scope.vc.viewState.QV_9850_34524.column = {};
            $scope.vc.grids.QV_9850_34524.editable = false;
            $scope.vc.grids.QV_9850_34524.events = {
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
                    $scope.vc.trackers.CustomerTransferRequest.cancelTrackedChanges(e.model);
                    var data = $scope.vc.model['CustomerTransferRequest'].data();
                    if (data.length == 1) {
                        $scope.vc.viewState.QV_9850_34524.appendRecordsButton.show = false;
                    }
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9850_34524.selectedRow = e.model;
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9850_34524");
                    $scope.vc.hideShowColumns("QV_9850_34524", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9850_34524.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9850_34524.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9850_34524.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9850_34524 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9850_34524 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isUndefined($scope.vc.grids.QV_9850_34524.nextRegisters) || $("#QV_9850_34524_appendRecordsButton").length == 0) {
                        $scope.vc.grids.QV_9850_34524.nextRegisters = angular.element(document.querySelector("#QV_9850_34524 .k-pager-wrap"));
                        var element = '&nbsp <button id="QV_9850_34524_appendRecordsButton" class="btn btn-default cb-btn-append-records" ' +
                            'ng-show="vc.viewState.QV_9850_34524.appendRecordsButton.show" ' +
                            'ng-disabled="!vc.viewState.QV_9850_34524.appendRecordsButton.enabled" ' +
                            'ng-click="vc.executeQueryAndAppendResults(vc.getRequestQuery_Q_CUSTOMNS_9850(),\'QV_9850_34524\')"><span class="glyphicon glyphicon-plus-sign"></span></button>';
                        $scope.vc.grids.QV_9850_34524.nextRegisters.append(element);
                        var appendRecButton = $("#QV_9850_34524_appendRecordsButton");
                        $compile($scope.vc.grids.QV_9850_34524.nextRegisters.contents())(appendRecButton.scope());
                        appendRecButton.scope().$apply();
                    } else {
                        if (dataView !== null) {
                            if (dataView.length == 0) {
                                $scope.vc.viewState.QV_9850_34524.appendRecordsButton.show = false;
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9850_34524.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9850_34524.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9850_34524.column.customerId = {
                title: 'CSTMR.LBL_CSTMR_IDLYODHAH_45086',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMON_774231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT53_CUSTOMER869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.customerId.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.customerName = {
                title: 'CSTMR.LBL_CSTMR_NOMBRESOQ_57455',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXECP_408231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT12_CUSTOMEM869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.customerName.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.registrationDate = {
                title: 'CSTMR.LBL_CSTMR_FECHARESO_81852',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCCQ_471231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT80_REGISTRO869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.registrationDate.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.lastUpdateDate = {
                title: 'CSTMR.LBL_CSTMR_FECHAULDD_42822',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUTR_306231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT82_LASTUPTT869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.lastUpdateDate.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.customerStatus = {
                title: 'CSTMR.LBL_CSTMR_ESTADOXKN_15577',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_COMBOBOXUWZENKI_771231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT95_CUSTOMTT869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.customerStatus.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Query,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.cicles = {
                title: 'CSTMR.LBL_CSTMR_NOCICLOSS_11016',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWWQ_231231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT71_CICLESAG869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.cicles.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.creditAmount = {
                title: 'CSTMR.LBL_CSTMR_MONTOYXRS_24647',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXULU_359231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT56_CREDITMT869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.creditAmount.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.weeksDelay = {
                title: 'CSTMR.LBL_CSTMR_ATRASOJFM_73598',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZVM_506231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT78_WEEKSDYY869 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_9850_34524.column.weeksDelay.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.isChecked = {
                title: 'CSTMR.LBL_CSTMR_SELECCIAA_21296',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXQELWHKO_910231',
                element: []
            };
            $scope.vc.grids.QV_9850_34524.AT15_ISCHECKD869 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9850_34524.column.isChecked.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_CHECKBOXQELWHKO_910231",
                        'ng-class': 'vc.viewState.QV_9850_34524.column.isChecked.element["' + options.model.uid + '"].style',
                        'ng-click': "vc.change(null,'VA_CHECKBOXQELWHKO_910231',this.dataItem,'" + options.field + "', $event.target)"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9850_34524.column.officialId = {
                title: 'officialId',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_9850_34524.column.officeId = {
                title: 'officeId',
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
            $scope.vc.viewState.QV_9850_34524.column.isGroup = {
                title: 'isGroup',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_9850_34524.column.marketType = {
                title: 'marketType',
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
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_9850_34524.column.customerId.title|translate:vc.viewState.QV_9850_34524.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.customerId.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.customerId.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT53_CUSTOMER869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_9850_34524\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_9850_34524.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9850_34524.column.customerId.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_9850_34524.column.customerName.title|translate:vc.viewState.QV_9850_34524.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.customerName.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.customerName.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT12_CUSTOMEM869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_9850_34524\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9850_34524.column.customerName.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'registrationDate',
                    title: '{{vc.viewState.QV_9850_34524.column.registrationDate.title|translate:vc.viewState.QV_9850_34524.column.registrationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.registrationDate.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.registrationDate.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT80_REGISTRO869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.registrationDate.style' ng-bind='vc.getStringColumnFormat(dataItem.registrationDate, \"QV_9850_34524\", \"registrationDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9850_34524.column.registrationDate.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.registrationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.registrationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'lastUpdateDate',
                    title: '{{vc.viewState.QV_9850_34524.column.lastUpdateDate.title|translate:vc.viewState.QV_9850_34524.column.lastUpdateDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.lastUpdateDate.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.lastUpdateDate.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT82_LASTUPTT869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.lastUpdateDate.style' ng-bind='vc.getStringColumnFormat(dataItem.lastUpdateDate, \"QV_9850_34524\", \"lastUpdateDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9850_34524.column.lastUpdateDate.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.lastUpdateDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.lastUpdateDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Query, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'customerStatus',
                    title: '{{vc.viewState.QV_9850_34524.column.customerStatus.title|translate:vc.viewState.QV_9850_34524.column.customerStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.customerStatus.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.customerStatus.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT95_CUSTOMTT869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.customerStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.customerStatus, \"QV_9850_34524\", \"customerStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9850_34524.column.customerStatus.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.customerStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.customerStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'cicles',
                    title: '{{vc.viewState.QV_9850_34524.column.cicles.title|translate:vc.viewState.QV_9850_34524.column.cicles.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.cicles.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.cicles.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT71_CICLESAG869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.cicles.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.cicles, \"QV_9850_34524\", \"cicles\"):kendo.toString(#=cicles#, vc.viewState.QV_9850_34524.column.cicles.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9850_34524.column.cicles.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.cicles.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.cicles.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'creditAmount',
                    title: '{{vc.viewState.QV_9850_34524.column.creditAmount.title|translate:vc.viewState.QV_9850_34524.column.creditAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.creditAmount.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.creditAmount.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT56_CREDITMT869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.creditAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.creditAmount, \"QV_9850_34524\", \"creditAmount\"):kendo.toString(#=creditAmount#, vc.viewState.QV_9850_34524.column.creditAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9850_34524.column.creditAmount.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.creditAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.creditAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'weeksDelay',
                    title: '{{vc.viewState.QV_9850_34524.column.weeksDelay.title|translate:vc.viewState.QV_9850_34524.column.weeksDelay.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.weeksDelay.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.weeksDelay.format,
                    editor: $scope.vc.grids.QV_9850_34524.AT78_WEEKSDYY869.control,
                    template: "<span ng-class='vc.viewState.QV_9850_34524.column.weeksDelay.style' ng-bind='vc.getStringColumnFormat(dataItem.weeksDelay, \"QV_9850_34524\", \"weeksDelay\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9850_34524.column.weeksDelay.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.weeksDelay.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.weeksDelay.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode)) {
                $scope.vc.grids.QV_9850_34524.columns.push({
                    field: 'isChecked',
                    title: '{{vc.viewState.QV_9850_34524.column.isChecked.title|translate:vc.viewState.QV_9850_34524.column.isChecked.titleArgs}}',
                    width: $scope.vc.viewState.QV_9850_34524.column.isChecked.width,
                    format: $scope.vc.viewState.QV_9850_34524.column.isChecked.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_9850_34524', 'isChecked', $scope.vc.grids.QV_9850_34524.AT15_ISCHECKD869.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_9850_34524', 'isChecked', "<input name='isChecked' type='checkbox' value='#=isChecked#' #=isChecked?checked='checked':''# disabled='disabled' data-bind='value:isChecked' ng-class='vc.viewState.QV_9850_34524.column.isChecked.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9850_34524.column.isChecked.style",
                        "title": "{{vc.viewState.QV_9850_34524.column.isChecked.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9850_34524.column.isChecked.hidden
                });
            }
            $scope.vc.viewState.QV_9850_34524.toolbar = {
                CEQV_201QV_9850_34524_863: {
                    visible: true
                },
                CEQV_201QV_9850_34524_627: {
                    visible: true
                },
                CEQV_201QV_9850_34524_386: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_9850_34524.toolbar = [{
                "name": "CEQV_201QV_9850_34524_863",
                "text": "{{'CSTMR.LBL_CSTMR_SELECCIAA_21296'|translate}}",
                "template": "<button id='CEQV_201QV_9850_34524_863' " + " ng-if='vc.viewState.QV_9850_34524.toolbar.CEQV_201QV_9850_34524_863.visible' " + "ng-disabled = 'vc.viewState.G_TRANSFERUR_637231.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_9850_34524_863\",\"CustomerTransferRequest\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand'> #: text #</button>"
            }, {
                "name": "CEQV_201QV_9850_34524_627",
                "template": "<button id='CEQV_201QV_9850_34524_627' " + " ng-if='vc.viewState.QV_9850_34524.toolbar.CEQV_201QV_9850_34524_627.visible' " + "ng-disabled = 'vc.viewState.G_TRANSFERUR_637231.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_9850_34524_627\",\"CustomerTransferRequest\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-square'></span></button>"
            }, {
                "name": "CEQV_201QV_9850_34524_386",
                "template": "<button id='CEQV_201QV_9850_34524_386' " + " ng-if='vc.viewState.QV_9850_34524.toolbar.CEQV_201QV_9850_34524_386.visible' " + "ng-disabled = 'vc.viewState.G_TRANSFERUR_637231.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201QV_9850_34524_386\",\"CustomerTransferRequest\")' class='btn btn-default cb-grid-image-button cb-btn-custom-gridcommand'><span class='fa fa-check-square'></span></button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRTCAJUPXM_188_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRTCAJUPXM_188_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TCSTMRTC_CTS",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CREARSOCC_91678",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_ISGROUPLIZMPQWJ_431231.read();
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
                $scope.vc.render('VC_TRANSFERUR_363188');
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
    var cobisMainModule = cobis.createModule("VC_TRANSFERUR_363188", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_TRANSFERUR_363188", {
            templateUrl: "VC_TRANSFERUR_363188_FORM.html",
            controller: "VC_TRANSFERUR_363188_CTRL",
            labelId: "CSTMR.LBL_CSTMR_SOLICITTU_13329",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TRANSFERUR_363188?" + $.param(search);
            }
        });
        VC_TRANSFERUR_363188(cobisMainModule);
    }]);
} else {
    VC_TRANSFERUR_363188(cobisMainModule);
}