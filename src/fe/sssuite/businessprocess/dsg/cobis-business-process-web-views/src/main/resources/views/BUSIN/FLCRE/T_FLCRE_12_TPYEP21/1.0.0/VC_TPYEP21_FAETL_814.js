//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tpaymentplan = designerEvents.api.tpaymentplan || designer.dsgEvents();

function VC_TPYEP21_FAETL_814(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TPYEP21_FAETL_814_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TPYEP21_FAETL_814_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_12_TPYEP21",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TPYEP21_FAETL_814",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_12_TPYEP21",
        designerEvents.api.tpaymentplan,
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
                vcName: 'VC_TPYEP21_FAETL_814'
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
                    taskId: 'T_FLCRE_12_TPYEP21',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Category: "Category",
                    CategoryNew: "CategoryNew",
                    PaymentSelection: "PaymentSelection",
                    MemberAmount: "MemberAmount",
                    PaymentPlanHeader: "PaymentPlanHeader",
                    GeneralParameterLoan: "GeneralParameterLoan",
                    PaymentPlan: "PaymentPlan",
                    AmortizationTableItem: "AmortizationTableItem",
                    PaymentCapacity: "PaymentCapacity",
                    ApprovalCriteriaQuestion: "ApprovalCriteriaQuestion",
                    PaymentCapacityHeader: "PaymentCapacityHeader",
                    DebtorGeneral: "DebtorGeneral",
                    Holiday: "Holiday",
                    AmortizationTableHeader: "AmortizationTableHeader",
                    EditableItems: "EditableItems"
                },
                entities: {
                    Category: {
                        PaymentArrears: 'AT_CAT957ATRR00',
                        AmounToApply: 'AT_CAT957AUNL12',
                        bank: 'AT_CAT957BANK56',
                        AccountAbono: 'AT_CAT957CNBO35',
                        ConceptAsoc: 'AT_CAT957CNTA33',
                        Concept: 'AT_CAT957COEP74',
                        Currency: 'AT_CAT957CREY02',
                        ConceptTypeDescription: 'AT_CAT957CTCR03',
                        AccountPayment: 'AT_CAT957CTPY07',
                        DifferDays: 'AT_CAT957DRDA32',
                        ReferenceDescription: 'AT_CAT957ECRI97',
                        Reference: 'AT_CAT957EENE30',
                        ReferentialReadjustment: 'AT_CAT957EEUM99',
                        segment: 'AT_CAT957EGMT36',
                        PercentageDay: 'AT_CAT957ENTG63',
                        Factor: 'AT_CAT957FAOR47',
                        Funded: 'AT_CAT957FNDD20',
                        Affectation: 'AT_CAT957FTTO35',
                        Grace: 'AT_CAT957GRCE98',
                        HasDecimals: 'AT_CAT957HDAL27',
                        isHeritage: 'AT_CAT957HETG57',
                        Differ: 'AT_CAT957IFER44',
                        itemType: 'AT_CAT957IMTY53',
                        ItemDesc: 'AT_CAT957ITMS50',
                        CalculatedBase: 'AT_CAT957LEBS82',
                        MaxRate: 'AT_CAT957MAXR59',
                        Maximun: 'AT_CAT957MAXU35',
                        MethodOfPayment: 'AT_CAT957MEON23',
                        Minimum: 'AT_CAT957MIMM00',
                        RotMinimunRate: 'AT_CAT957MIMT63',
                        MinRate: 'AT_CAT957MINA75',
                        Money: 'AT_CAT957MOEY52',
                        AmountToApplyDesc: 'AT_CAT957MUPE99',
                        ConceptType: 'AT_CAT957NCEP81',
                        ConceptDescription: 'AT_CAT957NSPN99',
                        Provisioned: 'AT_CAT957OVON18',
                        ProductType: 'AT_CAT957PDUP16',
                        Percentage: 'AT_CAT957PENG62',
                        Priority: 'AT_CAT957PIRY70',
                        PaymentForm: 'AT_CAT957PMEO22',
                        Readjustment: 'AT_CAT957RJET51',
                        ReferenceAmount: 'AT_CAT957RNCU78',
                        sector: 'AT_CAT957SETR06',
                        Sign: 'AT_CAT957SIGN95',
                        isNew: 'AT_CAT957SNEW75',
                        Spread: 'AT_CAT957SPRD31',
                        DiscountForm: 'AT_CAT957SUOM48',
                        FormThirdPayment: 'AT_CAT957TRAT87',
                        ReadjustmentFactor: 'AT_CAT957USEI06',
                        ReadjustmentSign: 'AT_CAT957UTNI48',
                        Value: 'AT_CAT957VALU37',
                        PaymentFormDescription: 'AT_CAT957YTRP63',
                        _pks: [],
                        _entityId: 'EN_CATEGORYM957',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CategoryNew: {
                        Concept: 'AT_ATE531CCEP97',
                        Percentage: 'AT_ATE531CNTG76',
                        MethodOfPayment: 'AT_ATE531EOFP26',
                        Factor: 'AT_ATE531FATR68',
                        Reference: 'AT_ATE531FERE31',
                        ConceptType: 'AT_ATE531OCPT88',
                        Sign: 'AT_ATE531SIGN84',
                        _pks: [],
                        _entityId: 'EN_ATEGRYNEW531',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentSelection: {
                        creditType: 'AT65_CREDITYT825',
                        transactionNumber: 'AT70_TRANSANT825',
                        groupId: 'AT73_GROUPIDD825',
                        _pks: [],
                        _entityId: 'EN_PAYMENTLT_825',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    MemberAmount: {
                        memberId: 'AT17_MEMBERII619',
                        groupId: 'AT35_GROUPIDD619',
                        memberName: 'AT58_MEMBERNE619',
                        credit: 'AT74_CREDITMV619',
                        amount: 'AT80_AMOUNTHS619',
                        accountNumber: 'AT82_ACCOUNMM619',
                        secuential: 'AT95_SECUENLI619',
                        _pks: [],
                        _entityId: 'EN_MEMBERATN_619',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentPlanHeader: {
                        paymentDay: 'AT23_PAYMENAT771',
                        dispersionDateValidate: 'AT33_DISPERRO771',
                        account: 'AT42_ACCOUNTT771',
                        typePayment: 'AT80_TYPEPAYN771',
                        dispersionDate: 'AT99_DISPERAO771',
                        amount: 'AT_ANT771AMUN93',
                        approvedAmount: 'AT_ANT771AOUN07',
                        apr: 'AT_ANT771APRE32',
                        auxApprovedAmount: 'AT_ANT771AVEO47',
                        debitAccount: 'AT_ANT771BTCO94',
                        classOperation: 'AT_ANT771CARO73',
                        customerName: 'AT_ANT771CUOM65',
                        debit: 'AT_ANT771DBIT28',
                        daysPerYear: 'AT_ANT771DERA56',
                        idRequested: 'AT_ANT771DQUS87',
                        fee: 'AT_ANT771FEEQ56',
                        initialDate: 'AT_ANT771IATE13',
                        applicationNumber: 'AT_ANT771ICAT12',
                        localCurrency: 'AT_ANT771LURE16',
                        customerCode: 'AT_ANT771MEOE57',
                        productType: 'AT_ANT771ODCP64',
                        operationCode: 'AT_ANT771OEOD19',
                        rate: 'AT_ANT771RATE93',
                        currency: 'AT_ANT771RENC79',
                        shareValue: 'AT_ANT771SHAL56',
                        firstExpirationFeeDate: 'AT_ANT771SPRE60',
                        sumAmount: 'AT_ANT771SUUN83',
                        tea: 'AT_ANT771TEAD55',
                        tir: 'AT_ANT771TIRP92',
                        wayToPay: 'AT_ANT771WAYA88',
                        _pks: [],
                        _entityId: 'EN_ANTAHEDER771',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GeneralParameterLoan: {
                        acceptsAdditionalPayments: 'AT_NEA473ANPN23',
                        credit: 'AT_NEA473CRDI77',
                        helpText: 'AT_NEA473EPET84',
                        especialReadjustment: 'AT_NEA473ERSE82',
                        interestPayment: 'AT_NEA473ETME07',
                        exchangeRate: 'AT_NEA473HNGE08',
                        interestPaymentType: 'AT_NEA473IYME23',
                        allowsPrepay: 'AT_NEA473LPRA81',
                        allowsRenewal: 'AT_NEA473LRWA65',
                        paymentType: 'AT_NEA473METY66',
                        applyOnlyCapital: 'AT_NEA473OIAL08',
                        periodicity: 'AT_NEA473OITY73',
                        onlyCompleteFeePayments: 'AT_NEA473OMPE24',
                        depositType: 'AT_NEA473OTYP89',
                        payment: 'AT_NEA473PAME26',
                        keepTerm: 'AT_NEA473PERM11',
                        prePaymentType: 'AT_NEA473REPE32',
                        readjustmentPeriodicity: 'AT_NEA473RIOI95',
                        rateChange: 'AT_NEA473RTCG86',
                        extraordinaryEffectPayment: 'AT_NEA473YECY57',
                        _pks: [],
                        _entityId: 'EN_NEAPRMEAN473',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentPlan: {
                        daysPerYear: 'AT_AYM712APEA31',
                        termType: 'AT_AYM712ATQC70',
                        fixedpPaymentDate: 'AT_AYM712ATTE68',
                        bank: 'AT_AYM712BANK20',
                        tableType: 'AT_AYM712BLYE55',
                        capital: 'AT_AYM712CTAL41',
                        customerCode: 'AT_AYM712CTEO77',
                        interestPeriodGrace: 'AT_AYM712EACE02',
                        interestsPeriodGrace: 'AT_AYM712EERA54',
                        interestPeriod: 'AT_AYM712EREP01',
                        paymentDay: 'AT_AYM712ETDY12',
                        graceArrearsDays: 'AT_AYM712GARR88',
                        capitalPeriodGrace: 'AT_AYM712IALR81',
                        calculationStatus: 'AT_AYM712LOSS51',
                        monthNoPayment: 'AT_AYM712NENT04',
                        calculationBased: 'AT_AYM712NSED21',
                        avoidHolidays: 'AT_AYM712OHOI43',
                        capitalPeriod: 'AT_AYM712PILO63',
                        quotaInterest: 'AT_AYM712QAIT83',
                        quota: 'AT_AYM712QUOT62',
                        quotaType: 'AT_AYM712TATY64',
                        term: 'AT_AYM712TERM10',
                        basCalculationInterest: 'AT_AYM712UATI81',
                        _pks: [],
                        _entityId: 'EN_AYMENTLAN712',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AmortizationTableItem: {
                        Balance: 'AT_MRI884BAAC22',
                        Dividend: 'AT_MRI884DVDE03',
                        ExpirationDate: 'AT_MRI884EPTI34',
                        Item4: 'AT_MRI884IEM481',
                        Item6: 'AT_MRI884IEM603',
                        Item2: 'AT_MRI884ITE219',
                        Item7: 'AT_MRI884ITE729',
                        Item5: 'AT_MRI884ITEM43',
                        Item3: 'AT_MRI884ITEM64',
                        Item13: 'AT_MRI884ITM128',
                        Item11: 'AT_MRI884ITM148',
                        OperationNumber: 'AT_MRI884OENU60',
                        Fee: 'AT_MRI884SHRE57',
                        Item10: 'AT_MRI884TE1034',
                        Item12: 'AT_MRI884TEM155',
                        Item1: 'AT_MRI884TEM164',
                        Item8: 'AT_MRI884TEM887',
                        Item9: 'AT_MRI884TEM984',
                        _pks: [],
                        _entityId: 'EN_MRIZATITM884',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentCapacity: {
                        Balance5: 'AT_AEN625AAN573',
                        Balance9: 'AT_AEN625ANE944',
                        Balance11: 'AT_AEN625BAA127',
                        Balance4: 'AT_AEN625BAL417',
                        Balance7: 'AT_AEN625BAN705',
                        Balance6: 'AT_AEN625BANE67',
                        Balance8: 'AT_AEN625BLC803',
                        Balance3: 'AT_AEN625BLNC39',
                        Balance2: 'AT_AEN625BLNC84',
                        Balance1: 'AT_AEN625BLNE27',
                        CustomerID: 'AT_AEN625CORI29',
                        Balance12: 'AT_AEN625LANC40',
                        Balance10: 'AT_AEN625LE1053',
                        MonthAverage: 'AT_AEN625TEAG02',
                        TotalAnnual: 'AT_AEN625TOLA98',
                        CustomerName: 'AT_AEN625UTEA38',
                        _pks: [],
                        _entityId: 'EN_AENTAPAIT625',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ApprovalCriteriaQuestion: {
                        sharedEntityQuestion: 'AT_APO644AEET87',
                        comparedExplusiveCustomerQuestion: 'AT_APO644AETE75',
                        rebateRequest: 'AT_APO644EBEQ90',
                        internalScore: 'AT_APO644LSOR23',
                        maximumDiscountCustomerType: 'AT_APO644MITR05',
                        customerCPOPQuestion: 'AT_APO644OCPN24',
                        proposedRate: 'AT_APO644OPRA06',
                        customerNoCPOPQuestion: 'AT_APO644OQSO31',
                        applyRebateCROP: 'AT_APO644PBTR64',
                        rebate: 'AT_APO644REAT93',
                        rebateCustomerType: 'AT_APO644REYE23',
                        otherDebtCICQuestion: 'AT_APO644RIEN52',
                        recordsMatchingQuestion: 'AT_APO644RORT10',
                        currentRateFIE: 'AT_APO644RTIE25',
                        previousRateFIE: 'AT_APO644RURF17',
                        rateApply: 'AT_APO644TPPY20',
                        tariffRate: 'AT_APO644TRAE25',
                        _pks: [],
                        _entityId: 'EN_APOALRUSO644',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentCapacityHeader: {
                        StartMonth: 'AT_AYE293ARTM76',
                        CountTerm: 'AT_AYE293OUTM83',
                        PeriodGrace: 'AT_AYE293PEIO73',
                        Status: 'AT_AYE293SATU60',
                        ValidationSuccess: 'AT_AYE293VTSS51',
                        _pks: [],
                        _entityId: 'EN_AYENTACTE293',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DebtorGeneral: {
                        riskLevel: 'AT37_RISKLEVV342',
                        customerType: 'AT38_CUSTOMER342',
                        creditBureau: 'AT45_CREDITUU342',
                        rfc: 'AT94_RFCNDBHX342',
                        Address: 'AT_DEB342ADRS63',
                        CustomerCode: 'AT_DEB342CUST03',
                        CustomerName: 'AT_DEB342CUST55',
                        TypeDocumentId: 'AT_DEB342DOTD15',
                        DateCIC: 'AT_DEB342DTCC73',
                        Identification: 'AT_DEB342IDEN84',
                        AditionalCode: 'AT_DEB342ITDE08',
                        Role: 'AT_DEB342ROLE73',
                        Qualification: 'AT_DEB342UALN46',
                        _pks: ['CustomerCode'],
                        _entityId: 'EN_DEBTORHHW342',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Holiday: {
                        holidayDate: 'AT_HOL971HDAT62',
                        _pks: [],
                        _entityId: 'EN_HOLIDAYLQ971',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AmortizationTableHeader: {
                        Description: 'AT_ZTO288DCPN45',
                        Concept: 'AT_ZTO288OEPT64',
                        rate: 'AT_ZTO288RATE00',
                        Type: 'AT_ZTO288TYPE70',
                        _pks: [],
                        _entityId: 'EN_ZTOTBEEAD288',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    EditableItems: {
                        value: 'AT45_VALUEEPS383',
                        item: 'AT74_ITEMWXTO383',
                        _pks: [],
                        _entityId: 'EN_EDITABLMI_383',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QERYITSE_6962 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QERYITSE_6962 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QERYITSE_6962_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QERYITSE_6962_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ATEGRYNEW531',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QERYITSE_6962',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QERYITSE_6962_filters = {};
            $scope.vc.queryProperties.Q_QUYOINBL_3312 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUYOINBL_3312 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUYOINBL_3312_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUYOINBL_3312_filters;
                    parametersAux = {
                        OperationNumber: filters.OperationNumber
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MRIZATITM884',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUYOINBL_3312',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['OperationNumber'] = this.filters.OperationNumber;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QUYOINBL_3312_filters = {};
            $scope.vc.queryProperties.Q_MEMBERNA_9304 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_MEMBERNA_9304 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MEMBERNA_9304_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MEMBERNA_9304_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MEMBERATN_619',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MEMBERNA_9304',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_MEMBERNA_9304_filters = {};
            $scope.vc.queryProperties.Q_QUERIEMS_4251 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUERIEMS_4251 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUERIEMS_4251_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUERIEMS_4251_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CATEGORYM957',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUERIEMS_4251',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUERIEMS_4251_filters = {};
            var defaultValues = {
                Category: {},
                CategoryNew: {},
                PaymentSelection: {},
                MemberAmount: {},
                PaymentPlanHeader: {},
                GeneralParameterLoan: {},
                PaymentPlan: {},
                AmortizationTableItem: {},
                PaymentCapacity: {},
                ApprovalCriteriaQuestion: {},
                PaymentCapacityHeader: {},
                DebtorGeneral: {},
                Holiday: {},
                AmortizationTableHeader: {},
                EditableItems: {}
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
                $scope.vc.execute("temporarySave", VC_TPYEP21_FAETL_814, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_TPYEP21_FAETL_814, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_TPYEP21_FAETL_814, data, function() {});
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
            $scope.vc.viewState.VC_TPYEP21_FAETL_814 = {
                style: []
            }
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_04",
                hasId: true,
                componentStyle: [],
                label: 'Contenedor Acorde\u00f3n',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Cabecera
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_16",
                hasId: true,
                componentStyle: ["cabecera"],
                htmlSection: true,
                label: '[Grupo - Cabecera',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_16-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Pie de la vista]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_10",
                hasId: true,
                componentStyle: [],
                label: '[Grupo - Pie de la vista]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Rubros]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_12",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RUBROSYTF_19129",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Rubros]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_26",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Rubros]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Category = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "Concept", ''),
                        validation: {
                            ConceptRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    ConceptTypeDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "ConceptTypeDescription", '')
                    },
                    Reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "Reference", '')
                    },
                    Factor: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "Factor", 0)
                    },
                    MethodOfPayment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "MethodOfPayment", '')
                    },
                    ConceptType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "ConceptType", '')
                    },
                    ConceptDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "ConceptDescription", '')
                    },
                    Percentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "Percentage", 0)
                    },
                    Sign: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "Sign", '')
                    },
                    Value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "Value", 0)
                    },
                    PaymentFormDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Category", "PaymentFormDescription", '')
                    },
                    isHeritage: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Category = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUERIEMS_4251();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Category',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_UYCTE6570_70', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Category
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_UYCTE6570_70").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUERIEMS_4251 = $scope.vc.model.Category;
            $scope.vc.trackers.Category = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Category);
            $scope.vc.model.Category.bind('change', function(e) {
                $scope.vc.trackers.Category.track(e);
            });
            $scope.vc.grids.QV_UYCTE6570_70 = {};
            $scope.vc.grids.QV_UYCTE6570_70.queryId = 'Q_QUERIEMS_4251';
            $scope.vc.viewState.QV_UYCTE6570_70 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column = {};
            $scope.vc.grids.QV_UYCTE6570_70.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_UYCTE6570_70.events = {
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
                        moduleId: "BUSIN",
                        subModuleId: "FLCRE",
                        taskId: "T_FLCRE_24_CTORY86",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_CTORY86_CTEGO_587',
                        title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_UYCTE6570_70", dialogParameters);
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
                    $scope.vc.gridDataBound("QV_UYCTE6570_70");
                    $scope.vc.hideShowColumns("QV_UYCTE6570_70", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UYCTE6570_70.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UYCTE6570_70.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_UYCTE6570_70.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UYCTE6570_70 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UYCTE6570_70 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UYCTE6570_70.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UYCTE6570_70.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UYCTE6570_70.column.Concept = {
                title: 'Concepto',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_VWPAYMENLA2626_COEP813',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription = {
                title: 'BUSIN.DLB_BUSIN_TIPOLRXRX_31531',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_CTCR394',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.Reference = {
                title: 'BUSIN.DLB_BUSIN_RFERENIAL_57921',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_EENE971',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.Factor = {
                title: 'BUSIN.DLB_BUSIN_FACTORFQZ_14215',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_FAOR082',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_MEON555',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptType = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_NCEP311',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptDescription = {
                title: 'BUSIN.DLB_BUSIN_CONCEPTOM_59109',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_NSPN217',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.Percentage = {
                title: 'BUSIN.DLB_BUSIN_TASAGRLAC_24263',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_PENG209',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.Sign = {
                title: 'BUSIN.DLB_BUSIN_SIGNOTCWB_56579',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_SIGN952',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.Value = {
                title: 'BUSIN.DLB_BUSIN_VALORMDZS_51434',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_VALU101',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription = {
                title: 'BUSIN.DLB_BUSIN_FORMDEPAG_44742',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2626_YTRP823',
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.isHeritage = {
                title: 'IsHeritage',
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
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'Concept',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.Concept.title|translate:vc.viewState.QV_UYCTE6570_70.column.Concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.Concept.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.Concept.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.Concept.style' ng-bind='vc.getStringColumnFormat(dataItem.Concept, \"QV_UYCTE6570_70\", \"Concept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.Concept.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.Concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.Concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'ConceptTypeDescription',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.title|translate:vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.ConceptTypeDescription, \"QV_UYCTE6570_70\", \"ConceptTypeDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptTypeDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'Reference',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.Reference.title|translate:vc.viewState.QV_UYCTE6570_70.column.Reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.Reference.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.Reference.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.Reference.style' ng-bind='vc.getStringColumnFormat(dataItem.Reference, \"QV_UYCTE6570_70\", \"Reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.Reference.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.Reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.Reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'Factor',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.Factor.title|translate:vc.viewState.QV_UYCTE6570_70.column.Factor.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.Factor.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.Factor.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.Factor.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Factor, \"QV_UYCTE6570_70\", \"Factor\"):kendo.toString(#=Factor#, vc.viewState.QV_UYCTE6570_70.column.Factor.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.Factor.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.Factor.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.Factor.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'MethodOfPayment',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.title|translate:vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.style' ng-bind='vc.getStringColumnFormat(dataItem.MethodOfPayment, \"QV_UYCTE6570_70\", \"MethodOfPayment\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.MethodOfPayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'ConceptType',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.ConceptType.title|translate:vc.viewState.QV_UYCTE6570_70.column.ConceptType.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptType.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptType.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.ConceptType.style' ng-bind='vc.getStringColumnFormat(dataItem.ConceptType, \"QV_UYCTE6570_70\", \"ConceptType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.ConceptType.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.ConceptType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'ConceptDescription',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.title|translate:vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.ConceptDescription, \"QV_UYCTE6570_70\", \"ConceptDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.ConceptDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'Percentage',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.Percentage.title|translate:vc.viewState.QV_UYCTE6570_70.column.Percentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.Percentage.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.Percentage.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.Percentage.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Percentage, \"QV_UYCTE6570_70\", \"Percentage\"):kendo.toString(#=Percentage#, vc.viewState.QV_UYCTE6570_70.column.Percentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.Percentage.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.Percentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.Percentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'Sign',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.Sign.title|translate:vc.viewState.QV_UYCTE6570_70.column.Sign.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.Sign.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.Sign.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.Sign.style' ng-bind='vc.getStringColumnFormat(dataItem.Sign, \"QV_UYCTE6570_70\", \"Sign\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.Sign.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.Sign.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.Sign.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'Value',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.Value.title|translate:vc.viewState.QV_UYCTE6570_70.column.Value.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.Value.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.Value.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.Value.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Value, \"QV_UYCTE6570_70\", \"Value\"):kendo.toString(#=Value#, vc.viewState.QV_UYCTE6570_70.column.Value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.Value.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.Value.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.Value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                    field: 'PaymentFormDescription',
                    title: '{{vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.title|translate:vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.format,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.PaymentFormDescription, \"QV_UYCTE6570_70\", \"PaymentFormDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_70.column.PaymentFormDescription.hidden
                });
            }
            $scope.vc.viewState.QV_UYCTE6570_70.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_UYCTE6570_70.column.cmdEdition = {};
            $scope.vc.viewState.QV_UYCTE6570_70.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_UYCTE6570_70.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Category",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_UYCTE6570_70.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_UYCTE6570_70.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.GR_VWPAYMENLA26_26.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_UYCTE6570_70.events.customEdit($event, \"#:entity#\", grids.QV_UYCTE6570_70)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_UYCTE6570_70.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_UYCTE6570_70.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.GR_VWPAYMENLA26_26.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_UYCTE6570_70.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_UYCTE6570_70.toolbar = {
                CEQV_201_QV_UYCTE6570_70_368: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_UYCTE6570_70.toolbar = [{
                "name": "CEQV_201_QV_UYCTE6570_70_368",
                "text": "{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}",
                "template": "<button id='CEQV_201_QV_UYCTE6570_70_368' " + " ng-if='vc.viewState.QV_UYCTE6570_70.toolbar.CEQV_201_QV_UYCTE6570_70_368.visible' " + "ng-disabled = 'vc.viewState.GR_VWPAYMENLA26_26.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_UYCTE6570_70_368\",\"Category\")' class='btn btn-default cb-grid-button cb-btn-custom-nuevo'> #: text #</button>"
            }];
            //ViewState - Group: Separator
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_14",
                hasId: true,
                componentStyle: [],
                label: 'Separator',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2614_0000831",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Otros Rubros]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_27",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RUBROSNVO_58071",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CategoryNew = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Factor: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "Factor", 0)
                    },
                    MethodOfPayment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "MethodOfPayment", '')
                    },
                    ConceptType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "ConceptType", '')
                    },
                    Sign: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "Sign", '')
                    },
                    Percentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "Percentage", 0)
                    },
                    Reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "Reference", '')
                    },
                    Concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CategoryNew", "Concept", '')
                    }
                }
            });
            $scope.vc.model.CategoryNew = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QERYITSE_6962();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'CategoryNew',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERYI6962_42', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.CategoryNew
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_QERYI6962_42").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QERYITSE_6962 = $scope.vc.model.CategoryNew;
            $scope.vc.trackers.CategoryNew = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CategoryNew);
            $scope.vc.model.CategoryNew.bind('change', function(e) {
                $scope.vc.trackers.CategoryNew.track(e);
            });
            $scope.vc.grids.QV_QERYI6962_42 = {};
            $scope.vc.grids.QV_QERYI6962_42.queryId = 'Q_QERYITSE_6962';
            $scope.vc.viewState.QV_QERYI6962_42 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QERYI6962_42.column = {};
            $scope.vc.grids.QV_QERYI6962_42.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_QERYI6962_42.events = {
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
                    $scope.vc.trackers.CategoryNew.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QERYI6962_42.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QERYI6962_42");
                    $scope.vc.hideShowColumns("QV_QERYI6962_42", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QERYI6962_42.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QERYI6962_42.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_QERYI6962_42.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QERYI6962_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QERYI6962_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_QERYI6962_42.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QERYI6962_42.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "CategoryNew", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QERYI6962_42.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QERYI6962_42.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QERYI6962_42.column.Factor = {
                title: 'Factor',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXICR_288_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531FATR68 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.Factor.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXICR_288_27",
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.Factor.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERYI6962_42.column.Factor.format",
                        'k-decimals': "vc.viewState.QV_QERYI6962_42.column.Factor.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.Factor.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.MethodOfPayment = {
                title: 'Forma Pago',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLEG_483_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531EOFP26 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLEG_483_27",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.ConceptType = {
                title: 'Tipo Concepto',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNAN_663_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531OCPT88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.ConceptType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNAN_663_27",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.ConceptType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.ConceptType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.Sign = {
                title: 'Signo',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOVY_106_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531SIGN84 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.Sign.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOVY_106_27",
                        'maxlength': 2,
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.Sign.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.Sign.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.Percentage = {
                title: 'Tasa',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRVJ_403_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531CNTG76 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.Percentage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRVJ_403_27",
                        'maxlength': 13,
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.Percentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERYI6962_42.column.Percentage.format",
                        'k-decimals': "vc.viewState.QV_QERYI6962_42.column.Percentage.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.Percentage.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.Reference = {
                title: 'Referencial',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUZC_508_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531FERE31 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.Reference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUZC_508_27",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.Reference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.Reference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.Concept = {
                title: 'Concepto',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXTJ_580_27',
                element: []
            };
            $scope.vc.grids.QV_QERYI6962_42.AT_ATE531CCEP97 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERYI6962_42.column.Concept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXTJ_580_27",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QERYI6962_42.column.Concept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_12,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QERYI6962_42.column.Concept.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'Factor',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.Factor.title|translate:vc.viewState.QV_QERYI6962_42.column.Factor.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.Factor.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.Factor.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531FATR68.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.Factor.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Factor, \"QV_QERYI6962_42\", \"Factor\"):kendo.toString(#=Factor#, vc.viewState.QV_QERYI6962_42.column.Factor.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.Factor.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.Factor.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.Factor.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'MethodOfPayment',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.title|translate:vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531EOFP26.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.style' ng-bind='vc.getStringColumnFormat(dataItem.MethodOfPayment, \"QV_QERYI6962_42\", \"MethodOfPayment\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.MethodOfPayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'ConceptType',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.ConceptType.title|translate:vc.viewState.QV_QERYI6962_42.column.ConceptType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.ConceptType.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.ConceptType.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531OCPT88.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.ConceptType.style' ng-bind='vc.getStringColumnFormat(dataItem.ConceptType, \"QV_QERYI6962_42\", \"ConceptType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.ConceptType.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.ConceptType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.ConceptType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'Sign',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.Sign.title|translate:vc.viewState.QV_QERYI6962_42.column.Sign.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.Sign.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.Sign.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531SIGN84.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.Sign.style' ng-bind='vc.getStringColumnFormat(dataItem.Sign, \"QV_QERYI6962_42\", \"Sign\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.Sign.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.Sign.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.Sign.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'Percentage',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.Percentage.title|translate:vc.viewState.QV_QERYI6962_42.column.Percentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.Percentage.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.Percentage.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531CNTG76.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.Percentage.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Percentage, \"QV_QERYI6962_42\", \"Percentage\"):kendo.toString(#=Percentage#, vc.viewState.QV_QERYI6962_42.column.Percentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.Percentage.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.Percentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.Percentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'Reference',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.Reference.title|translate:vc.viewState.QV_QERYI6962_42.column.Reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.Reference.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.Reference.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531FERE31.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.Reference.style' ng-bind='vc.getStringColumnFormat(dataItem.Reference, \"QV_QERYI6962_42\", \"Reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.Reference.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.Reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.Reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERYI6962_42.columns.push({
                    field: 'Concept',
                    title: '{{vc.viewState.QV_QERYI6962_42.column.Concept.title|translate:vc.viewState.QV_QERYI6962_42.column.Concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERYI6962_42.column.Concept.width,
                    format: $scope.vc.viewState.QV_QERYI6962_42.column.Concept.format,
                    editor: $scope.vc.grids.QV_QERYI6962_42.AT_ATE531CCEP97.control,
                    template: "<span ng-class='vc.viewState.QV_QERYI6962_42.column.Concept.style' ng-bind='vc.getStringColumnFormat(dataItem.Concept, \"QV_QERYI6962_42\", \"Concept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERYI6962_42.column.Concept.style",
                        "title": "{{vc.viewState.QV_QERYI6962_42.column.Concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERYI6962_42.column.Concept.hidden
                });
            }
            $scope.vc.viewState.QV_QERYI6962_42.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_QERYI6962_42.column.cmdEdition = {};
            $scope.vc.viewState.QV_QERYI6962_42.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_QERYI6962_42.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_QERYI6962_42.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_QERYI6962_42.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.GR_VWPAYMENLA26_27.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_QERYI6962_42.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_QERYI6962_42.toolbar = {
                CEQV_201_QV_QERYI6962_42_736: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_QERYI6962_42.toolbar = [{
                "name": "CEQV_201_QV_QERYI6962_42_736",
                "text": "{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}",
                "template": "<button id='CEQV_201_QV_QERYI6962_42_736' " + " ng-if='vc.viewState.QV_QERYI6962_42.toolbar.CEQV_201_QV_QERYI6962_42_736.visible' " + "ng-disabled = 'vc.viewState.GR_VWPAYMENLA26_27.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_QERYI6962_42_736\",\"CategoryNew\")' class='btn btn-default cb-grid-button cb-btn-custom-nuevo'> #: text #</button>"
            }]; //ViewState - Group: [Grupo - Parámetros]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_13",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_NDCIONSDE_80393",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PaymentPlanHeader = {
                paymentDay: $scope.vc.channelDefaultValues("PaymentPlanHeader", "paymentDay"),
                dispersionDateValidate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "dispersionDateValidate"),
                account: $scope.vc.channelDefaultValues("PaymentPlanHeader", "account"),
                typePayment: $scope.vc.channelDefaultValues("PaymentPlanHeader", "typePayment"),
                dispersionDate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "dispersionDate"),
                amount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "amount"),
                approvedAmount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "approvedAmount"),
                apr: $scope.vc.channelDefaultValues("PaymentPlanHeader", "apr"),
                auxApprovedAmount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "auxApprovedAmount"),
                debitAccount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "debitAccount"),
                classOperation: $scope.vc.channelDefaultValues("PaymentPlanHeader", "classOperation"),
                customerName: $scope.vc.channelDefaultValues("PaymentPlanHeader", "customerName"),
                debit: $scope.vc.channelDefaultValues("PaymentPlanHeader", "debit"),
                daysPerYear: $scope.vc.channelDefaultValues("PaymentPlanHeader", "daysPerYear"),
                idRequested: $scope.vc.channelDefaultValues("PaymentPlanHeader", "idRequested"),
                fee: $scope.vc.channelDefaultValues("PaymentPlanHeader", "fee"),
                initialDate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "initialDate"),
                applicationNumber: $scope.vc.channelDefaultValues("PaymentPlanHeader", "applicationNumber"),
                localCurrency: $scope.vc.channelDefaultValues("PaymentPlanHeader", "localCurrency"),
                customerCode: $scope.vc.channelDefaultValues("PaymentPlanHeader", "customerCode"),
                productType: $scope.vc.channelDefaultValues("PaymentPlanHeader", "productType"),
                operationCode: $scope.vc.channelDefaultValues("PaymentPlanHeader", "operationCode"),
                rate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "rate"),
                currency: $scope.vc.channelDefaultValues("PaymentPlanHeader", "currency"),
                shareValue: $scope.vc.channelDefaultValues("PaymentPlanHeader", "shareValue"),
                firstExpirationFeeDate: $scope.vc.channelDefaultValues("PaymentPlanHeader", "firstExpirationFeeDate"),
                sumAmount: $scope.vc.channelDefaultValues("PaymentPlanHeader", "sumAmount"),
                tea: $scope.vc.channelDefaultValues("PaymentPlanHeader", "tea"),
                tir: $scope.vc.channelDefaultValues("PaymentPlanHeader", "tir"),
                wayToPay: $scope.vc.channelDefaultValues("PaymentPlanHeader", "wayToPay")
            };
            //ViewState - Group: [Pago]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_18",
                hasId: true,
                componentStyle: [],
                label: '[Pago]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: typePayment
            $scope.vc.createViewState({
                id: "VA_8375LIFACAQCGJL_261A26",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_8375LIFACAQCGJL_261A26 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'G',
                            value: $filter('translate')('BUSIN.LBL_BUSIN_PAGOSCOUP_79649')
                        }, {
                            code: 'I',
                            value: $filter('translate')('BUSIN.LBL_BUSIN_PAGOSCONE_43566')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_8375LIFACAQCGJL_261A26 !== "undefined") {}
            //ViewState - Entity: PaymentPlanHeader, Attribute: wayToPay
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2618_MEOE230",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FORMDEPAG_44742",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2618_MEOE230 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2618_MEOE230', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2618_MEOE230'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2618_MEOE230");
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
            //ViewState - Entity: PaymentPlanHeader, Attribute: account
            $scope.vc.createViewState({
                id: "VA_ACCOUNTQXYRZIXM_963A26",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CUENTAVIU_30208",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: debitAccount
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2618_BTCO941",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CUENTAVIU_30208",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2618_BTCO941 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2618_BTCO941', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2618_BTCO941'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2618_BTCO941");
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
                id: "VA_VABUTTONPSZFMGQ_712A26",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_MIEMBROSS_30893",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2618_MEOE369",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1631
            $scope.vc.createViewState({
                id: "G_VWPAYMELNP_969A26",
                hasId: true,
                componentStyle: [],
                label: 'Group1631',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.MemberAmount = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "secuential", 0)
                    },
                    accountNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "accountNumber", '')
                    },
                    memberName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "memberName", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "amount", 0)
                    },
                    memberId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "memberId", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "groupId", 0)
                    },
                    credit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("MemberAmount", "credit", 0)
                    }
                }
            });
            $scope.vc.model.MemberAmount = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_MEMBERNA_9304();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
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
                    model: $scope.vc.types.MemberAmount
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9304_30287").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MEMBERNA_9304 = $scope.vc.model.MemberAmount;
            $scope.vc.trackers.MemberAmount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.MemberAmount);
            $scope.vc.model.MemberAmount.bind('change', function(e) {
                $scope.vc.trackers.MemberAmount.track(e);
            });
            $scope.vc.grids.QV_9304_30287 = {};
            $scope.vc.grids.QV_9304_30287.queryId = 'Q_MEMBERNA_9304';
            $scope.vc.viewState.QV_9304_30287 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9304_30287.column = {};
            $scope.vc.grids.QV_9304_30287.editable = false;
            $scope.vc.grids.QV_9304_30287.events = {
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
                    $scope.vc.trackers.MemberAmount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9304_30287.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_9304_30287");
                    $scope.vc.hideShowColumns("QV_9304_30287", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9304_30287.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9304_30287.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9304_30287.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9304_30287 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9304_30287 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9304_30287.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9304_30287.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9304_30287.column.secuential = {
                title: 'secuential',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCQN_920A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT95_SECUENLI619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.secuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCQN_920A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_30287.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_9304_30287.column.secuential.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.secuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_30287.column.accountNumber = {
                title: 'BUSIN.LBL_BUSIN_NMERODEAN_36022',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXELZ_635A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT82_ACCOUNMM619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.accountNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXELZ_635A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.accountNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.accountNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_30287.column.memberName = {
                title: 'BUSIN.LBL_BUSIN_NOMBRECEL_25540',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEQF_589A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT58_MEMBERNE619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.memberName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEQF_589A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.memberName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.memberName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_30287.column.amount = {
                title: 'amount',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLVH_588A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT80_AMOUNTHS619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLVH_588A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_30287.column.amount.format",
                        'k-decimals': "vc.viewState.QV_9304_30287.column.amount.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_30287.column.memberId = {
                title: 'BUSIN.LBL_BUSIN_CDIGODECT_31316',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMAM_577A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT17_MEMBERII619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.memberId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMAM_577A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.memberId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_30287.column.memberId.format",
                        'k-decimals': "vc.viewState.QV_9304_30287.column.memberId.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.memberId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_30287.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMUW_239A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT35_GROUPIDD619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMUW_239A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_30287.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_9304_30287.column.groupId.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9304_30287.column.credit = {
                title: 'credit',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWNU_509A26',
                element: []
            };
            $scope.vc.grids.QV_9304_30287.AT74_CREDITMV619 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9304_30287.column.credit.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWNU_509A26",
                        'data-validation-code': "{{vc.viewState.QV_9304_30287.column.credit.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9304_30287.column.credit.format",
                        'k-decimals': "vc.viewState.QV_9304_30287.column.credit.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_13,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9304_30287.column.credit.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_9304_30287.column.secuential.title|translate:vc.viewState.QV_9304_30287.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.secuential.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.secuential.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT95_SECUENLI619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.secuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_9304_30287\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_9304_30287.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_30287.column.secuential.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'accountNumber',
                    title: '{{vc.viewState.QV_9304_30287.column.accountNumber.title|translate:vc.viewState.QV_9304_30287.column.accountNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.accountNumber.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.accountNumber.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT82_ACCOUNMM619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.accountNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.accountNumber, \"QV_9304_30287\", \"accountNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9304_30287.column.accountNumber.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.accountNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.accountNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'memberName',
                    title: '{{vc.viewState.QV_9304_30287.column.memberName.title|translate:vc.viewState.QV_9304_30287.column.memberName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.memberName.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.memberName.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT58_MEMBERNE619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.memberName.style' ng-bind='vc.getStringColumnFormat(dataItem.memberName, \"QV_9304_30287\", \"memberName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9304_30287.column.memberName.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.memberName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.memberName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_9304_30287.column.amount.title|translate:vc.viewState.QV_9304_30287.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.amount.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.amount.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT80_AMOUNTHS619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_9304_30287\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_9304_30287.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_30287.column.amount.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'memberId',
                    title: '{{vc.viewState.QV_9304_30287.column.memberId.title|translate:vc.viewState.QV_9304_30287.column.memberId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.memberId.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.memberId.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT17_MEMBERII619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.memberId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.memberId, \"QV_9304_30287\", \"memberId\"):kendo.toString(#=memberId#, vc.viewState.QV_9304_30287.column.memberId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_30287.column.memberId.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.memberId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.memberId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_9304_30287.column.groupId.title|translate:vc.viewState.QV_9304_30287.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.groupId.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.groupId.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT35_GROUPIDD619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_9304_30287\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_9304_30287.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_30287.column.groupId.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9304_30287.columns.push({
                    field: 'credit',
                    title: '{{vc.viewState.QV_9304_30287.column.credit.title|translate:vc.viewState.QV_9304_30287.column.credit.titleArgs}}',
                    width: $scope.vc.viewState.QV_9304_30287.column.credit.width,
                    format: $scope.vc.viewState.QV_9304_30287.column.credit.format,
                    editor: $scope.vc.grids.QV_9304_30287.AT74_CREDITMV619.control,
                    template: "<span ng-class='vc.viewState.QV_9304_30287.column.credit.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.credit, \"QV_9304_30287\", \"credit\"):kendo.toString(#=credit#, vc.viewState.QV_9304_30287.column.credit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9304_30287.column.credit.style",
                        "title": "{{vc.viewState.QV_9304_30287.column.credit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9304_30287.column.credit.hidden
                });
            }
            $scope.vc.viewState.QV_9304_30287.toolbar = {}
            $scope.vc.grids.QV_9304_30287.toolbar = [];
            $scope.vc.model.PaymentSelection = {
                creditType: $scope.vc.channelDefaultValues("PaymentSelection", "creditType"),
                transactionNumber: $scope.vc.channelDefaultValues("PaymentSelection", "transactionNumber"),
                groupId: $scope.vc.channelDefaultValues("PaymentSelection", "groupId")
            };
            //ViewState - Group: Group1131
            $scope.vc.createViewState({
                id: "G_VWPAYMEATT_914A26",
                hasId: true,
                componentStyle: [],
                label: 'Group1131',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: PaymentSelection, Attribute: groupId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXOOV_735A26",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_GRUPOSMDD_37129",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentSelection, Attribute: transactionNumber
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPFM_878A26",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_TRANSACCO_42353",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentSelection, Attribute: creditType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXUPR_935A26",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CREDITOFW_45667",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Condiciones]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_19",
                hasId: true,
                componentStyle: [],
                label: '[Condiciones]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GeneralParameterLoan = {
                acceptsAdditionalPayments: $scope.vc.channelDefaultValues("GeneralParameterLoan", "acceptsAdditionalPayments"),
                credit: $scope.vc.channelDefaultValues("GeneralParameterLoan", "credit"),
                helpText: $scope.vc.channelDefaultValues("GeneralParameterLoan", "helpText"),
                especialReadjustment: $scope.vc.channelDefaultValues("GeneralParameterLoan", "especialReadjustment"),
                interestPayment: $scope.vc.channelDefaultValues("GeneralParameterLoan", "interestPayment"),
                exchangeRate: $scope.vc.channelDefaultValues("GeneralParameterLoan", "exchangeRate"),
                interestPaymentType: $scope.vc.channelDefaultValues("GeneralParameterLoan", "interestPaymentType"),
                allowsPrepay: $scope.vc.channelDefaultValues("GeneralParameterLoan", "allowsPrepay"),
                allowsRenewal: $scope.vc.channelDefaultValues("GeneralParameterLoan", "allowsRenewal"),
                paymentType: $scope.vc.channelDefaultValues("GeneralParameterLoan", "paymentType"),
                applyOnlyCapital: $scope.vc.channelDefaultValues("GeneralParameterLoan", "applyOnlyCapital"),
                periodicity: $scope.vc.channelDefaultValues("GeneralParameterLoan", "periodicity"),
                onlyCompleteFeePayments: $scope.vc.channelDefaultValues("GeneralParameterLoan", "onlyCompleteFeePayments"),
                depositType: $scope.vc.channelDefaultValues("GeneralParameterLoan", "depositType"),
                payment: $scope.vc.channelDefaultValues("GeneralParameterLoan", "payment"),
                keepTerm: $scope.vc.channelDefaultValues("GeneralParameterLoan", "keepTerm"),
                prePaymentType: $scope.vc.channelDefaultValues("GeneralParameterLoan", "prePaymentType"),
                readjustmentPeriodicity: $scope.vc.channelDefaultValues("GeneralParameterLoan", "readjustmentPeriodicity"),
                rateChange: $scope.vc.channelDefaultValues("GeneralParameterLoan", "rateChange"),
                extraordinaryEffectPayment: $scope.vc.channelDefaultValues("GeneralParameterLoan", "extraordinaryEffectPayment")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_25",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: allowsRenewal
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2625_LRWA032",
                componentStyle: ["text-right"],
                label: "BUSIN.DLB_BUSIN_RMIRENVCI_25325",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: allowsPrepay
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2625_LPRA172",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PRITANCAR_39412",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_28",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: payment
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2628_PAME177",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2628_PAME177 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'D',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_GOPORCUOT_07320')
                        }, {
                            code: 'C',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_PAOPORUBO_19171')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2628_PAME177 !== "undefined") {}
            //ViewState - Entity: GeneralParameterLoan, Attribute: interestPayment
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2628_ETME049",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2628_ETME049 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'A',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_GITEAULAD_85075')
                        }, {
                            code: 'P',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_NTESSREDS_22892')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2628_ETME049 !== "undefined") {}
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2628_LRWA385",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_29",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: acceptsAdditionalPayments
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2629_ANPN062",
                componentStyle: [],
                labelImageId: "glyphicon glyphicon-info-sign",
                label: "BUSIN.DLB_BUSIN_AETAPGOSE_85662",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2629_ANPN062 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2629_ANPN062 !== "undefined") {}
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_30",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: paymentType
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2630_METY849",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_TIPDEPAGO_42621",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2630_METY849 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'N',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_AOOLLTADO_36078')
                        }, {
                            code: 'E',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_PASETAINR_32979')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2630_METY849 !== "undefined") {}
            //ViewState - Entity: GeneralParameterLoan, Attribute: extraordinaryEffectPayment
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2630_YECY081",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_EOPOETODO_12793",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2630_YECY081 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'C',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_ECNDECUTD_63162')
                        }, {
                            code: 'T',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_EUCIDETPO_26252')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2630_YECY081 !== "undefined") {}
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2630_LRWA286",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_31",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: exchangeRate
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2631_HNGE222",
                componentStyle: [],
                labelImageId: "glyphicon glyphicon-info-sign",
                label: "BUSIN.DLB_BUSIN_CAMBIOTAS_72875",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2631_HNGE222 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_REJUSTABL_76102')
                        }, {
                            code: 'N',
                            value: $filter('translate')('BUSIN.DLB_BUSIN_NEAUSTALE_73874')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2631_HNGE222 !== "undefined") {}
            //ViewState - Entity: GeneralParameterLoan, Attribute: periodicity
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2631_OITY034",
                componentStyle: [],
                labelImageId: "glyphicon glyphicon-info-sign",
                label: "BUSIN.DLB_BUSIN_PERIDCIDD_86135",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_32",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2632_0000261",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: especialReadjustment
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2632_ERSE615",
                componentStyle: [],
                labelImageId: "glyphicon glyphicon-info-sign",
                label: "BUSIN.DLB_BUSIN_AJUSTSCIL_12225",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2632_ERSE615 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2632_ERSE615 !== "undefined") {}
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_33",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2633_0000497",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralParameterLoan, Attribute: readjustmentPeriodicity
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2633_RIOI469",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ERIDDRUAI_61397",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2633_RIOI469 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_VWPAYMENLA2633_RIOI469 !== "undefined") {}
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_34",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2634_LRWA164",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2634_0000932",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Button]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_21",
                hasId: true,
                componentStyle: [],
                label: '[Button]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2621_0000881",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2621_0000855",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GARAPMETR_90233",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2621_0000417",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2621_0000251",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: [Grupo - Tabla de Amortización]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_20",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ADEMTACIN_10056",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Grupo - Criterio 0
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_15",
                hasId: true,
                componentStyle: [],
                label: 'Grupo - Criterio 0',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: approvedAmount
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_AOUN065",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DIRENTMUT_35064",
                format: "##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 36,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: initialDate
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_IATE307",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FECORINIO_74083",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: firstExpirationFeeDate
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_SPRE849",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FNETODECO_16576",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: rate
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_RATE787",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_TASAGRLAC_24263",
                format: "##0.00",
                suffix: "%",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: tea
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_APRE101",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_TEAWARKMU_89934",
                format: "##0.00",
                suffix: "%",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: tir
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_TIRP175",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_TIRLBLDQW_41281",
                format: "##0.00",
                suffix: "%",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: auxApprovedAmount
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_AVEO102",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Query
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: dispersionDate
            $scope.vc.createViewState({
                id: "VA_DISPERSIONDATTT_417A26",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FECHADIRP_78999",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlanHeader, Attribute: paymentDay
            $scope.vc.createViewState({
                id: "VA_PAYMENTDAYSQXGZ_884A26",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_DAPAGOYWT_65194",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2615_0000668",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PaymentPlan = {
                daysPerYear: $scope.vc.channelDefaultValues("PaymentPlan", "daysPerYear"),
                termType: $scope.vc.channelDefaultValues("PaymentPlan", "termType"),
                fixedpPaymentDate: $scope.vc.channelDefaultValues("PaymentPlan", "fixedpPaymentDate"),
                bank: $scope.vc.channelDefaultValues("PaymentPlan", "bank"),
                tableType: $scope.vc.channelDefaultValues("PaymentPlan", "tableType"),
                capital: $scope.vc.channelDefaultValues("PaymentPlan", "capital"),
                customerCode: $scope.vc.channelDefaultValues("PaymentPlan", "customerCode"),
                interestPeriodGrace: $scope.vc.channelDefaultValues("PaymentPlan", "interestPeriodGrace"),
                interestsPeriodGrace: $scope.vc.channelDefaultValues("PaymentPlan", "interestsPeriodGrace"),
                interestPeriod: $scope.vc.channelDefaultValues("PaymentPlan", "interestPeriod"),
                paymentDay: $scope.vc.channelDefaultValues("PaymentPlan", "paymentDay"),
                graceArrearsDays: $scope.vc.channelDefaultValues("PaymentPlan", "graceArrearsDays"),
                capitalPeriodGrace: $scope.vc.channelDefaultValues("PaymentPlan", "capitalPeriodGrace"),
                calculationStatus: $scope.vc.channelDefaultValues("PaymentPlan", "calculationStatus"),
                monthNoPayment: $scope.vc.channelDefaultValues("PaymentPlan", "monthNoPayment"),
                calculationBased: $scope.vc.channelDefaultValues("PaymentPlan", "calculationBased"),
                avoidHolidays: $scope.vc.channelDefaultValues("PaymentPlan", "avoidHolidays"),
                capitalPeriod: $scope.vc.channelDefaultValues("PaymentPlan", "capitalPeriod"),
                quotaInterest: $scope.vc.channelDefaultValues("PaymentPlan", "quotaInterest"),
                quota: $scope.vc.channelDefaultValues("PaymentPlan", "quota"),
                quotaType: $scope.vc.channelDefaultValues("PaymentPlan", "quotaType"),
                term: $scope.vc.channelDefaultValues("PaymentPlan", "term"),
                basCalculationInterest: $scope.vc.channelDefaultValues("PaymentPlan", "basCalculationInterest")
            };
            //ViewState - Group: [Grupo - Criterio 1]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_07",
                hasId: true,
                componentStyle: [],
                label: '[Grupo - Criterio 1]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: tableType
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_BLYE585",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_TIPODEABL_33677",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2605_BLYE585 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2605_BLYE585', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2605_BLYE585'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2605_BLYE585");
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
            //ViewState - Entity: PaymentPlan, Attribute: quota
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2607_QUOT918",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CUOTADPJP_65632",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2607_CTAL292",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: term
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2607_TERM808",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                format: "n0",
                decimals: 0,
                validationCode: 96,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: termType
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2607_ATQC570",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2607_ATQC570 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2607_ATQC570', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2607_ATQC570'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2607_ATQC570");
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
            //ViewState - Entity: PaymentPlan, Attribute: basCalculationInterest
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2607_UATI478",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_BSCLCINTS_68385",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2607_UATI478 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2607_UATI478', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2607_UATI478'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2607_UATI478");
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
                id: "VA_VWPAYMENLA2607_CTEO478",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Criterio 1]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_08",
                hasId: true,
                componentStyle: [],
                label: '[Grupo - Criterio 1]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: fixedpPaymentDate
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_ATTE607",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FCHAPGOIJ_10233",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2605_ATTE607 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2605_ATTE607");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: PaymentPlan, Attribute: paymentDay
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_ETDY540",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DAPAGONDO_10805",
                format: "n0",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: monthNoPayment
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_NENT977",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MEDENOPAO_66497",
                format: "n0",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2608_CTEO475",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Criterio 2]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_05",
                hasId: true,
                componentStyle: [],
                label: '[Grupo - Criterio 2]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: quotaType
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_TATY621",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2605_TATY621 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2605_TATY621', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2605_TATY621'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2605_TATY621");
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
            //ViewState - Entity: PaymentPlan, Attribute: capitalPeriod
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_PILO354",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PCAPTAZKQ_30725",
                format: "######",
                suffix: "d\u00edas",
                decimals: 0,
                validationCode: 96,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: interestPeriod
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_EREP542",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PINTYWHBD_54757",
                format: "######",
                suffix: "d\u00edas",
                decimals: 0,
                validationCode: 96,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_CTEO891",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: capitalPeriodGrace
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_IALR796",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ERIOGAPIL_92412",
                format: "######",
                suffix: "d\u00edas",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: interestPeriodGrace
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_EACE223",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RIDGAIINS_94307",
                format: "######",
                suffix: "d\u00edas",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_0000721",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_0000733",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: quotaInterest
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2605_QAIT788",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_UOODDERAC_77005",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2605_QAIT788 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VWPAYMENLA2605_QAIT788', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VWPAYMENLA2605_QAIT788'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2605_QAIT788");
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
                id: "VA_VWPAYMENLA2605_BLYE951",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Critero 3]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_17",
                hasId: true,
                componentStyle: [],
                label: '[Grupo - Critero 3]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: graceArrearsDays
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2617_GARR154",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DGRACIASO_83463",
                format: "######",
                suffix: "d\u00edas",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PaymentPlan, Attribute: avoidHolidays
            $scope.vc.createViewState({
                id: "VA_VWPAYMENLA2617_OHOI726",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ITARFERIS_77638",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VWPAYMENLA2617_OHOI726 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_VWPAYMENLA2617_OHOI726");
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
                id: "VA_VWPAYMENLA2617_CTEO321",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Tabla de Amortización]
            $scope.vc.createViewState({
                id: "GR_VWPAYMENLA26_11",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: "BUSIN.DLB_BUSIN_ADEMTACIN_10056",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AmortizationTableItem = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Dividend: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Dividend", 0)
                    },
                    ExpirationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "ExpirationDate", new Date())
                    },
                    Balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Balance", 0)
                    },
                    Item1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item1", 0)
                    },
                    Item2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item2", 0)
                    },
                    Item3: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item3", 0)
                    },
                    Item4: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item4", 0)
                    },
                    Item5: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item5", 0)
                    },
                    Item7: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item7", 0)
                    },
                    Item8: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item8", 0)
                    },
                    Item9: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item9", 0)
                    },
                    Item10: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item10", 0)
                    },
                    Item11: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item11", 0)
                    },
                    Item12: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item12", 0)
                    },
                    Item13: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item13", 0)
                    },
                    Item6: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Item6", 0)
                    },
                    Fee: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTableItem", "Fee", 0)
                    },
                    OperationNumber: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.AmortizationTableItem = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUYOINBL_3312();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'AmortizationTableItem',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QUYOI3312_16', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.AmortizationTableItem
                },
                aggregate: [{
                    field: "Item1",
                    aggregate: "sum"
                }, {
                    field: "Item2",
                    aggregate: "sum"
                }, {
                    field: "Item3",
                    aggregate: "sum"
                }, {
                    field: "Item4",
                    aggregate: "sum"
                }, {
                    field: "Item5",
                    aggregate: "sum"
                }, {
                    field: "Item7",
                    aggregate: "sum"
                }, {
                    field: "Item8",
                    aggregate: "sum"
                }, {
                    field: "Item9",
                    aggregate: "sum"
                }, {
                    field: "Item10",
                    aggregate: "sum"
                }, {
                    field: "Item11",
                    aggregate: "sum"
                }, {
                    field: "Item12",
                    aggregate: "sum"
                }, {
                    field: "Item13",
                    aggregate: "sum"
                }, {
                    field: "Item6",
                    aggregate: "sum"
                }, {
                    field: "Fee",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_QUYOI3312_16").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUYOINBL_3312 = $scope.vc.model.AmortizationTableItem;
            $scope.vc.trackers.AmortizationTableItem = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationTableItem);
            $scope.vc.model.AmortizationTableItem.bind('change', function(e) {
                $scope.vc.trackers.AmortizationTableItem.track(e);
            });
            $scope.vc.grids.QV_QUYOI3312_16 = {};
            $scope.vc.grids.QV_QUYOI3312_16.queryId = 'Q_QUYOINBL_3312';
            $scope.vc.viewState.QV_QUYOI3312_16 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column = {};
            $scope.vc.grids.QV_QUYOI3312_16.editable = {
                mode: 'incell'
            };
            $scope.vc.grids.QV_QUYOI3312_16.events = {
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
                    $scope.vc.trackers.AmortizationTableItem.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    var columnIndex = this.cellIndex(e.container);
                    var fieldName = this.thead.find("th").eq(columnIndex).data("field");
                    if (angular.isDefined($scope.vc.viewState.QV_QUYOI3312_16.column[fieldName]) && $scope.vc.viewState.QV_QUYOI3312_16.column[fieldName].enabled === false) {
                        this.closeCell();
                        return;
                    }
                    $scope.vc.grids.QV_QUYOI3312_16.selectedRow = e.model;
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
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'AmortizationTableItem',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_QUYOI3312_16", args, function() {
                        if (args.cancel) {
                            $("#QV_QUYOI3312_16").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'AmortizationTableItem',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_QUYOI3312_16", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_QUYOI3312_16");
                    $scope.vc.hideShowColumns("QV_QUYOI3312_16", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUYOI3312_16.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUYOI3312_16.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_QUYOI3312_16.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUYOI3312_16 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUYOI3312_16 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_QUYOI3312_16.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QUYOI3312_16.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "AmortizationTableItem", $scope);
                        }
                    });
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_QUYOI3312_16.events.evalGridRowRendering(i, dataView[i]);
                    }
                },
                save: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                },
                remove: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUYOI3312_16.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUYOI3312_16.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend = {
                title: 'BUSIN.DLB_BUSIN_LBLNUMBER_44946',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_DVDE005',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884DVDE03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Dividend.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_DVDE005",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Dividend.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Dividend.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Dividend.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Dividend.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate = {
                title: 'BUSIN.DLB_BUSIN_EXIRTIONA_39042',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_EPTI184',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884EPTI34 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_EPTI184",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.validationCode}}",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_EPTI184',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_EPTI184',this.dataItem,'" + options.field + "')",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Balance = {
                title: 'BUSIN.DLB_BUSIN_LDOECITAL_77904',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_BAAC274',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884BAAC22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Balance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_BAAC274",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Balance.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Balance.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Balance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item1 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_TEM1405',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM164 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item1.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_TEM1405",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item1.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item1.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_TEM1405',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_TEM1405',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item1.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item2 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_ITE2959',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE219 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item2.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_ITE2959",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item2.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item2.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_ITE2959',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_ITE2959',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item2.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item3 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_ITEM212',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM64 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item3.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_ITEM212",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item3.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item3.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item3.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_ITEM212',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_ITEM212',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item3.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item4 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_IEM4759',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM481 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item4.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_IEM4759",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item4.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item4.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item4.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_IEM4759',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_IEM4759',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item4.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item5 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_ITEM747',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item5.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_ITEM747",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item5.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item5.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item5.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_ITEM747',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_ITEM747',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item5.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item7 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_ITE7198',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE729 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item7.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_ITE7198",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item7.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item7.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item7.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_ITE7198',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_ITE7198',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item7.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item8 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_TEM8856',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM887 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item8.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_TEM8856",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item8.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item8.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item8.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_TEM8856',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_TEM8856',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item8.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item9 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_TEM9148',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM984 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item9.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_TEM9148",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item9.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item9.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item9.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_TEM9148',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_TEM9148',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item9.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item10 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_TE10172',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TE1034 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item10.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_TE10172",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item10.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item10.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item10.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_TE10172',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_TE10172',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item10.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item11 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_ITM1595',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item11.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_ITM1595",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item11.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item11.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item11.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_ITM1595',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_ITM1595',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item11.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item12 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_TEM1824',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM155 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item12.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_TEM1824",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item12.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item12.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item12.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_TEM1824',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_TEM1824',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item12.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item13 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_ITM1742',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM128 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item13.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_ITM1742",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item13.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item13.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item13.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_ITM1742',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_ITM1742',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item13.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item6 = {
                title: 'BUSIN.DLB_BUSIN_RUBROTGJY_74230',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_IEM6601',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM603 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item6.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_IEM6601",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Item6.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Item6.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Item6.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_VWPAYMENLA2611_IEM6601',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_VWPAYMENLA2611_IEM6601',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item6.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Fee = {
                title: 'BUSIN.DLB_BUSIN_FEEQERNRC_97394',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_VWPAYMENLA2611_SHRE931',
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884SHRE57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Fee.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VWPAYMENLA2611_SHRE931",
                        'data-validation-code': "{{vc.viewState.QV_QUYOI3312_16.column.Fee.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUYOI3312_16.column.Fee.format",
                        'k-decimals': "vc.viewState.QV_QUYOI3312_16.column.Fee.decimals",
                        'data-cobis-group': "GroupLayout,GR_VWPAYMENLA26_20,5",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Fee.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.OperationNumber = {
                title: 'OperationNumber',
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
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Dividend',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Dividend.title|translate:vc.viewState.QV_QUYOI3312_16.column.Dividend.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884DVDE03.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Dividend.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Dividend, \"QV_QUYOI3312_16\", \"Dividend\"):kendo.toString(#=Dividend#, vc.viewState.QV_QUYOI3312_16.column.Dividend.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Dividend.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Dividend.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'ExpirationDate',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.title|translate:vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884EPTI34.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.style'>#=((ExpirationDate !== null) ? kendo.toString(ExpirationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Balance',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Balance.title|translate:vc.viewState.QV_QUYOI3312_16.column.Balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Balance.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Balance.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884BAAC22.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Balance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Balance, \"QV_QUYOI3312_16\", \"Balance\"):kendo.toString(#=Balance#, vc.viewState.QV_QUYOI3312_16.column.Balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Balance.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item1',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item1.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item1.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM164.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item1.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item1, \"QV_QUYOI3312_16\", \"Item1\"):kendo.toString(#=Item1#, vc.viewState.QV_QUYOI3312_16.column.Item1.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item1.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item1.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item2',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item2.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item2.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE219.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item2.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item2, \"QV_QUYOI3312_16\", \"Item2\"):kendo.toString(#=Item2#, vc.viewState.QV_QUYOI3312_16.column.Item2.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item2.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item2.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item3',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item3.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item3.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM64.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item3.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item3, \"QV_QUYOI3312_16\", \"Item3\"):kendo.toString(#=Item3#, vc.viewState.QV_QUYOI3312_16.column.Item3.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item3.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item3.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item3.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item3.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item4',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item4.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item4.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM481.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item4.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item4, \"QV_QUYOI3312_16\", \"Item4\"):kendo.toString(#=Item4#, vc.viewState.QV_QUYOI3312_16.column.Item4.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item4.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item4.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item4.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item4.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item5',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item5.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item5.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM43.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item5.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item5, \"QV_QUYOI3312_16\", \"Item5\"):kendo.toString(#=Item5#, vc.viewState.QV_QUYOI3312_16.column.Item5.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item5.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item5.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item5.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item5.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item7',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item7.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item7.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE729.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item7.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item7, \"QV_QUYOI3312_16\", \"Item7\"):kendo.toString(#=Item7#, vc.viewState.QV_QUYOI3312_16.column.Item7.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item7.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item7.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item7.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item8',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item8.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item8.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM887.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item8.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item8, \"QV_QUYOI3312_16\", \"Item8\"):kendo.toString(#=Item8#, vc.viewState.QV_QUYOI3312_16.column.Item8.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item8.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item8.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item8.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item8.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item9',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item9.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item9.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM984.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item9.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item9, \"QV_QUYOI3312_16\", \"Item9\"):kendo.toString(#=Item9#, vc.viewState.QV_QUYOI3312_16.column.Item9.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item9.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item9.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item9.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item9.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item10',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item10.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item10.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TE1034.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item10.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item10, \"QV_QUYOI3312_16\", \"Item10\"):kendo.toString(#=Item10#, vc.viewState.QV_QUYOI3312_16.column.Item10.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item10.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item10.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item10.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item10.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item11',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item11.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item11.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM148.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item11.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item11, \"QV_QUYOI3312_16\", \"Item11\"):kendo.toString(#=Item11#, vc.viewState.QV_QUYOI3312_16.column.Item11.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item11.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item11.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item11.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item11.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item12',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item12.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item12.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM155.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item12.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item12, \"QV_QUYOI3312_16\", \"Item12\"):kendo.toString(#=Item12#, vc.viewState.QV_QUYOI3312_16.column.Item12.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item12.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item12.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item12.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item12.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item13',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item13.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item13.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM128.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item13.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item13, \"QV_QUYOI3312_16\", \"Item13\"):kendo.toString(#=Item13#, vc.viewState.QV_QUYOI3312_16.column.Item13.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item13.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item13.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item13.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item13.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Item6',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item6.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item6.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM603.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item6.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Item6, \"QV_QUYOI3312_16\", \"Item6\"):kendo.toString(#=Item6#, vc.viewState.QV_QUYOI3312_16.column.Item6.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Item6.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Item6.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Item6.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Fee',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Fee.title|translate:vc.viewState.QV_QUYOI3312_16.column.Fee.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884SHRE57.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Fee.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Fee, \"QV_QUYOI3312_16\", \"Fee\"):kendo.toString(#=Fee#, vc.viewState.QV_QUYOI3312_16.column.Fee.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.Fee.sum, $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUYOI3312_16.column.Fee.style",
                        "title": "{{vc.viewState.QV_QUYOI3312_16.column.Fee.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.hidden
                });
            }
            $scope.vc.viewState.QV_QUYOI3312_16.column.edit = {
                element: []
            };
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_QUYOI3312_16.column.VA_VWPAYMENLA2611_0000301 = {
                    tooltip: '',
                    imageId: 'glyphicon glyphicon-remove-sign',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_QUYOI3312_16.column.Eliminar)) {
                    $scope.vc.viewState.QV_QUYOI3312_16.column.Eliminar = {};
                }
                $scope.vc.viewState.QV_QUYOI3312_16.column.Eliminar.hidden = false;
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Eliminar',
                    title: ' ',
                    command: {
                        name: "VA_VWPAYMENLA2611_0000301",
                        entity: "AmortizationTableItem",
                        text: "{{'DSGNR.SYS_DSGNR_LBLESTETQ_00024'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'cb-btn-custom-eliminar':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_VWPAYMENLA2611_0000301\", " + "vc.viewState.QV_QUYOI3312_16.column.VA_VWPAYMENLA2611_0000301.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_QUYOI3312_16.column.VA_VWPAYMENLA2611_0000301.enabled || vc.viewState.GR_VWPAYMENLA26_11.disabled' " + "data-ng-click = 'vc.grids.QV_QUYOI3312_16.events.customRowClick($event, \"VA_VWPAYMENLA2611_0000301\", \"#:entity#\", \"QV_QUYOI3312_16\")' " + "title = \"{{vc.viewState.QV_QUYOI3312_16.column.VA_VWPAYMENLA2611_0000301.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.VA_VWPAYMENLA2611_0000301.imageId'></span>" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_QUYOI3312_16.column.Eliminar.hidden
                });
            }
            $scope.vc.viewState.QV_QUYOI3312_16.toolbar = {
                CEQV_201_QV_QUYOI3312_16_019: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_QUYOI3312_16.toolbar = [{
                "name": "CEQV_201_QV_QUYOI3312_16_019",
                "text": "{{'BUSIN.DLB_BUSIN_LBLNWQUOA_35689'|translate}}",
                "template": "<button id='CEQV_201_QV_QUYOI3312_16_019' " + " ng-if='vc.viewState.QV_QUYOI3312_16.toolbar.CEQV_201_QV_QUYOI3312_16_019.visible' " + "ng-disabled = 'vc.viewState.GR_VWPAYMENLA26_11.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_QUYOI3312_16_019\",\"AmortizationTableItem\")' class='btn btn-default cb-grid-image-button cb-btn-custom-newfee'><span class='glyphicon glyphicon-plus-sign'></span> #: text #</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_12_TPYEP21_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_12_TPYEP21_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Compute
            $scope.vc.createViewState({
                id: "CM_TPYEP21MTE89",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CALCULARH_20617",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.PaymentCapacity = {
                Balance5: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance5"),
                Balance9: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance9"),
                Balance11: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance11"),
                Balance4: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance4"),
                Balance7: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance7"),
                Balance6: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance6"),
                Balance8: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance8"),
                Balance3: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance3"),
                Balance2: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance2"),
                Balance1: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance1"),
                CustomerID: $scope.vc.channelDefaultValues("PaymentCapacity", "CustomerID"),
                Balance12: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance12"),
                Balance10: $scope.vc.channelDefaultValues("PaymentCapacity", "Balance10"),
                MonthAverage: $scope.vc.channelDefaultValues("PaymentCapacity", "MonthAverage"),
                TotalAnnual: $scope.vc.channelDefaultValues("PaymentCapacity", "TotalAnnual"),
                CustomerName: $scope.vc.channelDefaultValues("PaymentCapacity", "CustomerName")
            };
            $scope.vc.model.ApprovalCriteriaQuestion = {
                sharedEntityQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "sharedEntityQuestion"),
                comparedExplusiveCustomerQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "comparedExplusiveCustomerQuestion"),
                rebateRequest: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rebateRequest"),
                internalScore: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "internalScore"),
                maximumDiscountCustomerType: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "maximumDiscountCustomerType"),
                customerCPOPQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "customerCPOPQuestion"),
                proposedRate: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "proposedRate"),
                customerNoCPOPQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "customerNoCPOPQuestion"),
                applyRebateCROP: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "applyRebateCROP"),
                rebate: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rebate"),
                rebateCustomerType: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rebateCustomerType"),
                otherDebtCICQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "otherDebtCICQuestion"),
                recordsMatchingQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "recordsMatchingQuestion"),
                currentRateFIE: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "currentRateFIE"),
                previousRateFIE: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "previousRateFIE"),
                rateApply: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rateApply"),
                tariffRate: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "tariffRate")
            };
            $scope.vc.model.PaymentCapacityHeader = {
                StartMonth: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "StartMonth"),
                CountTerm: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "CountTerm"),
                PeriodGrace: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "PeriodGrace"),
                Status: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "Status"),
                ValidationSuccess: $scope.vc.channelDefaultValues("PaymentCapacityHeader", "ValidationSuccess")
            };
            $scope.vc.model.DebtorGeneral = {
                riskLevel: $scope.vc.channelDefaultValues("DebtorGeneral", "riskLevel"),
                customerType: $scope.vc.channelDefaultValues("DebtorGeneral", "customerType"),
                creditBureau: $scope.vc.channelDefaultValues("DebtorGeneral", "creditBureau"),
                rfc: $scope.vc.channelDefaultValues("DebtorGeneral", "rfc"),
                Address: $scope.vc.channelDefaultValues("DebtorGeneral", "Address"),
                CustomerCode: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerCode"),
                CustomerName: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerName"),
                TypeDocumentId: $scope.vc.channelDefaultValues("DebtorGeneral", "TypeDocumentId"),
                DateCIC: $scope.vc.channelDefaultValues("DebtorGeneral", "DateCIC"),
                Identification: $scope.vc.channelDefaultValues("DebtorGeneral", "Identification"),
                AditionalCode: $scope.vc.channelDefaultValues("DebtorGeneral", "AditionalCode"),
                Role: $scope.vc.channelDefaultValues("DebtorGeneral", "Role"),
                Qualification: $scope.vc.channelDefaultValues("DebtorGeneral", "Qualification")
            };
            $scope.vc.model.Holiday = {
                holidayDate: $scope.vc.channelDefaultValues("Holiday", "holidayDate")
            };
            $scope.vc.model.AmortizationTableHeader = {
                Description: $scope.vc.channelDefaultValues("AmortizationTableHeader", "Description"),
                Concept: $scope.vc.channelDefaultValues("AmortizationTableHeader", "Concept"),
                rate: $scope.vc.channelDefaultValues("AmortizationTableHeader", "rate"),
                Type: $scope.vc.channelDefaultValues("AmortizationTableHeader", "Type")
            };
            $scope.vc.model.EditableItems = {
                value: $scope.vc.channelDefaultValues("EditableItems", "value"),
                item: $scope.vc.channelDefaultValues("EditableItems", "item")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_8375LIFACAQCGJL_261A26.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2628_PAME177.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2628_ETME049.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2629_ANPN062.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2630_METY849.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2630_YECY081.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2631_HNGE222.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2632_ERSE615.read();
                    $scope.vc.catalogs.VA_VWPAYMENLA2633_RIOI469.read();
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
                $scope.vc.render('VC_TPYEP21_FAETL_814');
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
    var cobisMainModule = cobis.createModule("VC_TPYEP21_FAETL_814", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_TPYEP21_FAETL_814", {
            templateUrl: "VC_TPYEP21_FAETL_814_FORM.html",
            controller: "VC_TPYEP21_FAETL_814_CTRL",
            label: "FPaymentPlan",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TPYEP21_FAETL_814?" + $.param(search);
            }
        });
        VC_TPYEP21_FAETL_814(cobisMainModule);
    }]);
} else {
    VC_TPYEP21_FAETL_814(cobisMainModule);
}