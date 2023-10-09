//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.querygeneralinformationmain = designerEvents.api.querygeneralinformationmain || designer.dsgEvents();

function VC_GENERALITN_743443(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GENERALITN_743443_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GENERALITN_743443_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "QERYS",
            taskId: "T_GENERALINANNN_443",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GENERALITN_743443",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_GENERALINANNN_443",
        designerEvents.api.querygeneralinformationmain,
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
                vcName: 'VC_GENERALITN_743443'
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
                    subModuleId: 'QERYS',
                    taskId: 'T_GENERALINANNN_443',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Transaction: "Transaction",
                    PaymentSummary: "PaymentSummary",
                    LoanRates: "LoanRates",
                    LoanEntry: "LoanEntry",
                    RefinanceLoans: "RefinanceLoans",
                    ColumnsDataValue: "ColumnsDataValue",
                    OperationPaymentColumn: "OperationPaymentColumn",
                    LoanWarranty: "LoanWarranty",
                    LoanDebtor: "LoanDebtor",
                    ConsolidatedLoanStatus: "ConsolidatedLoanStatus",
                    SummaryLoanStatus: "SummaryLoanStatus",
                    Loan: "Loan",
                    Amortization: "Amortization",
                    ItemsLoan: "ItemsLoan",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
                    Transaction: {
                        currency: 'AT10_CURRENYY612',
                        valueDate: 'AT11_VALUEDTE612',
                        ammount: 'AT14_AMMOUNTT612',
                        officeName: 'AT14_OFFICEMN612',
                        registerDate: 'AT22_REGISTAE612',
                        transactionId: 'AT25_TRANSADT612',
                        paymentWay: 'AT42_PAYMENYW612',
                        transactionStatus: 'AT62_TRANSASS612',
                        user: 'AT76_USERADGL612',
                        sequential: 'AT82_SEQUENIA612',
                        corresponsalId: 'AT90_CORRESND612',
                        transactionType: 'AT90_TRANSAYN612',
                        _pks: [],
                        _entityId: 'EN_TRANSACON_612',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentSummary: {
                        amount: 'AT13_AMOUNTMQ759',
                        paymentWay: 'AT29_PAYMENAT759',
                        corresponsalId: 'AT40_CORRESDA759',
                        sequentialIdentity: 'AT41_SEQUENAT759',
                        valueDate: 'AT45_VALUEDAE759',
                        message: 'AT51_MESSAGEE759',
                        user: 'AT53_USERFIIG759',
                        office: 'AT76_OFFICENK759',
                        paymentId: 'AT77_PAYMENDT759',
                        currency: 'AT78_CURRENCC759',
                        paymentStatus: 'AT82_PAYMENTT759',
                        registerDate: 'AT92_REGISTEA759',
                        sequentialQuery: 'AT97_SEQUENTA759',
                        _pks: [],
                        _entityId: 'EN_PAYMENTMR_759',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanRates: {
                        sequential: 'AT72_SEQUENAT507',
                        updatedOn: 'AT95_UPDATEDO507',
                        quota: 'AT85_QUOTAKSY507',
                        item: 'AT81_ITEMZSAC507',
                        valueToApply: 'AT41_VALUETPY507',
                        signToApply: 'AT17_SIGNTOAY507',
                        spreadApply: 'AT71_SPREADPY507',
                        currentRate: 'AT39_CURRENTR507',
                        anualEffectiveRate: 'AT59_ANUALEFA507',
                        referentialRate: 'AT15_REFERERA507',
                        valueReferenceRate: 'AT29_VALUERAC507',
                        dateReferenceRate: 'AT97_DATERERE507',
                        _pks: [],
                        _entityId: 'EN_LOANRATES_507',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanEntry: {
                        concept: 'AT52_CONCEPTT197',
                        description: 'AT15_DESCRIPT197',
                        itemType: 'AT19_ITEMTYPE197',
                        paymentMethod: 'AT18_PAYMENTH197',
                        value: 'AT80_VALUEIST197',
                        priority: 'AT78_PRIORITT197',
                        latePayment: 'AT36_LATEPAYN197',
                        cause: 'AT26_CAUSEJWV197',
                        reference: 'AT67_REFERENE197',
                        sign: 'AT34_SIGNVYDC197',
                        pointsValue: 'AT63_POINTSAU197',
                        pointsType: 'AT15_POINTSYY197',
                        valueTotalRate: 'AT45_VALUETEL197',
                        negotiatedRate: 'AT65_NEGOTITR197',
                        annualEfecRate: 'AT53_ANNUALFE197',
                        reajustmenSign: 'AT31_REAJUSNN197',
                        reajustmentValuePoints: 'AT17_REAJUSPT197',
                        reajustmentReference: 'AT50_REAJUSNN197',
                        gain: 'AT84_GAINLJFX197',
                        baseCalculation: 'AT27_BASECAOT197',
                        chargeForRinging: 'AT24_CHARGENR197',
                        warrantyType: 'AT74_WARRANET197',
                        warrantyNumber: 'AT66_WARRANUY197',
                        coveragePercentage: 'AT69_COVERAEN197',
                        warrantyValue: 'AT60_WARRANYE197',
                        dividendType: 'AT48_DIVIDEYY197',
                        interestPeriod: 'AT11_INTEREPS197',
                        tableOtherRate: 'AT16_TABLEOTE197',
                        _pks: [],
                        _entityId: 'EN_OPERATIOE_197',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RefinanceLoans: {
                        loan: 'AT67_LOANWAUS582',
                        line: 'AT78_LINEUGLL582',
                        initialAmount: 'AT34_INITIAAA582',
                        totalToRefinance: 'AT94_TOTALTCA582',
                        totalBalance: 'AT16_TOTALBCN582',
                        currencyCode: 'AT55_CURRENDE582',
                        quotation: 'AT54_QUOTATNO582',
                        transactionID: 'AT25_TRANSANC582',
                        officialID: 'AT85_OFFICIDL582',
                        originalTerm: 'AT35_ORIGINAT582',
                        capitalBalance: 'AT89_CAPITABA582',
                        interestBalance: 'AT86_INTEREAA582',
                        defaultBalance: 'AT59_DEFAULCN582',
                        otherConceptsBalance: 'AT25_OTHERCAA582',
                        residualTerm: 'AT97_RESIDURR582',
                        loanStatus: 'AT33_LOANSTUA582',
                        currencyType: 'AT34_CURRENCP582',
                        overdueFees: 'AT30_OVERDUSE582',
                        _pks: [],
                        _entityId: 'EN_REFINANLC_582',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ColumnsDataValue: {
                        col12: 'AT10_COL12GFC491',
                        col153: 'AT10_COL153TH491',
                        col15: 'AT11_COL15OGY491',
                        col2: 'AT11_COL2KKNL491',
                        col111: 'AT12_COL111GT491',
                        col35: 'AT12_COL35KBE491',
                        col92: 'AT12_COL92VNG491',
                        col125: 'AT13_COL125II491',
                        col14: 'AT13_COL14YAR491',
                        col1: 'AT13_COL1XVKZ491',
                        col126: 'AT15_COL126TI491',
                        col21: 'AT16_COL21ZIE491',
                        col141: 'AT17_COL141JR491',
                        col157: 'AT17_COL157MH491',
                        col32: 'AT17_COL32HDB491',
                        col76: 'AT17_COL76LRQ491',
                        col101: 'AT19_COL101TQ491',
                        col130: 'AT19_COL130ST491',
                        col150: 'AT19_COL150JD491',
                        col158: 'AT19_COL158NB491',
                        col38: 'AT19_COL38HWX491',
                        col47: 'AT19_COL47DUD491',
                        col75: 'AT19_COL75WHB491',
                        col82: 'AT20_COL82NGT491',
                        col116: 'AT21_COL116HO491',
                        col163: 'AT21_COL163NR491',
                        col24: 'AT21_COL24EJG491',
                        col88: 'AT21_COL88IBT491',
                        col121: 'AT22_COL121VW491',
                        col10: 'AT23_COL10LXO491',
                        col64: 'AT24_COL64OAX491',
                        col22: 'AT25_COL22KOS491',
                        col160: 'AT26_COL160HE491',
                        col154: 'AT27_COL154PD491',
                        col25: 'AT27_COL25NKL491',
                        col144: 'AT28_COL144ZT491',
                        col109: 'AT29_COL109QN491',
                        col159: 'AT30_COL159XJ491',
                        col61: 'AT32_COL61VAN491',
                        col100: 'AT33_COL100VN491',
                        col119: 'AT33_COL119UX491',
                        col148: 'AT33_COL148YB491',
                        col155: 'AT33_COL155QB491',
                        col31: 'AT33_COL31LIL491',
                        col133: 'AT34_COL133BS491',
                        col62: 'AT34_COL62OAC491',
                        col84: 'AT34_COL84RKG491',
                        col108: 'AT35_COL108IQ491',
                        col87: 'AT35_COL87EIY491',
                        col91: 'AT39_COL91TKO491',
                        col140: 'AT40_COL140JE491',
                        col66: 'AT42_COL66VJM491',
                        col135: 'AT43_COL135BC491',
                        col17: 'AT43_COL17OXH491',
                        col26: 'AT43_COL26LOB491',
                        col72: 'AT43_COL72XZR491',
                        col78: 'AT43_COL78GLF491',
                        col118: 'AT45_COL118LU491',
                        col20: 'AT45_COL20NCM491',
                        col52: 'AT46_COL52VFM491',
                        col49: 'AT47_COL49TNJ491',
                        col18: 'AT49_COL18WVS491',
                        col67: 'AT49_COL67OPP491',
                        col56: 'AT50_COL56HOY491',
                        col68: 'AT50_COL68ZOX491',
                        col69: 'AT50_COL69SAC491',
                        col129: 'AT52_COL129AW491',
                        col37: 'AT52_COL37LWK491',
                        col146: 'AT54_COL146EV491',
                        col93: 'AT57_COL93JHG491',
                        col103: 'AT58_COL103KB491',
                        col136: 'AT58_COL136XL491',
                        col43: 'AT58_COL43PPD491',
                        col46: 'AT58_COL46GMH491',
                        col128: 'AT59_COL128SQ491',
                        col165: 'AT59_COL165AB491',
                        col29: 'AT59_COL29TAK491',
                        col70: 'AT59_COL70KDV491',
                        col138: 'AT60_COL138LD491',
                        col86: 'AT60_COL86CIU491',
                        col96: 'AT60_COL96LLF491',
                        col106: 'AT61_COL106ME491',
                        col8: 'AT61_COL8CFRE491',
                        col94: 'AT61_COL94SBJ491',
                        col97: 'AT61_COL97LJP491',
                        col113: 'AT63_COL113XA491',
                        col115: 'AT63_COL115RA491',
                        col152: 'AT64_COL152WY491',
                        col19: 'AT64_COL19GTA491',
                        col42: 'AT64_COL42URF491',
                        col33: 'AT65_COL33FWA491',
                        col73: 'AT65_COL73ESK491',
                        col161: 'AT67_COL161BV491',
                        col74: 'AT67_COL74PRQ491',
                        col102: 'AT69_COL102RQ491',
                        col55: 'AT69_COL55MGC491',
                        col58: 'AT69_COL58OQY491',
                        col95: 'AT69_COL95IYB491',
                        col120: 'AT70_COL120LB491',
                        col151: 'AT70_COL151DU491',
                        col107: 'AT71_COL107VL491',
                        col117: 'AT71_COL117WE491',
                        col80: 'AT71_COL80KQN491',
                        col112: 'AT72_COL112RE491',
                        col164: 'AT72_COL164UL491',
                        col40: 'AT73_COL40UYG491',
                        col4: 'AT73_COL4HRES491',
                        col63: 'AT74_COL63PUP491',
                        col79: 'AT74_COL79CSV491',
                        col122: 'AT75_COL122DI491',
                        col124: 'AT75_COL124VV491',
                        col41: 'AT75_COL41KNQ491',
                        col5: 'AT75_COL5WARP491',
                        col27: 'AT77_COL27YEH491',
                        col28: 'AT77_COL28PUD491',
                        col44: 'AT77_COL44OEY491',
                        col77: 'AT78_COL77PPP491',
                        col85: 'AT78_COL85DWF491',
                        col16: 'AT79_COL16IVN491',
                        col48: 'AT80_COL48SAS491',
                        col65: 'AT80_COL65PQU491',
                        col6: 'AT80_COL6RQXO491',
                        col89: 'AT80_COL89RHR491',
                        col137: 'AT81_COL137CC491',
                        col59: 'AT81_COL59SYH491',
                        col105: 'AT82_COL105CN491',
                        col147: 'AT83_COL147NA491',
                        col139: 'AT84_COL139XX491',
                        col54: 'AT85_COL54YKS491',
                        col110: 'AT86_COL110KR491',
                        col23: 'AT86_COL23LXG491',
                        col81: 'AT86_COL81WRS491',
                        col83: 'AT86_COL83JWS491',
                        col127: 'AT87_COL127US491',
                        col45: 'AT87_COL45RSV491',
                        col11: 'AT88_COL11XUV491',
                        col132: 'AT88_COL132FM491',
                        col149: 'AT88_COL149PC491',
                        col34: 'AT88_COL34GWI491',
                        col114: 'AT89_COL114XR491',
                        col13: 'AT89_COL13AZM491',
                        col3: 'AT89_COL3QLEY491',
                        col51: 'AT89_COL51AJY491',
                        col131: 'AT90_COL131UZ491',
                        col7: 'AT90_COL7QSGO491',
                        col99: 'AT90_COL99DTQ491',
                        col156: 'AT91_COL156ZP491',
                        col53: 'AT91_COL53MOC491',
                        col90: 'AT91_COL90WTG491',
                        col9: 'AT91_COL9KTTY491',
                        col143: 'AT92_COL143MQ491',
                        col50: 'AT93_COL50TCK491',
                        col57: 'AT93_COL57RQP491',
                        col104: 'AT94_COL104IL491',
                        col123: 'AT94_COL123BP491',
                        col134: 'AT94_COL134OU491',
                        col98: 'AT95_COL98JRI491',
                        col142: 'AT96_COL142DT491',
                        col30: 'AT96_COL30GNE491',
                        col36: 'AT96_COL36BYU491',
                        col60: 'AT96_COL60FWI491',
                        col39: 'AT97_COL39JSY491',
                        col145: 'AT98_COL145EM491',
                        col162: 'AT98_COL162JU491',
                        col71: 'AT98_COL71XRW491',
                        _pks: [],
                        _entityId: 'EN_GENERALLA_491',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OperationPaymentColumn: {
                        attribute1: 'AT02_1HDFNEOY258',
                        attribute2: 'AT03_2HNZJIAV258',
                        attribute3: 'AT04_3YRVILSE258',
                        attribute4: 'AT05_4QQFLXNV258',
                        attribute5: 'AT06_5ZTXXBWH258',
                        attribute6: 'AT07_6SGMBQVD258',
                        attribute7: 'AT08_7AYQTOGH258',
                        attribute8: 'AT09_8ZJBBPVB258',
                        attribute9: 'AT10_9ONHDOZN258',
                        attribute10: 'AT11_10SGROMR258',
                        attribute11: 'AT12_11HYXJFT258',
                        attribute12: 'AT13_12STULTV258',
                        attribute13: 'AT14_13QBQBOE258',
                        attribute14: 'AT15_14ETNWVE258',
                        attribute15: 'AT16_15UBFSYC258',
                        attribute16: 'AT17_16QDTFGX258',
                        _pks: [],
                        _entityId: 'EN_14HHEOYJC_258',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanWarranty: {
                        warranty: 'AT17_WARRANTY642',
                        statusWarranty: 'AT77_STATUSAR642',
                        description: 'AT51_DESCRION642',
                        customerID: 'AT13_CODCLINN642',
                        customer: 'AT79_CUSTOMER642',
                        currentValue: 'AT25_CURRENAL642',
                        currencyID: 'AT13_CURRENYY642',
                        createdOn: 'AT92_CREATENO642',
                        _pks: [],
                        _entityId: 'EN_LOANWARRY_642',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanDebtor: {
                        customerID: 'AT49_CUSTOMDR749',
                        identityCard: 'AT78_IDCARDFV749',
                        role: 'AT91_ROLEJPXR749',
                        customerName: 'AT58_CUSTOMME749',
                        phone: 'AT72_PHONEKRF749',
                        address: 'AT39_ADDRESSS749',
                        centralCollection: 'AT27_CENTRAOI749',
                        _pks: [],
                        _entityId: 'EN_LOANDEBTO_749',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ConsolidatedLoanStatus: {
                        amortizationStatus: 'AT48_LOANSTSS643',
                        capital: 'AT75_CAPITALL643',
                        interest: 'AT25_INTERESS643',
                        arrear: 'AT98_ARREARUC643',
                        interestArrear: 'AT87_INTERERE643',
                        otherItems: 'AT55_OTHERIMT643',
                        total: 'AT69_TOTALRYN643',
                        numberPayments: 'AT90_NUMBERPP643',
                        _pks: [],
                        _entityId: 'EN_CONSOLITS_643',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    SummaryLoanStatus: {
                        capital: 'AT16_CAPITALL170',
                        interestArrear: 'AT24_INTERERR170',
                        otherItems: 'AT67_OTHERIMT170',
                        total: 'AT57_TOTALIRN170',
                        statusAmortization: 'AT64_STATUSOZ170',
                        _pks: [],
                        _entityId: 'EN_SUMMARYAT_170',
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
                    Amortization: {
                        items12: 'AT10_ITEMS122592',
                        items6: 'AT11_ITEMS6DA592',
                        items2: 'AT13_ITEMS2OT592',
                        items8: 'AT13_ITEMS8ZO592',
                        items10: 'AT15_ITEMS100592',
                        items9: 'AT17_ITEMS9BT592',
                        shareValue: 'AT18_SHAREVEL592',
                        days: 'AT25_DAYSFBZN592',
                        expiration: 'AT33_EXPIRANO592',
                        items3: 'AT35_ITEMS3HC592',
                        items5: 'AT37_ITEMS5ZX592',
                        items4: 'AT51_ITEMS4SF592',
                        items7: 'AT54_ITEMS7OM592',
                        state: 'AT63_STATEQEV592',
                        porroga: 'AT65_PORROGAA592',
                        share: 'AT71_SHAREPCW592',
                        items13: 'AT72_ITEMS133592',
                        items14: 'AT74_ITEMS144592',
                        balanceCap: 'AT83_BALANCCA592',
                        items11: 'AT84_ITEMS111592',
                        items15: 'AT89_ITEMS155592',
                        items1: 'AT97_ITEMS1UJ592',
                        _pks: [],
                        _entityId: 'EN_2ZNYDYMCX_592',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ItemsLoan: {
                        concept: 'AT71_CONCEPTT118',
                        description: 'AT36_DESCRITO118',
                        itemType: 'AT64_ITEMTYEE118',
                        paymentMethod: 'AT22_PAYMENMD118',
                        value: 'AT14_VALUEIYS118',
                        priority: 'AT15_PRIORITT118',
                        latePayment: 'AT45_LATEPAYE118',
                        cause: 'AT75_CAUSEPOS118',
                        reference: 'AT23_REFERENN118',
                        sign: 'AT51_SIGNTBXM118',
                        pointsValue: 'AT15_POINTSLV118',
                        pointsType: 'AT18_POINTSET118',
                        valueTotalRate: 'AT63_VALUETAL118',
                        negotiatedRate: 'AT53_NEGOTITT118',
                        annualEfecRate: 'AT39_ANNUALTR118',
                        reajustmenSign: 'AT55_REAJUSSN118',
                        reajustmentValuePoints: 'AT21_REAJUSSL118',
                        reajustmentReference: 'AT15_REAJUSTE118',
                        gain: 'AT83_GAINNRTF118',
                        baseCalculation: 'AT53_BASECATL118',
                        chargeForRinging: 'AT41_CHARGERG118',
                        warrantyType: 'AT53_WARRANTT118',
                        warrantyNumber: 'AT47_WARRANBM118',
                        coveragePercentage: 'AT25_COVERANP118',
                        warrantyValue: 'AT39_WARRANAY118',
                        dividendType: 'AT28_DIVIDEDE118',
                        interestPeriod: 'AT10_INTERETR118',
                        tableOtherRate: 'AT93_TABLEOET118',
                        _pks: [],
                        _entityId: 'EN_ITEMSLONA_118',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
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
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_LOANWATN_1941 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_LOANWATN_1941 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_LOANWATN_1941_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_LOANWATN_1941_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_LOANWARRY_642',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_LOANWATN_1941',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_LOANWATN_1941_filters = {};
            $scope.vc.queryProperties.Q_LOANDEBB_6719 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_LOANDEBB_6719 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_LOANDEBB_6719_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_LOANDEBB_6719_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_LOANDEBTO_749',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_LOANDEBB_6719',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_LOANDEBB_6719_filters = {};
            $scope.vc.queryProperties.Q_SUMMARST_6100 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_SUMMARST_6100 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_SUMMARST_6100_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_SUMMARST_6100_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SUMMARYAT_170',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_SUMMARST_6100',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_SUMMARST_6100_filters = {};
            $scope.vc.queryProperties.Q_TRANSACC_2353 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_TRANSACC_2353 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_TRANSACC_2353_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_TRANSACC_2353_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_TRANSACON_612',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_TRANSACC_2353',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_TRANSACC_2353_filters = {};
            $scope.vc.queryProperties.Q_AMORTIAN_8237 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_AMORTIAN_8237 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMORTIAN_8237_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMORTIAN_8237_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_2ZNYDYMCX_592',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMORTIAN_8237',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_AMORTIAN_8237_filters = {};
            $scope.vc.queryProperties.Q_REFINAOS_1949 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_REFINAOS_1949 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_REFINAOS_1949_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_REFINAOS_1949_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_REFINANLC_582',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_REFINAOS_1949',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_REFINAOS_1949_filters = {};
            $scope.vc.queryProperties.Q_LOANRATE_7625 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_LOANRATE_7625 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_LOANRATE_7625_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_LOANRATE_7625_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_LOANRATES_507',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_LOANRATE_7625',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_LOANRATE_7625_filters = {};
            $scope.vc.queryProperties.Q_OPERATNY_7536 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_OPERATNY_7536 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_OPERATNY_7536_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_OPERATNY_7536_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OPERATIOE_197',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_OPERATNY_7536',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_OPERATNY_7536_filters = {};
            $scope.vc.queryProperties.Q_PAYMENUM_1439 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_PAYMENUM_1439 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PAYMENUM_1439_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PAYMENUM_1439_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PAYMENTMR_759',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PAYMENUM_1439',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_PAYMENUM_1439_filters = {};
            var defaultValues = {
                Transaction: {},
                PaymentSummary: {},
                LoanRates: {},
                LoanEntry: {},
                RefinanceLoans: {},
                ColumnsDataValue: {},
                OperationPaymentColumn: {},
                LoanWarranty: {},
                LoanDebtor: {},
                ConsolidatedLoanStatus: {},
                SummaryLoanStatus: {},
                Loan: {},
                Amortization: {},
                ItemsLoan: {},
                LoanInstancia: {}
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
                $scope.vc.execute("temporarySave", VC_GENERALITN_743443, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GENERALITN_743443, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GENERALITN_743443, data, function() {});
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
            $scope.vc.viewState.VC_GENERALITN_743443 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_GENERALITN_743443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DATOSGEEE_96748",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PBXJORPCKR_929443",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_CFCVHAOGYY_528316",
                hasId: true,
                componentStyle: [],
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
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
            //ViewState - Group: Group2443
            $scope.vc.createViewState({
                id: "G_LOANHEADOD_564612",
                hasId: true,
                componentStyle: [],
                label: 'Group2443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_143612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1657
            $scope.vc.createViewState({
                id: "G_LOANHEADRO_349612",
                hasId: true,
                componentStyle: [],
                label: 'Group1657',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_867612",
                componentStyle: [],
                labelImageId: "",
                label: "ASSTS.LBL_ASSTS_PRSTAMOFK_44930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVITZRQ_108612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-info-sign",
                label: "ASSTS.LBL_ASSTS_MASINACIN_18792",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONORYJAMS_468612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-search",
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1848
            $scope.vc.createViewState({
                id: "G_LOANHEAINF_340612",
                hasId: true,
                componentStyle: [],
                label: 'Group1848',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_5034UOFCASVGKTK_993612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOCRDOO_69382",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: balanceDue
            $scope.vc.createViewState({
                id: "VA_2463BHBNLZPKLMU_865612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOEXBB_70535",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: status
            $scope.vc.createViewState({
                id: "VA_3853RRTWBIRUGHQ_533612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: office
            $scope.vc.createViewState({
                id: "VA_7292SEAHPRAXOKC_868612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_IUNKWGIJTB_659443",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_SQGVGUSZEG_189443",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_UZHAEDVAYY_515443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOACU_72691",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GeneralInfoLeftChartForm
            $scope.vc.createViewState({
                id: "VC_PBHCSHGRBY_778866",
                hasId: true,
                componentStyle: [],
                label: 'GeneralInfoLeftChartForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.ConsolidatedLoanStatus = {
                amortizationStatus: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "amortizationStatus"),
                capital: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "capital"),
                interest: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "interest"),
                arrear: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "arrear"),
                interestArrear: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "interestArrear"),
                otherItems: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "otherItems"),
                total: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "total"),
                numberPayments: $scope.vc.channelDefaultValues("ConsolidatedLoanStatus", "numberPayments")
            };
            //ViewState - Group: Group1954
            $scope.vc.createViewState({
                id: "G_GENERALOLN_670344",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1954',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1960",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1774
            $scope.vc.createViewState({
                id: "G_GENERALCRN_654344",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RESUMENBL_70613",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.SummaryLoanStatus = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    statusAmortization: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryLoanStatus", "statusAmortization", '')
                    },
                    capital: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryLoanStatus", "capital", 0)
                    },
                    interestArrear: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryLoanStatus", "interestArrear", 0)
                    },
                    otherItems: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryLoanStatus", "otherItems", 0)
                    },
                    total: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryLoanStatus", "total", 0)
                    }
                }
            });
            $scope.vc.model.SummaryLoanStatus = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_SUMMARST_6100();
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
                    model: $scope.vc.types.SummaryLoanStatus
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6100_21620").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_SUMMARST_6100 = $scope.vc.model.SummaryLoanStatus;
            $scope.vc.trackers.SummaryLoanStatus = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.SummaryLoanStatus);
            $scope.vc.model.SummaryLoanStatus.bind('change', function(e) {
                $scope.vc.trackers.SummaryLoanStatus.track(e);
            });
            $scope.vc.grids.QV_6100_21620 = {};
            $scope.vc.grids.QV_6100_21620.queryId = 'Q_SUMMARST_6100';
            $scope.vc.viewState.QV_6100_21620 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6100_21620.column = {};
            $scope.vc.grids.QV_6100_21620.editable = false;
            $scope.vc.grids.QV_6100_21620.events = {
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
                    $scope.vc.trackers.SummaryLoanStatus.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6100_21620.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6100_21620");
                    $scope.vc.hideShowColumns("QV_6100_21620", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6100_21620.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6100_21620.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6100_21620.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6100_21620 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6100_21620 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6100_21620.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6100_21620.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6100_21620.column.statusAmortization = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTMD_417344',
                element: []
            };
            $scope.vc.grids.QV_6100_21620.AT64_STATUSOZ170 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6100_21620.column.statusAmortization.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_ESTADOEAI_33340'|translate}}",
                        'id': "VA_TEXTINPUTBOXTMD_417344",
                        'data-validation-code': "{{vc.viewState.QV_6100_21620.column.statusAmortization.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6100_21620.column.statusAmortization.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6100_21620.column.capital = {
                title: 'ASSTS.LBL_ASSTS_CAPITALBZ_88457',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_CAPITALBZ_88457',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMWX_470344',
                element: []
            };
            $scope.vc.grids.QV_6100_21620.AT16_CAPITALL170 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6100_21620.column.capital.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_CAPITALBZ_88457'|translate}}",
                        'id': "VA_TEXTINPUTBOXMWX_470344",
                        'data-validation-code': "{{vc.viewState.QV_6100_21620.column.capital.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6100_21620.column.capital.format",
                        'k-decimals': "vc.viewState.QV_6100_21620.column.capital.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6100_21620.column.capital.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6100_21620.column.interestArrear = {
                title: 'ASSTS.LBL_ASSTS_INTERESWJ_80123',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_INTMORALZ_27798',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNHL_435344',
                element: []
            };
            $scope.vc.grids.QV_6100_21620.AT24_INTERERR170 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6100_21620.column.interestArrear.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_INTMORALZ_27798'|translate}}",
                        'id': "VA_TEXTINPUTBOXNHL_435344",
                        'data-validation-code': "{{vc.viewState.QV_6100_21620.column.interestArrear.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6100_21620.column.interestArrear.format",
                        'k-decimals': "vc.viewState.QV_6100_21620.column.interestArrear.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6100_21620.column.interestArrear.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6100_21620.column.otherItems = {
                title: 'ASSTS.LBL_ASSTS_OTROSRYRP_40547',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_OTROSRYRP_40547',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWXQ_508344',
                element: []
            };
            $scope.vc.grids.QV_6100_21620.AT67_OTHERIMT170 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6100_21620.column.otherItems.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_OTROSRYRP_40547'|translate}}",
                        'id': "VA_TEXTINPUTBOXWXQ_508344",
                        'data-validation-code': "{{vc.viewState.QV_6100_21620.column.otherItems.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6100_21620.column.otherItems.format",
                        'k-decimals': "vc.viewState.QV_6100_21620.column.otherItems.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6100_21620.column.otherItems.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6100_21620.column.total = {
                title: 'ASSTS.LBL_ASSTS_TOTALAOJT_55920',
                titleArgs: {},
                tooltip: 'ASSTS.LBL_ASSTS_TOTALAOJT_55920',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJLV_306344',
                element: []
            };
            $scope.vc.grids.QV_6100_21620.AT57_TOTALIRN170 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6100_21620.column.total.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'ASSTS.LBL_ASSTS_TOTALAOJT_55920'|translate}}",
                        'id': "VA_TEXTINPUTBOXJLV_306344",
                        'data-validation-code': "{{vc.viewState.QV_6100_21620.column.total.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6100_21620.column.total.format",
                        'k-decimals': "vc.viewState.QV_6100_21620.column.total.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6100_21620.column.total.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6100_21620.columns.push({
                    field: 'statusAmortization',
                    title: '{{vc.viewState.QV_6100_21620.column.statusAmortization.title|translate:vc.viewState.QV_6100_21620.column.statusAmortization.titleArgs}}',
                    width: $scope.vc.viewState.QV_6100_21620.column.statusAmortization.width,
                    format: $scope.vc.viewState.QV_6100_21620.column.statusAmortization.format,
                    editor: $scope.vc.grids.QV_6100_21620.AT64_STATUSOZ170.control,
                    template: "<span ng-class='vc.viewState.QV_6100_21620.column.statusAmortization.style' ng-bind='vc.getStringColumnFormat(dataItem.statusAmortization, \"QV_6100_21620\", \"statusAmortization\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6100_21620.column.statusAmortization.style",
                        "title": "{{vc.viewState.QV_6100_21620.column.statusAmortization.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6100_21620.column.statusAmortization.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6100_21620.columns.push({
                    field: 'capital',
                    title: '{{vc.viewState.QV_6100_21620.column.capital.title|translate:vc.viewState.QV_6100_21620.column.capital.titleArgs}}',
                    width: $scope.vc.viewState.QV_6100_21620.column.capital.width,
                    format: $scope.vc.viewState.QV_6100_21620.column.capital.format,
                    editor: $scope.vc.grids.QV_6100_21620.AT16_CAPITALL170.control,
                    template: "<span ng-class='vc.viewState.QV_6100_21620.column.capital.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.capital, \"QV_6100_21620\", \"capital\"):kendo.toString(#=capital#, vc.viewState.QV_6100_21620.column.capital.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6100_21620.column.capital.style",
                        "title": "{{vc.viewState.QV_6100_21620.column.capital.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6100_21620.column.capital.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6100_21620.columns.push({
                    field: 'interestArrear',
                    title: '{{vc.viewState.QV_6100_21620.column.interestArrear.title|translate:vc.viewState.QV_6100_21620.column.interestArrear.titleArgs}}',
                    width: $scope.vc.viewState.QV_6100_21620.column.interestArrear.width,
                    format: $scope.vc.viewState.QV_6100_21620.column.interestArrear.format,
                    editor: $scope.vc.grids.QV_6100_21620.AT24_INTERERR170.control,
                    template: "<span ng-class='vc.viewState.QV_6100_21620.column.interestArrear.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interestArrear, \"QV_6100_21620\", \"interestArrear\"):kendo.toString(#=interestArrear#, vc.viewState.QV_6100_21620.column.interestArrear.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6100_21620.column.interestArrear.style",
                        "title": "{{vc.viewState.QV_6100_21620.column.interestArrear.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6100_21620.column.interestArrear.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6100_21620.columns.push({
                    field: 'otherItems',
                    title: '{{vc.viewState.QV_6100_21620.column.otherItems.title|translate:vc.viewState.QV_6100_21620.column.otherItems.titleArgs}}',
                    width: $scope.vc.viewState.QV_6100_21620.column.otherItems.width,
                    format: $scope.vc.viewState.QV_6100_21620.column.otherItems.format,
                    editor: $scope.vc.grids.QV_6100_21620.AT67_OTHERIMT170.control,
                    template: "<span ng-class='vc.viewState.QV_6100_21620.column.otherItems.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.otherItems, \"QV_6100_21620\", \"otherItems\"):kendo.toString(#=otherItems#, vc.viewState.QV_6100_21620.column.otherItems.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6100_21620.column.otherItems.style",
                        "title": "{{vc.viewState.QV_6100_21620.column.otherItems.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6100_21620.column.otherItems.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6100_21620.columns.push({
                    field: 'total',
                    title: '{{vc.viewState.QV_6100_21620.column.total.title|translate:vc.viewState.QV_6100_21620.column.total.titleArgs}}',
                    width: $scope.vc.viewState.QV_6100_21620.column.total.width,
                    format: $scope.vc.viewState.QV_6100_21620.column.total.format,
                    editor: $scope.vc.grids.QV_6100_21620.AT57_TOTALIRN170.control,
                    template: "<span ng-class='vc.viewState.QV_6100_21620.column.total.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.total, \"QV_6100_21620\", \"total\"):kendo.toString(#=total#, vc.viewState.QV_6100_21620.column.total.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6100_21620.column.total.style",
                        "title": "{{vc.viewState.QV_6100_21620.column.total.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6100_21620.column.total.hidden
                });
            }
            $scope.vc.viewState.QV_6100_21620.toolbar = {}
            $scope.vc.grids.QV_6100_21620.toolbar = [];
            //ViewState - Group: Group1318
            $scope.vc.createViewState({
                id: "G_GENERALFCO_797344",
                hasId: true,
                componentStyle: [],
                label: 'Group1318',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer2888",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: AmortizationForm
            $scope.vc.createViewState({
                id: "VC_TJZZOAQCVM_326261",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TABLAAMIO_45588",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group2591
            $scope.vc.createViewState({
                id: "G_AMORTIZTAI_460871",
                hasId: true,
                componentStyle: [],
                label: 'Group2591',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Amortization = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    share: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "share", 0)
                    },
                    expiration: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "expiration", new Date())
                    },
                    days: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "days", 0)
                    },
                    balanceCap: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "balanceCap", 0)
                    },
                    items1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items1", 0)
                    },
                    items2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items2", 0)
                    },
                    items3: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items3", 0)
                    },
                    items4: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items4", 0)
                    },
                    items5: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items5", 0)
                    },
                    items6: {
                        type: "number",
                        editable: true
                    },
                    items7: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items7", 0)
                    },
                    items8: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items8", 0)
                    },
                    items9: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items9", 0)
                    },
                    items10: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items10", 0)
                    },
                    items11: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items11", 0)
                    },
                    items12: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items12", 0)
                    },
                    items13: {
                        type: "number",
                        editable: true
                    },
                    items14: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items14", 0)
                    },
                    items15: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "items15", 0)
                    },
                    shareValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "shareValue", 0)
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "state", '')
                    },
                    porroga: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amortization", "porroga", '')
                    }
                }
            });
            $scope.vc.model.Amortization = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMORTIAN_8237();
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
                    model: $scope.vc.types.Amortization
                },
                aggregate: [{
                    field: "items1",
                    aggregate: "sum"
                }, {
                    field: "items2",
                    aggregate: "sum"
                }, {
                    field: "items3",
                    aggregate: "sum"
                }, {
                    field: "items4",
                    aggregate: "sum"
                }, {
                    field: "items5",
                    aggregate: "sum"
                }, {
                    field: "items7",
                    aggregate: "sum"
                }, {
                    field: "items8",
                    aggregate: "sum"
                }, {
                    field: "items9",
                    aggregate: "sum"
                }, {
                    field: "items10",
                    aggregate: "sum"
                }, {
                    field: "items11",
                    aggregate: "sum"
                }, {
                    field: "items12",
                    aggregate: "sum"
                }, {
                    field: "items14",
                    aggregate: "sum"
                }, {
                    field: "items15",
                    aggregate: "sum"
                }, {
                    field: "shareValue",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8237_80795").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMORTIAN_8237 = $scope.vc.model.Amortization;
            $scope.vc.trackers.Amortization = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Amortization);
            $scope.vc.model.Amortization.bind('change', function(e) {
                $scope.vc.trackers.Amortization.track(e);
            });
            $scope.vc.grids.QV_8237_80795 = {};
            $scope.vc.grids.QV_8237_80795.queryId = 'Q_AMORTIAN_8237';
            $scope.vc.viewState.QV_8237_80795 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8237_80795.column = {};
            $scope.vc.grids.QV_8237_80795.editable = false;
            $scope.vc.grids.QV_8237_80795.events = {
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
                    $scope.vc.trackers.Amortization.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_8237_80795.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_8237_80795");
                    $scope.vc.hideShowColumns("QV_8237_80795", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8237_80795.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8237_80795.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8237_80795.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8237_80795 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8237_80795 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_8237_80795.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_8237_80795.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "Amortization", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8237_80795.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8237_80795.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8237_80795.column.share = {
                title: 'ASSTS.LBL_ASSTS_CUOTASNJN_88896',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCGV_473871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT71_SHAREPCW592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.share.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCGV_473871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.share.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.share.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.share.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.share.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.expiration = {
                title: 'ASSTS.LBL_ASSTS_FECHAVENE_58948',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDFOXURB_182871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT33_EXPIRANO592 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.expiration.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDFOXURB_182871",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.expiration.validationCode}}",
                        'ng-class': "vc.viewState.QV_8237_80795.column.expiration.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.days = {
                title: 'ASSTS.LBL_ASSTS_DASBHLJCD_37784',
                titleArgs: {},
                tooltip: '',
                width: 50,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIPF_316871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT25_DAYSFBZN592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.days.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIPF_316871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.days.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.days.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.days.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.days.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.balanceCap = {
                title: 'ASSTS.LBL_ASSTS_SALDOCAAI_86331',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGNF_245871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT83_BALANCCA592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.balanceCap.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGNF_245871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.balanceCap.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.balanceCap.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.balanceCap.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.balanceCap.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items1 = {
                title: 'items1',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAHH_793871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT97_ITEMS1UJ592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items1.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAHH_793871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items1.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items1.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items1.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items2 = {
                title: 'items2',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSCO_259871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT13_ITEMS2OT592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items2.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSCO_259871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items2.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items2.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items2.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items3 = {
                title: 'items3',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHJE_714871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT35_ITEMS3HC592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items3.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHJE_714871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items3.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items3.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items3.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items3.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items4 = {
                title: 'items4',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGNU_184871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT51_ITEMS4SF592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items4.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGNU_184871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items4.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items4.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items4.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items4.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items5 = {
                title: 'items5',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXORN_815871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT37_ITEMS5ZX592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items5.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXORN_815871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items5.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items5.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items5.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items5.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items6 = {
                title: 'items6',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT11_ITEMS6DA592 = {
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
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items6.enabled",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items6.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items7 = {
                title: 'items7',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNNA_760871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT54_ITEMS7OM592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items7.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNNA_760871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items7.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items7.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items7.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items7.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items8 = {
                title: 'items8',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVNJ_518871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT13_ITEMS8ZO592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items8.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVNJ_518871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items8.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items8.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items8.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items8.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items9 = {
                title: 'items9',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWNG_395871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT17_ITEMS9BT592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items9.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWNG_395871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items9.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items9.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items9.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items9.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items10 = {
                title: 'items10',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLHX_722871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT15_ITEMS100592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items10.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLHX_722871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items10.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items10.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items10.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items10.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items11 = {
                title: 'items11',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYRS_353871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT84_ITEMS111592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items11.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYRS_353871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items11.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items11.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items11.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items11.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items12 = {
                title: 'items12',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJUK_798871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT10_ITEMS122592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items12.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJUK_798871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items12.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items12.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items12.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items12.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items13 = {
                title: 'items13',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT72_ITEMS133592 = {
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
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items13.enabled",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items13.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items14 = {
                title: 'items14',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLLZ_404871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT74_ITEMS144592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items14.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLLZ_404871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items14.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items14.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items14.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items14.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.items15 = {
                title: 'items15',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUHU_691871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT89_ITEMS155592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.items15.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUHU_691871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.items15.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.items15.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.items15.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.items15.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.shareValue = {
                title: 'ASSTS.LBL_ASSTS_VALORCUTO_78445',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKTI_114871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT18_SHAREVEL592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.shareValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKTI_114871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.shareValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_8237_80795.column.shareValue.format",
                        'k-decimals': "vc.viewState.QV_8237_80795.column.shareValue.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.shareValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.state = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLBZ_172871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT63_STATEQEV592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.state.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLBZ_172871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.state.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.state.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_8237_80795.column.porroga = {
                title: 'ASSTS.LBL_ASSTS_PRRROGAER_90410',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJUQ_295871',
                element: []
            };
            $scope.vc.grids.QV_8237_80795.AT65_PORROGAA592 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_8237_80795.column.porroga.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJUQ_295871",
                        'data-validation-code': "{{vc.viewState.QV_8237_80795.column.porroga.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_8237_80795.column.porroga.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'share',
                    title: '{{vc.viewState.QV_8237_80795.column.share.title|translate:vc.viewState.QV_8237_80795.column.share.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.share.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.share.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT71_SHAREPCW592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.share.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.share, \"QV_8237_80795\", \"share\"):kendo.toString(#=share#, vc.viewState.QV_8237_80795.column.share.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.share.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.share.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.share.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'expiration',
                    title: '{{vc.viewState.QV_8237_80795.column.expiration.title|translate:vc.viewState.QV_8237_80795.column.expiration.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.expiration.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.expiration.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT33_EXPIRANO592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.expiration.style'>#=((expiration !== null) ? kendo.toString(expiration, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8237_80795.column.expiration.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.expiration.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.expiration.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'days',
                    title: '{{vc.viewState.QV_8237_80795.column.days.title|translate:vc.viewState.QV_8237_80795.column.days.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.days.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.days.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT25_DAYSFBZN592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.days.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.days, \"QV_8237_80795\", \"days\"):kendo.toString(#=days#, vc.viewState.QV_8237_80795.column.days.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.days.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.days.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.days.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'balanceCap',
                    title: '{{vc.viewState.QV_8237_80795.column.balanceCap.title|translate:vc.viewState.QV_8237_80795.column.balanceCap.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.balanceCap.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.balanceCap.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT83_BALANCCA592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.balanceCap.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.balanceCap, \"QV_8237_80795\", \"balanceCap\"):kendo.toString(#=balanceCap#, vc.viewState.QV_8237_80795.column.balanceCap.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.balanceCap.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.balanceCap.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.balanceCap.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items1',
                    title: '{{vc.viewState.QV_8237_80795.column.items1.title|translate:vc.viewState.QV_8237_80795.column.items1.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items1.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items1.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT97_ITEMS1UJ592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items1.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items1, \"QV_8237_80795\", \"items1\"):kendo.toString(#=items1#, vc.viewState.QV_8237_80795.column.items1.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items1.sum, $scope.vc.viewState.QV_8237_80795.column.items1.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items1.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items2',
                    title: '{{vc.viewState.QV_8237_80795.column.items2.title|translate:vc.viewState.QV_8237_80795.column.items2.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items2.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items2.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT13_ITEMS2OT592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items2.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items2, \"QV_8237_80795\", \"items2\"):kendo.toString(#=items2#, vc.viewState.QV_8237_80795.column.items2.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items2.sum, $scope.vc.viewState.QV_8237_80795.column.items2.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items2.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items3',
                    title: '{{vc.viewState.QV_8237_80795.column.items3.title|translate:vc.viewState.QV_8237_80795.column.items3.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items3.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items3.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT35_ITEMS3HC592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items3.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items3, \"QV_8237_80795\", \"items3\"):kendo.toString(#=items3#, vc.viewState.QV_8237_80795.column.items3.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items3.sum, $scope.vc.viewState.QV_8237_80795.column.items3.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items3.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items3.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items3.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items4',
                    title: '{{vc.viewState.QV_8237_80795.column.items4.title|translate:vc.viewState.QV_8237_80795.column.items4.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items4.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items4.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT51_ITEMS4SF592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items4.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items4, \"QV_8237_80795\", \"items4\"):kendo.toString(#=items4#, vc.viewState.QV_8237_80795.column.items4.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items4.sum, $scope.vc.viewState.QV_8237_80795.column.items4.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items4.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items4.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items4.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items5',
                    title: '{{vc.viewState.QV_8237_80795.column.items5.title|translate:vc.viewState.QV_8237_80795.column.items5.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items5.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items5.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT37_ITEMS5ZX592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items5.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items5, \"QV_8237_80795\", \"items5\"):kendo.toString(#=items5#, vc.viewState.QV_8237_80795.column.items5.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items5.sum, $scope.vc.viewState.QV_8237_80795.column.items5.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items5.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items5.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items5.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items6',
                    title: '{{vc.viewState.QV_8237_80795.column.items6.title|translate:vc.viewState.QV_8237_80795.column.items6.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items6.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items6.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT11_ITEMS6DA592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items6.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items6, \"QV_8237_80795\", \"items6\"):kendo.toString(#=items6#, vc.viewState.QV_8237_80795.column.items6.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items6.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items6.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items6.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items7',
                    title: '{{vc.viewState.QV_8237_80795.column.items7.title|translate:vc.viewState.QV_8237_80795.column.items7.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items7.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items7.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT54_ITEMS7OM592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items7.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items7, \"QV_8237_80795\", \"items7\"):kendo.toString(#=items7#, vc.viewState.QV_8237_80795.column.items7.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items7.sum, $scope.vc.viewState.QV_8237_80795.column.items7.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items7.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items7.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items7.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items8',
                    title: '{{vc.viewState.QV_8237_80795.column.items8.title|translate:vc.viewState.QV_8237_80795.column.items8.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items8.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items8.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT13_ITEMS8ZO592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items8.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items8, \"QV_8237_80795\", \"items8\"):kendo.toString(#=items8#, vc.viewState.QV_8237_80795.column.items8.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items8.sum, $scope.vc.viewState.QV_8237_80795.column.items8.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items8.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items8.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items8.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items9',
                    title: '{{vc.viewState.QV_8237_80795.column.items9.title|translate:vc.viewState.QV_8237_80795.column.items9.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items9.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items9.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT17_ITEMS9BT592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items9.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items9, \"QV_8237_80795\", \"items9\"):kendo.toString(#=items9#, vc.viewState.QV_8237_80795.column.items9.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items9.sum, $scope.vc.viewState.QV_8237_80795.column.items9.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items9.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items9.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items9.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items10',
                    title: '{{vc.viewState.QV_8237_80795.column.items10.title|translate:vc.viewState.QV_8237_80795.column.items10.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items10.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items10.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT15_ITEMS100592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items10.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items10, \"QV_8237_80795\", \"items10\"):kendo.toString(#=items10#, vc.viewState.QV_8237_80795.column.items10.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items10.sum, $scope.vc.viewState.QV_8237_80795.column.items10.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items10.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items10.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items10.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items11',
                    title: '{{vc.viewState.QV_8237_80795.column.items11.title|translate:vc.viewState.QV_8237_80795.column.items11.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items11.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items11.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT84_ITEMS111592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items11.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items11, \"QV_8237_80795\", \"items11\"):kendo.toString(#=items11#, vc.viewState.QV_8237_80795.column.items11.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items11.sum, $scope.vc.viewState.QV_8237_80795.column.items11.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items11.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items11.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items11.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items12',
                    title: '{{vc.viewState.QV_8237_80795.column.items12.title|translate:vc.viewState.QV_8237_80795.column.items12.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items12.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items12.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT10_ITEMS122592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items12.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items12, \"QV_8237_80795\", \"items12\"):kendo.toString(#=items12#, vc.viewState.QV_8237_80795.column.items12.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items12.sum, $scope.vc.viewState.QV_8237_80795.column.items12.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items12.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items12.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items12.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items13',
                    title: '{{vc.viewState.QV_8237_80795.column.items13.title|translate:vc.viewState.QV_8237_80795.column.items13.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items13.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items13.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT72_ITEMS133592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items13.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items13, \"QV_8237_80795\", \"items13\"):kendo.toString(#=items13#, vc.viewState.QV_8237_80795.column.items13.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items13.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items13.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items13.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items14',
                    title: '{{vc.viewState.QV_8237_80795.column.items14.title|translate:vc.viewState.QV_8237_80795.column.items14.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items14.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items14.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT74_ITEMS144592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items14.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items14, \"QV_8237_80795\", \"items14\"):kendo.toString(#=items14#, vc.viewState.QV_8237_80795.column.items14.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items14.sum, $scope.vc.viewState.QV_8237_80795.column.items14.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items14.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items14.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items14.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'items15',
                    title: '{{vc.viewState.QV_8237_80795.column.items15.title|translate:vc.viewState.QV_8237_80795.column.items15.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.items15.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.items15.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT89_ITEMS155592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.items15.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.items15, \"QV_8237_80795\", \"items15\"):kendo.toString(#=items15#, vc.viewState.QV_8237_80795.column.items15.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.items15.sum, $scope.vc.viewState.QV_8237_80795.column.items15.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.items15.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.items15.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.items15.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'shareValue',
                    title: '{{vc.viewState.QV_8237_80795.column.shareValue.title|translate:vc.viewState.QV_8237_80795.column.shareValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.shareValue.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.shareValue.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT18_SHAREVEL592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.shareValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.shareValue, \"QV_8237_80795\", \"shareValue\"):kendo.toString(#=shareValue#, vc.viewState.QV_8237_80795.column.shareValue.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.shareValue.sum, $scope.vc.viewState.QV_8237_80795.column.shareValue.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8237_80795.column.shareValue.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.shareValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.shareValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_8237_80795.column.state.title|translate:vc.viewState.QV_8237_80795.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.state.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.state.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT63_STATEQEV592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_8237_80795\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8237_80795.column.state.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8237_80795.columns.push({
                    field: 'porroga',
                    title: '{{vc.viewState.QV_8237_80795.column.porroga.title|translate:vc.viewState.QV_8237_80795.column.porroga.titleArgs}}',
                    width: $scope.vc.viewState.QV_8237_80795.column.porroga.width,
                    format: $scope.vc.viewState.QV_8237_80795.column.porroga.format,
                    editor: $scope.vc.grids.QV_8237_80795.AT65_PORROGAA592.control,
                    template: "<span ng-class='vc.viewState.QV_8237_80795.column.porroga.style' ng-bind='vc.getStringColumnFormat(dataItem.porroga, \"QV_8237_80795\", \"porroga\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8237_80795.column.porroga.style",
                        "title": "{{vc.viewState.QV_8237_80795.column.porroga.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8237_80795.column.porroga.hidden
                });
            }
            $scope.vc.viewState.QV_8237_80795.toolbar = {}
            $scope.vc.grids.QV_8237_80795.toolbar = [];
            $scope.vc.model.ItemsLoan = {
                concept: $scope.vc.channelDefaultValues("ItemsLoan", "concept"),
                description: $scope.vc.channelDefaultValues("ItemsLoan", "description"),
                itemType: $scope.vc.channelDefaultValues("ItemsLoan", "itemType"),
                paymentMethod: $scope.vc.channelDefaultValues("ItemsLoan", "paymentMethod"),
                value: $scope.vc.channelDefaultValues("ItemsLoan", "value"),
                priority: $scope.vc.channelDefaultValues("ItemsLoan", "priority"),
                latePayment: $scope.vc.channelDefaultValues("ItemsLoan", "latePayment"),
                cause: $scope.vc.channelDefaultValues("ItemsLoan", "cause"),
                reference: $scope.vc.channelDefaultValues("ItemsLoan", "reference"),
                sign: $scope.vc.channelDefaultValues("ItemsLoan", "sign"),
                pointsValue: $scope.vc.channelDefaultValues("ItemsLoan", "pointsValue"),
                pointsType: $scope.vc.channelDefaultValues("ItemsLoan", "pointsType"),
                valueTotalRate: $scope.vc.channelDefaultValues("ItemsLoan", "valueTotalRate"),
                negotiatedRate: $scope.vc.channelDefaultValues("ItemsLoan", "negotiatedRate"),
                annualEfecRate: $scope.vc.channelDefaultValues("ItemsLoan", "annualEfecRate"),
                reajustmenSign: $scope.vc.channelDefaultValues("ItemsLoan", "reajustmenSign"),
                reajustmentValuePoints: $scope.vc.channelDefaultValues("ItemsLoan", "reajustmentValuePoints"),
                reajustmentReference: $scope.vc.channelDefaultValues("ItemsLoan", "reajustmentReference"),
                gain: $scope.vc.channelDefaultValues("ItemsLoan", "gain"),
                baseCalculation: $scope.vc.channelDefaultValues("ItemsLoan", "baseCalculation"),
                chargeForRinging: $scope.vc.channelDefaultValues("ItemsLoan", "chargeForRinging"),
                warrantyType: $scope.vc.channelDefaultValues("ItemsLoan", "warrantyType"),
                warrantyNumber: $scope.vc.channelDefaultValues("ItemsLoan", "warrantyNumber"),
                coveragePercentage: $scope.vc.channelDefaultValues("ItemsLoan", "coveragePercentage"),
                warrantyValue: $scope.vc.channelDefaultValues("ItemsLoan", "warrantyValue"),
                dividendType: $scope.vc.channelDefaultValues("ItemsLoan", "dividendType"),
                interestPeriod: $scope.vc.channelDefaultValues("ItemsLoan", "interestPeriod"),
                tableOtherRate: $scope.vc.channelDefaultValues("ItemsLoan", "tableOtherRate")
            };
            //ViewState - Group: Group1611
            $scope.vc.createViewState({
                id: "G_AMORTIZANI_193871",
                hasId: true,
                componentStyle: [],
                label: 'Group1611',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer1382",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanInstancia = {
                groupSummary: $scope.vc.channelDefaultValues("LoanInstancia", "groupSummary"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation"),
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                tipo: $scope.vc.channelDefaultValues("LoanInstancia", "tipo")
            };
            //ViewState - Group: Group1963
            $scope.vc.createViewState({
                id: "G_AMORTIZTAT_967871",
                hasId: true,
                componentStyle: [],
                label: 'Group1963',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1460",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PVGEOJEKVJ_884443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_INACINGAA_67127",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GeneralInformationForm
            $scope.vc.createViewState({
                id: "VC_EKJDNBLYKM_549347",
                hasId: true,
                componentStyle: [],
                label: 'GeneralInformationForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1373
            $scope.vc.createViewState({
                id: "G_GENERALIAI_310203",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1373',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1472
            $scope.vc.createViewState({
                id: "G_GENERALNII_893203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_INACINGRR_27246",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2751
            $scope.vc.createViewState({
                id: "G_GENERALNTI_350203",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2751',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ColumnsDataValue = {
                col12: $scope.vc.channelDefaultValues("ColumnsDataValue", "col12"),
                col153: $scope.vc.channelDefaultValues("ColumnsDataValue", "col153"),
                col15: $scope.vc.channelDefaultValues("ColumnsDataValue", "col15"),
                col2: $scope.vc.channelDefaultValues("ColumnsDataValue", "col2"),
                col111: $scope.vc.channelDefaultValues("ColumnsDataValue", "col111"),
                col35: $scope.vc.channelDefaultValues("ColumnsDataValue", "col35"),
                col92: $scope.vc.channelDefaultValues("ColumnsDataValue", "col92"),
                col125: $scope.vc.channelDefaultValues("ColumnsDataValue", "col125"),
                col14: $scope.vc.channelDefaultValues("ColumnsDataValue", "col14"),
                col1: $scope.vc.channelDefaultValues("ColumnsDataValue", "col1"),
                col126: $scope.vc.channelDefaultValues("ColumnsDataValue", "col126"),
                col21: $scope.vc.channelDefaultValues("ColumnsDataValue", "col21"),
                col141: $scope.vc.channelDefaultValues("ColumnsDataValue", "col141"),
                col157: $scope.vc.channelDefaultValues("ColumnsDataValue", "col157"),
                col32: $scope.vc.channelDefaultValues("ColumnsDataValue", "col32"),
                col76: $scope.vc.channelDefaultValues("ColumnsDataValue", "col76"),
                col101: $scope.vc.channelDefaultValues("ColumnsDataValue", "col101"),
                col130: $scope.vc.channelDefaultValues("ColumnsDataValue", "col130"),
                col150: $scope.vc.channelDefaultValues("ColumnsDataValue", "col150"),
                col158: $scope.vc.channelDefaultValues("ColumnsDataValue", "col158"),
                col38: $scope.vc.channelDefaultValues("ColumnsDataValue", "col38"),
                col47: $scope.vc.channelDefaultValues("ColumnsDataValue", "col47"),
                col75: $scope.vc.channelDefaultValues("ColumnsDataValue", "col75"),
                col82: $scope.vc.channelDefaultValues("ColumnsDataValue", "col82"),
                col116: $scope.vc.channelDefaultValues("ColumnsDataValue", "col116"),
                col163: $scope.vc.channelDefaultValues("ColumnsDataValue", "col163"),
                col24: $scope.vc.channelDefaultValues("ColumnsDataValue", "col24"),
                col88: $scope.vc.channelDefaultValues("ColumnsDataValue", "col88"),
                col121: $scope.vc.channelDefaultValues("ColumnsDataValue", "col121"),
                col10: $scope.vc.channelDefaultValues("ColumnsDataValue", "col10"),
                col64: $scope.vc.channelDefaultValues("ColumnsDataValue", "col64"),
                col22: $scope.vc.channelDefaultValues("ColumnsDataValue", "col22"),
                col160: $scope.vc.channelDefaultValues("ColumnsDataValue", "col160"),
                col154: $scope.vc.channelDefaultValues("ColumnsDataValue", "col154"),
                col25: $scope.vc.channelDefaultValues("ColumnsDataValue", "col25"),
                col144: $scope.vc.channelDefaultValues("ColumnsDataValue", "col144"),
                col109: $scope.vc.channelDefaultValues("ColumnsDataValue", "col109"),
                col159: $scope.vc.channelDefaultValues("ColumnsDataValue", "col159"),
                col61: $scope.vc.channelDefaultValues("ColumnsDataValue", "col61"),
                col100: $scope.vc.channelDefaultValues("ColumnsDataValue", "col100"),
                col119: $scope.vc.channelDefaultValues("ColumnsDataValue", "col119"),
                col148: $scope.vc.channelDefaultValues("ColumnsDataValue", "col148"),
                col155: $scope.vc.channelDefaultValues("ColumnsDataValue", "col155"),
                col31: $scope.vc.channelDefaultValues("ColumnsDataValue", "col31"),
                col133: $scope.vc.channelDefaultValues("ColumnsDataValue", "col133"),
                col62: $scope.vc.channelDefaultValues("ColumnsDataValue", "col62"),
                col84: $scope.vc.channelDefaultValues("ColumnsDataValue", "col84"),
                col108: $scope.vc.channelDefaultValues("ColumnsDataValue", "col108"),
                col87: $scope.vc.channelDefaultValues("ColumnsDataValue", "col87"),
                col91: $scope.vc.channelDefaultValues("ColumnsDataValue", "col91"),
                col140: $scope.vc.channelDefaultValues("ColumnsDataValue", "col140"),
                col66: $scope.vc.channelDefaultValues("ColumnsDataValue", "col66"),
                col135: $scope.vc.channelDefaultValues("ColumnsDataValue", "col135"),
                col17: $scope.vc.channelDefaultValues("ColumnsDataValue", "col17"),
                col26: $scope.vc.channelDefaultValues("ColumnsDataValue", "col26"),
                col72: $scope.vc.channelDefaultValues("ColumnsDataValue", "col72"),
                col78: $scope.vc.channelDefaultValues("ColumnsDataValue", "col78"),
                col118: $scope.vc.channelDefaultValues("ColumnsDataValue", "col118"),
                col20: $scope.vc.channelDefaultValues("ColumnsDataValue", "col20"),
                col52: $scope.vc.channelDefaultValues("ColumnsDataValue", "col52"),
                col49: $scope.vc.channelDefaultValues("ColumnsDataValue", "col49"),
                col18: $scope.vc.channelDefaultValues("ColumnsDataValue", "col18"),
                col67: $scope.vc.channelDefaultValues("ColumnsDataValue", "col67"),
                col56: $scope.vc.channelDefaultValues("ColumnsDataValue", "col56"),
                col68: $scope.vc.channelDefaultValues("ColumnsDataValue", "col68"),
                col69: $scope.vc.channelDefaultValues("ColumnsDataValue", "col69"),
                col129: $scope.vc.channelDefaultValues("ColumnsDataValue", "col129"),
                col37: $scope.vc.channelDefaultValues("ColumnsDataValue", "col37"),
                col146: $scope.vc.channelDefaultValues("ColumnsDataValue", "col146"),
                col93: $scope.vc.channelDefaultValues("ColumnsDataValue", "col93"),
                col103: $scope.vc.channelDefaultValues("ColumnsDataValue", "col103"),
                col136: $scope.vc.channelDefaultValues("ColumnsDataValue", "col136"),
                col43: $scope.vc.channelDefaultValues("ColumnsDataValue", "col43"),
                col46: $scope.vc.channelDefaultValues("ColumnsDataValue", "col46"),
                col128: $scope.vc.channelDefaultValues("ColumnsDataValue", "col128"),
                col165: $scope.vc.channelDefaultValues("ColumnsDataValue", "col165"),
                col29: $scope.vc.channelDefaultValues("ColumnsDataValue", "col29"),
                col70: $scope.vc.channelDefaultValues("ColumnsDataValue", "col70"),
                col138: $scope.vc.channelDefaultValues("ColumnsDataValue", "col138"),
                col86: $scope.vc.channelDefaultValues("ColumnsDataValue", "col86"),
                col96: $scope.vc.channelDefaultValues("ColumnsDataValue", "col96"),
                col106: $scope.vc.channelDefaultValues("ColumnsDataValue", "col106"),
                col8: $scope.vc.channelDefaultValues("ColumnsDataValue", "col8"),
                col94: $scope.vc.channelDefaultValues("ColumnsDataValue", "col94"),
                col97: $scope.vc.channelDefaultValues("ColumnsDataValue", "col97"),
                col113: $scope.vc.channelDefaultValues("ColumnsDataValue", "col113"),
                col115: $scope.vc.channelDefaultValues("ColumnsDataValue", "col115"),
                col152: $scope.vc.channelDefaultValues("ColumnsDataValue", "col152"),
                col19: $scope.vc.channelDefaultValues("ColumnsDataValue", "col19"),
                col42: $scope.vc.channelDefaultValues("ColumnsDataValue", "col42"),
                col33: $scope.vc.channelDefaultValues("ColumnsDataValue", "col33"),
                col73: $scope.vc.channelDefaultValues("ColumnsDataValue", "col73"),
                col161: $scope.vc.channelDefaultValues("ColumnsDataValue", "col161"),
                col74: $scope.vc.channelDefaultValues("ColumnsDataValue", "col74"),
                col102: $scope.vc.channelDefaultValues("ColumnsDataValue", "col102"),
                col55: $scope.vc.channelDefaultValues("ColumnsDataValue", "col55"),
                col58: $scope.vc.channelDefaultValues("ColumnsDataValue", "col58"),
                col95: $scope.vc.channelDefaultValues("ColumnsDataValue", "col95"),
                col120: $scope.vc.channelDefaultValues("ColumnsDataValue", "col120"),
                col151: $scope.vc.channelDefaultValues("ColumnsDataValue", "col151"),
                col107: $scope.vc.channelDefaultValues("ColumnsDataValue", "col107"),
                col117: $scope.vc.channelDefaultValues("ColumnsDataValue", "col117"),
                col80: $scope.vc.channelDefaultValues("ColumnsDataValue", "col80"),
                col112: $scope.vc.channelDefaultValues("ColumnsDataValue", "col112"),
                col164: $scope.vc.channelDefaultValues("ColumnsDataValue", "col164"),
                col40: $scope.vc.channelDefaultValues("ColumnsDataValue", "col40"),
                col4: $scope.vc.channelDefaultValues("ColumnsDataValue", "col4"),
                col63: $scope.vc.channelDefaultValues("ColumnsDataValue", "col63"),
                col79: $scope.vc.channelDefaultValues("ColumnsDataValue", "col79"),
                col122: $scope.vc.channelDefaultValues("ColumnsDataValue", "col122"),
                col124: $scope.vc.channelDefaultValues("ColumnsDataValue", "col124"),
                col41: $scope.vc.channelDefaultValues("ColumnsDataValue", "col41"),
                col5: $scope.vc.channelDefaultValues("ColumnsDataValue", "col5"),
                col27: $scope.vc.channelDefaultValues("ColumnsDataValue", "col27"),
                col28: $scope.vc.channelDefaultValues("ColumnsDataValue", "col28"),
                col44: $scope.vc.channelDefaultValues("ColumnsDataValue", "col44"),
                col77: $scope.vc.channelDefaultValues("ColumnsDataValue", "col77"),
                col85: $scope.vc.channelDefaultValues("ColumnsDataValue", "col85"),
                col16: $scope.vc.channelDefaultValues("ColumnsDataValue", "col16"),
                col48: $scope.vc.channelDefaultValues("ColumnsDataValue", "col48"),
                col65: $scope.vc.channelDefaultValues("ColumnsDataValue", "col65"),
                col6: $scope.vc.channelDefaultValues("ColumnsDataValue", "col6"),
                col89: $scope.vc.channelDefaultValues("ColumnsDataValue", "col89"),
                col137: $scope.vc.channelDefaultValues("ColumnsDataValue", "col137"),
                col59: $scope.vc.channelDefaultValues("ColumnsDataValue", "col59"),
                col105: $scope.vc.channelDefaultValues("ColumnsDataValue", "col105"),
                col147: $scope.vc.channelDefaultValues("ColumnsDataValue", "col147"),
                col139: $scope.vc.channelDefaultValues("ColumnsDataValue", "col139"),
                col54: $scope.vc.channelDefaultValues("ColumnsDataValue", "col54"),
                col110: $scope.vc.channelDefaultValues("ColumnsDataValue", "col110"),
                col23: $scope.vc.channelDefaultValues("ColumnsDataValue", "col23"),
                col81: $scope.vc.channelDefaultValues("ColumnsDataValue", "col81"),
                col83: $scope.vc.channelDefaultValues("ColumnsDataValue", "col83"),
                col127: $scope.vc.channelDefaultValues("ColumnsDataValue", "col127"),
                col45: $scope.vc.channelDefaultValues("ColumnsDataValue", "col45"),
                col11: $scope.vc.channelDefaultValues("ColumnsDataValue", "col11"),
                col132: $scope.vc.channelDefaultValues("ColumnsDataValue", "col132"),
                col149: $scope.vc.channelDefaultValues("ColumnsDataValue", "col149"),
                col34: $scope.vc.channelDefaultValues("ColumnsDataValue", "col34"),
                col114: $scope.vc.channelDefaultValues("ColumnsDataValue", "col114"),
                col13: $scope.vc.channelDefaultValues("ColumnsDataValue", "col13"),
                col3: $scope.vc.channelDefaultValues("ColumnsDataValue", "col3"),
                col51: $scope.vc.channelDefaultValues("ColumnsDataValue", "col51"),
                col131: $scope.vc.channelDefaultValues("ColumnsDataValue", "col131"),
                col7: $scope.vc.channelDefaultValues("ColumnsDataValue", "col7"),
                col99: $scope.vc.channelDefaultValues("ColumnsDataValue", "col99"),
                col156: $scope.vc.channelDefaultValues("ColumnsDataValue", "col156"),
                col53: $scope.vc.channelDefaultValues("ColumnsDataValue", "col53"),
                col90: $scope.vc.channelDefaultValues("ColumnsDataValue", "col90"),
                col9: $scope.vc.channelDefaultValues("ColumnsDataValue", "col9"),
                col143: $scope.vc.channelDefaultValues("ColumnsDataValue", "col143"),
                col50: $scope.vc.channelDefaultValues("ColumnsDataValue", "col50"),
                col57: $scope.vc.channelDefaultValues("ColumnsDataValue", "col57"),
                col104: $scope.vc.channelDefaultValues("ColumnsDataValue", "col104"),
                col123: $scope.vc.channelDefaultValues("ColumnsDataValue", "col123"),
                col134: $scope.vc.channelDefaultValues("ColumnsDataValue", "col134"),
                col98: $scope.vc.channelDefaultValues("ColumnsDataValue", "col98"),
                col142: $scope.vc.channelDefaultValues("ColumnsDataValue", "col142"),
                col30: $scope.vc.channelDefaultValues("ColumnsDataValue", "col30"),
                col36: $scope.vc.channelDefaultValues("ColumnsDataValue", "col36"),
                col60: $scope.vc.channelDefaultValues("ColumnsDataValue", "col60"),
                col39: $scope.vc.channelDefaultValues("ColumnsDataValue", "col39"),
                col145: $scope.vc.channelDefaultValues("ColumnsDataValue", "col145"),
                col162: $scope.vc.channelDefaultValues("ColumnsDataValue", "col162"),
                col71: $scope.vc.channelDefaultValues("ColumnsDataValue", "col71")
            };
            //ViewState - Group: Group2346
            $scope.vc.createViewState({
                id: "G_GENERALTOT_320203",
                hasId: true,
                componentStyle: [],
                label: 'Group2346',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col30
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXYLL_293203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CIUDADOWX_60477",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col82
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXFHY_331203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHALTOO_39934",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col91
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXCX_878203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLASECAAR_47647",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col11
            $scope.vc.createViewState({
                id: "VA_COL11DMRXFYBTRJ_832203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAVECC_96232",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col89
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXOZJ_807203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LNEACRDTO_48406",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col70
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXCLV_313203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NODESEMOO_55920",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col3
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXCEU_727203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NOTRMITEE_74697",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col74
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXZST_196203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONTOAPBD_71203",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col4
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKKT_290203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUPOCRDTI_19665",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col63
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQVD_784203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONTODEOD_23440",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col28
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXFUR_725203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESTINOOC_59024",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col127
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXAE_419203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_EDADLACET_95722",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col96
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNUC_515203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOTOAL_26299",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col116
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXMIJ_255203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DASMORATI_28104",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col148
            $scope.vc.createViewState({
                id: "VA_COL148YHTMQIFBH_165203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORVEOC_61297",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col98
            $scope.vc.createViewState({
                id: "VA_COL98VYAYLZCUKZ_984203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DASMORAAT_28115",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col149
            $scope.vc.createViewState({
                id: "VA_COL149ECRVIIDXJ_360203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VALORVEON_28016",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col94
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTXW_844203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CALIFICCI_91783",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col150
            $scope.vc.createViewState({
                id: "VA_COL150TJUVFKMWM_571203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOALEC_65454",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col16
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVHS_357203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CALIFICNO_68506",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col151
            $scope.vc.createViewState({
                id: "VA_COL151XEUXPLAEA_433203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOALCO_75666",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col17
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVBB_693203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CALIFICET_92262",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col138
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXWVS_331203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RECONOCAR_36694",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col13
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLAA_716203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAAPCN_19760",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col139
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXEUN_350203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOREMO_75006",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col71
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPCU_828203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADEOS_48240",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1229",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col153
            $scope.vc.createViewState({
                id: "Spacer1311",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TOTALINRR_66897",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col154
            $scope.vc.createViewState({
                id: "Spacer2686",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUOTASATA_69407",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col155
            $scope.vc.createViewState({
                id: "Spacer2171",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAULPG_53460",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col165
            $scope.vc.createViewState({
                id: "VA_4086ZMVXZJNDMHS_762203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESCUENSS_59587",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1470
            $scope.vc.createViewState({
                id: "G_GENERALONN_841203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_INACINDOU_54590",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col100
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVBP_896203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SITUACINE_16890",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col102
            $scope.vc.createViewState({
                id: "VA_COL102IZHQPGLGQ_823203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CAUSALDLE_65221",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col103
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXSFC_390203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ACTIVIDDO_51539",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col88
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXZSP_614203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DIRECCIEL_96339",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1222
            $scope.vc.createViewState({
                id: "G_GENERALNNI_340203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOSUVW_11378",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col158
            $scope.vc.createViewState({
                id: "Spacer2826",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONTOAPBR_67663",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col159
            $scope.vc.createViewState({
                id: "Spacer2147",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOCAIL_20293",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col160
            $scope.vc.createViewState({
                id: "Spacer2988",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DISPONISS_66660",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col161
            $scope.vc.createViewState({
                id: "Spacer2946",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESEMBOLL_35488",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col162
            $scope.vc.createViewState({
                id: "Spacer2278",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOEXLL_19429",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col163
            $scope.vc.createViewState({
                id: "Spacer2684",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDOPRLL_32016",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1127
            $scope.vc.createViewState({
                id: "G_GENERALONI_753203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FINANCITT_72718",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col93
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXQS_367203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ORIGENLOR_50930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col106
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDFL_233203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOEMPRR_89552",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col10
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLDN_789203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRESTAMIA_77621",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col144
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPRC_818203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_LLAVEFIRN_58448",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col92
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXAYN_905203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PROGRAMIA_80361",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col146
            $scope.vc.createViewState({
                id: "VA_COL146AYXFKCRYI_168203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GARANTIAA_86084",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2395
            $scope.vc.createViewState({
                id: "G_GENERALANO_847203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_COBRANZAA_71245",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col128
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHNK_820203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOCRN_89020",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col136
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXMWQ_662203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TELFONOOA_88199",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col132
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXYAE_738203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ABOGADOOO_21860",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col137
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPRR_754203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DIRECCICG_85645",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col14
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXFJI_119203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHACAIT_74724",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2849
            $scope.vc.createViewState({
                id: "G_GENERALIII_644203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RENOVACSE_44398",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col37
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXSJD_345203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERMITEEE_35071",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col38
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLZX_625203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NMERORENN_52628",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col140
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXZYM_339203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OPERACIED_32635",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col141
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTAU_538203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OPERACINI_16531",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col119
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXWQL_188203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERMITETT_45382",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col133
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQNT_219203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DIFERIDNI_94027",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col95
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXYN_505203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NMERORERU_53366",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col97
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGBW_313203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHALTTT_31717",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col134
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKJW_728203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SALDODIOR_28205",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1277
            $scope.vc.createViewState({
                id: "G_GENERALNNT_676203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONDICIEE_44365",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2205
            $scope.vc.createViewState({
                id: "G_GENERALOAO_673203",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2205',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1998
            $scope.vc.createViewState({
                id: "G_GENERALITA_364203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PAGOSDEOA_39140",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col32
            $scope.vc.createViewState({
                id: "VA_COL32CDFPUYWBGD_758203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APAGOVQRF_51833",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col46
            $scope.vc.createViewState({
                id: "VA_COL46RBGZXOSXUD_578203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PAGOADIAL_89040",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col33
            $scope.vc.createViewState({
                id: "VA_COL33GXLNAEOZIW_513203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REFERENCC_20812",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col54
            $scope.vc.createViewState({
                id: "VA_COL54TKWEEBKVXN_134203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DAPAGOCVP_50161",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col44
            $scope.vc.createViewState({
                id: "VA_COL44RQKRIFDDCK_361203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOCOBRO_94502",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1893
            $scope.vc.createViewState({
                id: "G_GENERALNNA_696203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRSTAMOCV_96028",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col18
            $scope.vc.createViewState({
                id: "VA_COL18MPQAUPJEQF_886203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PLAZOEZCX_65608",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col24
            $scope.vc.createViewState({
                id: "VA_COL24NFMYARIPPW_188203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERODOSIL_10161",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col22
            $scope.vc.createViewState({
                id: "VA_COL22GPNCCEADAN_455203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERODOSAO_51516",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col25
            $scope.vc.createViewState({
                id: "VA_COL25RWYMCMPQKL_227203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERODOSIE_78309",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col23
            $scope.vc.createViewState({
                id: "VA_COL23ZUQVNTSTGF_643203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERODOSIO_78507",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col77
            $scope.vc.createViewState({
                id: "VA_COL77JLESNGFECP_839203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MESGRACAI_83900",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2800
            $scope.vc.createViewState({
                id: "G_GENERALIOI_483203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TABLAAMIO_45588",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col49
            $scope.vc.createViewState({
                id: "VA_COL49ZEUCHXHDSZ_263203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOTABCZ_61680",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col81
            $scope.vc.createViewState({
                id: "VA_COL81JBFTYRSPYI_282203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_EVITARDDA_31627",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col111
            $scope.vc.createViewState({
                id: "VA_COL111PZXDZUYUC_787203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BASECLCLU_56377",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col113
            $scope.vc.createViewState({
                id: "VA_COL113YQSWHDUHL_890203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ULTIMODII_19737",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col48
            $scope.vc.createViewState({
                id: "VA_COL48UDRRPRVRAD_844203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DASDELAOO_32774",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col53
            $scope.vc.createViewState({
                id: "VA_COL53CZDOJNOMFT_346203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DASGRACAA_67492",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col112
            $scope.vc.createViewState({
                id: "VA_COL112OCPGNLXFG_495203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RECALCUAA_80422",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1763
            $scope.vc.createViewState({
                id: "G_GENERALNOA_213203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REAJUSTEE_13520",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col80
            $scope.vc.createViewState({
                id: "VA_COL80ASFOWXJRDC_132203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REAJUSTAE_35292",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col35
            $scope.vc.createViewState({
                id: "VA_COL35HREVITBWJO_552203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAPRIM_57148",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ColumnsDataValue, Attribute: col34
            $scope.vc.createViewState({
                id: "VA_COL34HWLCGTUDDY_405203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERODOSUE_60819",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1145
            $scope.vc.createViewState({
                id: "G_GENERALOAN_318203",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CONDICINE_19717",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.OperationPaymentColumn = {
                attribute1: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute1"),
                attribute2: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute2"),
                attribute3: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute3"),
                attribute4: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute4"),
                attribute5: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute5"),
                attribute6: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute6"),
                attribute7: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute7"),
                attribute8: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute8"),
                attribute9: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute9"),
                attribute10: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute10"),
                attribute11: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute11"),
                attribute12: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute12"),
                attribute13: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute13"),
                attribute14: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute14"),
                attribute15: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute15"),
                attribute16: $scope.vc.channelDefaultValues("OperationPaymentColumn", "attribute16")
            };
            //ViewState - Group: Group1450
            $scope.vc.createViewState({
                id: "G_GENERALTIO_414203",
                hasId: true,
                componentStyle: [],
                label: 'Group1450',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute1
            $scope.vc.createViewState({
                id: "VA_1FGSVHUUVWIKFUH_287203",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_1FGSVHUUVWIKFUH_287203 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'A',
                            value: 'Pago los intereses acumulados?'
                        }, {
                            code: 'P',
                            value: 'Pago los intereses proyectados?'
                        }, {
                            code: 'E',
                            value: 'Pago los intereses en valor presente'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_1FGSVHUUVWIKFUH_287203 !== "undefined") {}
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute2
            $scope.vc.createViewState({
                id: "VA_2SRBPZVHVQZKGLJ_978203",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_2SRBPZVHVQZKGLJ_978203 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Pagos por Cuota'
                        }, {
                            code: 'N',
                            value: 'Pagos por Rubro'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_2SRBPZVHVQZKGLJ_978203 !== "undefined") {}
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute7
            $scope.vc.createViewState({
                id: "VA_7HLMTHMOBEPUKDK_450203",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_7HLMTHMOBEPUKDK_450203 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'N',
                            value: 'Pago Normal'
                        }, {
                            code: 'C',
                            value: 'Pago Extraordinario con reducción de cuota'
                        }, {
                            code: 'T',
                            value: 'Pago Extraordinario con reducción de tiempo'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_7HLMTHMOBEPUKDK_450203 !== "undefined") {}
            //ViewState - Group: Group1518
            $scope.vc.createViewState({
                id: "G_GENERALNTO_230203",
                hasId: true,
                componentStyle: [],
                label: 'Group1518',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute3
            $scope.vc.createViewState({
                id: "VA_3NNEJBUKBEXSHGE_308203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CALCULACT_91300",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute4
            $scope.vc.createViewState({
                id: "VA_4FLCMFUIKOOYYCR_921203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SEACEPTAO_97874",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute5
            $scope.vc.createViewState({
                id: "VA_5KYGLTQZCBSQIFR_819203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SOLOPAGCT_38138",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OperationPaymentColumn, Attribute: attribute6
            $scope.vc.createViewState({
                id: "VA_6ECRCCEMLGMWTWN_816203",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PERMITECA_18156",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_QUIXVIFIPS_846443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GARANTADS_87414",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: QueryLoanWarrantyForm
            $scope.vc.createViewState({
                id: "VC_EPZIMVPJNM_155123",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GARANTASS_13684",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1332
            $scope.vc.createViewState({
                id: "G_LOANWARANT_597867",
                hasId: true,
                componentStyle: [],
                label: 'Group1332',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.LoanWarranty = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    warranty: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "warranty", '')
                    },
                    statusWarranty: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "statusWarranty", '')
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "description", '')
                    },
                    customerID: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "customerID", 0)
                    },
                    customer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "customer", '')
                    },
                    currentValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "currentValue", 0)
                    },
                    currencyID: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "currencyID", 0)
                    },
                    createdOn: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanWarranty", "createdOn", '')
                    }
                }
            });
            $scope.vc.model.LoanWarranty = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_LOANWATN_1941();
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
                    model: $scope.vc.types.LoanWarranty
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1941_28530").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_LOANWATN_1941 = $scope.vc.model.LoanWarranty;
            $scope.vc.trackers.LoanWarranty = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.LoanWarranty);
            $scope.vc.model.LoanWarranty.bind('change', function(e) {
                $scope.vc.trackers.LoanWarranty.track(e);
            });
            $scope.vc.grids.QV_1941_28530 = {};
            $scope.vc.grids.QV_1941_28530.queryId = 'Q_LOANWATN_1941';
            $scope.vc.viewState.QV_1941_28530 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1941_28530.column = {};
            $scope.vc.grids.QV_1941_28530.editable = false;
            $scope.vc.grids.QV_1941_28530.events = {
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
                    $scope.vc.trackers.LoanWarranty.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1941_28530.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_1941_28530");
                    $scope.vc.hideShowColumns("QV_1941_28530", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1941_28530.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1941_28530.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1941_28530.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1941_28530 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1941_28530 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1941_28530.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1941_28530.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1941_28530.column.warranty = {
                title: 'ASSTS.LBL_ASSTS_GARANTAUE_45721',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXASD_283867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT17_WARRANTY642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.warranty.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXASD_283867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.warranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.warranty.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.statusWarranty = {
                title: 'ASSTS.LBL_ASSTS_ESTADOGTA_51240',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLGJ_305867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT77_STATUSAR642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.statusWarranty.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLGJ_305867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.statusWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.statusWarranty.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPNI_65857',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGCL_579867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT51_DESCRION642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGCL_579867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.customerID = {
                title: 'ASSTS.LBL_ASSTS_CODIGOCEN_52038',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#######",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYZM_796867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT13_CODCLINN642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.customerID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYZM_796867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.customerID.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1941_28530.column.customerID.format",
                        'k-decimals': "vc.viewState.QV_1941_28530.column.customerID.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.customerID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.customer = {
                title: 'ASSTS.LBL_ASSTS_NOMBRECNI_63306',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYSC_521867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT79_CUSTOMER642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.customer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYSC_521867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.customer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.customer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.currentValue = {
                title: 'ASSTS.LBL_ASSTS_VALORACUA_99891',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIAU_379867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT25_CURRENAL642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.currentValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIAU_379867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.currentValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1941_28530.column.currentValue.format",
                        'k-decimals': "vc.viewState.QV_1941_28530.column.currentValue.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.currentValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.currencyID = {
                title: 'ASSTS.LBL_ASSTS_MONEDATUB_92849',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVWC_252867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT13_CURRENYY642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.currencyID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVWC_252867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.currencyID.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1941_28530.column.currencyID.format",
                        'k-decimals': "vc.viewState.QV_1941_28530.column.currencyID.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.currencyID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1941_28530.column.createdOn = {
                title: 'ASSTS.LBL_ASSTS_FECHAINGG_82521',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRQN_217867',
                element: []
            };
            $scope.vc.grids.QV_1941_28530.AT92_CREATENO642 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1941_28530.column.createdOn.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRQN_217867",
                        'data-validation-code': "{{vc.viewState.QV_1941_28530.column.createdOn.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1941_28530.column.createdOn.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'warranty',
                    title: '{{vc.viewState.QV_1941_28530.column.warranty.title|translate:vc.viewState.QV_1941_28530.column.warranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.warranty.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.warranty.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT17_WARRANTY642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.warranty.style' ng-bind='vc.getStringColumnFormat(dataItem.warranty, \"QV_1941_28530\", \"warranty\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1941_28530.column.warranty.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.warranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.warranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'statusWarranty',
                    title: '{{vc.viewState.QV_1941_28530.column.statusWarranty.title|translate:vc.viewState.QV_1941_28530.column.statusWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.statusWarranty.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.statusWarranty.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT77_STATUSAR642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.statusWarranty.style' ng-bind='vc.getStringColumnFormat(dataItem.statusWarranty, \"QV_1941_28530\", \"statusWarranty\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1941_28530.column.statusWarranty.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.statusWarranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.statusWarranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_1941_28530.column.description.title|translate:vc.viewState.QV_1941_28530.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.description.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.description.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT51_DESCRION642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_1941_28530\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1941_28530.column.description.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'customerID',
                    title: '{{vc.viewState.QV_1941_28530.column.customerID.title|translate:vc.viewState.QV_1941_28530.column.customerID.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.customerID.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.customerID.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT13_CODCLINN642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.customerID.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerID, \"QV_1941_28530\", \"customerID\"):kendo.toString(#=customerID#, vc.viewState.QV_1941_28530.column.customerID.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1941_28530.column.customerID.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.customerID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.customerID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'customer',
                    title: '{{vc.viewState.QV_1941_28530.column.customer.title|translate:vc.viewState.QV_1941_28530.column.customer.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.customer.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.customer.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT79_CUSTOMER642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.customer.style' ng-bind='vc.getStringColumnFormat(dataItem.customer, \"QV_1941_28530\", \"customer\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1941_28530.column.customer.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.customer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.customer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'currentValue',
                    title: '{{vc.viewState.QV_1941_28530.column.currentValue.title|translate:vc.viewState.QV_1941_28530.column.currentValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.currentValue.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.currentValue.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT25_CURRENAL642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.currentValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currentValue, \"QV_1941_28530\", \"currentValue\"):kendo.toString(#=currentValue#, vc.viewState.QV_1941_28530.column.currentValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1941_28530.column.currentValue.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.currentValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.currentValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'currencyID',
                    title: '{{vc.viewState.QV_1941_28530.column.currencyID.title|translate:vc.viewState.QV_1941_28530.column.currencyID.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.currencyID.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.currencyID.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT13_CURRENYY642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.currencyID.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currencyID, \"QV_1941_28530\", \"currencyID\"):kendo.toString(#=currencyID#, vc.viewState.QV_1941_28530.column.currencyID.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1941_28530.column.currencyID.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.currencyID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.currencyID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1941_28530.columns.push({
                    field: 'createdOn',
                    title: '{{vc.viewState.QV_1941_28530.column.createdOn.title|translate:vc.viewState.QV_1941_28530.column.createdOn.titleArgs}}',
                    width: $scope.vc.viewState.QV_1941_28530.column.createdOn.width,
                    format: $scope.vc.viewState.QV_1941_28530.column.createdOn.format,
                    editor: $scope.vc.grids.QV_1941_28530.AT92_CREATENO642.control,
                    template: "<span ng-class='vc.viewState.QV_1941_28530.column.createdOn.style' ng-bind='vc.getStringColumnFormat(dataItem.createdOn, \"QV_1941_28530\", \"createdOn\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1941_28530.column.createdOn.style",
                        "title": "{{vc.viewState.QV_1941_28530.column.createdOn.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1941_28530.column.createdOn.hidden
                });
            }
            $scope.vc.viewState.QV_1941_28530.toolbar = {}
            $scope.vc.grids.QV_1941_28530.toolbar = []; //ViewState - Container: QueryLoanDebtorForm
            $scope.vc.createViewState({
                id: "VC_OMVKQHYJYA_439168",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DEUDORESS_24940",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1814
            $scope.vc.createViewState({
                id: "G_LOANDEBOOO_201252",
                hasId: true,
                componentStyle: [],
                label: 'Group1814',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.LoanDebtor = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    customerID: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "customerID", 0)
                    },
                    identityCard: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "identityCard", '')
                    },
                    role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "role", '')
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "customerName", '')
                    },
                    phone: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "phone", '')
                    },
                    address: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "address", '')
                    },
                    centralCollection: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanDebtor", "centralCollection", '')
                    }
                }
            });
            $scope.vc.model.LoanDebtor = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_LOANDEBB_6719();
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
                    model: $scope.vc.types.LoanDebtor
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6719_92672").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_LOANDEBB_6719 = $scope.vc.model.LoanDebtor;
            $scope.vc.trackers.LoanDebtor = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.LoanDebtor);
            $scope.vc.model.LoanDebtor.bind('change', function(e) {
                $scope.vc.trackers.LoanDebtor.track(e);
            });
            $scope.vc.grids.QV_6719_92672 = {};
            $scope.vc.grids.QV_6719_92672.queryId = 'Q_LOANDEBB_6719';
            $scope.vc.viewState.QV_6719_92672 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6719_92672.column = {};
            $scope.vc.grids.QV_6719_92672.editable = false;
            $scope.vc.grids.QV_6719_92672.events = {
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
                    $scope.vc.trackers.LoanDebtor.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6719_92672.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6719_92672");
                    $scope.vc.hideShowColumns("QV_6719_92672", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6719_92672.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6719_92672.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6719_92672.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6719_92672 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6719_92672 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6719_92672.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6719_92672.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6719_92672.column.customerID = {
                title: 'ASSTS.LBL_ASSTS_CODIGOCEN_52038',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#######",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEKG_185252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT49_CUSTOMDR749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.customerID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEKG_185252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.customerID.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6719_92672.column.customerID.format",
                        'k-decimals': "vc.viewState.QV_6719_92672.column.customerID.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.customerID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6719_92672.column.identityCard = {
                title: 'ASSTS.LBL_ASSTS_CENITANEL_46995',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRPO_508252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT78_IDCARDFV749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.identityCard.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRPO_508252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.identityCard.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.identityCard.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6719_92672.column.role = {
                title: 'ASSTS.LBL_ASSTS_ROLDOBJMA_96413',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOOO_135252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT91_ROLEJPXR749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.role.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOOO_135252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.role.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.role.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6719_92672.column.customerName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREULS_81822',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBZS_504252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT58_CUSTOMME749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBZS_504252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6719_92672.column.phone = {
                title: 'ASSTS.LBL_ASSTS_TELFONOPO_65834',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJET_751252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT72_PHONEKRF749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.phone.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJET_751252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.phone.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.phone.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6719_92672.column.address = {
                title: 'ASSTS.LBL_ASSTS_DIRECCINN_30768',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHKU_739252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT39_ADDRESSS749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.address.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHKU_739252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.address.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.address.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6719_92672.column.centralCollection = {
                title: 'ASSTS.LBL_ASSTS_COBCENTAR_80329',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXKU_150252',
                element: []
            };
            $scope.vc.grids.QV_6719_92672.AT27_CENTRAOI749 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6719_92672.column.centralCollection.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXKU_150252",
                        'data-validation-code': "{{vc.viewState.QV_6719_92672.column.centralCollection.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6719_92672.column.centralCollection.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'customerID',
                    title: '{{vc.viewState.QV_6719_92672.column.customerID.title|translate:vc.viewState.QV_6719_92672.column.customerID.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.customerID.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.customerID.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT49_CUSTOMDR749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.customerID.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerID, \"QV_6719_92672\", \"customerID\"):kendo.toString(#=customerID#, vc.viewState.QV_6719_92672.column.customerID.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6719_92672.column.customerID.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.customerID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.customerID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'identityCard',
                    title: '{{vc.viewState.QV_6719_92672.column.identityCard.title|translate:vc.viewState.QV_6719_92672.column.identityCard.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.identityCard.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.identityCard.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT78_IDCARDFV749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.identityCard.style' ng-bind='vc.getStringColumnFormat(dataItem.identityCard, \"QV_6719_92672\", \"identityCard\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6719_92672.column.identityCard.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.identityCard.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.identityCard.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'role',
                    title: '{{vc.viewState.QV_6719_92672.column.role.title|translate:vc.viewState.QV_6719_92672.column.role.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.role.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.role.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT91_ROLEJPXR749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.role.style' ng-bind='vc.getStringColumnFormat(dataItem.role, \"QV_6719_92672\", \"role\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6719_92672.column.role.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_6719_92672.column.customerName.title|translate:vc.viewState.QV_6719_92672.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.customerName.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.customerName.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT58_CUSTOMME749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_6719_92672\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6719_92672.column.customerName.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'phone',
                    title: '{{vc.viewState.QV_6719_92672.column.phone.title|translate:vc.viewState.QV_6719_92672.column.phone.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.phone.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.phone.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT72_PHONEKRF749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.phone.style' ng-bind='vc.getStringColumnFormat(dataItem.phone, \"QV_6719_92672\", \"phone\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6719_92672.column.phone.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.phone.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.phone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'address',
                    title: '{{vc.viewState.QV_6719_92672.column.address.title|translate:vc.viewState.QV_6719_92672.column.address.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.address.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.address.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT39_ADDRESSS749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.address.style' ng-bind='vc.getStringColumnFormat(dataItem.address, \"QV_6719_92672\", \"address\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6719_92672.column.address.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.address.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.address.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6719_92672.columns.push({
                    field: 'centralCollection',
                    title: '{{vc.viewState.QV_6719_92672.column.centralCollection.title|translate:vc.viewState.QV_6719_92672.column.centralCollection.titleArgs}}',
                    width: $scope.vc.viewState.QV_6719_92672.column.centralCollection.width,
                    format: $scope.vc.viewState.QV_6719_92672.column.centralCollection.format,
                    editor: $scope.vc.grids.QV_6719_92672.AT27_CENTRAOI749.control,
                    template: "<span ng-class='vc.viewState.QV_6719_92672.column.centralCollection.style' ng-bind='vc.getStringColumnFormat(dataItem.centralCollection, \"QV_6719_92672\", \"centralCollection\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6719_92672.column.centralCollection.style",
                        "title": "{{vc.viewState.QV_6719_92672.column.centralCollection.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6719_92672.column.centralCollection.hidden
                });
            }
            $scope.vc.viewState.QV_6719_92672.toolbar = {}
            $scope.vc.grids.QV_6719_92672.toolbar = []; //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_IQUYIRTOTY_341443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RUBROSYSA_16960",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: QueryItemsLoanForm
            $scope.vc.createViewState({
                id: "VC_QURKRPJTSC_906712",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RUBROSAEW_67124",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1415
            $scope.vc.createViewState({
                id: "G_ITEMSLONNA_169129",
                hasId: true,
                componentStyle: [],
                label: 'Group1415',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.LoanEntry = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "description", '')
                    },
                    concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "concept", '')
                    },
                    paymentMethod: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "paymentMethod", '')
                    },
                    itemType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "itemType", '')
                    },
                    priority: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "priority", 0)
                    },
                    value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "value", 0)
                    },
                    latePayment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "latePayment", '')
                    },
                    reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "reference", '')
                    },
                    sign: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "sign", '')
                    },
                    cause: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "cause", '')
                    },
                    pointsValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "pointsValue", 0)
                    },
                    pointsType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "pointsType", '')
                    },
                    valueTotalRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "valueTotalRate", 0)
                    },
                    negotiatedRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "negotiatedRate", 0)
                    },
                    annualEfecRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "annualEfecRate", 0)
                    },
                    reajustmenSign: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "reajustmenSign", '')
                    },
                    reajustmentValuePoints: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "reajustmentValuePoints", 0)
                    },
                    reajustmentReference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "reajustmentReference", '')
                    },
                    gain: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "gain", 0)
                    },
                    baseCalculation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "baseCalculation", 0)
                    },
                    chargeForRinging: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "chargeForRinging", 0)
                    },
                    warrantyType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "warrantyType", '')
                    },
                    warrantyNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "warrantyNumber", '')
                    },
                    coveragePercentage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "coveragePercentage", '')
                    },
                    warrantyValue: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "warrantyValue", '')
                    },
                    dividendType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "dividendType", '')
                    },
                    interestPeriod: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "interestPeriod", 0)
                    },
                    tableOtherRate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanEntry", "tableOtherRate", '')
                    }
                }
            });
            $scope.vc.model.LoanEntry = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_OPERATNY_7536();
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
                    model: $scope.vc.types.LoanEntry
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7536_43842").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_OPERATNY_7536 = $scope.vc.model.LoanEntry;
            $scope.vc.trackers.LoanEntry = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.LoanEntry);
            $scope.vc.model.LoanEntry.bind('change', function(e) {
                $scope.vc.trackers.LoanEntry.track(e);
            });
            $scope.vc.grids.QV_7536_43842 = {};
            $scope.vc.grids.QV_7536_43842.queryId = 'Q_OPERATNY_7536';
            $scope.vc.viewState.QV_7536_43842 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7536_43842.column = {};
            $scope.vc.grids.QV_7536_43842.editable = false;
            $scope.vc.grids.QV_7536_43842.events = {
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
                    $scope.vc.trackers.LoanEntry.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7536_43842.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7536_43842");
                    $scope.vc.hideShowColumns("QV_7536_43842", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7536_43842.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7536_43842.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7536_43842.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7536_43842 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7536_43842 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_7536_43842.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_7536_43842.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "LoanEntry", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7536_43842.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7536_43842.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7536_43842.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPNI_65857',
                titleArgs: {},
                tooltip: '',
                width: 450,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWQQ_927129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT15_DESCRIPT197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWQQ_927129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.concept = {
                title: 'ASSTS.LBL_ASSTS_RUBROFKGQ_42963',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPWL_897129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT52_CONCEPTT197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.concept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPWL_897129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.concept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.concept.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.paymentMethod = {
                title: 'ASSTS.LBL_ASSTS_FPAGORPAW_90895',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGZZ_547129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT18_PAYMENTH197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.paymentMethod.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGZZ_547129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.paymentMethod.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.paymentMethod.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.itemType = {
                title: 'ASSTS.LBL_ASSTS_TIPORUBRR_96500',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXELD_365129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT19_ITEMTYPE197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.itemType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXELD_365129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.itemType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.itemType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.priority = {
                title: 'ASSTS.LBL_ASSTS_PRIORIDDD_58504',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUKJ_377129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT78_PRIORITT197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.priority.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUKJ_377129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.priority.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.priority.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.priority.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.priority.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.value = {
                title: 'ASSTS.LBL_ASSTS_VALORNPRH_26284',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVJT_905129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT80_VALUEIST197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.value.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVJT_905129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.value.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.value.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.value.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.value.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.latePayment = {
                title: 'ASSTS.LBL_ASSTS_PAGAMORAA_45490',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPWU_574129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT36_LATEPAYN197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.latePayment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPWU_574129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.latePayment.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.latePayment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.reference = {
                title: 'ASSTS.LBL_ASSTS_REFERENCC_20812',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEHI_505129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT67_REFERENE197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.reference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEHI_505129",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.reference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.reference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.sign = {
                title: 'ASSTS.LBL_ASSTS_SIGNORIHO_57042',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUAW_754129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT34_SIGNVYDC197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.sign.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUAW_754129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.sign.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.sign.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.cause = {
                title: 'ASSTS.LBL_ASSTS_CAUSAWSDF_28774',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRPV_709129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT26_CAUSEJWV197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.cause.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRPV_709129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.cause.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.cause.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.pointsValue = {
                title: 'ASSTS.LBL_ASSTS_VALORPUSN_71021',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXZQ_673129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT63_POINTSAU197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.pointsValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXZQ_673129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.pointsValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.pointsValue.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.pointsValue.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.pointsValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.pointsType = {
                title: 'ASSTS.LBL_ASSTS_TIPOPUNSS_34777',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZDB_612129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT15_POINTSYY197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.pointsType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZDB_612129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.pointsType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.pointsType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.valueTotalRate = {
                title: 'ASSTS.LBL_ASSTS_VALORTAAT_13849',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "##.## \%",
                decimals: 5,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBHL_158129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT45_VALUETEL197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.valueTotalRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBHL_158129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.valueTotalRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.valueTotalRate.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.valueTotalRate.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.valueTotalRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.negotiatedRate = {
                title: 'ASSTS.LBL_ASSTS_TASANEGCD_62769',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "##.## \%",
                decimals: 5,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGKJ_582129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT65_NEGOTITR197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.negotiatedRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGKJ_582129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.negotiatedRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.negotiatedRate.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.negotiatedRate.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.negotiatedRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.annualEfecRate = {
                title: 'ASSTS.LBL_ASSTS_TASAEFECA_65157',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "##.## \%",
                decimals: 5,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXILF_690129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT53_ANNUALFE197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.annualEfecRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXILF_690129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.annualEfecRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.annualEfecRate.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.annualEfecRate.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.annualEfecRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.reajustmenSign = {
                title: 'ASSTS.LBL_ASSTS_SIGNOREJJ_83381',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAOL_704129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT31_REAJUSNN197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.reajustmenSign.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAOL_704129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.reajustmenSign.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.reajustmenSign.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.reajustmentValuePoints = {
                title: 'ASSTS.LBL_ASSTS_VALORPUSS_38342',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLYN_413129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT17_REAJUSPT197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.reajustmentValuePoints.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLYN_413129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.reajustmentValuePoints.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.reajustmentValuePoints.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.reajustmentValuePoints.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.reajustmentValuePoints.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.reajustmentReference = {
                title: 'ASSTS.LBL_ASSTS_REFERENAI_46054',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIGC_163129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT50_REAJUSNN197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.reajustmentReference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIGC_163129",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.reajustmentReference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.reajustmentReference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.gain = {
                title: 'ASSTS.LBL_ASSTS_GRACIAVXF_14263',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIBA_173129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT84_GAINLJFX197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.gain.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIBA_173129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.gain.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.gain.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.gain.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.gain.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.baseCalculation = {
                title: 'ASSTS.LBL_ASSTS_BASECLCLU_56377',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPTQ_834129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT27_BASECAOT197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.baseCalculation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPTQ_834129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.baseCalculation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.baseCalculation.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.baseCalculation.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.baseCalculation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.chargeForRinging = {
                title: 'ASSTS.LBL_ASSTS_PORCOBRRM_45131',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNUQ_510129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT24_CHARGENR197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.chargeForRinging.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNUQ_510129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.chargeForRinging.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.chargeForRinging.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.chargeForRinging.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.chargeForRinging.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.warrantyType = {
                title: 'ASSTS.LBL_ASSTS_TIPOGARAT_87847',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYID_261129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT74_WARRANET197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.warrantyType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYID_261129",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.warrantyType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.warrantyType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.warrantyNumber = {
                title: 'ASSTS.LBL_ASSTS_NROGARATA_77976',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBRS_263129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT66_WARRANUY197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.warrantyNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBRS_263129",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.warrantyNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.warrantyNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.coveragePercentage = {
                title: 'ASSTS.LBL_ASSTS_COBERTUGA_99369',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTRE_710129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT69_COVERAEN197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.coveragePercentage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTRE_710129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.coveragePercentage.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.coveragePercentage.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.warrantyValue = {
                title: 'ASSTS.LBL_ASSTS_VALORGANA_72320',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTXW_242129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT60_WARRANYE197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.warrantyValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTXW_242129",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.warrantyValue.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.warrantyValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.dividendType = {
                title: 'ASSTS.LBL_ASSTS_TIPODIVOE_98503',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJJD_513129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT48_DIVIDEYY197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.dividendType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJJD_513129",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.dividendType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.dividendType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.interestPeriod = {
                title: 'ASSTS.LBL_ASSTS_NOPERIODT_82606',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBFF_919129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT11_INTEREPS197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.interestPeriod.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBFF_919129",
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.interestPeriod.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7536_43842.column.interestPeriod.format",
                        'k-decimals': "vc.viewState.QV_7536_43842.column.interestPeriod.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.interestPeriod.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7536_43842.column.tableOtherRate = {
                title: 'ASSTS.LBL_ASSTS_TABLAOTSS_47101',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOBK_430129',
                element: []
            };
            $scope.vc.grids.QV_7536_43842.AT16_TABLEOTE197 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7536_43842.column.tableOtherRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOBK_430129",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_7536_43842.column.tableOtherRate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7536_43842.column.tableOtherRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7536_43842.column.description.title|translate:vc.viewState.QV_7536_43842.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.description.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.description.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT15_DESCRIPT197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7536_43842\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.description.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'concept',
                    title: '{{vc.viewState.QV_7536_43842.column.concept.title|translate:vc.viewState.QV_7536_43842.column.concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.concept.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.concept.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT52_CONCEPTT197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.concept.style' ng-bind='vc.getStringColumnFormat(dataItem.concept, \"QV_7536_43842\", \"concept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.concept.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'paymentMethod',
                    title: '{{vc.viewState.QV_7536_43842.column.paymentMethod.title|translate:vc.viewState.QV_7536_43842.column.paymentMethod.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.paymentMethod.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.paymentMethod.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT18_PAYMENTH197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.paymentMethod.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentMethod, \"QV_7536_43842\", \"paymentMethod\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.paymentMethod.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.paymentMethod.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.paymentMethod.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'itemType',
                    title: '{{vc.viewState.QV_7536_43842.column.itemType.title|translate:vc.viewState.QV_7536_43842.column.itemType.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.itemType.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.itemType.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT19_ITEMTYPE197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.itemType.style' ng-bind='vc.getStringColumnFormat(dataItem.itemType, \"QV_7536_43842\", \"itemType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.itemType.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.itemType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.itemType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'priority',
                    title: '{{vc.viewState.QV_7536_43842.column.priority.title|translate:vc.viewState.QV_7536_43842.column.priority.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.priority.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.priority.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT78_PRIORITT197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.priority.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.priority, \"QV_7536_43842\", \"priority\"):kendo.toString(#=priority#, vc.viewState.QV_7536_43842.column.priority.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.priority.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.priority.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.priority.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'value',
                    title: '{{vc.viewState.QV_7536_43842.column.value.title|translate:vc.viewState.QV_7536_43842.column.value.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.value.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.value.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT80_VALUEIST197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.value.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.value, \"QV_7536_43842\", \"value\"):kendo.toString(#=value#, vc.viewState.QV_7536_43842.column.value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.value.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.value.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'latePayment',
                    title: '{{vc.viewState.QV_7536_43842.column.latePayment.title|translate:vc.viewState.QV_7536_43842.column.latePayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.latePayment.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.latePayment.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT36_LATEPAYN197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.latePayment.style' ng-bind='vc.getStringColumnFormat(dataItem.latePayment, \"QV_7536_43842\", \"latePayment\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.latePayment.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.latePayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.latePayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'reference',
                    title: '{{vc.viewState.QV_7536_43842.column.reference.title|translate:vc.viewState.QV_7536_43842.column.reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.reference.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.reference.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT67_REFERENE197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.reference.style' ng-bind='vc.getStringColumnFormat(dataItem.reference, \"QV_7536_43842\", \"reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.reference.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'sign',
                    title: '{{vc.viewState.QV_7536_43842.column.sign.title|translate:vc.viewState.QV_7536_43842.column.sign.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.sign.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.sign.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT34_SIGNVYDC197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.sign.style' ng-bind='vc.getStringColumnFormat(dataItem.sign, \"QV_7536_43842\", \"sign\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.sign.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.sign.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.sign.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'cause',
                    title: '{{vc.viewState.QV_7536_43842.column.cause.title|translate:vc.viewState.QV_7536_43842.column.cause.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.cause.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.cause.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT26_CAUSEJWV197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.cause.style' ng-bind='vc.getStringColumnFormat(dataItem.cause, \"QV_7536_43842\", \"cause\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.cause.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.cause.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.cause.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'pointsValue',
                    title: '{{vc.viewState.QV_7536_43842.column.pointsValue.title|translate:vc.viewState.QV_7536_43842.column.pointsValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.pointsValue.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.pointsValue.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT63_POINTSAU197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.pointsValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.pointsValue, \"QV_7536_43842\", \"pointsValue\"):kendo.toString(#=pointsValue#, vc.viewState.QV_7536_43842.column.pointsValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.pointsValue.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.pointsValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.pointsValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'pointsType',
                    title: '{{vc.viewState.QV_7536_43842.column.pointsType.title|translate:vc.viewState.QV_7536_43842.column.pointsType.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.pointsType.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.pointsType.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT15_POINTSYY197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.pointsType.style' ng-bind='vc.getStringColumnFormat(dataItem.pointsType, \"QV_7536_43842\", \"pointsType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.pointsType.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.pointsType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.pointsType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'valueTotalRate',
                    title: '{{vc.viewState.QV_7536_43842.column.valueTotalRate.title|translate:vc.viewState.QV_7536_43842.column.valueTotalRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.valueTotalRate.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.valueTotalRate.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT45_VALUETEL197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.valueTotalRate.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueTotalRate, \"QV_7536_43842\", \"valueTotalRate\"):kendo.toString(#=valueTotalRate#, vc.viewState.QV_7536_43842.column.valueTotalRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.valueTotalRate.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.valueTotalRate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.valueTotalRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'negotiatedRate',
                    title: '{{vc.viewState.QV_7536_43842.column.negotiatedRate.title|translate:vc.viewState.QV_7536_43842.column.negotiatedRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.negotiatedRate.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.negotiatedRate.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT65_NEGOTITR197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.negotiatedRate.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.negotiatedRate, \"QV_7536_43842\", \"negotiatedRate\"):kendo.toString(#=negotiatedRate#, vc.viewState.QV_7536_43842.column.negotiatedRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.negotiatedRate.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.negotiatedRate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.negotiatedRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'annualEfecRate',
                    title: '{{vc.viewState.QV_7536_43842.column.annualEfecRate.title|translate:vc.viewState.QV_7536_43842.column.annualEfecRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.annualEfecRate.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.annualEfecRate.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT53_ANNUALFE197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.annualEfecRate.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.annualEfecRate, \"QV_7536_43842\", \"annualEfecRate\"):kendo.toString(#=annualEfecRate#, vc.viewState.QV_7536_43842.column.annualEfecRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.annualEfecRate.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.annualEfecRate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.annualEfecRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'reajustmenSign',
                    title: '{{vc.viewState.QV_7536_43842.column.reajustmenSign.title|translate:vc.viewState.QV_7536_43842.column.reajustmenSign.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.reajustmenSign.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.reajustmenSign.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT31_REAJUSNN197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.reajustmenSign.style' ng-bind='vc.getStringColumnFormat(dataItem.reajustmenSign, \"QV_7536_43842\", \"reajustmenSign\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.reajustmenSign.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.reajustmenSign.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.reajustmenSign.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'reajustmentValuePoints',
                    title: '{{vc.viewState.QV_7536_43842.column.reajustmentValuePoints.title|translate:vc.viewState.QV_7536_43842.column.reajustmentValuePoints.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.reajustmentValuePoints.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.reajustmentValuePoints.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT17_REAJUSPT197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.reajustmentValuePoints.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.reajustmentValuePoints, \"QV_7536_43842\", \"reajustmentValuePoints\"):kendo.toString(#=reajustmentValuePoints#, vc.viewState.QV_7536_43842.column.reajustmentValuePoints.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.reajustmentValuePoints.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.reajustmentValuePoints.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.reajustmentValuePoints.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'reajustmentReference',
                    title: '{{vc.viewState.QV_7536_43842.column.reajustmentReference.title|translate:vc.viewState.QV_7536_43842.column.reajustmentReference.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.reajustmentReference.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.reajustmentReference.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT50_REAJUSNN197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.reajustmentReference.style' ng-bind='vc.getStringColumnFormat(dataItem.reajustmentReference, \"QV_7536_43842\", \"reajustmentReference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.reajustmentReference.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.reajustmentReference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.reajustmentReference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'gain',
                    title: '{{vc.viewState.QV_7536_43842.column.gain.title|translate:vc.viewState.QV_7536_43842.column.gain.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.gain.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.gain.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT84_GAINLJFX197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.gain.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.gain, \"QV_7536_43842\", \"gain\"):kendo.toString(#=gain#, vc.viewState.QV_7536_43842.column.gain.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.gain.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.gain.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.gain.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'baseCalculation',
                    title: '{{vc.viewState.QV_7536_43842.column.baseCalculation.title|translate:vc.viewState.QV_7536_43842.column.baseCalculation.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.baseCalculation.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.baseCalculation.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT27_BASECAOT197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.baseCalculation.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.baseCalculation, \"QV_7536_43842\", \"baseCalculation\"):kendo.toString(#=baseCalculation#, vc.viewState.QV_7536_43842.column.baseCalculation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.baseCalculation.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.baseCalculation.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.baseCalculation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'chargeForRinging',
                    title: '{{vc.viewState.QV_7536_43842.column.chargeForRinging.title|translate:vc.viewState.QV_7536_43842.column.chargeForRinging.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.chargeForRinging.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.chargeForRinging.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT24_CHARGENR197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.chargeForRinging.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.chargeForRinging, \"QV_7536_43842\", \"chargeForRinging\"):kendo.toString(#=chargeForRinging#, vc.viewState.QV_7536_43842.column.chargeForRinging.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.chargeForRinging.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.chargeForRinging.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.chargeForRinging.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'warrantyType',
                    title: '{{vc.viewState.QV_7536_43842.column.warrantyType.title|translate:vc.viewState.QV_7536_43842.column.warrantyType.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.warrantyType.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.warrantyType.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT74_WARRANET197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.warrantyType.style' ng-bind='vc.getStringColumnFormat(dataItem.warrantyType, \"QV_7536_43842\", \"warrantyType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.warrantyType.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.warrantyType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.warrantyType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'warrantyNumber',
                    title: '{{vc.viewState.QV_7536_43842.column.warrantyNumber.title|translate:vc.viewState.QV_7536_43842.column.warrantyNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.warrantyNumber.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.warrantyNumber.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT66_WARRANUY197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.warrantyNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.warrantyNumber, \"QV_7536_43842\", \"warrantyNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.warrantyNumber.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.warrantyNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.warrantyNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'coveragePercentage',
                    title: '{{vc.viewState.QV_7536_43842.column.coveragePercentage.title|translate:vc.viewState.QV_7536_43842.column.coveragePercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.coveragePercentage.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.coveragePercentage.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT69_COVERAEN197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.coveragePercentage.style' ng-bind='vc.getStringColumnFormat(dataItem.coveragePercentage, \"QV_7536_43842\", \"coveragePercentage\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.coveragePercentage.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.coveragePercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.coveragePercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'warrantyValue',
                    title: '{{vc.viewState.QV_7536_43842.column.warrantyValue.title|translate:vc.viewState.QV_7536_43842.column.warrantyValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.warrantyValue.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.warrantyValue.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT60_WARRANYE197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.warrantyValue.style' ng-bind='vc.getStringColumnFormat(dataItem.warrantyValue, \"QV_7536_43842\", \"warrantyValue\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.warrantyValue.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.warrantyValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.warrantyValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'dividendType',
                    title: '{{vc.viewState.QV_7536_43842.column.dividendType.title|translate:vc.viewState.QV_7536_43842.column.dividendType.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.dividendType.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.dividendType.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT48_DIVIDEYY197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.dividendType.style' ng-bind='vc.getStringColumnFormat(dataItem.dividendType, \"QV_7536_43842\", \"dividendType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.dividendType.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.dividendType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.dividendType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'interestPeriod',
                    title: '{{vc.viewState.QV_7536_43842.column.interestPeriod.title|translate:vc.viewState.QV_7536_43842.column.interestPeriod.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.interestPeriod.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.interestPeriod.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT11_INTEREPS197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.interestPeriod.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interestPeriod, \"QV_7536_43842\", \"interestPeriod\"):kendo.toString(#=interestPeriod#, vc.viewState.QV_7536_43842.column.interestPeriod.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7536_43842.column.interestPeriod.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.interestPeriod.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.interestPeriod.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7536_43842.columns.push({
                    field: 'tableOtherRate',
                    title: '{{vc.viewState.QV_7536_43842.column.tableOtherRate.title|translate:vc.viewState.QV_7536_43842.column.tableOtherRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7536_43842.column.tableOtherRate.width,
                    format: $scope.vc.viewState.QV_7536_43842.column.tableOtherRate.format,
                    editor: $scope.vc.grids.QV_7536_43842.AT16_TABLEOTE197.control,
                    template: "<span ng-class='vc.viewState.QV_7536_43842.column.tableOtherRate.style' ng-bind='vc.getStringColumnFormat(dataItem.tableOtherRate, \"QV_7536_43842\", \"tableOtherRate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7536_43842.column.tableOtherRate.style",
                        "title": "{{vc.viewState.QV_7536_43842.column.tableOtherRate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7536_43842.column.tableOtherRate.hidden
                });
            }
            $scope.vc.viewState.QV_7536_43842.toolbar = {}
            $scope.vc.grids.QV_7536_43842.toolbar = []; //ViewState - Container: QueryRatesForm
            $scope.vc.createViewState({
                id: "VC_JPCYNTJFQV_296186",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TASASWEXW_63256",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1417
            $scope.vc.createViewState({
                id: "G_RATESYEVWB_973660",
                hasId: true,
                componentStyle: [],
                label: 'Group1417',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.LoanRates = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    sequential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "sequential", 0)
                    },
                    updatedOn: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "updatedOn", '')
                    },
                    quota: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "quota", 0)
                    },
                    item: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "item", '')
                    },
                    valueToApply: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "valueToApply", '')
                    },
                    signToApply: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "signToApply", '')
                    },
                    spreadApply: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "spreadApply", '')
                    },
                    currentRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "currentRate", 0)
                    },
                    anualEffectiveRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "anualEffectiveRate", 0)
                    },
                    dateReferenceRate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "dateReferenceRate", '')
                    },
                    referentialRate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "referentialRate", '')
                    },
                    valueReferenceRate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("LoanRates", "valueReferenceRate", 0)
                    }
                }
            });
            $scope.vc.model.LoanRates = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_LOANRATE_7625();
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
                    model: $scope.vc.types.LoanRates
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7625_68514").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_LOANRATE_7625 = $scope.vc.model.LoanRates;
            $scope.vc.trackers.LoanRates = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.LoanRates);
            $scope.vc.model.LoanRates.bind('change', function(e) {
                $scope.vc.trackers.LoanRates.track(e);
            });
            $scope.vc.grids.QV_7625_68514 = {};
            $scope.vc.grids.QV_7625_68514.queryId = 'Q_LOANRATE_7625';
            $scope.vc.viewState.QV_7625_68514 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7625_68514.column = {};
            $scope.vc.grids.QV_7625_68514.editable = false;
            $scope.vc.grids.QV_7625_68514.events = {
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
                    $scope.vc.trackers.LoanRates.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7625_68514.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7625_68514");
                    $scope.vc.hideShowColumns("QV_7625_68514", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7625_68514.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7625_68514.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7625_68514.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7625_68514 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7625_68514 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_7625_68514.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_7625_68514.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "LoanRates", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7625_68514.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7625_68514.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7625_68514.column.sequential = {
                title: 'sequential',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVAQ_545660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT72_SEQUENAT507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.sequential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVAQ_545660",
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.sequential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7625_68514.column.sequential.format",
                        'k-decimals': "vc.viewState.QV_7625_68514.column.sequential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.sequential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.updatedOn = {
                title: 'ASSTS.LBL_ASSTS_FECHAMODD_53824',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKWQ_686660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT95_UPDATEDO507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.updatedOn.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKWQ_686660",
                        'maxlength': 12,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.updatedOn.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.updatedOn.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.quota = {
                title: 'ASSTS.LBL_ASSTS_NOCUOTACN_33552',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGAR_184660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT85_QUOTAKSY507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.quota.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGAR_184660",
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.quota.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7625_68514.column.quota.format",
                        'k-decimals': "vc.viewState.QV_7625_68514.column.quota.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.quota.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.item = {
                title: 'ASSTS.LBL_ASSTS_RUBROFKGQ_42963',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRSO_292660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT81_ITEMZSAC507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.item.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRSO_292660",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.item.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.item.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.valueToApply = {
                title: 'ASSTS.LBL_ASSTS_VALORAPLI_55165',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFFC_765660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT41_VALUETPY507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.valueToApply.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFFC_765660",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.valueToApply.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.valueToApply.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.signToApply = {
                title: 'ASSTS.LBL_ASSTS_SIGNOAPLL_32241',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYGA_388660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT17_SIGNTOAY507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.signToApply.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYGA_388660",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.signToApply.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.signToApply.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.spreadApply = {
                title: 'ASSTS.LBL_ASSTS_SPREADACC_20484',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLAZ_256660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT71_SPREADPY507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.spreadApply.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLAZ_256660",
                        'maxlength': 25,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.spreadApply.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.spreadApply.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.currentRate = {
                title: 'ASSTS.LBL_ASSTS_TASAACTLL_22656',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "##.## \%",
                decimals: 5,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHTZ_428660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT39_CURRENTR507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.currentRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHTZ_428660",
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.currentRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7625_68514.column.currentRate.format",
                        'k-decimals': "vc.viewState.QV_7625_68514.column.currentRate.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.currentRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.anualEffectiveRate = {
                title: 'ASSTS.LBL_ASSTS_TASAEFECA_65157',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "##.## \%",
                decimals: 5,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYKA_140660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT59_ANUALEFA507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.anualEffectiveRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYKA_140660",
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.anualEffectiveRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7625_68514.column.anualEffectiveRate.format",
                        'k-decimals': "vc.viewState.QV_7625_68514.column.anualEffectiveRate.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.anualEffectiveRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.dateReferenceRate = {
                title: 'ASSTS.LBL_ASSTS_FECHATASC_22366',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQOD_800660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT97_DATERERE507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.dateReferenceRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQOD_800660",
                        'maxlength': 12,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.dateReferenceRate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.dateReferenceRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.referentialRate = {
                title: 'ASSTS.LBL_ASSTS_TASAREFEI_65089',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUWM_511660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT15_REFERERA507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.referentialRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUWM_511660",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.referentialRate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.referentialRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7625_68514.column.valueReferenceRate = {
                title: 'ASSTS.LBL_ASSTS_VALORTALS_42653',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "##.## \%",
                decimals: 5,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMSZ_323660',
                element: []
            };
            $scope.vc.grids.QV_7625_68514.AT29_VALUERAC507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7625_68514.column.valueReferenceRate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMSZ_323660",
                        'data-validation-code': "{{vc.viewState.QV_7625_68514.column.valueReferenceRate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7625_68514.column.valueReferenceRate.format",
                        'k-decimals': "vc.viewState.QV_7625_68514.column.valueReferenceRate.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7625_68514.column.valueReferenceRate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'sequential',
                    title: '{{vc.viewState.QV_7625_68514.column.sequential.title|translate:vc.viewState.QV_7625_68514.column.sequential.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.sequential.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.sequential.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT72_SEQUENAT507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.sequential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequential, \"QV_7625_68514\", \"sequential\"):kendo.toString(#=sequential#, vc.viewState.QV_7625_68514.column.sequential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7625_68514.column.sequential.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.sequential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.sequential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'updatedOn',
                    title: '{{vc.viewState.QV_7625_68514.column.updatedOn.title|translate:vc.viewState.QV_7625_68514.column.updatedOn.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.updatedOn.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.updatedOn.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT95_UPDATEDO507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.updatedOn.style' ng-bind='vc.getStringColumnFormat(dataItem.updatedOn, \"QV_7625_68514\", \"updatedOn\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.updatedOn.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.updatedOn.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.updatedOn.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'quota',
                    title: '{{vc.viewState.QV_7625_68514.column.quota.title|translate:vc.viewState.QV_7625_68514.column.quota.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.quota.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.quota.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT85_QUOTAKSY507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.quota.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quota, \"QV_7625_68514\", \"quota\"):kendo.toString(#=quota#, vc.viewState.QV_7625_68514.column.quota.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7625_68514.column.quota.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.quota.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.quota.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'item',
                    title: '{{vc.viewState.QV_7625_68514.column.item.title|translate:vc.viewState.QV_7625_68514.column.item.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.item.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.item.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT81_ITEMZSAC507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.item.style' ng-bind='vc.getStringColumnFormat(dataItem.item, \"QV_7625_68514\", \"item\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.item.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.item.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.item.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'valueToApply',
                    title: '{{vc.viewState.QV_7625_68514.column.valueToApply.title|translate:vc.viewState.QV_7625_68514.column.valueToApply.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.valueToApply.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.valueToApply.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT41_VALUETPY507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.valueToApply.style' ng-bind='vc.getStringColumnFormat(dataItem.valueToApply, \"QV_7625_68514\", \"valueToApply\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.valueToApply.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.valueToApply.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.valueToApply.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'signToApply',
                    title: '{{vc.viewState.QV_7625_68514.column.signToApply.title|translate:vc.viewState.QV_7625_68514.column.signToApply.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.signToApply.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.signToApply.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT17_SIGNTOAY507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.signToApply.style' ng-bind='vc.getStringColumnFormat(dataItem.signToApply, \"QV_7625_68514\", \"signToApply\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.signToApply.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.signToApply.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.signToApply.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'spreadApply',
                    title: '{{vc.viewState.QV_7625_68514.column.spreadApply.title|translate:vc.viewState.QV_7625_68514.column.spreadApply.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.spreadApply.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.spreadApply.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT71_SPREADPY507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.spreadApply.style' ng-bind='vc.getStringColumnFormat(dataItem.spreadApply, \"QV_7625_68514\", \"spreadApply\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.spreadApply.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.spreadApply.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.spreadApply.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'currentRate',
                    title: '{{vc.viewState.QV_7625_68514.column.currentRate.title|translate:vc.viewState.QV_7625_68514.column.currentRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.currentRate.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.currentRate.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT39_CURRENTR507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.currentRate.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currentRate, \"QV_7625_68514\", \"currentRate\"):kendo.toString(#=currentRate#, vc.viewState.QV_7625_68514.column.currentRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7625_68514.column.currentRate.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.currentRate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.currentRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'anualEffectiveRate',
                    title: '{{vc.viewState.QV_7625_68514.column.anualEffectiveRate.title|translate:vc.viewState.QV_7625_68514.column.anualEffectiveRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.anualEffectiveRate.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.anualEffectiveRate.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT59_ANUALEFA507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.anualEffectiveRate.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.anualEffectiveRate, \"QV_7625_68514\", \"anualEffectiveRate\"):kendo.toString(#=anualEffectiveRate#, vc.viewState.QV_7625_68514.column.anualEffectiveRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7625_68514.column.anualEffectiveRate.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.anualEffectiveRate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.anualEffectiveRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'dateReferenceRate',
                    title: '{{vc.viewState.QV_7625_68514.column.dateReferenceRate.title|translate:vc.viewState.QV_7625_68514.column.dateReferenceRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.dateReferenceRate.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.dateReferenceRate.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT97_DATERERE507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.dateReferenceRate.style' ng-bind='vc.getStringColumnFormat(dataItem.dateReferenceRate, \"QV_7625_68514\", \"dateReferenceRate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.dateReferenceRate.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.dateReferenceRate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.dateReferenceRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'referentialRate',
                    title: '{{vc.viewState.QV_7625_68514.column.referentialRate.title|translate:vc.viewState.QV_7625_68514.column.referentialRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.referentialRate.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.referentialRate.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT15_REFERERA507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.referentialRate.style' ng-bind='vc.getStringColumnFormat(dataItem.referentialRate, \"QV_7625_68514\", \"referentialRate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7625_68514.column.referentialRate.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.referentialRate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.referentialRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7625_68514.columns.push({
                    field: 'valueReferenceRate',
                    title: '{{vc.viewState.QV_7625_68514.column.valueReferenceRate.title|translate:vc.viewState.QV_7625_68514.column.valueReferenceRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_7625_68514.column.valueReferenceRate.width,
                    format: $scope.vc.viewState.QV_7625_68514.column.valueReferenceRate.format,
                    editor: $scope.vc.grids.QV_7625_68514.AT29_VALUERAC507.control,
                    template: "<span ng-class='vc.viewState.QV_7625_68514.column.valueReferenceRate.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueReferenceRate, \"QV_7625_68514\", \"valueReferenceRate\"):kendo.toString(#=valueReferenceRate#, vc.viewState.QV_7625_68514.column.valueReferenceRate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7625_68514.column.valueReferenceRate.style",
                        "title": "{{vc.viewState.QV_7625_68514.column.valueReferenceRate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7625_68514.column.valueReferenceRate.hidden
                });
            }
            $scope.vc.viewState.QV_7625_68514.toolbar = {}
            $scope.vc.grids.QV_7625_68514.toolbar = []; //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_ECJGSCVCNJ_417443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ABONOSBOQ_70064",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: PaymentQueryForm
            $scope.vc.createViewState({
                id: "VC_QTILISBFCN_407714",
                hasId: true,
                componentStyle: [],
                label: 'PaymentQueryForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1348
            $scope.vc.createViewState({
                id: "G_PAYMENTRKG_540154",
                hasId: true,
                componentStyle: [],
                label: 'Group1348',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PaymentSummary = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    paymentId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "paymentId", 0)
                    },
                    paymentWay: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "paymentWay", '')
                    },
                    registerDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "registerDate", '')
                    },
                    valueDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "valueDate", '')
                    },
                    office: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "office", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "amount", 0)
                    },
                    currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "currency", '')
                    },
                    corresponsalId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "corresponsalId", '')
                    },
                    paymentStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "paymentStatus", '')
                    },
                    user: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "user", '')
                    },
                    message: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "message", '')
                    },
                    sequentialQuery: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "sequentialQuery", 0)
                    },
                    sequentialIdentity: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentSummary", "sequentialIdentity", 0)
                    }
                }
            });
            $scope.vc.model.PaymentSummary = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_PAYMENUM_1439';
                            var queryRequest = $scope.vc.getRequestQuery_Q_PAYMENUM_1439();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_1439_82210',
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
                                            'pageSize': 20
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
                    model: $scope.vc.types.PaymentSummary
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1439_82210").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PAYMENUM_1439 = $scope.vc.model.PaymentSummary;
            $scope.vc.trackers.PaymentSummary = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PaymentSummary);
            $scope.vc.model.PaymentSummary.bind('change', function(e) {
                $scope.vc.trackers.PaymentSummary.track(e);
            });
            $scope.vc.grids.QV_1439_82210 = {};
            $scope.vc.grids.QV_1439_82210.queryId = 'Q_PAYMENUM_1439';
            $scope.vc.viewState.QV_1439_82210 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1439_82210.column = {};
            $scope.vc.grids.QV_1439_82210.editable = false;
            $scope.vc.grids.QV_1439_82210.events = {
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
                    $scope.vc.trackers.PaymentSummary.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1439_82210.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_1439_82210");
                    $scope.vc.hideShowColumns("QV_1439_82210", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1439_82210.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1439_82210.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1439_82210.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1439_82210 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1439_82210 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_1439_82210.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_1439_82210.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "PaymentSummary", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1439_82210.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1439_82210.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1439_82210.column.paymentId = {
                title: 'ASSTS.LBL_ASSTS_IDPAGOXQY_12745',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXVW_486154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT77_PAYMENDT759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.paymentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXVW_486154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.paymentId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1439_82210.column.paymentId.format",
                        'k-decimals': "vc.viewState.QV_1439_82210.column.paymentId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.paymentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.paymentWay = {
                title: 'ASSTS.LBL_ASSTS_APAGOUKPC_13431',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHIN_348154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT29_PAYMENAT759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.paymentWay.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHIN_348154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.paymentWay.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.paymentWay.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.registerDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAINRR_80192',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNQX_630154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT92_REGISTEA759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.registerDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNQX_630154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.registerDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.registerDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.valueDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAVALO_78292',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZGN_290154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT45_VALUEDAE759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.valueDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZGN_290154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.valueDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.valueDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.office = {
                title: 'ASSTS.LBL_ASSTS_OFICINAHX_44623',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCVN_176154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT76_OFFICENK759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.office.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCVN_176154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.office.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.office.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.amount = {
                title: 'ASSTS.LBL_ASSTS_MONTOEMFX_52083',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQSZ_535154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT13_AMOUNTMQ759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQSZ_535154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1439_82210.column.amount.format",
                        'k-decimals': "vc.viewState.QV_1439_82210.column.amount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.currency = {
                title: 'ASSTS.LBL_ASSTS_MONEDATUB_92849',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKTV_285154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT78_CURRENCC759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.currency.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKTV_285154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.currency.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.currency.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.corresponsalId = {
                title: 'ASSTS.LBL_ASSTS_IDCORREPS_12443',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTKG_112154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT40_CORRESDA759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.corresponsalId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTKG_112154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.corresponsalId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.corresponsalId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.paymentStatus = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXSO_207154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT82_PAYMENTT759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.paymentStatus.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXSO_207154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.paymentStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.paymentStatus.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.user = {
                title: 'ASSTS.LBL_ASSTS_USUARIOTE_48852',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXYG_531154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT53_USERFIIG759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.user.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXYG_531154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.user.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.user.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.message = {
                title: 'ASSTS.LBL_ASSTS_MENSAJEJC_76975',
                titleArgs: {},
                tooltip: '',
                width: 400,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOSL_743154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT51_MESSAGEE759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.message.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOSL_743154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.message.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.message.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.sequentialQuery = {
                title: 'sequentialQuery',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYKA_340154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT97_SEQUENTA759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.sequentialQuery.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYKA_340154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.sequentialQuery.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1439_82210.column.sequentialQuery.format",
                        'k-decimals': "vc.viewState.QV_1439_82210.column.sequentialQuery.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.sequentialQuery.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1439_82210.column.sequentialIdentity = {
                title: 'sequentialIdentity',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFBX_281154',
                element: []
            };
            $scope.vc.grids.QV_1439_82210.AT41_SEQUENAT759 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1439_82210.column.sequentialIdentity.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFBX_281154",
                        'data-validation-code': "{{vc.viewState.QV_1439_82210.column.sequentialIdentity.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1439_82210.column.sequentialIdentity.format",
                        'k-decimals': "vc.viewState.QV_1439_82210.column.sequentialIdentity.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1439_82210.column.sequentialIdentity.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'paymentId',
                    title: '{{vc.viewState.QV_1439_82210.column.paymentId.title|translate:vc.viewState.QV_1439_82210.column.paymentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.paymentId.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.paymentId.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT77_PAYMENDT759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.paymentId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.paymentId, \"QV_1439_82210\", \"paymentId\"):kendo.toString(#=paymentId#, vc.viewState.QV_1439_82210.column.paymentId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1439_82210.column.paymentId.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.paymentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.paymentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'paymentWay',
                    title: '{{vc.viewState.QV_1439_82210.column.paymentWay.title|translate:vc.viewState.QV_1439_82210.column.paymentWay.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.paymentWay.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.paymentWay.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT29_PAYMENAT759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.paymentWay.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentWay, \"QV_1439_82210\", \"paymentWay\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.paymentWay.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.paymentWay.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.paymentWay.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'registerDate',
                    title: '{{vc.viewState.QV_1439_82210.column.registerDate.title|translate:vc.viewState.QV_1439_82210.column.registerDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.registerDate.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.registerDate.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT92_REGISTEA759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.registerDate.style' ng-bind='vc.getStringColumnFormat(dataItem.registerDate, \"QV_1439_82210\", \"registerDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.registerDate.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.registerDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.registerDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'valueDate',
                    title: '{{vc.viewState.QV_1439_82210.column.valueDate.title|translate:vc.viewState.QV_1439_82210.column.valueDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.valueDate.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.valueDate.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT45_VALUEDAE759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.valueDate.style' ng-bind='vc.getStringColumnFormat(dataItem.valueDate, \"QV_1439_82210\", \"valueDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.valueDate.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.valueDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.valueDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'office',
                    title: '{{vc.viewState.QV_1439_82210.column.office.title|translate:vc.viewState.QV_1439_82210.column.office.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.office.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.office.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT76_OFFICENK759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.office.style' ng-bind='vc.getStringColumnFormat(dataItem.office, \"QV_1439_82210\", \"office\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.office.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.office.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.office.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_1439_82210.column.amount.title|translate:vc.viewState.QV_1439_82210.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.amount.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.amount.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT13_AMOUNTMQ759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_1439_82210\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_1439_82210.column.amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1439_82210.column.amount.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'currency',
                    title: '{{vc.viewState.QV_1439_82210.column.currency.title|translate:vc.viewState.QV_1439_82210.column.currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.currency.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.currency.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT78_CURRENCC759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.currency.style' ng-bind='vc.getStringColumnFormat(dataItem.currency, \"QV_1439_82210\", \"currency\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.currency.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'corresponsalId',
                    title: '{{vc.viewState.QV_1439_82210.column.corresponsalId.title|translate:vc.viewState.QV_1439_82210.column.corresponsalId.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.corresponsalId.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.corresponsalId.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT40_CORRESDA759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.corresponsalId.style' ng-bind='vc.getStringColumnFormat(dataItem.corresponsalId, \"QV_1439_82210\", \"corresponsalId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.corresponsalId.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.corresponsalId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.corresponsalId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'paymentStatus',
                    title: '{{vc.viewState.QV_1439_82210.column.paymentStatus.title|translate:vc.viewState.QV_1439_82210.column.paymentStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.paymentStatus.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.paymentStatus.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT82_PAYMENTT759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.paymentStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentStatus, \"QV_1439_82210\", \"paymentStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.paymentStatus.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.paymentStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.paymentStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'user',
                    title: '{{vc.viewState.QV_1439_82210.column.user.title|translate:vc.viewState.QV_1439_82210.column.user.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.user.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.user.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT53_USERFIIG759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.user.style' ng-bind='vc.getStringColumnFormat(dataItem.user, \"QV_1439_82210\", \"user\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.user.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.user.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.user.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'message',
                    title: '{{vc.viewState.QV_1439_82210.column.message.title|translate:vc.viewState.QV_1439_82210.column.message.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.message.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.message.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT51_MESSAGEE759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.message.style' ng-bind='vc.getStringColumnFormat(dataItem.message, \"QV_1439_82210\", \"message\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1439_82210.column.message.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.message.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.message.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'sequentialQuery',
                    title: '{{vc.viewState.QV_1439_82210.column.sequentialQuery.title|translate:vc.viewState.QV_1439_82210.column.sequentialQuery.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.sequentialQuery.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.sequentialQuery.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT97_SEQUENTA759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.sequentialQuery.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequentialQuery, \"QV_1439_82210\", \"sequentialQuery\"):kendo.toString(#=sequentialQuery#, vc.viewState.QV_1439_82210.column.sequentialQuery.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1439_82210.column.sequentialQuery.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.sequentialQuery.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.sequentialQuery.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_1439_82210.columns.push({
                    field: 'sequentialIdentity',
                    title: '{{vc.viewState.QV_1439_82210.column.sequentialIdentity.title|translate:vc.viewState.QV_1439_82210.column.sequentialIdentity.titleArgs}}',
                    width: $scope.vc.viewState.QV_1439_82210.column.sequentialIdentity.width,
                    format: $scope.vc.viewState.QV_1439_82210.column.sequentialIdentity.format,
                    editor: $scope.vc.grids.QV_1439_82210.AT41_SEQUENAT759.control,
                    template: "<span ng-class='vc.viewState.QV_1439_82210.column.sequentialIdentity.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequentialIdentity, \"QV_1439_82210\", \"sequentialIdentity\"):kendo.toString(#=sequentialIdentity#, vc.viewState.QV_1439_82210.column.sequentialIdentity.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1439_82210.column.sequentialIdentity.style",
                        "title": "{{vc.viewState.QV_1439_82210.column.sequentialIdentity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1439_82210.column.sequentialIdentity.hidden
                });
            }
            $scope.vc.viewState.QV_1439_82210.toolbar = {}
            $scope.vc.grids.QV_1439_82210.toolbar = []; //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_LAKAZILCTL_919443",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OPERACIRV_49346",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: RefinancedLoansForm
            $scope.vc.createViewState({
                id: "VC_DYACFZQTJQ_702857",
                hasId: true,
                componentStyle: [],
                label: 'RefinancedLoansForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1922
            $scope.vc.createViewState({
                id: "G_REFINANSDE_580587",
                hasId: true,
                componentStyle: [],
                label: 'Group1922',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinanceLoans = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    transactionID: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "transactionID", 0)
                    },
                    loan: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "loan", '')
                    },
                    initialAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "initialAmount", 0)
                    },
                    totalToRefinance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "totalToRefinance", 0)
                    },
                    line: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "line", '')
                    },
                    officialID: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinanceLoans", "officialID", '')
                    }
                }
            });
            $scope.vc.model.RefinanceLoans = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_REFINAOS_1949();
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
                    model: $scope.vc.types.RefinanceLoans
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1949_60600").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_REFINAOS_1949 = $scope.vc.model.RefinanceLoans;
            $scope.vc.trackers.RefinanceLoans = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinanceLoans);
            $scope.vc.model.RefinanceLoans.bind('change', function(e) {
                $scope.vc.trackers.RefinanceLoans.track(e);
            });
            $scope.vc.grids.QV_1949_60600 = {};
            $scope.vc.grids.QV_1949_60600.queryId = 'Q_REFINAOS_1949';
            $scope.vc.viewState.QV_1949_60600 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1949_60600.column = {};
            $scope.vc.grids.QV_1949_60600.editable = false;
            $scope.vc.grids.QV_1949_60600.events = {
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
                    $scope.vc.trackers.RefinanceLoans.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1949_60600.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_1949_60600");
                    $scope.vc.hideShowColumns("QV_1949_60600", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1949_60600.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1949_60600.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1949_60600.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1949_60600 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1949_60600 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_1949_60600.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_1949_60600.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "RefinanceLoans", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1949_60600.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1949_60600.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1949_60600.column.transactionID = {
                title: 'ASSTS.LBL_ASSTS_TRMITESSF_56882',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXICW_312587',
                element: []
            };
            $scope.vc.grids.QV_1949_60600.AT25_TRANSANC582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1949_60600.column.transactionID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXICW_312587",
                        'maxlength': 4,
                        'data-validation-code': "{{vc.viewState.QV_1949_60600.column.transactionID.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1949_60600.column.transactionID.format",
                        'k-decimals': "vc.viewState.QV_1949_60600.column.transactionID.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1949_60600.column.transactionID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1949_60600.column.loan = {
                title: 'ASSTS.LBL_ASSTS_OPERACIVV_10728',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLUN_357587',
                element: []
            };
            $scope.vc.grids.QV_1949_60600.AT67_LOANWAUS582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1949_60600.column.loan.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLUN_357587",
                        'maxlength': 16,
                        'data-validation-code': "{{vc.viewState.QV_1949_60600.column.loan.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1949_60600.column.loan.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1949_60600.column.initialAmount = {
                title: 'ASSTS.LBL_ASSTS_MONTOORGI_46642',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDPQ_833587',
                element: []
            };
            $scope.vc.grids.QV_1949_60600.AT34_INITIAAA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1949_60600.column.initialAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDPQ_833587",
                        'data-validation-code': "{{vc.viewState.QV_1949_60600.column.initialAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1949_60600.column.initialAmount.format",
                        'k-decimals': "vc.viewState.QV_1949_60600.column.initialAmount.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1949_60600.column.initialAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1949_60600.column.totalToRefinance = {
                title: 'ASSTS.LBL_ASSTS_SALDORENN_27297',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFFS_866587',
                element: []
            };
            $scope.vc.grids.QV_1949_60600.AT94_TOTALTCA582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1949_60600.column.totalToRefinance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFFS_866587",
                        'data-validation-code': "{{vc.viewState.QV_1949_60600.column.totalToRefinance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1949_60600.column.totalToRefinance.format",
                        'k-decimals': "vc.viewState.QV_1949_60600.column.totalToRefinance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1949_60600.column.totalToRefinance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1949_60600.column.line = {
                title: 'ASSTS.LBL_ASSTS_TIPOCRDOO_69382',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJOJ_919587',
                element: []
            };
            $scope.vc.grids.QV_1949_60600.AT78_LINEUGLL582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1949_60600.column.line.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJOJ_919587",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_1949_60600.column.line.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1949_60600.column.line.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1949_60600.column.officialID = {
                title: 'ASSTS.LBL_ASSTS_FUNCIONRA_97040',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOYD_123587',
                element: []
            };
            $scope.vc.grids.QV_1949_60600.AT85_OFFICIDL582 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1949_60600.column.officialID.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOYD_123587",
                        'maxlength': 14,
                        'data-validation-code': "{{vc.viewState.QV_1949_60600.column.officialID.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1949_60600.column.officialID.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1949_60600.columns.push({
                    field: 'transactionID',
                    title: '{{vc.viewState.QV_1949_60600.column.transactionID.title|translate:vc.viewState.QV_1949_60600.column.transactionID.titleArgs}}',
                    width: $scope.vc.viewState.QV_1949_60600.column.transactionID.width,
                    format: $scope.vc.viewState.QV_1949_60600.column.transactionID.format,
                    editor: $scope.vc.grids.QV_1949_60600.AT25_TRANSANC582.control,
                    template: "<span ng-class='vc.viewState.QV_1949_60600.column.transactionID.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.transactionID, \"QV_1949_60600\", \"transactionID\"):kendo.toString(#=transactionID#, vc.viewState.QV_1949_60600.column.transactionID.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1949_60600.column.transactionID.style",
                        "title": "{{vc.viewState.QV_1949_60600.column.transactionID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1949_60600.column.transactionID.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1949_60600.columns.push({
                    field: 'loan',
                    title: '{{vc.viewState.QV_1949_60600.column.loan.title|translate:vc.viewState.QV_1949_60600.column.loan.titleArgs}}',
                    width: $scope.vc.viewState.QV_1949_60600.column.loan.width,
                    format: $scope.vc.viewState.QV_1949_60600.column.loan.format,
                    editor: $scope.vc.grids.QV_1949_60600.AT67_LOANWAUS582.control,
                    template: "<span ng-class='vc.viewState.QV_1949_60600.column.loan.style' ng-bind='vc.getStringColumnFormat(dataItem.loan, \"QV_1949_60600\", \"loan\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1949_60600.column.loan.style",
                        "title": "{{vc.viewState.QV_1949_60600.column.loan.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1949_60600.column.loan.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1949_60600.columns.push({
                    field: 'initialAmount',
                    title: '{{vc.viewState.QV_1949_60600.column.initialAmount.title|translate:vc.viewState.QV_1949_60600.column.initialAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_1949_60600.column.initialAmount.width,
                    format: $scope.vc.viewState.QV_1949_60600.column.initialAmount.format,
                    editor: $scope.vc.grids.QV_1949_60600.AT34_INITIAAA582.control,
                    template: "<span ng-class='vc.viewState.QV_1949_60600.column.initialAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.initialAmount, \"QV_1949_60600\", \"initialAmount\"):kendo.toString(#=initialAmount#, vc.viewState.QV_1949_60600.column.initialAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1949_60600.column.initialAmount.style",
                        "title": "{{vc.viewState.QV_1949_60600.column.initialAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1949_60600.column.initialAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1949_60600.columns.push({
                    field: 'totalToRefinance',
                    title: '{{vc.viewState.QV_1949_60600.column.totalToRefinance.title|translate:vc.viewState.QV_1949_60600.column.totalToRefinance.titleArgs}}',
                    width: $scope.vc.viewState.QV_1949_60600.column.totalToRefinance.width,
                    format: $scope.vc.viewState.QV_1949_60600.column.totalToRefinance.format,
                    editor: $scope.vc.grids.QV_1949_60600.AT94_TOTALTCA582.control,
                    template: "<span ng-class='vc.viewState.QV_1949_60600.column.totalToRefinance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.totalToRefinance, \"QV_1949_60600\", \"totalToRefinance\"):kendo.toString(#=totalToRefinance#, vc.viewState.QV_1949_60600.column.totalToRefinance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1949_60600.column.totalToRefinance.style",
                        "title": "{{vc.viewState.QV_1949_60600.column.totalToRefinance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1949_60600.column.totalToRefinance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1949_60600.columns.push({
                    field: 'line',
                    title: '{{vc.viewState.QV_1949_60600.column.line.title|translate:vc.viewState.QV_1949_60600.column.line.titleArgs}}',
                    width: $scope.vc.viewState.QV_1949_60600.column.line.width,
                    format: $scope.vc.viewState.QV_1949_60600.column.line.format,
                    editor: $scope.vc.grids.QV_1949_60600.AT78_LINEUGLL582.control,
                    template: "<span ng-class='vc.viewState.QV_1949_60600.column.line.style' ng-bind='vc.getStringColumnFormat(dataItem.line, \"QV_1949_60600\", \"line\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1949_60600.column.line.style",
                        "title": "{{vc.viewState.QV_1949_60600.column.line.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1949_60600.column.line.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1949_60600.columns.push({
                    field: 'officialID',
                    title: '{{vc.viewState.QV_1949_60600.column.officialID.title|translate:vc.viewState.QV_1949_60600.column.officialID.titleArgs}}',
                    width: $scope.vc.viewState.QV_1949_60600.column.officialID.width,
                    format: $scope.vc.viewState.QV_1949_60600.column.officialID.format,
                    editor: $scope.vc.grids.QV_1949_60600.AT85_OFFICIDL582.control,
                    template: "<span ng-class='vc.viewState.QV_1949_60600.column.officialID.style' ng-bind='vc.getStringColumnFormat(dataItem.officialID, \"QV_1949_60600\", \"officialID\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1949_60600.column.officialID.style",
                        "title": "{{vc.viewState.QV_1949_60600.column.officialID.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1949_60600.column.officialID.hidden
                });
            }
            $scope.vc.viewState.QV_1949_60600.toolbar = {}
            $scope.vc.grids.QV_1949_60600.toolbar = []; //ViewState - Container: TransactionQueryForm
            $scope.vc.createViewState({
                id: "VC_AKGBZZTEDQ_686749",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TRANSACOI_43194",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1367
            $scope.vc.createViewState({
                id: "G_TRANSACNNI_163395",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1367',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1406
            $scope.vc.createViewState({
                id: "G_TRANSACIOT_623395",
                hasId: true,
                componentStyle: [],
                label: 'Group1406',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Transaction = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    transactionType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "transactionType", '')
                    },
                    transactionId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "transactionId", '')
                    },
                    registerDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "registerDate", '')
                    },
                    valueDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "valueDate", '')
                    },
                    officeName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "officeName", '')
                    },
                    ammount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "ammount", 0)
                    },
                    currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "currency", '')
                    },
                    corresponsalId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "corresponsalId", '')
                    },
                    paymentWay: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "paymentWay", '')
                    },
                    transactionStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "transactionStatus", '')
                    },
                    user: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "user", '')
                    },
                    sequential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Transaction", "sequential", 0)
                    }
                }
            });
            $scope.vc.model.Transaction = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_TRANSACC_2353';
                            var queryRequest = $scope.vc.getRequestQuery_Q_TRANSACC_2353();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_2353_40892',
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
                                            'pageSize': 20
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
                    model: $scope.vc.types.Transaction
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2353_40892").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_TRANSACC_2353 = $scope.vc.model.Transaction;
            $scope.vc.trackers.Transaction = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Transaction);
            $scope.vc.model.Transaction.bind('change', function(e) {
                $scope.vc.trackers.Transaction.track(e);
            });
            $scope.vc.grids.QV_2353_40892 = {};
            $scope.vc.grids.QV_2353_40892.queryId = 'Q_TRANSACC_2353';
            $scope.vc.viewState.QV_2353_40892 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2353_40892.column = {};
            $scope.vc.grids.QV_2353_40892.editable = false;
            $scope.vc.grids.QV_2353_40892.events = {
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
                    $scope.vc.trackers.Transaction.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2353_40892.selectedRow = e.model;
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
                    $scope.vc.exportGrid(e, 'QV_2353_40892', this.dataSource);
                },
                excel: {
                    fileName: 'QV_2353_40892.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_2353_40892.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_2353_40892");
                    $scope.vc.hideShowColumns("QV_2353_40892", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2353_40892.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2353_40892.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2353_40892.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2353_40892 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2353_40892 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_2353_40892.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_2353_40892.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "Transaction", $scope);
                        }
                    });
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2353_40892.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2353_40892.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2353_40892.column.transactionType = {
                title: 'ASSTS.LBL_ASSTS_TIPOTRAAN_75324',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLFV_432395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT90_TRANSAYN612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.transactionType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLFV_432395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.transactionType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.transactionType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.transactionId = {
                title: 'ASSTS.LBL_ASSTS_IDTRANSIC_81159',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMDU_434395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT25_TRANSADT612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.transactionId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMDU_434395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.transactionId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.transactionId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.registerDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAINRR_80192',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXNU_842395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT22_REGISTAE612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.registerDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXNU_842395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.registerDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.registerDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.valueDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAVALO_78292',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVMQ_724395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT11_VALUEDTE612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.valueDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVMQ_724395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.valueDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.valueDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.officeName = {
                title: 'ASSTS.LBL_ASSTS_OFICINAHX_44623',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEDH_237395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT14_OFFICEMN612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.officeName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEDH_237395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.officeName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.officeName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.ammount = {
                title: 'ASSTS.LBL_ASSTS_MONTOEMFX_52083',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXREM_163395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT14_AMMOUNTT612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.ammount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXREM_163395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.ammount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2353_40892.column.ammount.format",
                        'k-decimals': "vc.viewState.QV_2353_40892.column.ammount.decimals",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.ammount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.currency = {
                title: 'ASSTS.LBL_ASSTS_MONEDATUB_92849',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPUI_461395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT10_CURRENYY612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.currency.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPUI_461395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.currency.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.currency.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.corresponsalId = {
                title: 'ASSTS.LBL_ASSTS_IDCORREPS_12443',
                titleArgs: {},
                tooltip: '',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRJT_174395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT90_CORRESND612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.corresponsalId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRJT_174395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.corresponsalId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.corresponsalId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.paymentWay = {
                title: 'ASSTS.LBL_ASSTS_APAGOUKPC_13431',
                titleArgs: {},
                tooltip: '',
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLJX_178395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT42_PAYMENYW612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.paymentWay.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLJX_178395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.paymentWay.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.paymentWay.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.transactionStatus = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYZR_450395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT62_TRANSASS612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.transactionStatus.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYZR_450395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.transactionStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.transactionStatus.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.user = {
                title: 'ASSTS.LBL_ASSTS_USUARIOTE_48852',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKVY_754395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT76_USERADGL612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.user.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKVY_754395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.user.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.user.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2353_40892.column.sequential = {
                title: 'sequential',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNAR_969395',
                element: []
            };
            $scope.vc.grids.QV_2353_40892.AT82_SEQUENIA612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2353_40892.column.sequential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNAR_969395",
                        'data-validation-code': "{{vc.viewState.QV_2353_40892.column.sequential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2353_40892.column.sequential.format",
                        'k-decimals': "vc.viewState.QV_2353_40892.column.sequential.decimals",
                        'data-cobis-group': "GroupLayout,G_TRANSACNNI_163395,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2353_40892.column.sequential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'transactionType',
                    title: '{{vc.viewState.QV_2353_40892.column.transactionType.title|translate:vc.viewState.QV_2353_40892.column.transactionType.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.transactionType.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.transactionType.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT90_TRANSAYN612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.transactionType.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionType, \"QV_2353_40892\", \"transactionType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.transactionType.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.transactionType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.transactionType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'transactionId',
                    title: '{{vc.viewState.QV_2353_40892.column.transactionId.title|translate:vc.viewState.QV_2353_40892.column.transactionId.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.transactionId.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.transactionId.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT25_TRANSADT612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.transactionId.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionId, \"QV_2353_40892\", \"transactionId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.transactionId.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.transactionId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.transactionId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'registerDate',
                    title: '{{vc.viewState.QV_2353_40892.column.registerDate.title|translate:vc.viewState.QV_2353_40892.column.registerDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.registerDate.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.registerDate.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT22_REGISTAE612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.registerDate.style' ng-bind='vc.getStringColumnFormat(dataItem.registerDate, \"QV_2353_40892\", \"registerDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.registerDate.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.registerDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.registerDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'valueDate',
                    title: '{{vc.viewState.QV_2353_40892.column.valueDate.title|translate:vc.viewState.QV_2353_40892.column.valueDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.valueDate.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.valueDate.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT11_VALUEDTE612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.valueDate.style' ng-bind='vc.getStringColumnFormat(dataItem.valueDate, \"QV_2353_40892\", \"valueDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.valueDate.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.valueDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.valueDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'officeName',
                    title: '{{vc.viewState.QV_2353_40892.column.officeName.title|translate:vc.viewState.QV_2353_40892.column.officeName.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.officeName.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.officeName.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT14_OFFICEMN612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.officeName.style' ng-bind='vc.getStringColumnFormat(dataItem.officeName, \"QV_2353_40892\", \"officeName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.officeName.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.officeName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.officeName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'ammount',
                    title: '{{vc.viewState.QV_2353_40892.column.ammount.title|translate:vc.viewState.QV_2353_40892.column.ammount.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.ammount.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.ammount.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT14_AMMOUNTT612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.ammount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.ammount, \"QV_2353_40892\", \"ammount\"):kendo.toString(#=ammount#, vc.viewState.QV_2353_40892.column.ammount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2353_40892.column.ammount.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.ammount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.ammount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'currency',
                    title: '{{vc.viewState.QV_2353_40892.column.currency.title|translate:vc.viewState.QV_2353_40892.column.currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.currency.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.currency.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT10_CURRENYY612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.currency.style' ng-bind='vc.getStringColumnFormat(dataItem.currency, \"QV_2353_40892\", \"currency\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.currency.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'corresponsalId',
                    title: '{{vc.viewState.QV_2353_40892.column.corresponsalId.title|translate:vc.viewState.QV_2353_40892.column.corresponsalId.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.corresponsalId.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.corresponsalId.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT90_CORRESND612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.corresponsalId.style' ng-bind='vc.getStringColumnFormat(dataItem.corresponsalId, \"QV_2353_40892\", \"corresponsalId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.corresponsalId.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.corresponsalId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.corresponsalId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'paymentWay',
                    title: '{{vc.viewState.QV_2353_40892.column.paymentWay.title|translate:vc.viewState.QV_2353_40892.column.paymentWay.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.paymentWay.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.paymentWay.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT42_PAYMENYW612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.paymentWay.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentWay, \"QV_2353_40892\", \"paymentWay\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.paymentWay.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.paymentWay.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.paymentWay.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'transactionStatus',
                    title: '{{vc.viewState.QV_2353_40892.column.transactionStatus.title|translate:vc.viewState.QV_2353_40892.column.transactionStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.transactionStatus.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.transactionStatus.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT62_TRANSASS612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.transactionStatus.style' ng-bind='vc.getStringColumnFormat(dataItem.transactionStatus, \"QV_2353_40892\", \"transactionStatus\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.transactionStatus.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.transactionStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.transactionStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'user',
                    title: '{{vc.viewState.QV_2353_40892.column.user.title|translate:vc.viewState.QV_2353_40892.column.user.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.user.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.user.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT76_USERADGL612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.user.style' ng-bind='vc.getStringColumnFormat(dataItem.user, \"QV_2353_40892\", \"user\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2353_40892.column.user.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.user.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.user.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_2353_40892.columns.push({
                    field: 'sequential',
                    title: '{{vc.viewState.QV_2353_40892.column.sequential.title|translate:vc.viewState.QV_2353_40892.column.sequential.titleArgs}}',
                    width: $scope.vc.viewState.QV_2353_40892.column.sequential.width,
                    format: $scope.vc.viewState.QV_2353_40892.column.sequential.format,
                    editor: $scope.vc.grids.QV_2353_40892.AT82_SEQUENIA612.control,
                    template: "<span ng-class='vc.viewState.QV_2353_40892.column.sequential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequential, \"QV_2353_40892\", \"sequential\"):kendo.toString(#=sequential#, vc.viewState.QV_2353_40892.column.sequential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2353_40892.column.sequential.style",
                        "title": "{{vc.viewState.QV_2353_40892.column.sequential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2353_40892.column.sequential.hidden
                });
            }
            $scope.vc.viewState.QV_2353_40892.toolbar = {}
            $scope.vc.grids.QV_2353_40892.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_2353_40892.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_GENERALINANNN_443_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_GENERALINANNN_443_CANCEL",
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
                    $scope.vc.catalogs.VA_1FGSVHUUVWIKFUH_287203.read();
                    $scope.vc.catalogs.VA_2SRBPZVHVQZKGLJ_978203.read();
                    $scope.vc.catalogs.VA_7HLMTHMOBEPUKDK_450203.read();
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
                $scope.vc.render('VC_GENERALITN_743443');
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
    var cobisMainModule = cobis.createModule("VC_GENERALITN_743443", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_GENERALITN_743443", {
            templateUrl: "VC_GENERALITN_743443_FORM.html",
            controller: "VC_GENERALITN_743443_CTRL",
            labelId: "ASSTS.LBL_ASSTS_DATOSGEEE_96748",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GENERALITN_743443?" + $.param(search);
            }
        });
        VC_GENERALITN_743443(cobisMainModule);
    }]);
} else {
    VC_GENERALITN_743443(cobisMainModule);
}