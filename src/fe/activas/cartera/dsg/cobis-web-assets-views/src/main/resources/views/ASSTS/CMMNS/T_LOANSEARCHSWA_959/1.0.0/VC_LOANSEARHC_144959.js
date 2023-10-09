//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.loansearchform = designerEvents.api.loansearchform || designer.dsgEvents();

function VC_LOANSEARHC_144959(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LOANSEARHC_144959_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LOANSEARHC_144959_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANSEARCHSWA_959",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LOANSEARHC_144959",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/CMMNS/T_LOANSEARCHSWA_959",
        designerEvents.api.loansearchform,
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
                vcName: 'VC_LOANSEARHC_144959'
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
                    taskId: 'T_LOANSEARCHSWA_959',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LoanInstancia: "LoanInstancia",
                    Loan: "Loan",
                    LoanSearchFilter: "LoanSearchFilter"
                },
                entities: {
                    LoanInstancia: {
                        groupSummary: 'AT55_GROUPSAM482',
                        idOptionMenu: 'AT59_IDOPTINM482',
                        errorValidation: 'AT62_ERRORVAA482',
                        idInstancia: 'AT74_IDINSTAA482',
                        tipo: 'AT77_TIPOCLXG482',
                        _pks: [],
                        _entityId: 'EN_LOANINSTC_482',
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
                    },
                    LoanSearchFilter: {
                        groupSummary: 'AT15_GROUPSRM824',
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
            $scope.vc.queryProperties.Q_LOANDPQM_3009 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_LOANDPQM_3009 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_LOANDPQM_3009_filters)) {
                    parametersAux = {
                        loanBankID: $scope.vc.model.LoanSearchFilter.operation,
                        officeID: $scope.vc.model.LoanSearchFilter.office,
                        status: $scope.vc.model.LoanSearchFilter.status,
                        identityCardNumber: $scope.vc.model.LoanSearchFilter.numIdentification,
                        disbursementDate: $scope.vc.model.LoanSearchFilter.disbursementDate,
                        clientID: $scope.vc.model.LoanSearchFilter.codClient,
                        codCurrency: $scope.vc.model.LoanSearchFilter.codCurrency,
                        numProcedure: $scope.vc.model.LoanSearchFilter.numProcedures,
                        migratedOper: $scope.vc.model.LoanSearchFilter.migratedOper
                    };
                } else {
                    var filters = $scope.vc.queries.Q_LOANDPQM_3009_filters;
                    parametersAux = {
                        loanBankID: filters.loanBankID,
                        officeID: filters.officeID,
                        status: filters.status,
                        identityCardNumber: filters.identityCardNumber,
                        disbursementDate: filters.disbursementDate,
                        clientID: filters.clientID,
                        codCurrency: filters.codCurrency,
                        numProcedure: filters.numProcedure,
                        migratedOper: filters.migratedOper,
                        group: filters.group,
                        isDisbursment: filters.isDisbursment,
                        category: filters.category
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_LOANKYMRI_882',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_LOANDPQM_3009',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['loanBankID'] = $scope.vc.model.LoanSearchFilter.operation;
                            this.parameters['officeID'] = $scope.vc.model.LoanSearchFilter.office;
                            this.parameters['status'] = $scope.vc.model.LoanSearchFilter.status;
                            this.parameters['identityCardNumber'] = $scope.vc.model.LoanSearchFilter.numIdentification;
                            this.parameters['disbursementDate'] = $scope.vc.model.LoanSearchFilter.disbursementDate;
                            this.parameters['clientID'] = $scope.vc.model.LoanSearchFilter.codClient;
                            this.parameters['codCurrency'] = $scope.vc.model.LoanSearchFilter.codCurrency;
                            this.parameters['numProcedure'] = $scope.vc.model.LoanSearchFilter.numProcedures;
                            this.parameters['migratedOper'] = $scope.vc.model.LoanSearchFilter.migratedOper;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['loanBankID'] = this.filters.loanBankID;
                            this.parameters['officeID'] = this.filters.officeID;
                            this.parameters['status'] = this.filters.status;
                            this.parameters['identityCardNumber'] = this.filters.identityCardNumber;
                            this.parameters['disbursementDate'] = this.filters.disbursementDate;
                            this.parameters['clientID'] = this.filters.clientID;
                            this.parameters['codCurrency'] = this.filters.codCurrency;
                            this.parameters['numProcedure'] = this.filters.numProcedure;
                            this.parameters['migratedOper'] = this.filters.migratedOper;
                            this.parameters['group'] = this.filters.group;
                            this.parameters['isDisbursment'] = this.filters.isDisbursment;
                            this.parameters['category'] = this.filters.category;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_LOANDPQM_3009_filters = {};
            var defaultValues = {
                LoanInstancia: {},
                Loan: {},
                LoanSearchFilter: {}
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
                $scope.vc.execute("temporarySave", VC_LOANSEARHC_144959, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LOANSEARHC_144959, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LOANSEARHC_144959, data, function() {});
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
            $scope.vc.viewState.VC_LOANSEARHC_144959 = {
                style: []
            }
            //ViewState - Group: GroupLayout1809
            $scope.vc.createViewState({
                id: "G_LOANSEARRH_169508",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIBS_16700",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanSearchFilter = {
                groupSummary: $scope.vc.channelDefaultValues("LoanSearchFilter", "groupSummary"),
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
            //ViewState - Group: Group1910
            $scope.vc.createViewState({
                id: "G_LOANSEAHRH_621508",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIBS_16700",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: numIdentification
            $scope.vc.createViewState({
                id: "VA_CODCLIENTCIXLEY_866508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CODIGOCEN_52038",
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: operation
            $scope.vc.createViewState({
                id: "VA_OPERATIONZDFLWM_772508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NUMPRSTOO_83774",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: numProcedures
            $scope.vc.createViewState({
                id: "VA_NUMPROCEDURESSS_195508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NUMTRMITE_20261",
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: office
            $scope.vc.createViewState({
                id: "VA_OFFICEVEGBCEQOG_104508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFFICEVEGBCEQOG_104508 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFFICEVEGBCEQOG_104508', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFFICEVEGBCEQOG_104508'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICEVEGBCEQOG_104508");
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
            //ViewState - Entity: LoanSearchFilter, Attribute: groupSummary
            $scope.vc.createViewState({
                id: "Spacer1633",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RESUMENAA_13752",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.Spacer1633 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("Spacer1633");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: codCurrency
            $scope.vc.createViewState({
                id: "VA_CODCURRENCYKYKA_122508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONEDATUB_92849",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CODCURRENCYKYKA_122508 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CODCURRENCYKYKA_122508', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CODCURRENCYKYKA_122508'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CODCURRENCYKYKA_122508");
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
                id: "VA_DISBURSEMENTDTD_602508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADEBE_42043",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: status
            $scope.vc.createViewState({
                id: "VA_STATUSRUGGOTSMF_965508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOPEM_54793",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_STATUSRUGGOTSMF_965508 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_STATUSRUGGOTSMF_965508', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_STATUSRUGGOTSMF_965508'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_STATUSRUGGOTSMF_965508");
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
            //ViewState - Entity: LoanSearchFilter, Attribute: migratedOper
            $scope.vc.createViewState({
                id: "VA_MIGRATEDOPERFRB_417508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRSTAMOIO_81821",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group1243
            $scope.vc.createViewState({
                id: "G_LOANSEAHRH_717508",
                hasId: true,
                componentStyle: [],
                label: 'Group1243',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoanSearchFilter, Attribute: avanceSearch
            $scope.vc.createViewState({
                id: "VA_AVANCESEARCHMXA_533508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRITERIOO_80936",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2473",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1732",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONBCZSHFM_208508",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_LOANDPQM_3009',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2648
            $scope.vc.createViewState({
                id: "G_LOANSEAHHH_461508",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LISTADOSR_79472",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
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
                    desOperationType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "desOperationType", '')
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
                    status: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.status
                        }
                    },
                    expirationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "expirationDate", new Date())
                    },
                    codCurrency: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.codCurrency
                        }
                    },
                    disbursementDate: {
                        type: "date",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.disbursementDate
                        }
                    },
                    clientID: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.codClient
                        }
                    },
                    numProcedure: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.numProcedures
                        }
                    },
                    group: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "group", '')
                    },
                    isDisbursment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "isDisbursment", '')
                    },
                    category: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Loan", "category", 0)
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
                    migratedOper: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.LoanSearchFilter.migratedOper
                        }
                    }
                }
            });
            $scope.vc.model.Loan = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_LOANDPQM_3009';
                            var queryRequest = $scope.vc.getRequestQuery_Q_LOANDPQM_3009();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_3009_96085',
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
                                            'pageSize': 5
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
                        $("#QV_3009_96085").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_LOANDPQM_3009 = $scope.vc.model.Loan;
            $scope.vc.trackers.Loan = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Loan);
            $scope.vc.model.Loan.bind('change', function(e) {
                $scope.vc.trackers.Loan.track(e);
            });
            $scope.vc.grids.QV_3009_96085 = {};
            $scope.vc.grids.QV_3009_96085.queryId = 'Q_LOANDPQM_3009';
            $scope.vc.viewState.QV_3009_96085 = {
                style: undefined
            };
            $scope.vc.viewState.QV_3009_96085.column = {};
            $scope.vc.grids.QV_3009_96085.editable = false;
            $scope.vc.grids.QV_3009_96085.events = {
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
                    $scope.vc.grids.QV_3009_96085.selectedRow = e.model;
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_3009_96085', this.dataSource);
                },
                excel: {
                    fileName: 'QV_3009_96085.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_3009_96085.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_3009_96085");
                    $scope.vc.hideShowColumns("QV_3009_96085", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_3009_96085.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_3009_96085.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_3009_96085.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_3009_96085 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_3009_96085 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_3009_96085.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_3009_96085.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "Loan", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_3009_96085.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_3009_96085.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_3009_96085.column.desOperationType = {
                title: 'ASSTS.LBL_ASSTS_TIPOPREMM_37747',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDAN_761508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT57_DESOPETI882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.desOperationType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDAN_761508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.desOperationType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.desOperationType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.loanBankID = {
                title: 'ASSTS.LBL_ASSTS_NUMPRSTOO_83774',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFXZ_333508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT42_LOANBADK882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.loanBankID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFXZ_333508",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.loanBankID.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.loanBankID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.clientName = {
                title: 'ASSTS.LBL_ASSTS_NOMBRECNI_63306',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBPY_504508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT71_CLIENTNA882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.clientName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBPY_504508",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.clientName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.clientName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.amount = {
                title: 'ASSTS.LBL_ASSTS_MONTOPROO_10190',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWLO_792508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT91_AMOUNTMO882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWLO_792508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3009_96085.column.amount.format",
                        'k-decimals': "vc.viewState.QV_3009_96085.column.amount.decimals",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.status = {
                title: 'ASSTS.LBL_ASSTS_ESTADOPEM_54793',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLLX_842508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT66_STATUSOB882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.status.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLLX_842508",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.status.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.status.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.expirationDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAVENE_58948',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDDDLJHB_303508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT76_EXPIRAEE882 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.expirationDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDDDLJHB_303508",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.expirationDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_3009_96085.column.expirationDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.codCurrency = {
                title: 'ASSTS.LBL_ASSTS_CODMONEDD_59972',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVFT_322508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT24_CODMONDD882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.codCurrency.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVFT_322508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.codCurrency.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3009_96085.column.codCurrency.format",
                        'k-decimals': "vc.viewState.QV_3009_96085.column.codCurrency.decimals",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.codCurrency.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.disbursementDate = {
                title: 'ASSTS.LBL_ASSTS_FECHADEBE_42043',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDLYQLTD_622508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT76_DISBURTS882 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.disbursementDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDLYQLTD_622508",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.disbursementDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_3009_96085.column.disbursementDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.clientID = {
                title: 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEUM_243508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT68_CLIENTII882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.clientID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEUM_243508",
                        'maxlength': 4,
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.clientID.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3009_96085.column.clientID.format",
                        'k-decimals': "vc.viewState.QV_3009_96085.column.clientID.decimals",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.clientID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.numProcedure = {
                title: 'ASSTS.LBL_ASSTS_NUMTRMITE_20261',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXJI_412508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT10_NUMPROUE882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.numProcedure.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXJI_412508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.numProcedure.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.numProcedure.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.group = {
                title: 'group',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBHQ_121508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT62_GROUPTNG882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.group.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBHQ_121508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.group.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.group.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.isDisbursment = {
                title: 'isDisbursment',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBCW_500508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT26_ISDISBTU882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.isDisbursment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBCW_500508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.isDisbursment.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.isDisbursment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.category = {
                title: 'category',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYB_745508',
                element: []
            };
            $scope.vc.grids.QV_3009_96085.AT23_CATEGOYR882 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_3009_96085.column.category.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQYB_745508",
                        'data-validation-code': "{{vc.viewState.QV_3009_96085.column.category.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_3009_96085.column.category.format",
                        'k-decimals': "vc.viewState.QV_3009_96085.column.category.decimals",
                        'data-cobis-group': "GroupLayout,G_LOANSEARRH_169508,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_3009_96085.column.category.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_3009_96085.column.officeID = {
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
            $scope.vc.viewState.QV_3009_96085.column.identityCardNumber = {
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
            $scope.vc.viewState.QV_3009_96085.column.migratedOper = {
                title: 'migratedOper',
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
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'desOperationType',
                    title: '{{vc.viewState.QV_3009_96085.column.desOperationType.title|translate:vc.viewState.QV_3009_96085.column.desOperationType.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.desOperationType.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.desOperationType.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT57_DESOPETI882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.desOperationType.style' ng-bind='vc.getStringColumnFormat(dataItem.desOperationType, \"QV_3009_96085\", \"desOperationType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.desOperationType.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.desOperationType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.desOperationType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'loanBankID',
                    title: '{{vc.viewState.QV_3009_96085.column.loanBankID.title|translate:vc.viewState.QV_3009_96085.column.loanBankID.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.loanBankID.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.loanBankID.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT42_LOANBADK882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.loanBankID.style' ng-bind='vc.getStringColumnFormat(dataItem.loanBankID, \"QV_3009_96085\", \"loanBankID\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.loanBankID.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.loanBankID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.loanBankID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'clientName',
                    title: '{{vc.viewState.QV_3009_96085.column.clientName.title|translate:vc.viewState.QV_3009_96085.column.clientName.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.clientName.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.clientName.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT71_CLIENTNA882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.clientName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientName, \"QV_3009_96085\", \"clientName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.clientName.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.clientName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.clientName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_3009_96085.column.amount.title|translate:vc.viewState.QV_3009_96085.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.amount.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.amount.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT91_AMOUNTMO882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_3009_96085\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_3009_96085.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3009_96085.column.amount.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'status',
                    title: '{{vc.viewState.QV_3009_96085.column.status.title|translate:vc.viewState.QV_3009_96085.column.status.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.status.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.status.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT66_STATUSOB882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.status.style' ng-bind='vc.getStringColumnFormat(dataItem.status, \"QV_3009_96085\", \"status\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.status.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.status.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.status.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'expirationDate',
                    title: '{{vc.viewState.QV_3009_96085.column.expirationDate.title|translate:vc.viewState.QV_3009_96085.column.expirationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.expirationDate.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.expirationDate.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT76_EXPIRAEE882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.expirationDate.style'>#=((expirationDate !== null) ? kendo.toString(expirationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.expirationDate.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.expirationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.expirationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'codCurrency',
                    title: '{{vc.viewState.QV_3009_96085.column.codCurrency.title|translate:vc.viewState.QV_3009_96085.column.codCurrency.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.codCurrency.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.codCurrency.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT24_CODMONDD882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.codCurrency.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.codCurrency, \"QV_3009_96085\", \"codCurrency\"):kendo.toString(#=codCurrency#, vc.viewState.QV_3009_96085.column.codCurrency.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3009_96085.column.codCurrency.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.codCurrency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.codCurrency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'disbursementDate',
                    title: '{{vc.viewState.QV_3009_96085.column.disbursementDate.title|translate:vc.viewState.QV_3009_96085.column.disbursementDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.disbursementDate.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.disbursementDate.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT76_DISBURTS882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.disbursementDate.style'>#=((disbursementDate !== null) ? kendo.toString(disbursementDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.disbursementDate.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.disbursementDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.disbursementDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'clientID',
                    title: '{{vc.viewState.QV_3009_96085.column.clientID.title|translate:vc.viewState.QV_3009_96085.column.clientID.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.clientID.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.clientID.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT68_CLIENTII882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.clientID.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.clientID, \"QV_3009_96085\", \"clientID\"):kendo.toString(#=clientID#, vc.viewState.QV_3009_96085.column.clientID.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3009_96085.column.clientID.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.clientID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.clientID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'numProcedure',
                    title: '{{vc.viewState.QV_3009_96085.column.numProcedure.title|translate:vc.viewState.QV_3009_96085.column.numProcedure.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.numProcedure.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.numProcedure.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT10_NUMPROUE882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.numProcedure.style' ng-bind='vc.getStringColumnFormat(dataItem.numProcedure, \"QV_3009_96085\", \"numProcedure\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.numProcedure.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.numProcedure.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.numProcedure.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'group',
                    title: '{{vc.viewState.QV_3009_96085.column.group.title|translate:vc.viewState.QV_3009_96085.column.group.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.group.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.group.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT62_GROUPTNG882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.group.style' ng-bind='vc.getStringColumnFormat(dataItem.group, \"QV_3009_96085\", \"group\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.group.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.group.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.group.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'isDisbursment',
                    title: '{{vc.viewState.QV_3009_96085.column.isDisbursment.title|translate:vc.viewState.QV_3009_96085.column.isDisbursment.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.isDisbursment.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.isDisbursment.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT26_ISDISBTU882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.isDisbursment.style' ng-bind='vc.getStringColumnFormat(dataItem.isDisbursment, \"QV_3009_96085\", \"isDisbursment\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_3009_96085.column.isDisbursment.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.isDisbursment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.isDisbursment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_3009_96085.columns.push({
                    field: 'category',
                    title: '{{vc.viewState.QV_3009_96085.column.category.title|translate:vc.viewState.QV_3009_96085.column.category.titleArgs}}',
                    width: $scope.vc.viewState.QV_3009_96085.column.category.width,
                    format: $scope.vc.viewState.QV_3009_96085.column.category.format,
                    editor: $scope.vc.grids.QV_3009_96085.AT23_CATEGOYR882.control,
                    template: "<span ng-class='vc.viewState.QV_3009_96085.column.category.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.category, \"QV_3009_96085\", \"category\"):kendo.toString(#=category#, vc.viewState.QV_3009_96085.column.category.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_3009_96085.column.category.style",
                        "title": "{{vc.viewState.QV_3009_96085.column.category.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_3009_96085.column.category.hidden
                });
            }
            $scope.vc.viewState.QV_3009_96085.toolbar = {}
            $scope.vc.grids.QV_3009_96085.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_3009_96085.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            $scope.vc.model.LoanInstancia = {
                groupSummary: $scope.vc.channelDefaultValues("LoanInstancia", "groupSummary"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation"),
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                tipo: $scope.vc.channelDefaultValues("LoanInstancia", "tipo")
            };
            //ViewState - Group: Group1762
            $scope.vc.createViewState({
                id: "G_LOANSEARCH_564508",
                hasId: true,
                componentStyle: [],
                label: 'Group1762',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer2999",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSEARCHSWA_959_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSEARCHSWA_959_CANCEL",
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
                $scope.vc.render('VC_LOANSEARHC_144959');
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
    var cobisMainModule = cobis.createModule("VC_LOANSEARHC_144959", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_LOANSEARHC_144959", {
            templateUrl: "VC_LOANSEARHC_144959_FORM.html",
            controller: "VC_LOANSEARHC_144959_CTRL",
            labelId: "ASSTS.LBL_ASSTS_BSQUEDASS_55923",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LOANSEARHC_144959?" + $.param(search);
            }
        });
        VC_LOANSEARHC_144959(cobisMainModule);
    }]);
} else {
    VC_LOANSEARHC_144959(cobisMainModule);
}