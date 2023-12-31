//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.paymentmodeform = designerEvents.api.paymentmodeform || designer.dsgEvents();

function VC_PAYMENTMDE_245368(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PAYMENTMDE_245368_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PAYMENTMDE_245368_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "TRNSC",
            taskId: "T_PAYMENTMODEEE_368",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PAYMENTMDE_245368",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_PAYMENTMODEEE_368",
        designerEvents.api.paymentmodeform,
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
                vcName: 'VC_PAYMENTMDE_245368'
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
                    subModuleId: 'TRNSC',
                    taskId: 'T_PAYMENTMODEEE_368',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    PaymentForm: "PaymentForm",
                    Loan: "Loan",
                    LoanAdditionalInformation: "LoanAdditionalInformation"
                },
                entities: {
                    PaymentForm: {
                        currencyId: 'AT54_CURRENDC123',
                        currencyName: 'AT93_CURRENAN123',
                        payFormId: 'AT97_PAYIDUGR123',
                        payFormName: 'AT95_PAYNAMEE123',
                        clientId: 'AT17_CLIENTID123',
                        clientFullName: 'AT56_CLIENTEM123',
                        reference: 'AT73_REFERECE123',
                        checkNumber: 'AT27_CHECKNBU123',
                        payAmount: 'AT78_PAYAMOUU123',
                        officeId: 'AT39_OFFICEII123',
                        concept: 'AT83_CONEPTWT123',
                        payQuoteLbl: 'AT98_PAYQUOEE123',
                        accountNumber: 'AT98_ACCOUNUB123',
                        restrictiveCrossing: 'AT21_RESTRINI123',
                        economicDestination: 'AT32_ECONOMAD123',
                        currencyIdAux: 'AT66_CURRENXD123',
                        currencyFlagAux: 'AT95_CURRENGC123',
                        payFormCategory: 'AT98_PAYCATOE123',
                        _pks: [],
                        _entityId: 'EN_PAYMENTZD_123',
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
                    LoanAdditionalInformation: {
                        dateToDisburse: 'AT16_LOANDAEE167',
                        amountToCancel: 'AT10_AMOUNTCT167',
                        amountOperation: 'AT81_AMOUNTAO167',
                        quotation: 'AT23_QUOTATOI167',
                        lblAmountToCancel: 'AT65_LBLAMOTA167',
                        renovation: 'AT99_RENOVANI167',
                        _pks: [],
                        _entityId: 'EN_LOANADDOI_167',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                PaymentForm: {},
                Loan: {},
                LoanAdditionalInformation: {}
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
                $scope.vc.execute("temporarySave", VC_PAYMENTMDE_245368, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PAYMENTMDE_245368, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PAYMENTMDE_245368, data, function() {});
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
            $scope.vc.viewState.VC_PAYMENTMDE_245368 = {
                style: []
            }
            //ViewState - Group: GroupLayout1578
            $scope.vc.createViewState({
                id: "G_PAYMENTMED_964216",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1578',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PaymentForm = {
                currencyId: $scope.vc.channelDefaultValues("PaymentForm", "currencyId"),
                currencyName: $scope.vc.channelDefaultValues("PaymentForm", "currencyName"),
                payFormId: $scope.vc.channelDefaultValues("PaymentForm", "payFormId"),
                payFormName: $scope.vc.channelDefaultValues("PaymentForm", "payFormName"),
                clientId: $scope.vc.channelDefaultValues("PaymentForm", "clientId"),
                clientFullName: $scope.vc.channelDefaultValues("PaymentForm", "clientFullName"),
                reference: $scope.vc.channelDefaultValues("PaymentForm", "reference"),
                checkNumber: $scope.vc.channelDefaultValues("PaymentForm", "checkNumber"),
                payAmount: $scope.vc.channelDefaultValues("PaymentForm", "payAmount"),
                officeId: $scope.vc.channelDefaultValues("PaymentForm", "officeId"),
                concept: $scope.vc.channelDefaultValues("PaymentForm", "concept"),
                payQuoteLbl: $scope.vc.channelDefaultValues("PaymentForm", "payQuoteLbl"),
                accountNumber: $scope.vc.channelDefaultValues("PaymentForm", "accountNumber"),
                restrictiveCrossing: $scope.vc.channelDefaultValues("PaymentForm", "restrictiveCrossing"),
                economicDestination: $scope.vc.channelDefaultValues("PaymentForm", "economicDestination"),
                currencyIdAux: $scope.vc.channelDefaultValues("PaymentForm", "currencyIdAux"),
                currencyFlagAux: $scope.vc.channelDefaultValues("PaymentForm", "currencyFlagAux"),
                payFormCategory: $scope.vc.channelDefaultValues("PaymentForm", "payFormCategory")
            };
            //ViewState - Group: Group2809
            $scope.vc.createViewState({
                id: "G_PAYMENTMMD_765216",
                hasId: true,
                componentStyle: [],
                label: 'Group2809',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: currencyIdAux
            $scope.vc.createViewState({
                id: "VA_6057SWXKCQQHOIS_464216",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_6057SWXKCQQHOIS_464216 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_6057SWXKCQQHOIS_464216', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_6057SWXKCQQHOIS_464216'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_6057SWXKCQQHOIS_464216");
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
            //ViewState - Entity: PaymentForm, Attribute: payFormId
            $scope.vc.createViewState({
                id: "Spacer2675",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APAGOVQRF_51833",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.Spacer2675 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('Spacer2675', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTSpacer2675'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("Spacer2675");
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
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITEPXIR_377216",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: clientFullName
            $scope.vc.createViewState({
                id: "VA_6386FQVBTKCYFWG_461216",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BENEFICOI_14873",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITENOLL_984216",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: checkNumber
            $scope.vc.createViewState({
                id: "Spacer2495",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CHEQUEOJY_58866",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: restrictiveCrossing
            $scope.vc.createViewState({
                id: "Spacer2547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CRUCERECI_95868",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITEMMEP_241216",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: accountNumber
            $scope.vc.createViewState({
                id: "VA_2481BBVZTGCBDCR_830216",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REFERENII_77924",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITERBQN_479216",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: payAmount
            $scope.vc.createViewState({
                id: "VA_8983QPJHQZZOSML_321216",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORSLQL_66501",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: currencyId
            $scope.vc.createViewState({
                id: "VA_4212YIFTVBCOPPD_140216",
                componentStyle: [],
                label: ".",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_4212YIFTVBCOPPD_140216 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_4212YIFTVBCOPPD_140216', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_4212YIFTVBCOPPD_140216'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_4212YIFTVBCOPPD_140216");
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
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_582216",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentForm, Attribute: officeId
            $scope.vc.createViewState({
                id: "Spacer2237",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINANW_34561",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.Spacer2237 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('Spacer2237', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTSpacer2237'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("Spacer2237");
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
            //ViewState - Entity: PaymentForm, Attribute: economicDestination
            $scope.vc.createViewState({
                id: "Spacer1695",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESTINOCE_73285",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.Spacer1695 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('Spacer1695', 'ca_destino_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTSpacer1695'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("Spacer1695");
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
            //ViewState - Entity: PaymentForm, Attribute: concept
            $scope.vc.createViewState({
                id: "Spacer2254",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONCEPTOO_46083",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PAYMENTMODEEE_368_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PAYMENTMODEEE_368_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TPAYMENT_NS7",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ACEPTARDV_64984",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TPAYMENT_TEC",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CANCELARR_99965",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Loan = {
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                category: $scope.vc.channelDefaultValues("Loan", "category"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                isDisbursment: $scope.vc.channelDefaultValues("Loan", "isDisbursment"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                group: $scope.vc.channelDefaultValues("Loan", "group"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                officerID: $scope.vc.channelDefaultValues("Loan", "officerID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate")
            };
            $scope.vc.model.LoanAdditionalInformation = {
                dateToDisburse: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "dateToDisburse"),
                amountToCancel: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "amountToCancel"),
                amountOperation: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "amountOperation"),
                quotation: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "quotation"),
                lblAmountToCancel: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "lblAmountToCancel"),
                renovation: $scope.vc.channelDefaultValues("LoanAdditionalInformation", "renovation")
            };
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
                $scope.vc.render('VC_PAYMENTMDE_245368');
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
    var cobisMainModule = cobis.createModule("VC_PAYMENTMDE_245368", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_PAYMENTMDE_245368", {
            templateUrl: "VC_PAYMENTMDE_245368_FORM.html",
            controller: "VC_PAYMENTMDE_245368_CTRL",
            label: "PaymentModeForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PAYMENTMDE_245368?" + $.param(search);
            }
        });
        VC_PAYMENTMDE_245368(cobisMainModule);
    }]);
} else {
    VC_PAYMENTMDE_245368(cobisMainModule);
}