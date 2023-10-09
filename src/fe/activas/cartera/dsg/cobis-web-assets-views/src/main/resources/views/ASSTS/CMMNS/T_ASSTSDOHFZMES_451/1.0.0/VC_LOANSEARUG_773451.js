//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.loansearchgroupform = designerEvents.api.loansearchgroupform || designer.dsgEvents();

function VC_LOANSEARUG_773451(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LOANSEARUG_773451_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LOANSEARUG_773451_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "ASSTS",
            subModuleId: "CMMNS",
            taskId: "T_ASSTSDOHFZMES_451",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LOANSEARUG_773451",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/CMMNS/T_ASSTSDOHFZMES_451",
        designerEvents.api.loansearchgroupform,
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
                vcName: 'VC_LOANSEARUG_773451'
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
                    moduleId: 'ASSTS',
                    subModuleId: 'CMMNS',
                    taskId: 'T_ASSTSDOHFZMES_451',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LoanSearchFilter: "LoanSearchFilter",
                    Loan: "Loan"
                },
                entities: {
                    LoanSearchFilter: {
                        category: 'AT19_CATEGOYY824',
                        group: 'AT21_GROUPOWD824',
                        codClient: 'AT28_CODCLINN824',
                        avanceSearch: 'AT37_AVANCERR824',
                        isGroup: 'AT39_ISGROUPP824',
                        isDisbursment: 'AT46_ISDISBRE824',
                        operation: 'AT50_OPERATON824',
                        migratedOper: 'AT53_MIGRATER824',
                        officer: 'AT57_OFFICERR824',
                        numIdentification: 'AT58_NUMIDENN824',
                        codCurrency: 'AT64_CODCURYC824',
                        disbursementDate: 'AT73_DISBURDT824',
                        numProcedures: 'AT82_NUMPRODR824',
                        office: 'AT83_OFFICEOE824',
                        status: 'AT97_STATUSDD824',
                        _pks: [],
                        _entityId: 'EN_LOANSEACI_824',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Loan: {
                        numProcedure: 'AT10_NUMPROUE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        statusID: 'AT12_STATUSID882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        balanceDue: 'AT21_BALANCDD882',
                        category: 'AT23_CATEGOYR882',
                        operationTypeID: 'AT23_OPERATDP882',
                        codCurrency: 'AT24_CODMONDD882',
                        newStatusID: 'AT25_NEWSTATT882',
                        isDisbursment: 'AT26_ISDISBTU882',
                        migratedOper: 'AT33_MIGRATEO882',
                        loanID: 'AT37_LOANIDFI882',
                        officeID: 'AT37_OFFICEID882',
                        currencyName: 'AT39_CURRENYY882',
                        startDate: 'AT39_STARTDEE882',
                        loanBankID: 'AT42_LOANBADK882',
                        idType: 'AT48_IDTYPEBH882',
                        endDate: 'AT50_ENDDATEE882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        desOperationType: 'AT57_DESOPETI882',
                        redesCont: 'AT58_REDESCTN882',
                        newStatus: 'AT59_NEWSTASS882',
                        group: 'AT62_GROUPTNG882',
                        previousOper: 'AT65_PREVIOPU882',
                        status: 'AT66_STATUSOB882',
                        clientID: 'AT68_CLIENTII882',
                        operationType: 'AT70_OPERATPP882',
                        clientName: 'AT71_CLIENTNA882',
                        disbursementDate: 'AT76_DISBURTS882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        officer: 'AT77_OFFICERR882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        amount: 'AT91_AMOUNTMO882',
                        adjustment: 'AT94_ADJUSTNT882',
                        officerID: 'AT95_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        feeEndDate: 'AT99_FEEENDED882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_LOANSEACI_824',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_LOANKYMRI_882',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT57_OFFICERR824',
                        attributeIdFk: 'AT95_OFFICEID882'
                    }, {
                        attributeIdPk: 'AT97_STATUSDD824',
                        attributeIdFk: 'AT66_STATUSOB882'
                    }, {
                        attributeIdPk: 'AT82_NUMPRODR824',
                        attributeIdFk: 'AT10_NUMPROUE882'
                    }, {
                        attributeIdPk: 'AT53_MIGRATER824',
                        attributeIdFk: 'AT33_MIGRATEO882'
                    }, {
                        attributeIdPk: 'AT73_DISBURDT824',
                        attributeIdFk: 'AT76_DISBURTS882'
                    }, {
                        attributeIdPk: 'AT64_CODCURYC824',
                        attributeIdFk: 'AT24_CODMONDD882'
                    }, {
                        attributeIdPk: 'AT83_OFFICEOE824',
                        attributeIdFk: 'AT37_OFFICEID882'
                    }, {
                        attributeIdPk: 'AT58_NUMIDENN824',
                        attributeIdFk: 'AT56_IDCARDUU882'
                    }, {
                        attributeIdPk: 'AT28_CODCLINN824',
                        attributeIdFk: 'AT68_CLIENTII882'
                    }, {
                        attributeIdPk: 'AT50_OPERATON824',
                        attributeIdFk: 'AT42_LOANBADK882'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_LOANIBUZ_3992 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_LOANIBUZ_3992 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_LOANIBUZ_3992_filters)) {
                    parametersAux = {
                        loanBankID: $scope.vc.model.LoanSearchFilter.operation,
                        numProcedure: $scope.vc.model.LoanSearchFilter.numProcedures,
                        clientID: $scope.vc.model.LoanSearchFilter.codClient,
                        disbursementDate: $scope.vc.model.LoanSearchFilter.disbursementDate,
                        identityCardNumber: $scope.vc.model.LoanSearchFilter.numIdentification,
                        officeID: $scope.vc.model.LoanSearchFilter.office,
                        officerID: $scope.vc.model.LoanSearchFilter.officer
                    };
                } else {
                    var filters = $scope.vc.queries.Q_LOANIBUZ_3992_filters;
                    parametersAux = {
                        loanBankID: filters.loanBankID,
                        numProcedure: filters.numProcedure,
                        clientID: filters.clientID,
                        disbursementDate: filters.disbursementDate,
                        identityCardNumber: filters.identityCardNumber,
                        group: filters.group,
                        officeID: filters.officeID,
                        officerID: filters.officerID
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_LOANKYMRI_882',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_LOANIBUZ_3992',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['loanBankID'] = $scope.vc.model.LoanSearchFilter.operation;
                            this.parameters['numProcedure'] = $scope.vc.model.LoanSearchFilter.numProcedures;
                            this.parameters['clientID'] = $scope.vc.model.LoanSearchFilter.codClient;
                            this.parameters['disbursementDate'] = $scope.vc.model.LoanSearchFilter.disbursementDate;
                            this.parameters['identityCardNumber'] = $scope.vc.model.LoanSearchFilter.numIdentification;
                            this.parameters['officeID'] = $scope.vc.model.LoanSearchFilter.office;
                            this.parameters['officerID'] = $scope.vc.model.LoanSearchFilter.officer;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['loanBankID'] = this.filters.loanBankID;
                            this.parameters['numProcedure'] = this.filters.numProcedure;
                            this.parameters['clientID'] = this.filters.clientID;
                            this.parameters['disbursementDate'] = this.filters.disbursementDate;
                            this.parameters['identityCardNumber'] = this.filters.identityCardNumber;
                            this.parameters['group'] = this.filters.group;
                            this.parameters['officeID'] = this.filters.officeID;
                            this.parameters['officerID'] = this.filters.officerID;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_LOANIBUZ_3992_filters = {};
            var defaultValues = {
                LoanSearchFilter: {},
                Loan: {}
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
                $scope.vc.execute("temporarySave", VC_LOANSEARUG_773451, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LOANSEARUG_773451, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LOANSEARUG_773451, data, function() {});
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
            $scope.vc.viewState.VC_LOANSEARUG_773451 = {
                style: []
            }
            //ViewState - Group: GroupLayout2361
            $scope.vc.createViewState({
                id: "G_LOANSEARRR_805549",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2361',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanSearchFilter = {
                category: $scope.vc.channelDefaultValues("LoanSearchFilter", "category"),
                group: $scope.vc.channelDefaultValues("LoanSearchFilter", "group"),
                codClient: $scope.vc.channelDefaultValues("LoanSearchFilter", "codClient"),
                avanceSearch: $scope.vc.channelDefaultValues("LoanSearchFilter", "avanceSearch"),
                isGroup: $scope.vc.channelDefaultValues("LoanSearchFilter", "isGroup"),
                isDisbursment: $scope.vc.channelDefaultValues("LoanSearchFilter", "isDisbursment"),
                operation: $scope.vc.channelDefaultValues("LoanSearchFilter", "operation"),
                migratedOper: $scope.vc.channelDefaultValues("LoanSearchFilter", "migratedOper"),
                officer: $scope.vc.channelDefaultValues("LoanSearchFilter", "officer"),
                numIdentification: $scope.vc.channelDefaultValues("LoanSearchFilter", "numIdentification"),
                codCurrency: $scope.vc.channelDefaultValues("LoanSearchFilter", "codCurrency"),
                disbursementDate: $scope.vc.channelDefaultValues("LoanSearchFilter", "disbursementDate"),
                numProcedures: $scope.vc.channelDefaultValues("LoanSearchFilter", "numProcedures"),
                office: $scope.vc.channelDefaultValues("LoanSearchFilter", "office"),
                status: $scope.vc.channelDefaultValues("LoanSearchFilter", "status")
            };
            //ViewState - Group: Group2758
            $scope.vc.createViewState({
                id: "G_LOANSEARRC_434549",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIBS_16700",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: numIdentification
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHCG_720549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PORGRUPOO_82381",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: operation
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLPX_148549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NUMPRSTAM_17241",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: numProcedures
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXUDJ_171549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PORTRMIET_16045",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: office
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTKU_514549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_POROFICII_89969",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXTKU_514549 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXTKU_514549', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXTKU_514549'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXTKU_514549");
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
            //ViewState - Entity: LoanSearchFilter, Attribute: disbursementDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDCVISIT_349549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PORFECHIN_74457",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: officer
            $scope.vc.createViewState({
                id: "VA_OFFICERKLHXZUAP_236549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_POROFICLA_46243",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFFICERKLHXZUAP_236549 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFFICERKLHXZUAP_236549', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFFICERKLHXZUAP_236549'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICERKLHXZUAP_236549");
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
            //ViewState - Group: Group2915
            $scope.vc.createViewState({
                id: "G_LOANSEAHCG_262549",
                hasId: true,
                componentStyle: [],
                label: 'Group2915',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: avanceSearch
            $scope.vc.createViewState({
                id: "VA_AVANCESEARCHJRS_939549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIOO_80936",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2717",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONMIOOIVQ_638549",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_LOANIBUZ_3992',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2241
            $scope.vc.createViewState({
                id: "G_LOANSEARRR_385549",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LISTADOSR_79472",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Loan = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    loanBankID: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.operation
                        }
                    },
                    clientName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "clientName", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "amount", 0)
                    },
                    startDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "startDate", new Date())
                    },
                    numProcedure: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.numProcedures
                        }
                    },
                    clientIDBoolean: {
                        type: "boolean"
                    },
                    clientID: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.codClient
                        }
                    },
                    disbursementDate: {
                        type: "date",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.disbursementDate
                        }
                    },
                    identityCardNumberBoolean: {
                        type: "boolean"
                    },
                    identityCardNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.numIdentification
                        }
                    },
                    group: {
                        type: "string",
                        editable: true
                    },
                    officeIDBoolean: {
                        type: "boolean"
                    },
                    officeID: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.office
                        }
                    },
                    officerID: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.officer
                        }
                    }
                }
            });
            $scope.vc.model.Loan = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_LOANIBUZ_3992';
                            var queryRequest = $scope.vc.getRequestQuery_Q_LOANIBUZ_3992();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3992_44545',
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
                                            'allowPaging': false,
                                            'pageSize': 0
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
                    model: $scope.vc.types.Loan
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_3992_44545").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_LOANIBUZ_3992 = $scope.vc.model.Loan;
            $scope.vc.trackers.Loan = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Loan);
            $scope.vc.model.Loan.bind('change', function(e) {
                $scope.vc.trackers.Loan.track(e);
            });
            $scope.vc.grids.QV_3992_44545 = {};
            $scope.vc.grids.QV_3992_44545.queryId = 'Q_LOANIBUZ_3992';
            $scope.vc.viewState.QV_3992_44545 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3992_44545.column = {};
            $scope.vc.grids.QV_3992_44545.editable = false;
            $scope.vc.grids.QV_3992_44545.events = {
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
                    $scope.vc.trackers.Loan.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_3992_44545.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_3992_44545");
                    $scope.vc.hideShowColumns("QV_3992_44545", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3992_44545.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3992_44545.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3992_44545.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3992_44545 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3992_44545 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_3992_44545.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_3992_44545.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_3992_44545.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Loan",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_3992_44545", args);
                        }
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
            $scope.vc.grids.QV_3992_44545.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3992_44545.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3992_44545.column.loanBankID = {
                title: 'ASSTS.LBL_ASSTS_NUMPRSTRA_65807',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKXR_473549',
                element: []
            };
            $scope.vc.grids.QV_3992_44545.AT42_LOANBADK882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3992_44545.column.loanBankID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKXR_473549",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_3992_44545.column.loanBankID.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3992_44545.column.loanBankID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3992_44545.column.clientName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREGRR_11223',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSFI_253549',
                element: []
            };
            $scope.vc.grids.QV_3992_44545.AT71_CLIENTNA882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3992_44545.column.clientName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSFI_253549",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_3992_44545.column.clientName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3992_44545.column.clientName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3992_44545.column.amount = {
                title: 'ASSTS.LBL_ASSTS_MONTOPROM_71868',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQQF_208549',
                element: []
            };
            $scope.vc.grids.QV_3992_44545.AT91_AMOUNTMO882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3992_44545.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQQF_208549",
                        'data-validation-code': "{{vc.viewState.QV_3992_44545.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3992_44545.column.amount.format",
                        'k-decimals': "vc.viewState.QV_3992_44545.column.amount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3992_44545.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3992_44545.column.startDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAINCC_83803',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDYEFIRM_534549',
                element: []
            };
            $scope.vc.grids.QV_3992_44545.AT39_STARTDEE882 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3992_44545.column.startDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDYEFIRM_534549",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_3992_44545.column.startDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_3992_44545.column.startDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3992_44545.column.numProcedure = {
                title: 'numProcedure',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_3992_44545.column.clientID = {
                title: 'clientID',
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
            $scope.vc.viewState.QV_3992_44545.column.disbursementDate = {
                title: 'disbursementDate',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_3992_44545.column.identityCardNumber = {
                title: 'identityCardNumber',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_3992_44545.column.group = {
                title: 'group',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_3992_44545.column.officeID = {
                title: 'officeID',
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
            $scope.vc.viewState.QV_3992_44545.column.officerID = {
                title: 'officerID',
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
                $scope.vc.grids.QV_3992_44545.columns.push({
                    field: 'loanBankID',
                    title: '{{vc.viewState.QV_3992_44545.column.loanBankID.title|translate:vc.viewState.QV_3992_44545.column.loanBankID.titleArgs}}',
                    width: $scope.vc.viewState.QV_3992_44545.column.loanBankID.width,
                    format: $scope.vc.viewState.QV_3992_44545.column.loanBankID.format,
                    editor: $scope.vc.grids.QV_3992_44545.AT42_LOANBADK882.control,
                    template: "<span ng-class='vc.viewState.QV_3992_44545.column.loanBankID.style' ng-bind='vc.getStringColumnFormat(dataItem.loanBankID, \"QV_3992_44545\", \"loanBankID\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3992_44545.column.loanBankID.style",
                        "title": "{{vc.viewState.QV_3992_44545.column.loanBankID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3992_44545.column.loanBankID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3992_44545.columns.push({
                    field: 'clientName',
                    title: '{{vc.viewState.QV_3992_44545.column.clientName.title|translate:vc.viewState.QV_3992_44545.column.clientName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3992_44545.column.clientName.width,
                    format: $scope.vc.viewState.QV_3992_44545.column.clientName.format,
                    editor: $scope.vc.grids.QV_3992_44545.AT71_CLIENTNA882.control,
                    template: "<span ng-class='vc.viewState.QV_3992_44545.column.clientName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientName, \"QV_3992_44545\", \"clientName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3992_44545.column.clientName.style",
                        "title": "{{vc.viewState.QV_3992_44545.column.clientName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3992_44545.column.clientName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3992_44545.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_3992_44545.column.amount.title|translate:vc.viewState.QV_3992_44545.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_3992_44545.column.amount.width,
                    format: $scope.vc.viewState.QV_3992_44545.column.amount.format,
                    editor: $scope.vc.grids.QV_3992_44545.AT91_AMOUNTMO882.control,
                    template: "<span ng-class='vc.viewState.QV_3992_44545.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_3992_44545\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_3992_44545.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3992_44545.column.amount.style",
                        "title": "{{vc.viewState.QV_3992_44545.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3992_44545.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3992_44545.columns.push({
                    field: 'startDate',
                    title: '{{vc.viewState.QV_3992_44545.column.startDate.title|translate:vc.viewState.QV_3992_44545.column.startDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3992_44545.column.startDate.width,
                    format: $scope.vc.viewState.QV_3992_44545.column.startDate.format,
                    editor: $scope.vc.grids.QV_3992_44545.AT39_STARTDEE882.control,
                    template: "<span ng-class='vc.viewState.QV_3992_44545.column.startDate.style'>#=((startDate !== null) ? kendo.toString(startDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3992_44545.column.startDate.style",
                        "title": "{{vc.viewState.QV_3992_44545.column.startDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3992_44545.column.startDate.hidden
                });
            }
            $scope.vc.viewState.QV_3992_44545.toolbar = {}
            $scope.vc.grids.QV_3992_44545.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSDOHFZMES_451_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSDOHFZMES_451_CANCEL",
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
                $scope.vc.render('VC_LOANSEARUG_773451');
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
    var cobisMainModule = cobis.createModule("VC_LOANSEARUG_773451", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_LOANSEARUG_773451", {
            templateUrl: "VC_LOANSEARUG_773451_FORM.html",
            controller: "VC_LOANSEARUG_773451_CTRL",
            labelId: "ASSTS.LBL_ASSTS_BSQUEDAPA_68207",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LOANSEARUG_773451?" + $.param(search);
            }
        });
        VC_LOANSEARUG_773451(cobisMainModule);
    }]);
} else {
    VC_LOANSEARUG_773451(cobisMainModule);
}