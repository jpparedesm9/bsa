<!-- Designer Generator v 5.1.0.1601 - release SPR 2016-01 22/01/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.approvecreditrequest = designerEvents.api.approvecreditrequest || designer.dsgEvents();

function VC_APVER36_PPDET_074(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_APVER36_PPDET_074_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_APVER36_PPDET_074_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_79_APVER36",
            taskVersion: "1.0.0",
            viewContainerId: "VC_APVER36_PPDET_074",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_79_APVER36",
        designerEvents.api.approvecreditrequest,
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
                vcName: 'VC_APVER36_PPDET_074'
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
                    taskId: 'T_FLCRE_79_APVER36',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    OriginalHeader: "OriginalHeader",
                    Insurance: "Insurance",
                    Context: "Context",
                    VariablePolicy: "VariablePolicy",
                    AmortizationTableHeader: "AmortizationTableHeader",
                    LineHeader: "LineHeader",
                    FeeRate: "FeeRate",
                    AmortizationTableItem: "AmortizationTableItem",
                    DebtorGeneral: "DebtorGeneral",
                    IndexSizeActivity: "IndexSizeActivity",
                    Policy: "Policy",
                    GeneralData: "GeneralData",
                    DisbursementForms: "DisbursementForms",
                    Category: "Category",
                    DistributionLine: "DistributionLine",
                    GracePeriods: "GracePeriods",
                    VariableExceptions: "VariableExceptions",
                    ApprovalCriteriaQuestion: "ApprovalCriteriaQuestion",
                    Collateral: "Collateral",
                    SourceRevenueCustomer: "SourceRevenueCustomer",
                    RefinancingOperations: "RefinancingOperations",
                    ManagersPoints: "ManagersPoints",
                    QueryCentral: "QueryCentral",
                    InfocredHeader: "InfocredHeader",
                    TableType: "TableType",
                    RoleHierarchy: "RoleHierarchy",
                    OfficerAnalysis: "OfficerAnalysis",
                    Term: "Term",
                    Exceptions: "Exceptions",
                    Rate: "Rate"
                },
                entities: {
                    OriginalHeader: {
                        IDRequested: 'AT_RIG477RQSD66',
                        Office: 'AT_RIG477FICE32',
                        CityCode: 'AT_RIG477ITCE46',
                        AmountRequested: 'AT_RIG477OQUE10',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        Quota: 'AT_RIG477QUOA32',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        CreditTarget: 'AT_RIG477CRET05',
                        InitialDate: 'AT_RIG477IALT55',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        UserL: 'AT_RIG477USRL75',
                        Country: 'AT_RIG477COTR74',
                        Province: 'AT_RIG477OINC84',
                        Term: 'AT_RIG477TERM59',
                        TypeRequest: 'AT_RIG477YPRU27',
                        OfficerName: 'AT_RIG477FNME01',
                        NumberLine: 'AT_RIG477NMLN54',
                        AmountApproved: 'AT_RIG477AUPR26',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Expromission: 'AT_RIG477XSIN84',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        CityCredit: 'AT_RIG477CIDI98',
                        CreditSector: 'AT_RIG477EDCT30',
                        ClientSector: 'AT_RIG477LIEN42',
                        OfficerId: 'AT_RIG477OERD27',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        stageflux: 'AT_RIG477AGFX85',
                        ProductType: 'AT_RIG477PEOE42',
                        Type: 'AT_RIG477TYPE69',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        RejectionReason: 'AT_RIG477EIEA32',
                        RequestLine: 'AT_RIG477UTIN05',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Insurance: {
                        insuranceCode: 'AT_INS408NROD63',
                        insuranceType: 'AT_INS408IRAY49',
                        insuranceCompany: 'AT_INS408ECOY49',
                        insuranceValue: 'AT_INS408NSAU61',
                        _pks: [],
                        _entityId: 'EN_INSURANCE408',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Context: {
                        Application: 'AT_CON762APCI65',
                        RequestId: 'AT_CON762EUTD32',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        CustomerId: 'AT_CON762CSTE68',
                        Bookmark: 'AT_CON762BKAK11',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        TaskSubject: 'AT_CON762TSUT41',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VariablePolicy: {
                        VariableName: 'AT_VAR396ILEA09',
                        VariableValue: 'AT_VAR396VILV60',
                        VariableRule: 'AT_VAR396ALRL41',
                        VariableDescription: 'AT_VAR396BSCT95',
                        _pks: [],
                        _entityId: 'EN_VARBLEPCY396',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    AmortizationTableHeader: {
                        Description: 'AT_ZTO288DCPN45',
                        _pks: [],
                        _entityId: 'EN_ZTOTBEEAD288',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LineHeader: {
                        Rotary: 'AT_LIN382RTAY60',
                        Committed: 'AT_LIN382COMT19',
                        AmountProposed: 'AT_LIN382PROE14',
                        CurrencyProposed: 'AT_LIN382EPRO88',
                        EntryDate: 'AT_LIN382NDTE92',
                        ExpirationDate: 'AT_LIN382XPIA29',
                        Officer: 'AT_LIN382OFIC98',
                        Sector: 'AT_LIN382SCTR87',
                        Province: 'AT_LIN382RVIC64',
                        GeograohicDestination: 'AT_LIN382ADSN85',
                        officerName: 'AT_LIN382OFRE66',
                        AmountLocalCurrency: 'AT_LIN382AAUN05',
                        Number: 'AT_LIN382NUBE83',
                        Term: 'AT_LIN382TERM81',
                        CreditCode: 'AT_LIN382CEDD71',
                        AmountUsed: 'AT_LIN382USED53',
                        AvailableAmount: 'AT_LIN382ALEA97',
                        OfficeCode: 'AT_LIN382FIEC49',
                        CityCode: 'AT_LIN382CTCE01',
                        Code: 'AT_LIN382CODE27',
                        NumberTestimony: 'AT_LIN382NBTE14',
                        MaximunQuoteLine: 'AT_LIN382MAQI65',
                        MaximunQuote: 'AT_LIN382MUQT61',
                        _pks: [],
                        _entityId: 'EN_LINEEADER382',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    FeeRate: {
                        costCategory: 'AT_FEE359CCGR75',
                        factorFrom: 'AT_FEE359FCTO00',
                        factorTo: 'AT_FEE359FORO90',
                        percentage: 'AT_FEE359RCEE53',
                        percentageNew: 'AT_FEE359PRNT92',
                        maxValue: 'AT_FEE359ALUE11',
                        minValue: 'AT_FEE359NALE71',
                        commission: 'AT_FEE359MION60',
                        currency: 'AT_FEE359CURE55',
                        minimum: 'AT_FEE359IMUM30',
                        _pks: [],
                        _entityId: 'EN_FEERATEXR359',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    AmortizationTableItem: {
                        Dividend: 'AT_MRI884DVDE03',
                        ExpirationDate: 'AT_MRI884EPTI34',
                        Balance: 'AT_MRI884BAAC22',
                        Item1: 'AT_MRI884TEM164',
                        Item2: 'AT_MRI884ITE219',
                        Item3: 'AT_MRI884ITEM64',
                        Item4: 'AT_MRI884IEM481',
                        Item5: 'AT_MRI884ITEM43',
                        Item6: 'AT_MRI884IEM603',
                        Item7: 'AT_MRI884ITE729',
                        Item8: 'AT_MRI884TEM887',
                        Item9: 'AT_MRI884TEM984',
                        Item10: 'AT_MRI884TE1034',
                        Item11: 'AT_MRI884ITM148',
                        Item12: 'AT_MRI884TEM155',
                        Item13: 'AT_MRI884ITM128',
                        Fee: 'AT_MRI884SHRE57',
                        _pks: [],
                        _entityId: 'EN_MRIZATITM884',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DebtorGeneral: {
                        CustomerCode: 'AT_DEB342CUST03',
                        Role: 'AT_DEB342ROLE73',
                        Identification: 'AT_DEB342IDEN84',
                        CustomerName: 'AT_DEB342CUST55',
                        TypeDocumentId: 'AT_DEB342DOTD15',
                        Address: 'AT_DEB342ADRS63',
                        Qualification: 'AT_DEB342UALN46',
                        AditionalCode: 'AT_DEB342ITDE08',
                        DateCIC: 'AT_DEB342DTCC73',
                        _pks: ['CustomerCode'],
                        _entityId: 'EN_DEBTORHHW342',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    IndexSizeActivity: {
                        Patrimony: 'AT_NXI784ATRN01',
                        Sales: 'AT_NXI784SALE78',
                        PersonalNumber: 'AT_NXI784PESL28',
                        IndexSizeActivity: 'AT_NXI784NEIY03',
                        AnnualSales: 'AT_NXI784NULE21',
                        ProductiveAssets: 'AT_NXI784RCIE94',
                        ParameterFixedIncome: 'AT_NXI784IXDO09',
                        BtnCalculate: 'AT_NXI784TLAT16',
                        sizeCompany: 'AT_NXI784SECY11',
                        _pks: [],
                        _entityId: 'EN_NXIZECVIY784',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Policy: {
                        mnemonic: 'AT_POL965NMNI98',
                        description: 'AT_POL965DRTO65',
                        result: 'AT_POL965RELT93',
                        detail: 'AT_POL965DETA90',
                        _pks: [],
                        _entityId: 'EN_POLICYKGO965',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    GeneralData: {
                        OperationType: 'AT_GEN921PANE17',
                        Currency: 'AT_GEN921UREC40',
                        Amount: 'AT_GEN921AMON22',
                        Rate: 'AT_GEN921RATE77',
                        DateValueHome: 'AT_GEN921DAUE83',
                        ValueEndDate: 'AT_GEN921UEDE21',
                        ExpirationFirstQuota: 'AT_GEN921XNSA49',
                        _pks: [],
                        _entityId: 'EN_GENERADAT921',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DisbursementForms: {
                        DisbursemenTrate: 'AT_DBR527SNTT15',
                        Currency: 'AT_DBR527CRCY76',
                        Amount: 'AT_DBR527MOUT62',
                        ContributionRate: 'AT_DBR527CNRE01',
                        Quote: 'AT_DBR527UOTE58',
                        Account: 'AT_DBR527CUNT68',
                        Beneficiary: 'AT_DBR527NEAR05',
                        Observations: 'AT_DBR527BEIS98',
                        BeneficiaryId: 'AT_DBR527NEAD00',
                        _pks: [],
                        _entityId: 'EN_DBRSMNFRM527',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Category: {
                        ProductType: 'AT_CAT957PDUP16',
                        Currency: 'AT_CAT957CREY02',
                        Concept: 'AT_CAT957COEP74',
                        MethodOfPayment: 'AT_CAT957MEON23',
                        Reference: 'AT_CAT957EENE30',
                        Sign: 'AT_CAT957SIGN95',
                        Spread: 'AT_CAT957SPRD31',
                        Value: 'AT_CAT957VALU37',
                        Percentage: 'AT_CAT957PENG62',
                        Funded: 'AT_CAT957FNDD20',
                        ConceptType: 'AT_CAT957NCEP81',
                        Factor: 'AT_CAT957FAOR47',
                        ItemDesc: 'AT_CAT957ITMS50',
                        AmountToApplyDesc: 'AT_CAT957MUPE99',
                        AmounToApply: 'AT_CAT957AUNL12',
                        ReferenceAmount: 'AT_CAT957RNCU78',
                        Minimum: 'AT_CAT957MIMM00',
                        Maximun: 'AT_CAT957MAXU35',
                        MinRate: 'AT_CAT957MINA75',
                        Priority: 'AT_CAT957PIRY70',
                        PaymentArrears: 'AT_CAT957ATRR00',
                        Provisioned: 'AT_CAT957OVON18',
                        ReadjustmentSign: 'AT_CAT957UTNI48',
                        ReadjustmentFactor: 'AT_CAT957USEI06',
                        ReferentialReadjustment: 'AT_CAT957EEUM99',
                        Grace: 'AT_CAT957GRCE98',
                        CalculatedBase: 'AT_CAT957LEBS82',
                        AccountPayment: 'AT_CAT957CTPY07',
                        ConceptAsoc: 'AT_CAT957CNTA33',
                        PercentageDay: 'AT_CAT957ENTG63',
                        Affectation: 'AT_CAT957FTTO35',
                        Differ: 'AT_CAT957IFER44',
                        DifferDays: 'AT_CAT957DRDA32',
                        DiscountForm: 'AT_CAT957SUOM48',
                        FormThirdPayment: 'AT_CAT957TRAT87',
                        AccountAbono: 'AT_CAT957CNBO35',
                        RotMinimunRate: 'AT_CAT957MIMT63',
                        isHeritage: 'AT_CAT957HETG57',
                        _pks: [],
                        _entityId: 'EN_CATEGORYM957',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DistributionLine: {
                        CreditType: 'AT_STR478RITT46',
                        Currency: 'AT_STR478CUCY65',
                        AmountProposed: 'AT_STR478AONO09',
                        Quote: 'AT_STR478QOTE39',
                        AmountLocalCurrency: 'AT_STR478AREN75',
                        Module: 'AT_STR478MODL65',
                        _pks: [],
                        _entityId: 'EN_STRIIOINE478',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GracePeriods: {
                        GracePeriodsCapital: 'AT_RAC137APAI18',
                        GracePeriodsInterest: 'AT_RAC137RACE24',
                        ShapeRecoveryGracia: 'AT_RAC137ECVE17',
                        GraceDaysofMora: 'AT_RAC137GRDR00',
                        _pks: [],
                        _entityId: 'EN_RACEPEROS137',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VariableExceptions: {
                        VariableName: 'AT_ABL836RABM62',
                        VariableValue: 'AT_ABL836VBLE29',
                        VariableRule: 'AT_ABL836LELE47',
                        VariableDescription: 'AT_ABL836RSCP88',
                        _pks: [],
                        _entityId: 'EN_ABLEECPTO836',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ApprovalCriteriaQuestion: {
                        internalScore: 'AT_APO644LSOR23',
                        otherDebtCICQuestion: 'AT_APO644RIEN52',
                        sharedEntityQuestion: 'AT_APO644AEET87',
                        comparedExplusiveCustomerQuestion: 'AT_APO644AETE75',
                        currentRateFIE: 'AT_APO644RTIE25',
                        customerCPOPQuestion: 'AT_APO644OCPN24',
                        recordsMatchingQuestion: 'AT_APO644RORT10',
                        customerNoCPOPQuestion: 'AT_APO644OQSO31',
                        previousRateFIE: 'AT_APO644RURF17',
                        maximumDiscountCustomerType: 'AT_APO644MITR05',
                        applyRebateCROP: 'AT_APO644PBTR64',
                        tariffRate: 'AT_APO644TRAE25',
                        rebateCustomerType: 'AT_APO644REYE23',
                        proposedRate: 'AT_APO644OPRA06',
                        rateApply: 'AT_APO644TPPY20',
                        rebateRequest: 'AT_APO644EBEQ90',
                        rebate: 'AT_APO644REAT93',
                        _pks: [],
                        _entityId: 'EN_APOALRUSO644',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Collateral: {
                        collateralCode: 'AT_COL763OLAD86',
                        collateralType: 'AT_COL763CLTT00',
                        collateralDescription: 'AT_COL763CLAP75',
                        productValue: 'AT_COL763PDUV73',
                        residualNet: 'AT_COL763DUET15',
                        dateLastAppraisal: 'AT_COL763TPRL18',
                        _pks: [],
                        _entityId: 'EN_COLATERAL763',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    SourceRevenueCustomer: {
                        Type: 'AT_RER755TYPE77',
                        Sector: 'AT_RER755SCOR68',
                        SubSector: 'AT_RER755STOR39',
                        EconomicActivity: 'AT_RER755OCIT66',
                        ExplanationActivity: 'AT_RER755ENTY85',
                        CodeFIE: 'AT_RER755IECO72',
                        SourceFinancing: 'AT_RER755SORN75',
                        Rol: 'AT_RER755ROLU15',
                        IdClient: 'AT_RER755DCLN75',
                        Clarification: 'AT_RER755LRIN62',
                        descriptionActivity: 'AT_RER755ATVY95',
                        _pks: [],
                        _entityId: 'EN_RERUCUTOR755',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    RefinancingOperations: {
                        IdOperation: 'AT_RNA459DPER71',
                        RefinancingOption: 'AT_RNA459ANOP06',
                        Balance: 'AT_RNA459BANC23',
                        OriginalAmount: 'AT_RNA459GAMO94',
                        LocalCurrencyAmount: 'AT_RNA459RNUN43',
                        CreditType: 'AT_RNA459EITY95',
                        InternalCustomerClassification: 'AT_RNA459NAIC57',
                        DateGranting: 'AT_RNA459DTGN73',
                        IdRequestedOperation: 'AT_RNA459IDOO11',
                        OperationBank: 'AT_RNA459EANA92',
                        LocalCurrencyBalance: 'AT_RNA459OCBA30',
                        CurrencyOperation: 'AT_RNA459CURA87',
                        IsBase: 'AT_RNA459SIAL87',
                        oficialOperation: 'AT_RNA459AORN87',
                        OperationQualification: 'AT_RNA459EATI72',
                        PayoutPercentage: 'AT_RNA459PEEE15',
                        Rate: 'AT_RNA459RATE39',
                        Sector: 'AT_RNA459SEOR45',
                        _pks: [],
                        _entityId: 'EN_RNANCOPAI459',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    ManagersPoints: {
                        Check: 'AT_AAE501CECK86',
                        Role: 'AT_AAE501ROLE87',
                        SalePoints: 'AT_AAE501SEPI72',
                        IdRole: 'AT_AAE501IDOL31',
                        Processed: 'AT_AAE501PREE53',
                        _pks: [],
                        _entityId: 'EN_AAERPOITS501',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    QueryCentral: {
                        ReportMonthCIC: 'AT_UEC063OTHC87',
                        ReportMonthINFOCRED: 'AT_UEC063MICE66',
                        LevelIndebtedness: 'AT_UEC063EDNE07',
                        _pks: [],
                        _entityId: 'EN_UECENTRAL063',
                        _entityVersion: '1.0.0',
                        _transient: true
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
                    },
                    TableType: {
                        Type: 'AT_TAB721TYPE75',
                        FixedPaymentDate: 'AT_TAB721XAYM81',
                        PaymentDay: 'AT_TAB721PYTD71',
                        Capital: 'AT_TAB721PITL30',
                        PaymentMonthly: 'AT_TAB721ANMY98',
                        FeeFinal: 'AT_TAB721EFIA06',
                        Avoidholidays: 'AT_TAB721VOLA28',
                        _pks: [],
                        _entityId: 'EN_TABLETYPE721',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RoleHierarchy: {
                        HierarchyId: 'AT_OLH364EACH78',
                        RoleHierarchyIdIni: 'AT_OLH364CIDI86',
                        RoleHierarchyDescIni: 'AT_OLH364OHAD95',
                        RoleHierarchyIdEnd: 'AT_OLH364RERR36',
                        RoleHierarchyDescEnd: 'AT_OLH364RRCN94',
                        _pks: [],
                        _entityId: 'EN_OLHIERCHY364',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    OfficerAnalysis: {
                        CreditLineValid: 'AT_FIC039ETIA33',
                        CreditLineValidCustom: 'AT_FIC039ILDS81',
                        ApplicationNumber: 'AT_FIC039APIB92',
                        SuggestedAmount: 'AT_FIC039SAMN92',
                        AmounttoDisburse: 'AT_FIC039UNDU26',
                        Suggestedcurrency: 'AT_FIC039SURE63',
                        ProductType: 'AT_FIC039POCT17',
                        TermFrecuency: 'AT_FIC039TENY05',
                        Term: 'AT_FIC039TERM93',
                        Officer: 'AT_FIC039FFCE92',
                        Sector: 'AT_FIC039SCOR17',
                        Province: 'AT_FIC039PONE98',
                        City: 'AT_FIC039CITY75',
                        CreditLine: 'AT_FIC039CRTN56',
                        SerctorNeg: 'AT_FIC039ORNG42',
                        OfficierName: 'AT_FIC039OCEC07',
                        observationReprog: 'AT_FIC039BINO42',
                        _pks: ['ApplicationNumber'],
                        _entityId: 'EN_FICRALYSS039',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Term: {
                        TypeTerm: 'AT_TER028PEEM10',
                        Term: 'AT_TER028TERM00',
                        TypeofFee: 'AT_TER028POFE26',
                        PeriodicityCapital: 'AT_TER028ICIA35',
                        PeriodicityofInterest: 'AT_TER028POYI13',
                        CalculationBase: 'AT_TER028CLUA81',
                        FeeCalculationDays: 'AT_TER028FAID76',
                        _pks: [],
                        _entityId: 'EN_TERMLHHZR028',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Exceptions: {
                        mnemonic: 'AT_EXC513NONI25',
                        description: 'AT_EXC513RTIO01',
                        Aproved: 'AT_EXC513EULT52',
                        Authorized: 'AT_EXC513UOIZ62',
                        detail: 'AT_EXC513DETA22',
                        _pks: [],
                        _entityId: 'EN_EXCEPTINS513',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Rate: {
                        AccordingTariffRate: 'AT_TAS900CIRE75',
                        ProposedRate: 'AT_TAS900OSEE53',
                        _pks: [],
                        _entityId: 'EN_TASASTZLU900',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_BOREGEEL_0798 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_BOREGEEL_0798 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_BOREGEEL_0798_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_BOREGEEL_0798_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DEBTORHHW342',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_BOREGEEL_0798',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_BOREGEEL_0798_filters = {};
            $scope.vc.queryProperties.Q_UEVRBPOC_5831 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UEVRBPOC_5831 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UEVRBPOC_5831_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UEVRBPOC_5831_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_VARBLEPCY396',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UEVRBPOC_5831',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_UEVRBPOC_5831_filters = {};
            $scope.vc.queryProperties.Q_UYCTEGOY_6570 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UYCTEGOY_6570 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UYCTEGOY_6570_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UYCTEGOY_6570_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CATEGORYM957',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UYCTEGOY_6570',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_UYCTEGOY_6570_filters = {};
            $scope.vc.queryProperties.Q_RURCECER_2364 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_RURCECER_2364 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RURCECER_2364_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RURCECER_2364_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RERUCUTOR755',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RURCECER_2364',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_RURCECER_2364_filters = {};
            $scope.vc.queryProperties.Q_ITRICNAN_1523 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_ITRICNAN_1523 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ITRICNAN_1523_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ITRICNAN_1523_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RNANCOPAI459',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ITRICNAN_1523',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_ITRICNAN_1523_filters = {};
            $scope.vc.queryProperties.Q_QERISUIL_7170 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QERISUIL_7170 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QERISUIL_7170_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QERISUIL_7170_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_STRIIOINE478',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QERISUIL_7170',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QERISUIL_7170_filters = {};
            $scope.vc.queryProperties.Q_MARPNTEY_5915 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_MARPNTEY_5915 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_MARPNTEY_5915_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_MARPNTEY_5915_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_AAERPOITS501',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_MARPNTEY_5915',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_MARPNTEY_5915_filters = {};
            $scope.vc.queryProperties.Q_QUYOINBL_3312 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUYOINBL_3312 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUYOINBL_3312_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUYOINBL_3312_filters;
                    parametersAux = {};
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
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QUYOINBL_3312_filters = {};
            $scope.vc.queryProperties.Q_UERXCPTS_4756 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UERXCPTS_4756 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UERXCPTS_4756_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UERXCPTS_4756_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_EXCEPTINS513',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UERXCPTS_4756',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_UERXCPTS_4756_filters = {};
            $scope.vc.queryProperties.Q_QUNURACE_2482 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUNURACE_2482 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUNURACE_2482_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUNURACE_2482_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_INSURANCE408',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUNURACE_2482',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QUNURACE_2482_filters = {};
            $scope.vc.queryProperties.Q_EAIBLEEP_2309 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_EAIBLEEP_2309 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_EAIBLEEP_2309_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_EAIBLEEP_2309_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ABLEECPTO836',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_EAIBLEEP_2309',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_EAIBLEEP_2309_filters = {};
            $scope.vc.queryProperties.Q_QUELEEHY_6533 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUELEEHY_6533 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUELEEHY_6533_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUELEEHY_6533_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_OLHIERCHY364',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUELEEHY_6533',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QUELEEHY_6533_filters = {};
            $scope.vc.queryProperties.Q_HERAMITE_8244 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_HERAMITE_8244 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_HERAMITE_8244_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_HERAMITE_8244_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ZTOTBEEAD288',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_HERAMITE_8244',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_HERAMITE_8244_filters = {};
            $scope.vc.queryProperties.Q_QUEROLCY_4480 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUEROLCY_4480 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUEROLCY_4480_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUEROLCY_4480_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_POLICYKGO965',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUEROLCY_4480',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QUEROLCY_4480_filters = {};
            $scope.vc.queryProperties.Q_YCLAERAL_9320 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_YCLAERAL_9320 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_YCLAERAL_9320_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_YCLAERAL_9320_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_COLATERAL763',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_YCLAERAL_9320',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_YCLAERAL_9320_filters = {};
            $scope.vc.queryProperties.Q_QURDMNFR_9228 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QURDMNFR_9228 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QURDMNFR_9228_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QURDMNFR_9228_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DBRSMNFRM527',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QURDMNFR_9228',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QURDMNFR_9228_filters = {};
            defaultValues = {
                OriginalHeader: {},
                Insurance: {},
                Context: {},
                VariablePolicy: {},
                AmortizationTableHeader: {},
                LineHeader: {},
                FeeRate: {},
                AmortizationTableItem: {},
                DebtorGeneral: {},
                IndexSizeActivity: {},
                Policy: {},
                GeneralData: {},
                DisbursementForms: {},
                Category: {},
                DistributionLine: {},
                GracePeriods: {},
                VariableExceptions: {},
                ApprovalCriteriaQuestion: {},
                Collateral: {},
                SourceRevenueCustomer: {},
                RefinancingOperations: {},
                ManagersPoints: {},
                QueryCentral: {},
                InfocredHeader: {},
                TableType: {},
                RoleHierarchy: {},
                OfficerAnalysis: {},
                Term: {},
                Exceptions: {},
                Rate: {}
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
            $scope.vc.viewState.VC_APVER36_PPDET_074 = {
                style: []
            }
            //ViewState - Container: ApproveCreditRequest
            $scope.vc.createViewState({
                id: "VC_APVER36_PPDET_074",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PRNELUDDD_81422",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Datos del Crédito
            $scope.vc.createViewState({
                id: "VC_APVER36_TSLIT_995",
                hasId: true,
                componentStyle: "",
                label: 'Datos del Cr\u00e9dito',
                enabled: designer.constants.mode.None
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.OriginalHeader = {
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine")
            };
            //ViewState - Group: GRUOP_HEADER
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_02",
                hasId: true,
                componentStyle: "",
                label: 'GRUOP_HEADER',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: ApplicationNumber
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_IOUR445",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PLATONUER_39479",
                label: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: IDRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_RQSD386",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CRDITCODE_86774",
                label: "BUSIN.DLB_BUSIN_CRDITCODE_86774",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_0000908",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICEWWB_98352",
                label: "BUSIN.DLB_BUSIN_OFFICELSD_48549",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_0000908 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_0000908', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_0000908'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_0000908");
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
            //ViewState - Entity: OriginalHeader, Attribute: CityCode
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_ITCE121",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                label: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_ITCE121 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_ITCE121', 'cl_ciudad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_ITCE121'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_ITCE121");
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
            //ViewState - Entity: OriginalHeader, Attribute: AmountRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_OQUE134",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_AMOUTREED_14545",
                label: "BUSIN.DLB_BUSIN_AMOUTREED_14545",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 40,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: CurrencyRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_URQT595",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                label: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_URQT595 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_URQT595', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_URQT595'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_URQT595");
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
            //ViewState - Entity: OriginalHeader, Attribute: Quota
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_QUOA306",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PAYMENTOS_89327",
                label: "BUSIN.DLB_BUSIN_PAYMENTLI_94219",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 37,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: PaymentFrequency
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_NQUE773",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PYTFREUNY_61581",
                label: "BUSIN.DLB_BUSIN_PYTFREUNY_61581",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_NQUE773 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_NQUE773', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_NQUE773'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_NQUE773");
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
            //ViewState - Entity: OriginalHeader, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_TERM237",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                haslabelArgs: true,
                format: "###0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: CreditTarget
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_CRET312",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ENRUEINAN_89137",
                label: "BUSIN.DLB_BUSIN_DCIOEEDDT_35512",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: InitialDate
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_IALT328",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_STARTDATE_61282",
                label: "BUSIN.DLB_BUSIN_STARTDATE_61282",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: OfficerName
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_FNME018",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: NumberLine
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_NMLN737",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NROLINEAB_08143",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: Expromission
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_XSIN642",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OTIVOEXRI_92521",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_XSIN642 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_XSIN642', 'cr_motivoexp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_XSIN642'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_XSIN642");
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
            //ViewState - Entity: OriginalHeader, Attribute: ReasonRefinancing
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_AONN156",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_REASONMLS_18269",
                label: "BUSIN.DLB_BUSIN_REASONMLS_18269",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_AONN156 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_AONN156', 'cr_motivoref', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_AONN156'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_AONN156");
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
            //ViewState - Entity: OriginalHeader, Attribute: OpNumberBank
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_NRAK349",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NROLINEAB_08143",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: ProductType
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_PEOE356",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PODUCTTPE_53088",
                label: "BUSIN.DLB_BUSIN_PODUCTTPE_53088",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_PEOE356 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_PEOE356', 'ca_toperacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_PEOE356'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_PEOE356");
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
            //ViewState - Entity: OriginalHeader, Attribute: CreditLineValid
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_EVAL957",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_LNEDERDIT_79082",
                label: "BUSIN.DLB_BUSIN_LNEDERDIT_79082",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_EVAL957 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8602_EVAL957', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_EVAL957'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_EVAL957");
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
            //ViewState - Entity: OriginalHeader, Attribute: Agreement
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_REEM856",
                componentStyle: "text-left",
                label: "BUSIN.DLB_BUSIN_CONVENIOQ_42669",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: CodeAgreement
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_REET975",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CDIOEMPRS_19259",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_REET975 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8602_REET975', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_REET975'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_REET975");
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
            //ViewState - Entity: OriginalHeader, Attribute: RejectionReason
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_EIEA610",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOTORECHZ_03662",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_EIEA610 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8602_EIEA610', 'cr_motivo_rechazo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_EIEA610'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_EIEA610");
                        }, null, options.data.filter, 1);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Container: Dato Indice
            $scope.vc.createViewState({
                id: "VC_APVER36_DAINE_087",
                hasId: true,
                componentStyle: "",
                label: 'Dato Indice',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GPOfficerAnalysis
            $scope.vc.createViewState({
                id: "GR_OFICANSSEW26_04",
                hasId: true,
                componentStyle: "",
                label: 'GPOfficerAnalysis',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.OfficerAnalysis = {
                CreditLineValid: $scope.vc.channelDefaultValues("OfficerAnalysis", "CreditLineValid"),
                CreditLineValidCustom: $scope.vc.channelDefaultValues("OfficerAnalysis", "CreditLineValidCustom"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OfficerAnalysis", "ApplicationNumber"),
                SuggestedAmount: $scope.vc.channelDefaultValues("OfficerAnalysis", "SuggestedAmount"),
                AmounttoDisburse: $scope.vc.channelDefaultValues("OfficerAnalysis", "AmounttoDisburse"),
                Suggestedcurrency: $scope.vc.channelDefaultValues("OfficerAnalysis", "Suggestedcurrency"),
                ProductType: $scope.vc.channelDefaultValues("OfficerAnalysis", "ProductType"),
                TermFrecuency: $scope.vc.channelDefaultValues("OfficerAnalysis", "TermFrecuency"),
                Term: $scope.vc.channelDefaultValues("OfficerAnalysis", "Term"),
                Officer: $scope.vc.channelDefaultValues("OfficerAnalysis", "Officer"),
                Sector: $scope.vc.channelDefaultValues("OfficerAnalysis", "Sector"),
                Province: $scope.vc.channelDefaultValues("OfficerAnalysis", "Province"),
                City: $scope.vc.channelDefaultValues("OfficerAnalysis", "City"),
                CreditLine: $scope.vc.channelDefaultValues("OfficerAnalysis", "CreditLine"),
                SerctorNeg: $scope.vc.channelDefaultValues("OfficerAnalysis", "SerctorNeg"),
                OfficierName: $scope.vc.channelDefaultValues("OfficerAnalysis", "OfficierName"),
                observationReprog: $scope.vc.channelDefaultValues("OfficerAnalysis", "observationReprog")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OFICANSSEW26_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: ApplicationNumber
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_APIB151",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PLATONUER_39479",
                label: "BUSIN.DLB_BUSIN_APAONMBER_11346",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: SuggestedAmount
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_SAMN032",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_GGESTEAMT_15655",
                label: "BUSIN.DLB_BUSIN_SGSEDAMNT_58429",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: AmounttoDisburse
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_UNDU035",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_AMOUNTBSE_67188",
                label: "BUSIN.DLB_BUSIN_UNTODISUR_74563",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Suggestedcurrency
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_SURE913",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_GGSDCURNC_47914",
                label: "BUSIN.DLB_BUSIN_UGECRENCY_17995",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_SURE913 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_SURE913', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_SURE913'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_SURE913");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: ProductType
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_POCT250",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PODUCTTPE_53088",
                label: "BUSIN.DLB_BUSIN_PROUCTTPE_88016",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_POCT250 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_POCT250', 'ca_toperacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_POCT250'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_POCT250");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_TENY472",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TERMKHLPJ_39636",
                label: "BUSIN.DLB_BUSIN_TERMCUWZU_98612",
                haslabelArgs: true,
                format: "###0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: TermFrecuency
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_TERM877",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ECUEYTERM_20622",
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_TERM877 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_TERM877', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_TERM877'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_TERM877");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: Officer
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_FFCE753",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICERTU_38261",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: OfficierName
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_OCEC262",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_SCOR371",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TMERDUSRY_93208",
                label: "BUSIN.DLB_BUSIN_TMERDUSRY_93208",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_SCOR371 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_SCOR371', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_SCOR371'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_SCOR371");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: Province
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_PONE992",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                label: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_PONE992 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_PONE992', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_PONE992'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_PONE992");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: SerctorNeg
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_ORNG078",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CREITNSTY_93122",
                label: "BUSIN.DLB_BUSIN_CREITNSTY_93122",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_ORNG078 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_ORNG078', 'cl_sector_neg', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_ORNG078'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_ORNG078");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: City
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_CITY183",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CITYTUAFC_81780",
                label: "BUSIN.DLB_BUSIN_CITYAQLIM_46735",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_CITY183 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFICANSSEW2603_CITY183', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_CITY183'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_CITY183");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: CreditLine
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_CRTN299",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TYPECREIT_29679",
                label: "BUSIN.DLB_BUSIN_CREDITYPE_12941",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFICANSSEW2603_CRTN299 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OFICANSSEW2603_CRTN299', 'ca_tipo_cartera', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OFICANSSEW2603_CRTN299'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFICANSSEW2603_CRTN299");
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
            //ViewState - Entity: OfficerAnalysis, Attribute: CreditLineValid
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2603_ETIA407",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OFICANSSEW26_05",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OfficerAnalysis, Attribute: observationReprog
            $scope.vc.createViewState({
                id: "VA_OFICANSSEW2605_BINO138",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EVRRRAMCN_87315",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: Datos de Linea
            $scope.vc.createViewState({
                id: "VC_APVER36_TSEIE_892",
                hasId: true,
                componentStyle: "",
                label: 'Datos de Linea',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_VIWLNEHADE48_03",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LineHeader = {
                Rotary: $scope.vc.channelDefaultValues("LineHeader", "Rotary"),
                Committed: $scope.vc.channelDefaultValues("LineHeader", "Committed"),
                AmountProposed: $scope.vc.channelDefaultValues("LineHeader", "AmountProposed"),
                CurrencyProposed: $scope.vc.channelDefaultValues("LineHeader", "CurrencyProposed"),
                EntryDate: $scope.vc.channelDefaultValues("LineHeader", "EntryDate"),
                ExpirationDate: $scope.vc.channelDefaultValues("LineHeader", "ExpirationDate"),
                Officer: $scope.vc.channelDefaultValues("LineHeader", "Officer"),
                Sector: $scope.vc.channelDefaultValues("LineHeader", "Sector"),
                Province: $scope.vc.channelDefaultValues("LineHeader", "Province"),
                GeograohicDestination: $scope.vc.channelDefaultValues("LineHeader", "GeograohicDestination"),
                officerName: $scope.vc.channelDefaultValues("LineHeader", "officerName"),
                AmountLocalCurrency: $scope.vc.channelDefaultValues("LineHeader", "AmountLocalCurrency"),
                Number: $scope.vc.channelDefaultValues("LineHeader", "Number"),
                Term: $scope.vc.channelDefaultValues("LineHeader", "Term"),
                CreditCode: $scope.vc.channelDefaultValues("LineHeader", "CreditCode"),
                AmountUsed: $scope.vc.channelDefaultValues("LineHeader", "AmountUsed"),
                AvailableAmount: $scope.vc.channelDefaultValues("LineHeader", "AvailableAmount"),
                OfficeCode: $scope.vc.channelDefaultValues("LineHeader", "OfficeCode"),
                CityCode: $scope.vc.channelDefaultValues("LineHeader", "CityCode"),
                Code: $scope.vc.channelDefaultValues("LineHeader", "Code"),
                NumberTestimony: $scope.vc.channelDefaultValues("LineHeader", "NumberTestimony"),
                MaximunQuoteLine: $scope.vc.channelDefaultValues("LineHeader", "MaximunQuoteLine"),
                MaximunQuote: $scope.vc.channelDefaultValues("LineHeader", "MaximunQuote")
            };
            //ViewState - Group: Panel Plegable para LineHeader
            $scope.vc.createViewState({
                id: "GR_VIWLNEHADE48_04",
                hasId: true,
                componentStyle: "",
                label: 'Panel Plegable para LineHeader',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Rotary
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_RTAY467",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ROTARYWTD_99978",
                label: "BUSIN.DLB_BUSIN_ROTARYEIR_50583",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VIWLNEHADE4804_RTAY467 = new kendo.data.DataSource({
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
            if (typeof $scope.vc.catalogs.VA_VIWLNEHADE4804_RTAY467 !== "undefined") {}
            //ViewState - Entity: LineHeader, Attribute: Committed
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_COMT755",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_COMMITTED_95010",
                label: "BUSIN.DLB_BUSIN_COMMITTED_45668",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_VIWLNEHADE4804_COMT755 = new kendo.data.DataSource({
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
            if (typeof $scope.vc.catalogs.VA_VIWLNEHADE4804_COMT755 !== "undefined") {}
            //ViewState - Entity: LineHeader, Attribute: AmountProposed
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_PROE708",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OUNTPROSE_37841",
                label: "BUSIN.DLB_BUSIN_AMNRPOSED_26320",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: CurrencyProposed
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_EPRO969",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_CRRNCPOSD_21478",
                label: "BUSIN.DLB_BUSIN_CRNCYOPSD_46351",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIWLNEHADE4804_EPRO969 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIWLNEHADE4804_EPRO969', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIWLNEHADE4804_EPRO969'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIWLNEHADE4804_EPRO969");
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
            //ViewState - Entity: LineHeader, Attribute: AmountLocalCurrency
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_AAUN561",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOTLOCENC_66188",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: EntryDate
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_NDTE084",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_HEVGENCIA_90594",
                label: "BUSIN.DLB_BUSIN_HEVGENCIA_90594",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_TERM000",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_TERMKHLPJ_39636",
                label: "BUSIN.DLB_BUSIN_TEMMOTHLY_32519",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: ExpirationDate
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_XPIA754",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_EXIRTIONA_39042",
                label: "BUSIN.DLB_BUSIN_XPIRATION_69508",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: MaximunQuoteLine
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_MAQI739",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MAXUTALNE_73481",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: LineHeader, Attribute: MaximunQuote
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_MUQT825",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MAXIMUMQA_70875",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: LineHeader, Attribute: AvailableAmount
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_ALEA255",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AIAEBALAN_25129",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: LineHeader, Attribute: officerName
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_OFIC643",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_OFFICERTU_38261",
                label: "BUSIN.DLB_BUSIN_OFFICERAT_46633",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LineHeader, Attribute: Sector
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_SCTR177",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_WUIWWCGVG_35342",
                label: "BUSIN.DLB_BUSIN_CUXVQJCMT_72827",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIWLNEHADE4804_SCTR177 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIWLNEHADE4804_SCTR177', 'cl_sector_economico', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIWLNEHADE4804_SCTR177'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIWLNEHADE4804_SCTR177");
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
            //ViewState - Entity: LineHeader, Attribute: Province
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_RVIC022",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIWLNEHADE4804_RVIC022 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_VIWLNEHADE4804_RVIC022', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_VIWLNEHADE4804_RVIC022'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIWLNEHADE4804_RVIC022");
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
            //ViewState - Entity: LineHeader, Attribute: GeograohicDestination
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_ADSN982",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_GEOGAITIO_83190",
                label: "BUSIN.DLB_BUSIN_OAHDETION_14498",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_VIWLNEHADE4804_ADSN982 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_VIWLNEHADE4804_ADSN982', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_VIWLNEHADE4804_ADSN982'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_VIWLNEHADE4804_ADSN982");
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
            //ViewState - Entity: LineHeader, Attribute: NumberTestimony
            $scope.vc.createViewState({
                id: "VA_VIWLNEHADE4804_NBTE204",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_UMROTSINO_09550",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: Datos de Deudores
            $scope.vc.createViewState({
                id: "VC_APVER36_AEDOS_631",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BORWERDTA_05940",
                haslabelArgs: true,
                enabled: designer.constants.mode.None
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_BORRWRVIEW27_03",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: BorrowerGroup
            $scope.vc.createViewState({
                id: "GR_BORRWRVIEW27_83",
                hasId: true,
                componentStyle: "",
                label: 'BorrowerGroup',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DebtorGeneral = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CustomerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerCode", 0),
                        validation: {
                            CustomerCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    CustomerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "CustomerName", '')
                    },
                    Role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Role", '')
                    },
                    TypeDocumentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "TypeDocumentId", '')
                    },
                    Identification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Identification", '')
                    },
                    Qualification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "Qualification", '')
                    },
                    DateCIC: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "DateCIC", new Date())
                    }
                }
            });;
            $scope.vc.model.DebtorGeneral = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_BOREGEEL_0798();
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DebtorGeneral',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_BOREG0798_55', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
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
                    model: $scope.vc.types.DebtorGeneral
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_BOREG0798_55").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_BOREGEEL_0798 = $scope.vc.model.DebtorGeneral;
            $scope.vc.trackers.DebtorGeneral = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DebtorGeneral);
            $scope.vc.model.DebtorGeneral.bind('change', function(e) {
                $scope.vc.trackers.DebtorGeneral.track(e);
            });
            $scope.vc.grids.QV_BOREG0798_55 = {};
            $scope.vc.grids.QV_BOREG0798_55.queryId = 'Q_BOREGEEL_0798';
            $scope.vc.viewState.QV_BOREG0798_55 = {
                style: undefined
            };
            $scope.vc.viewState.QV_BOREG0798_55.column = {};
            $scope.vc.grids.QV_BOREG0798_55.events = {
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
                    var index = e.container.find("td > a.k-grid-update").parent().index();
                    if (index != -1) {
                        $scope.vc.changeGridColumnWidth('QV_BOREG0798_55', index, "0px");
                    }
                    $scope.vc.trackers.DebtorGeneral.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_BOREG0798_55.selectedRow = e.model;
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
                    $scope.vc.changeGridColumnWidth('QV_BOREG0798_55', index, "auto");
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'DebtorGeneral',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_BOREG0798_55", args, function() {
                        if (args.cancel) {
                            $("#QV_BOREG0798_55").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    index = grid.element.find("td > span.cb-commands").parent().index();
                    if (index != -1) {
                        $scope.vc.changeGridColumnWidth('QV_BOREG0798_55', index, "0px");
                    }
                    $scope.vc.gridDataBound("QV_BOREG0798_55");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_BOREG0798_55 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_BOREG0798_55 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_BOREG0798_55.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_BOREG0798_55.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode = {
                title: 'BUSIN.DLB_BUSIN_CDIGOZVON_13133',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                width: 60,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_BORRWRVIEW2783_CUST965',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CUTOMEROD_75260'|translate}}",
                        'id': "VA_BORRWRVIEW2783_CUST965",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CDIGOZVON_13133') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.format",
                        'k-decimals': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.decimals",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerCode.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName = {
                title: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_CUST678',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST55 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_NAMEFDOFF_74379'|translate}}",
                        'id': "VA_BORRWRVIEW2783_CUST678",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.CustomerName.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Role = {
                title: 'BUSIN.DLB_BUSIN_MANTRYTYP_29149',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_MANTRYTYP_29149',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_ROLE954',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values)) {
                            $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_BORRWRVIEW2783_ROLE954',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_BORRWRVIEW2783_ROLE954'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_ROLE954");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_ROLE954");
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
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Role.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_MANTRYTYP_29149'|translate}}",
                        'id': "VA_BORRWRVIEW2783_ROLE954",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.Role.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_BORRWRVIEW2783_ROLE954",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.Role.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Role.validationCode}}",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'k-on-change': "vc.change(kendoEvent,'VA_BORRWRVIEW2783_ROLE954',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_BORRWRVIEW2783_ROLE954',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId = {
                title: 'BUSIN.DLB_BUSIN_TIPOOMETO_33623',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_TIPOOMETO_33623',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_DOTD256',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values)) {
                            $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_BORRWRVIEW2783_DOTD256',
                                'cl_tipo_documento',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_BORRWRVIEW2783_DOTD256'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_DOTD256");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_BOREG0798_55", "VA_BORRWRVIEW2783_DOTD256");
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
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TIPOOMETO_33623'|translate}}",
                        'id': "VA_BORRWRVIEW2783_DOTD256",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_BORRWRVIEW2783_DOTD256",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.validationCode}}",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'k-on-change': "vc.change(kendoEvent,'VA_BORRWRVIEW2783_DOTD256',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_BORRWRVIEW2783_DOTD256',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Identification = {
                title: 'BUSIN.DLB_BUSIN_IFICTNBER_84824',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_IFICTNBER_84824',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_IDEN901',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342IDEN84 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Identification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_IFICTNBER_84824'|translate}}",
                        'id': "VA_BORRWRVIEW2783_IDEN901",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Identification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Identification.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Identification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Qualification = {
                title: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_UALN736',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342UALN46 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Qualification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CALIFCAIN_39502'|translate}}",
                        'id': "VA_BORRWRVIEW2783_UALN736",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Qualification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_BORRWRVIEW27_03,0",
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Qualification.enabled",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Qualification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC = {
                title: 'BUSIN.DLB_BUSIN_FECHACICY_04196',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_BORRWRVIEW2783_DTCC540',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.DateCIC.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_BORRWRVIEW2783_DTCC540",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.DateCIC.validationCode}}",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.DateCIC.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'CustomerCode',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.title|translate:vc.viewState.QV_BOREG0798_55.column.CustomerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST03.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerCode.element[dataItem.uid].style' ng-bind='kendo.toString(#=CustomerCode#, vc.viewState.QV_BOREG0798_55.column.CustomerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.CustomerCode.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.CustomerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'CustomerName',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.CustomerName.title|translate:vc.viewState.QV_BOREG0798_55.column.CustomerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342CUST55.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerName.element[dataItem.uid].style'>#if (CustomerName !== null) {# #=CustomerName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.CustomerName.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Role',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Role.title|translate:vc.viewState.QV_BOREG0798_55.column.Role.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Role.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Role.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Role.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_BORRWRVIEW2783_ROLE954.get(dataItem.Role).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Role.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'TypeDocumentId',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.title|translate:vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_BORRWRVIEW2783_DOTD256.get(dataItem.TypeDocumentId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Identification',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Identification.title|translate:vc.viewState.QV_BOREG0798_55.column.Identification.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342IDEN84.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Identification.element[dataItem.uid].style'>#if (Identification !== null) {# #=Identification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Identification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Identification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Qualification',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Qualification.title|translate:vc.viewState.QV_BOREG0798_55.column.Qualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342UALN46.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Qualification.element[dataItem.uid].style'>#if (Qualification !== null) {# #=Qualification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Qualification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Qualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'DateCIC',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.DateCIC.title|translate:vc.viewState.QV_BOREG0798_55.column.DateCIC.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_BOREG0798_55', 'DateCIC', $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_BOREG0798_55', 'DateCIC'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.DateCIC.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.DateCIC.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.hidden
                });
            }
            $scope.vc.grids.QV_BOREG0798_55.columns.push({
                command: {
                    template: "<span class='cb-commands'></span>"
                },
                attributes: {
                    "class": "btn-toolbar"
                },
                width: 1
            });
            $scope.vc.viewState.QV_BOREG0798_55.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                },
                CEQV_201_QV_BOREG0798_55_719: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_BOREG0798_55.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-show = 'vc.viewState.QV_BOREG0798_55.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_BORRWRVIEW27_83.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_BOREG0798_55_719",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_BOREG0798_55_719' ng-show='vc.viewState.QV_BOREG0798_55.toolbar.CEQV_201_QV_BOREG0798_55_719.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_BOREG0798_55_719\",\"DebtorGeneral\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }]; //ViewState - Container: Datos Refinanciamiento
            $scope.vc.createViewState({
                id: "VC_APVER36_TICNT_748",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RMSNERTOS_13509",
                haslabelArgs: true,
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor de Pestañas
            $scope.vc.createViewState({
                id: "GR_ININGOTONE04_08",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor de Pesta\u00f1as',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Pestaña para RefinancingOperations
            $scope.vc.createViewState({
                id: "GR_ININGOTONE04_35",
                hasId: true,
                componentStyle: "",
                label: 'Pesta\u00f1a para RefinancingOperations',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RefinancingOperations = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    IsBase: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "IsBase", false)
                    },
                    IdOperation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "IdOperation", '')
                    },
                    OperationBank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OperationBank", '')
                    },
                    RefinancingOption: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "RefinancingOption", '')
                    },
                    CurrencyOperation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "CurrencyOperation", 0)
                    },
                    Balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "Balance", 0)
                    },
                    LocalCurrencyBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "LocalCurrencyBalance", 0)
                    },
                    OriginalAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OriginalAmount", 0)
                    },
                    LocalCurrencyAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "LocalCurrencyAmount", 0)
                    },
                    CreditType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "CreditType", '')
                    },
                    InternalCustomerClassification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "InternalCustomerClassification", '')
                    },
                    OperationQualification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "OperationQualification", '')
                    },
                    PayoutPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "PayoutPercentage", 0)
                    },
                    DateGranting: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "DateGranting", '')
                    },
                    oficialOperation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RefinancingOperations", "oficialOperation", 0)
                    },
                    Rate: {
                        type: "number",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.RefinancingOperations = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_ITRICNAN_1523();
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RefinancingOperations',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_ITRIC1523_63', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RefinancingOperations',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_ITRIC1523_63', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RefinancingOperations',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_ITRIC1523_63', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.RefinancingOperations
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ITRIC1523_63").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ITRICNAN_1523 = $scope.vc.model.RefinancingOperations;
            $scope.vc.trackers.RefinancingOperations = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RefinancingOperations);
            $scope.vc.model.RefinancingOperations.bind('change', function(e) {
                $scope.vc.trackers.RefinancingOperations.track(e);
            });
            $scope.vc.grids.QV_ITRIC1523_63 = {};
            $scope.vc.grids.QV_ITRIC1523_63.queryId = 'Q_ITRICNAN_1523';
            $scope.vc.viewState.QV_ITRIC1523_63 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column = {};
            $scope.vc.grids.QV_ITRIC1523_63.events = {
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
                    var index = e.container.find("td > a.k-grid-update").parent().index();
                    if (index != -1) {
                        $scope.vc.changeGridColumnWidth('QV_ITRIC1523_63', index, "0px");
                    }
                    $scope.vc.trackers.RefinancingOperations.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_ITRIC1523_63.selectedRow = e.model;
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
                    $scope.vc.changeGridColumnWidth('QV_ITRIC1523_63', index, "auto");
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'RefinancingOperations',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_ITRIC1523_63", args, function() {
                        if (args.cancel) {
                            $("#QV_ITRIC1523_63").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    index = grid.element.find("td > span.cb-commands").parent().index();
                    if (index != -1) {
                        $scope.vc.changeGridColumnWidth('QV_ITRIC1523_63', index, "0px");
                    }
                    $scope.vc.gridDataBound("QV_ITRIC1523_63");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_ITRIC1523_63.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_ITRIC1523_63.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_ITRIC1523_63.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_ITRIC1523_63 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_ITRIC1523_63 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_ITRIC1523_63.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_ITRIC1523_63.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_ITRIC1523_63.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "RefinancingOperations",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_ITRIC1523_63", args);
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
            $scope.vc.grids.QV_ITRIC1523_63.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ITRIC1523_63.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ITRIC1523_63.column.IsBase = {
                title: 'BUSIN.DLB_BUSIN_SELECIOAR_14656',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_SIAL979',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459SIAL87 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.IsBase.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_ININGOTONE0435_SIAL979",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_63.column.IsBase.element["' + options.model.uid + '"].style',
                        'ng-click': "vc.change(null,'VA_ININGOTONE0435_SIAL979',this.dataItem,'" + options.field + "', $event.target)"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.IdOperation = {
                title: 'BUSIN.DLB_BUSIN_OPEIONBER_32159',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_OPEIONBER_32159',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_DPER910',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459DPER71 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.IdOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_OPEIONBER_32159'|translate}}",
                        'id': "VA_ININGOTONE0435_DPER910",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.IdOperation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.IdOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.IdOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.OperationBank = {
                title: 'BUSIN.DLB_BUSIN_OPEIONBER_32159',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_OPEIONBER_32159',
                width: 140,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_EANA700',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459EANA92 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.OperationBank.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_OPEIONBER_32159'|translate}}",
                        'id': "VA_ININGOTONE0435_EANA700",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.OperationBank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.OperationBank.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.OperationBank.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.RefinancingOption = {
                title: 'BUSIN.DLB_BUSIN_RFNANIPTN_49588',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_RFNANIPTN_49588',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_ANOP470',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_ININGOTONE0435_ANOP470 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_ININGOTONE0435_ANOP470_values)) {
                            $scope.vc.catalogs.VA_ININGOTONE0435_ANOP470_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_ININGOTONE0435_ANOP470',
                                'cr_opcion_refinan',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_ININGOTONE0435_ANOP470'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_ININGOTONE0435_ANOP470_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_63", "VA_ININGOTONE0435_ANOP470");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_ININGOTONE0435_ANOP470_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_63", "VA_ININGOTONE0435_ANOP470");
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
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459ANOP06 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_RFNANIPTN_49588'|translate}}",
                        'id': "VA_ININGOTONE0435_ANOP470",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_ININGOTONE0435_ANOP470",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.validationCode}}",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_CURA309',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_ININGOTONE0435_CURA309 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_ININGOTONE0435_CURA309_values)) {
                            $scope.vc.catalogs.VA_ININGOTONE0435_CURA309_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_ININGOTONE0435_CURA309',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_ININGOTONE0435_CURA309'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_ININGOTONE0435_CURA309_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_63", "VA_ININGOTONE0435_CURA309");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_ININGOTONE0435_CURA309_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_63", "VA_ININGOTONE0435_CURA309");
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
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459CURA87 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_MONEDAQAQ_04700'|translate}}",
                        'id': "VA_ININGOTONE0435_CURA309",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_ININGOTONE0435_CURA309",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.validationCode}}",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.Balance = {
                title: 'BUSIN.DLB_BUSIN_BALANCESI_24039',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_BALANCESI_24039',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_BANC052',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459BANC23 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.Balance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_BALANCESI_24039'|translate}}",
                        'id': "VA_ININGOTONE0435_BANC052",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.Balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_63.column.Balance.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_63.column.Balance.decimals",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.Balance.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.Balance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance = {
                title: 'BUSIN.DLB_BUSIN_LORRNYANE_43671',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_LORRNYANE_43671',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_OCBA092',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459OCBA30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_LORRNYANE_43671'|translate}}",
                        'id': "VA_ININGOTONE0435_OCBA092",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.decimals",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.OriginalAmount = {
                title: 'BUSIN.DLB_BUSIN_ORILAMOUN_89859',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_ORILAMOUN_89859',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_GAMO302',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459GAMO94 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_ORILAMOUN_89859'|translate}}",
                        'id': "VA_ININGOTONE0435_GAMO302",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.decimals",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount = {
                title: 'BUSIN.DLB_BUSIN_MOTLOCENC_66188',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_MOTLOCENC_66188',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_RNUN861',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459RNUN43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_MOTLOCENC_66188'|translate}}",
                        'id': "VA_ININGOTONE0435_RNUN861",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.decimals",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.CreditType = {
                title: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                width: 220,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_EITY549',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_ININGOTONE0435_EITY549 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_ININGOTONE0435_EITY549_values)) {
                            $scope.vc.catalogs.VA_ININGOTONE0435_EITY549_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_ININGOTONE0435_EITY549',
                                'ca_toperacion',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_ININGOTONE0435_EITY549'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_ININGOTONE0435_EITY549_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_63", "VA_ININGOTONE0435_EITY549");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_ININGOTONE0435_EITY549_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_ITRIC1523_63", "VA_ININGOTONE0435_EITY549");
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
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459EITY95 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.CreditType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CREDITYPE_12941'|translate}}",
                        'id': "VA_ININGOTONE0435_EITY549",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_ITRIC1523_63.column.CreditType.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_ININGOTONE0435_EITY549",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_ITRIC1523_63.column.CreditType.template",
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.CreditType.validationCode}}",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification = {
                title: 'BUSIN.DLB_BUSIN_INATOIATO_87203',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_INATOIATO_87203',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_NAIC020',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459NAIC57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_INATOIATO_87203'|translate}}",
                        'id': "VA_ININGOTONE0435_NAIC020",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.OperationQualification = {
                title: 'BUSIN.DLB_BUSIN_TELRETSCO_11552',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_EATI897',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459EATI72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.OperationQualification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_ININGOTONE0435_EATI897",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.OperationQualification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.OperationQualification.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.OperationQualification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage = {
                title: 'BUSIN.DLB_BUSIN_PYTPEETAG_70289',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_PEEE492',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459PEEE15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_ININGOTONE0435_PEEE492",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.decimals",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.DateGranting = {
                title: 'BUSIN.DLB_BUSIN_ATDATCRED_67761',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_ATDATCRED_67761',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_DTGN107',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459DTGN73 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.DateGranting.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_ATDATCRED_67761'|translate}}",
                        'id': "VA_ININGOTONE0435_DTGN107",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.DateGranting.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.DateGranting.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.DateGranting.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.oficialOperation = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ININGOTONE0435_AORN777',
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459AORN87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.oficialOperation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_ININGOTONE0435_AORN777",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_ITRIC1523_63.column.oficialOperation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ITRIC1523_63.column.oficialOperation.format",
                        'k-decimals': "vc.viewState.QV_ITRIC1523_63.column.oficialOperation.decimals",
                        'data-cobis-group': "Group,GR_ININGOTONE04_08,0",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.oficialOperation.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.oficialOperation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ITRIC1523_63.column.Rate = {
                title: 'Rate',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459RATE39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n'",
                        'ng-disabled': "!vc.viewState.QV_ITRIC1523_63.column.Rate.enabled",
                        'ng-class': "vc.viewState.QV_ITRIC1523_63.column.Rate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'IsBase',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.IsBase.title|translate:vc.viewState.QV_ITRIC1523_63.column.IsBase.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.IsBase.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.IsBase.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459SIAL87.control,
                    template: "<input name='IsBase' type='checkbox' value='#=IsBase#' #=IsBase?checked='checked':''# disabled='disabled' data-bind='value:IsBase' ng-class='vc.viewState.QV_ITRIC1523_63.column.IsBase.element[dataItem.uid].style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.IsBase.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.IsBase.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.IsBase.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'IdOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.IdOperation.title|translate:vc.viewState.QV_ITRIC1523_63.column.IdOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.IdOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.IdOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459DPER71.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.IdOperation.element[dataItem.uid].style'>#if (IdOperation !== null) {# #=IdOperation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.IdOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.IdOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.IdOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'OperationBank',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.OperationBank.title|translate:vc.viewState.QV_ITRIC1523_63.column.OperationBank.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.OperationBank.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.OperationBank.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459EANA92.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.OperationBank.element[dataItem.uid].style'>#if (OperationBank !== null) {# #=OperationBank# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.OperationBank.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.OperationBank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.OperationBank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'RefinancingOption',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.title|translate:vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459ANOP06.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_ININGOTONE0435_ANOP470.get(dataItem.RefinancingOption).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.RefinancingOption.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'CurrencyOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.title|translate:vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459CURA87.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_ININGOTONE0435_CURA309.get(dataItem.CurrencyOperation).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.CurrencyOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'Balance',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.Balance.title|translate:vc.viewState.QV_ITRIC1523_63.column.Balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.Balance.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.Balance.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459BANC23.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.Balance.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance#, vc.viewState.QV_ITRIC1523_63.column.Balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.Balance.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.Balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.Balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'LocalCurrencyBalance',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.title|translate:vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459OCBA30.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=LocalCurrencyBalance#, vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'OriginalAmount',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.title|translate:vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459GAMO94.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=OriginalAmount#, vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.OriginalAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'LocalCurrencyAmount',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.title|translate:vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459RNUN43.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.element[dataItem.uid].style' ng-bind='kendo.toString(#=LocalCurrencyAmount#, vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.LocalCurrencyAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'CreditType',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.CreditType.title|translate:vc.viewState.QV_ITRIC1523_63.column.CreditType.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.CreditType.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.CreditType.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459EITY95.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.CreditType.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_ININGOTONE0435_EITY549.get(dataItem.CreditType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.CreditType.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.CreditType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.CreditType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'InternalCustomerClassification',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.title|translate:vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459NAIC57.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.element[dataItem.uid].style'>#if (InternalCustomerClassification !== null) {# #=InternalCustomerClassification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.InternalCustomerClassification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'OperationQualification',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.OperationQualification.title|translate:vc.viewState.QV_ITRIC1523_63.column.OperationQualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.OperationQualification.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.OperationQualification.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459EATI72.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.OperationQualification.element[dataItem.uid].style'>#if (OperationQualification !== null) {# #=OperationQualification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.OperationQualification.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.OperationQualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.OperationQualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'PayoutPercentage',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.title|translate:vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459PEEE15.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=PayoutPercentage#, vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.PayoutPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'DateGranting',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.DateGranting.title|translate:vc.viewState.QV_ITRIC1523_63.column.DateGranting.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.DateGranting.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.DateGranting.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459DTGN73.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.DateGranting.element[dataItem.uid].style'>#if (DateGranting !== null) {# #=DateGranting# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.DateGranting.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.DateGranting.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.DateGranting.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'oficialOperation',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.oficialOperation.title|translate:vc.viewState.QV_ITRIC1523_63.column.oficialOperation.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.oficialOperation.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.oficialOperation.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459AORN87.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.oficialOperation.element[dataItem.uid].style' ng-bind='kendo.toString(#=oficialOperation#, vc.viewState.QV_ITRIC1523_63.column.oficialOperation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.oficialOperation.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.oficialOperation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.oficialOperation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                    field: 'Rate',
                    title: '{{vc.viewState.QV_ITRIC1523_63.column.Rate.title|translate:vc.viewState.QV_ITRIC1523_63.column.Rate.titleArgs}}',
                    width: $scope.vc.viewState.QV_ITRIC1523_63.column.Rate.width,
                    format: $scope.vc.viewState.QV_ITRIC1523_63.column.Rate.format,
                    editor: $scope.vc.grids.QV_ITRIC1523_63.AT_RNA459RATE39.control,
                    template: "<span ng-class='vc.viewState.QV_ITRIC1523_63.column.Rate.element[dataItem.uid].style' ng-bind='kendo.toString(#=Rate#, vc.viewState.QV_ITRIC1523_63.column.Rate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ITRIC1523_63.column.Rate.style",
                        "title": "{{vc.viewState.QV_ITRIC1523_63.column.Rate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ITRIC1523_63.column.Rate.hidden
                });
            }
            $scope.vc.grids.QV_ITRIC1523_63.columns.push({
                command: {
                    template: "<span class='cb-commands'></span>"
                },
                attributes: {
                    "class": "btn-toolbar"
                },
                width: 1
            });
            $scope.vc.viewState.QV_ITRIC1523_63.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                },
                CEQV_201_QV_ITRIC1523_63_992: {
                    visible: true
                },
                CEQV_201_QV_ITRIC1523_63_978: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_ITRIC1523_63.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-show = 'vc.viewState.QV_ITRIC1523_63.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_ININGOTONE04_35.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_ITRIC1523_63_992",
                "text": "{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}",
                "template": "<button id='CEQV_201_QV_ITRIC1523_63_992' ng-show='vc.viewState.QV_ITRIC1523_63.toolbar.CEQV_201_QV_ITRIC1523_63_992.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_ITRIC1523_63_992\",\"RefinancingOperations\")' class='btn btn-default cb-grid-button cb-btn-custom-cmdnew' title=\"{{'BUSIN.DLB_BUSIN_NUEVOOPAM_52575'|translate}}\"> #: text #</button>"
            }, {
                "name": "CEQV_201_QV_ITRIC1523_63_978",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_ITRIC1523_63_978' ng-show='vc.viewState.QV_ITRIC1523_63.toolbar.CEQV_201_QV_ITRIC1523_63_978.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_ITRIC1523_63_978\",\"RefinancingOperations\")' class='btn btn-default cb-grid-button cb-btn-custom-deletecommand' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }]; //ViewState - Container: Datos de Aprovación
            $scope.vc.createViewState({
                id: "VC_APVER36_GPOOE_100",
                hasId: true,
                componentStyle: "",
                label: 'Datos de Aprovaci\u00f3n',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor de Pestañas
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_04",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CACLATNDX_54807",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Pestaña para Politicas
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_07",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_POLTICASY_60350",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Politicas
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_10",
                hasId: true,
                componentStyle: "",
                label: 'Politicas',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Policy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    mnemonic: {
                        type: "string",
                        editable: true
                    },
                    description: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.Policy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUEROLCY_4480();
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
                    model: $scope.vc.types.Policy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QUERO4480_42").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUEROLCY_4480 = $scope.vc.model.Policy;
            $scope.vc.trackers.Policy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Policy);
            $scope.vc.model.Policy.bind('change', function(e) {
                $scope.vc.trackers.Policy.track(e);
            });
            $scope.vc.grids.QV_QUERO4480_42 = {};
            $scope.vc.grids.QV_QUERO4480_42.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_QUERO4480_42) && expandedRowUidActual !== expandedRowUid_QV_QUERO4480_42) {
                    var gridWidget = $('#QV_QUERO4480_42').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_QUERO4480_42 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_QUERO4480_42 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_QUERO4480_42 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_QUERO4480_42);
                }
                expandedRowUid_QV_QUERO4480_42 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_QUERO4480_42', args);
                if (angular.isDefined($scope.vc.grids.QV_QUERO4480_42.view)) {
                    $scope.vc.grids.QV_QUERO4480_42.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_QUERO4480_42.customView)) {
                    $scope.vc.grids.QV_QUERO4480_42.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_QUERO4480_42'/>"
            };
            $scope.vc.grids.QV_QUERO4480_42.queryId = 'Q_QUEROLCY_4480';
            $scope.vc.viewState.QV_QUERO4480_42 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUERO4480_42.column = {};
            var expandedRowUid_QV_QUERO4480_42;
            $scope.vc.grids.QV_QUERO4480_42.events = {
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
                    $scope.vc.trackers.Policy.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUERO4480_42.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QUERO4480_42");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUERO4480_42.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUERO4480_42.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QUERO4480_42.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUERO4480_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUERO4480_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_QUERO4480_42 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUERO4480_42.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUERO4480_42.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic = {
                title: 'BUSIN.DLB_BUSIN_NEMNICOZH_18160',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUERO4480_42.AT_POL965NMNI98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 10,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUERO4480_42.column.mnemonic.enabled",
                        'ng-class': "vc.viewState.QV_QUERO4480_42.column.mnemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERO4480_42.column.description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUERO4480_42.AT_POL965DRTO65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUERO4480_42.column.description.enabled",
                        'ng-class': "vc.viewState.QV_QUERO4480_42.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERO4480_42.columns.push({
                    field: 'mnemonic',
                    title: '{{vc.viewState.QV_QUERO4480_42.column.mnemonic.title|translate:vc.viewState.QV_QUERO4480_42.column.mnemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic.width,
                    format: $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic.format,
                    editor: $scope.vc.grids.QV_QUERO4480_42.AT_POL965NMNI98.control,
                    template: "<span ng-class='vc.viewState.QV_QUERO4480_42.column.mnemonic.element[dataItem.uid].style'>#if (mnemonic !== null) {# #=mnemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERO4480_42.column.mnemonic.style",
                        "title": "{{vc.viewState.QV_QUERO4480_42.column.mnemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERO4480_42.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_QUERO4480_42.column.description.title|translate:vc.viewState.QV_QUERO4480_42.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERO4480_42.column.description.width,
                    format: $scope.vc.viewState.QV_QUERO4480_42.column.description.format,
                    editor: $scope.vc.grids.QV_QUERO4480_42.AT_POL965DRTO65.control,
                    template: "<span ng-class='vc.viewState.QV_QUERO4480_42.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERO4480_42.column.description.style",
                        "title": "{{vc.viewState.QV_QUERO4480_42.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERO4480_42.column.description.hidden
                });
            }
            $scope.vc.viewState.QV_QUERO4480_42.toolbar = {}
            $scope.vc.grids.QV_QUERO4480_42.toolbar = [];
            //ViewState - Group: Detalle Politicas
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_11",
                hasId: true,
                componentStyle: "",
                htmlSection: true,
                label: 'Detalle Politicas',
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.VariablePolicy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    },
                    VariableDescription: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.VariablePolicy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UEVRBPOC_5831();
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
                    model: $scope.vc.types.VariablePolicy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UEVRB5831_12").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UEVRBPOC_5831 = $scope.vc.model.VariablePolicy;
            $scope.vc.trackers.VariablePolicy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariablePolicy);
            $scope.vc.model.VariablePolicy.bind('change', function(e) {
                $scope.vc.trackers.VariablePolicy.track(e);
            });
            $scope.vc.grids.QV_UEVRB5831_12 = {};
            $scope.vc.grids.QV_UEVRB5831_12.queryId = 'Q_UEVRBPOC_5831';
            $scope.vc.viewState.QV_UEVRB5831_12 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column = {};
            $scope.vc.grids.QV_UEVRB5831_12.events = {
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
                    $scope.vc.trackers.VariablePolicy.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UEVRB5831_12.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UEVRB5831_12");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UEVRB5831_12.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UEVRB5831_12.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UEVRB5831_12.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UEVRB5831_12 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UEVRB5831_12 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UEVRB5831_12.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UEVRB5831_12.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396ILEA09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396VILV60 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396BSCT95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableDescription.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableName.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396ILEA09.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableName.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableValue.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396VILV60.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableDescription',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableDescription.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396BSCT95.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableDescription.element[dataItem.uid].style'>#if (VariableDescription !== null) {# #=VariableDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableDescription.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.hidden
                });
            }
            $scope.vc.viewState.QV_UEVRB5831_12.toolbar = {}
            $scope.vc.grids.QV_UEVRB5831_12.toolbar = [];
            //ViewState - Group: Pestaña para Category
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_05",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RUBROSYTF_19129",
                haslabelArgs: true,
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
                        editable: true
                    },
                    MethodOfPayment: {
                        type: "string",
                        editable: true
                    },
                    Reference: {
                        type: "string",
                        editable: true
                    },
                    Sign: {
                        type: "string",
                        editable: true
                    },
                    Spread: {
                        type: "number",
                        editable: true
                    },
                    Value: {
                        type: "number",
                        editable: true
                    },
                    Percentage: {
                        type: "number",
                        editable: true
                    },
                    Funded: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.Category = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UYCTEGOY_6570();
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
                    model: $scope.vc.types.Category
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UYCTE6570_82").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UYCTEGOY_6570 = $scope.vc.model.Category;
            $scope.vc.trackers.Category = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Category);
            $scope.vc.model.Category.bind('change', function(e) {
                $scope.vc.trackers.Category.track(e);
            });
            $scope.vc.grids.QV_UYCTE6570_82 = {};
            $scope.vc.grids.QV_UYCTE6570_82.queryId = 'Q_UYCTEGOY_6570';
            $scope.vc.viewState.QV_UYCTE6570_82 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column = {};
            $scope.vc.grids.QV_UYCTE6570_82.events = {
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
                    $scope.vc.trackers.Category.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UYCTE6570_82.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UYCTE6570_82");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UYCTE6570_82.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UYCTE6570_82.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UYCTE6570_82.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UYCTE6570_82 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UYCTE6570_82 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UYCTE6570_82.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UYCTE6570_82.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UYCTE6570_82.column.Concept = {
                title: 'Concepto',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957COEP74 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Concept.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Concept.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment = {
                title: 'BUSIN.DLB_BUSIN_FORMDEPAG_44742',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957MEON23 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.Reference = {
                title: 'Referencial',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957EENE30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Reference.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Reference.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.Sign = {
                title: 'Signo',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957SIGN95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 2,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Sign.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Sign.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.Spread = {
                title: 'Spread',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957SPRD31 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 13,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n'",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Spread.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Spread.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.Value = {
                title: 'Valor',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957VALU37 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 53,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n'",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Value.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Value.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.Percentage = {
                title: 'Porcentaje',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957PENG62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 13,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n'",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Percentage.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Percentage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UYCTE6570_82.column.Funded = {
                title: 'Financiado',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957FNDD20 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 3,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UYCTE6570_82.column.Funded.enabled",
                        'ng-class': "vc.viewState.QV_UYCTE6570_82.column.Funded.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Concept',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Concept.title|translate:vc.viewState.QV_UYCTE6570_82.column.Concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Concept.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Concept.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957COEP74.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Concept.element[dataItem.uid].style'>#if (Concept !== null) {# #=Concept# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Concept.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'MethodOfPayment',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.title|translate:vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957MEON23.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.element[dataItem.uid].style'>#if (MethodOfPayment !== null) {# #=MethodOfPayment# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.MethodOfPayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Reference',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Reference.title|translate:vc.viewState.QV_UYCTE6570_82.column.Reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Reference.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Reference.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957EENE30.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Reference.element[dataItem.uid].style'>#if (Reference !== null) {# #=Reference# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Reference.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Sign',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Sign.title|translate:vc.viewState.QV_UYCTE6570_82.column.Sign.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Sign.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Sign.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957SIGN95.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Sign.element[dataItem.uid].style'>#if (Sign !== null) {# #=Sign# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Sign.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Sign.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Sign.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Spread',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Spread.title|translate:vc.viewState.QV_UYCTE6570_82.column.Spread.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Spread.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Spread.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957SPRD31.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Spread.element[dataItem.uid].style' ng-bind='kendo.toString(#=Spread#, vc.viewState.QV_UYCTE6570_82.column.Spread.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Spread.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Spread.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Spread.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Value',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Value.title|translate:vc.viewState.QV_UYCTE6570_82.column.Value.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Value.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Value.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957VALU37.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Value.element[dataItem.uid].style' ng-bind='kendo.toString(#=Value#, vc.viewState.QV_UYCTE6570_82.column.Value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Value.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Value.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Percentage',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Percentage.title|translate:vc.viewState.QV_UYCTE6570_82.column.Percentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Percentage.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Percentage.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957PENG62.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Percentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=Percentage#, vc.viewState.QV_UYCTE6570_82.column.Percentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Percentage.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Percentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Percentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UYCTE6570_82.columns.push({
                    field: 'Funded',
                    title: '{{vc.viewState.QV_UYCTE6570_82.column.Funded.title|translate:vc.viewState.QV_UYCTE6570_82.column.Funded.titleArgs}}',
                    width: $scope.vc.viewState.QV_UYCTE6570_82.column.Funded.width,
                    format: $scope.vc.viewState.QV_UYCTE6570_82.column.Funded.format,
                    editor: $scope.vc.grids.QV_UYCTE6570_82.AT_CAT957FNDD20.control,
                    template: "<span ng-class='vc.viewState.QV_UYCTE6570_82.column.Funded.element[dataItem.uid].style'>#if (Funded !== null) {# #=Funded# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UYCTE6570_82.column.Funded.style",
                        "title": "{{vc.viewState.QV_UYCTE6570_82.column.Funded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UYCTE6570_82.column.Funded.hidden
                });
            }
            $scope.vc.viewState.QV_UYCTE6570_82.toolbar = {}
            $scope.vc.grids.QV_UYCTE6570_82.toolbar = [];
            //ViewState - Group: Pestaña para Desembolso
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_06",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FRMADESOO_24698",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DisbursementForms = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    DisbursemenTrate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementForms", "DisbursemenTrate", ''),
                        validation: {
                            DisbursemenTrateRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementForms", "Currency", ''),
                        validation: {
                            CurrencyRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DisbursementForms", "Amount", 0),
                        validation: {
                            AmountRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    ContributionRate: {
                        type: "string",
                        editable: true
                    },
                    Quote: {
                        type: "number",
                        editable: true
                    },
                    Account: {
                        type: "string",
                        editable: true
                    },
                    Beneficiary: {
                        type: "string",
                        editable: true
                    },
                    Observations: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.DisbursementForms = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QURDMNFR_9228();
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
                    model: $scope.vc.types.DisbursementForms
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QURDM9228_60").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QURDMNFR_9228 = $scope.vc.model.DisbursementForms;
            $scope.vc.trackers.DisbursementForms = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DisbursementForms);
            $scope.vc.model.DisbursementForms.bind('change', function(e) {
                $scope.vc.trackers.DisbursementForms.track(e);
            });
            $scope.vc.grids.QV_QURDM9228_60 = {};
            $scope.vc.grids.QV_QURDM9228_60.queryId = 'Q_QURDMNFR_9228';
            $scope.vc.viewState.QV_QURDM9228_60 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QURDM9228_60.column = {};
            $scope.vc.grids.QV_QURDM9228_60.events = {
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
                    $scope.vc.trackers.DisbursementForms.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QURDM9228_60.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QURDM9228_60");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QURDM9228_60.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QURDM9228_60.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QURDM9228_60.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QURDM9228_60 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QURDM9228_60 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QURDM9228_60.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QURDM9228_60.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate = {
                title: 'BUSIN.DLB_BUSIN_TPESEMOLO_16200',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4806_SNTT435',
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527SNTT15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4806_SNTT435",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TPESEMOLO_16200') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,2",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAWDW_15876',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4806_CRCY669',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4806_CRCY669 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4806_CRCY669_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4806_CRCY669_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OVECRDTRQE4806_CRCY669',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4806_CRCY669'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4806_CRCY669_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QURDM9228_60", "VA_OVECRDTRQE4806_CRCY669");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4806_CRCY669_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QURDM9228_60", "VA_OVECRDTRQE4806_CRCY669");
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
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527CRCY76 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4806_CRCY669",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QURDM9228_60.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4806_CRCY669",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QURDM9228_60.column.Currency.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_MONEDAWDW_15876') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QURDM9228_60.column.Currency.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,2",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.Amount = {
                title: 'BUSIN.DLB_BUSIN_MONTOFVFP_36531',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4806_MOUT806',
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527MOUT62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Amount.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4806_MOUT806",
                        'maxlength': 28,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_MONTOFVFP_36531') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QURDM9228_60.column.Amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURDM9228_60.column.Amount.format",
                        'k-decimals': "vc.viewState.QV_QURDM9228_60.column.Amount.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,2",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Amount.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.Amount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.ContributionRate = {
                title: 'BUSIN.DLB_BUSIN_POOTIZCIN_28220',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527CNRE01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 1,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.ContributionRate.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.ContributionRate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.Quote = {
                title: 'BUSIN.DLB_BUSIN_COTIZACIN_81787',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527UOTE58 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 11,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n'",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Quote.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.Quote.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.Account = {
                title: 'Cuenta',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527CUNT68 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 24,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Account.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.Account.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.Beneficiary = {
                title: 'Beneficiario',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527NEAR05 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Beneficiary.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.Beneficiary.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURDM9228_60.column.Observations = {
                title: 'Observaciones',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QURDM9228_60.AT_DBR527BEIS98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QURDM9228_60.column.Observations.enabled",
                        'ng-class': "vc.viewState.QV_QURDM9228_60.column.Observations.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'DisbursemenTrate',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.title|translate:vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527SNTT15.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.element[dataItem.uid].style'>#if (DisbursemenTrate !== null) {# #=DisbursemenTrate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.DisbursemenTrate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.Currency.title|translate:vc.viewState.QV_QURDM9228_60.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.Currency.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.Currency.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527CRCY76.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4806_CRCY669.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.Currency.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'Amount',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.Amount.title|translate:vc.viewState.QV_QURDM9228_60.column.Amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.Amount.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.Amount.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527MOUT62.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.Amount.element[dataItem.uid].style' ng-bind='kendo.toString(#=Amount#, vc.viewState.QV_QURDM9228_60.column.Amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.Amount.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.Amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.Amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'ContributionRate',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.ContributionRate.title|translate:vc.viewState.QV_QURDM9228_60.column.ContributionRate.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.ContributionRate.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.ContributionRate.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527CNRE01.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.ContributionRate.element[dataItem.uid].style'>#if (ContributionRate !== null) {# #=ContributionRate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.ContributionRate.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.ContributionRate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.ContributionRate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'Quote',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.Quote.title|translate:vc.viewState.QV_QURDM9228_60.column.Quote.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.Quote.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.Quote.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527UOTE58.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.Quote.element[dataItem.uid].style' ng-bind='kendo.toString(#=Quote#, vc.viewState.QV_QURDM9228_60.column.Quote.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.Quote.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.Quote.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.Quote.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'Account',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.Account.title|translate:vc.viewState.QV_QURDM9228_60.column.Account.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.Account.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.Account.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527CUNT68.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.Account.element[dataItem.uid].style'>#if (Account !== null) {# #=Account# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.Account.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.Account.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.Account.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'Beneficiary',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.Beneficiary.title|translate:vc.viewState.QV_QURDM9228_60.column.Beneficiary.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.Beneficiary.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.Beneficiary.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527NEAR05.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.Beneficiary.element[dataItem.uid].style'>#if (Beneficiary !== null) {# #=Beneficiary# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.Beneficiary.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.Beneficiary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.Beneficiary.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURDM9228_60.columns.push({
                    field: 'Observations',
                    title: '{{vc.viewState.QV_QURDM9228_60.column.Observations.title|translate:vc.viewState.QV_QURDM9228_60.column.Observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURDM9228_60.column.Observations.width,
                    format: $scope.vc.viewState.QV_QURDM9228_60.column.Observations.format,
                    editor: $scope.vc.grids.QV_QURDM9228_60.AT_DBR527BEIS98.control,
                    template: "<span ng-class='vc.viewState.QV_QURDM9228_60.column.Observations.element[dataItem.uid].style'>#if (Observations !== null) {# #=Observations# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURDM9228_60.column.Observations.style",
                        "title": "{{vc.viewState.QV_QURDM9228_60.column.Observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURDM9228_60.column.Observations.hidden
                });
            }
            $scope.vc.viewState.QV_QURDM9228_60.toolbar = {}
            $scope.vc.grids.QV_QURDM9228_60.toolbar = []; //ViewState - Group: Pestaña para Plan de Pagos
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_13",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLANDEPAO_31165",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GeneralData = {
                OperationType: $scope.vc.channelDefaultValues("GeneralData", "OperationType"),
                Currency: $scope.vc.channelDefaultValues("GeneralData", "Currency"),
                Amount: $scope.vc.channelDefaultValues("GeneralData", "Amount"),
                Rate: $scope.vc.channelDefaultValues("GeneralData", "Rate"),
                DateValueHome: $scope.vc.channelDefaultValues("GeneralData", "DateValueHome"),
                ValueEndDate: $scope.vc.channelDefaultValues("GeneralData", "ValueEndDate"),
                ExpirationFirstQuota: $scope.vc.channelDefaultValues("GeneralData", "ExpirationFirstQuota")
            };
            //ViewState - Group: Datos Generales
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_14",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OSGENERAE_41401",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralData, Attribute: OperationType
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4814_PANE672",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIOPERACI_88193",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralData, Attribute: Currency
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4814_UREC490",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAQAQ_04700",
                haslabelArgs: true,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4814_UREC490 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OVECRDTRQE4814_UREC490', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4814_UREC490'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4814_UREC490");
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
            //ViewState - Entity: GeneralData, Attribute: Amount
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4814_AMON701",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONTOFVFP_36531",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralData, Attribute: Rate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4814_RATE697",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TASAGRLAC_24263",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralData, Attribute: DateValueHome
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4814_DAUE190",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FECORINIO_74083",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GeneralData, Attribute: ValueEndDate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4814_UEDE647",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EHAVALRFN_49354",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.TableType = {
                Type: $scope.vc.channelDefaultValues("TableType", "Type"),
                FixedPaymentDate: $scope.vc.channelDefaultValues("TableType", "FixedPaymentDate"),
                PaymentDay: $scope.vc.channelDefaultValues("TableType", "PaymentDay"),
                Capital: $scope.vc.channelDefaultValues("TableType", "Capital"),
                PaymentMonthly: $scope.vc.channelDefaultValues("TableType", "PaymentMonthly"),
                FeeFinal: $scope.vc.channelDefaultValues("TableType", "FeeFinal"),
                Avoidholidays: $scope.vc.channelDefaultValues("TableType", "Avoidholidays")
            };
            //ViewState - Group: Tipo Tabla
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_15",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIPODEABL_33677",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TableType, Attribute: Type
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_TYPE916",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIPOLRXRX_31531",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4815_TYPE916 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OVECRDTRQE4815_TYPE916', 'ca_tipo_amortizacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4815_TYPE916'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4815_TYPE916");
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
            //ViewState - Entity: TableType, Attribute: FixedPaymentDate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_XAYM524",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FCHAPGOIJ_10233",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4815_XAYM524 = new kendo.data.DataSource({
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
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4815_XAYM524 !== "undefined") {}
            //ViewState - Entity: TableType, Attribute: PaymentDay
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_PYTD956",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DAPAGONDO_10805",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TableType, Attribute: Capital
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_PITL142",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CAPITALTQ_09207",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TableType, Attribute: PaymentMonthly
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_ANMY709",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MESDENPAO_77813",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4815_ANMY709 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '0',
                            value: '0'
                        }, {
                            code: '1',
                            value: '1'
                        }, {
                            code: '2',
                            value: '2'
                        }, {
                            code: '3',
                            value: '3'
                        }, {
                            code: '4',
                            value: '4'
                        }, {
                            code: '5',
                            value: '5'
                        }, {
                            code: '6',
                            value: '6'
                        }, {
                            code: '7',
                            value: '7'
                        }, {
                            code: '8',
                            value: '8'
                        }, {
                            code: '9',
                            value: '9'
                        }, {
                            code: '10',
                            value: '10'
                        }, {
                            code: '11',
                            value: '11'
                        }, {
                            code: '12',
                            value: '12'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4815_ANMY709");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: TableType, Attribute: FeeFinal
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_EFIA525",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CUTAFINAL_29932",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: TableType, Attribute: Avoidholidays
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4815_VOLA594",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ITARFERIS_77638",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Term = {
                TypeTerm: $scope.vc.channelDefaultValues("Term", "TypeTerm"),
                Term: $scope.vc.channelDefaultValues("Term", "Term"),
                TypeofFee: $scope.vc.channelDefaultValues("Term", "TypeofFee"),
                PeriodicityCapital: $scope.vc.channelDefaultValues("Term", "PeriodicityCapital"),
                PeriodicityofInterest: $scope.vc.channelDefaultValues("Term", "PeriodicityofInterest"),
                CalculationBase: $scope.vc.channelDefaultValues("Term", "CalculationBase"),
                FeeCalculationDays: $scope.vc.channelDefaultValues("Term", "FeeCalculationDays")
            };
            //ViewState - Group: Plazo
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_17",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Term, Attribute: TypeTerm
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_PEEM344",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIPOPLAZO_08286",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4817_PEEM344 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OVECRDTRQE4817_PEEM344', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4817_PEEM344'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4817_PEEM344");
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
            //ViewState - Entity: Term, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_TERM522",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Term, Attribute: TypeofFee
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_POFE759",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIPOCUOTA_40772",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4817_POFE759 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OVECRDTRQE4817_POFE759', 'ca_tdividendo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4817_POFE759'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4817_POFE759");
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
            //ViewState - Entity: Term, Attribute: PeriodicityCapital
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_ICIA015",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PRODCACAL_98454",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Term, Attribute: PeriodicityofInterest
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_POYI389",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PRIIIDDNS_86574",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Term, Attribute: CalculationBase
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_CLUA993",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BASECLCUL_84618",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4817_CLUA993 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '360',
                            value: '360'
                        }, {
                            code: '365',
                            value: '365'
                        }, {
                            code: '366',
                            value: '366'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4817_CLUA993 !== "undefined") {}
            //ViewState - Entity: Term, Attribute: FeeCalculationDays
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4817_FAID036",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ASLOCUOTA_14683",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4817_FAID036 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'E',
                            value: 'Comercial'
                        }, {
                            code: 'R',
                            value: 'Calendario'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4817_FAID036 !== "undefined") {}
            $scope.vc.model.GracePeriods = {
                GracePeriodsCapital: $scope.vc.channelDefaultValues("GracePeriods", "GracePeriodsCapital"),
                GracePeriodsInterest: $scope.vc.channelDefaultValues("GracePeriods", "GracePeriodsInterest"),
                ShapeRecoveryGracia: $scope.vc.channelDefaultValues("GracePeriods", "ShapeRecoveryGracia"),
                GraceDaysofMora: $scope.vc.channelDefaultValues("GracePeriods", "GraceDaysofMora")
            };
            //ViewState - Group: Periodos de Gracia
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_18",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ERDDGRACI_69249",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GracePeriods, Attribute: GracePeriodsCapital
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4818_APAI734",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ERIOGAPIL_92412",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GracePeriods, Attribute: GracePeriodsInterest
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4818_RACE218",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RIDGAIINS_94307",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GracePeriods, Attribute: ShapeRecoveryGracia
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4818_ECVE659",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RDCURCEAA_11645",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4818_ECVE659 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: '1',
                            value: 'En primera cuota'
                        }, {
                            code: '2',
                            value: 'En cuotas Restantes'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4818_ECVE659 !== "undefined") {}
            //ViewState - Entity: GracePeriods, Attribute: GraceDaysofMora
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4818_GRDR974",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DGRACIASO_83463",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Tabla Amortización
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_16",
                hasId: true,
                componentStyle: "",
                htmlSection: true,
                label: "BUSIN.DLB_BUSIN_ADEMTACIN_10056",
                haslabelArgs: true,
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
                        editable: true
                    },
                    ExpirationDate: {
                        type: "date",
                        editable: true
                    },
                    Balance: {
                        type: "number",
                        editable: true
                    },
                    Item1: {
                        type: "number",
                        editable: true
                    },
                    Item2: {
                        type: "number",
                        editable: true
                    },
                    Item3: {
                        type: "number",
                        editable: true
                    },
                    Item4: {
                        type: "number",
                        editable: true
                    },
                    Item5: {
                        type: "number",
                        editable: true
                    },
                    Item6: {
                        type: "number",
                        editable: true
                    },
                    Item7: {
                        type: "number",
                        editable: true
                    },
                    Item8: {
                        type: "number",
                        editable: true
                    },
                    Item9: {
                        type: "number",
                        editable: true
                    },
                    Item10: {
                        type: "number",
                        editable: true
                    },
                    Item11: {
                        type: "number",
                        editable: true
                    },
                    Item12: {
                        type: "number",
                        editable: true
                    },
                    Item13: {
                        type: "number",
                        editable: true
                    },
                    Fee: {
                        type: "number",
                        editable: true
                    }
                }
            });;
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
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.AmortizationTableItem
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
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
            $scope.vc.grids.QV_QUYOI3312_16.events = {
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
                    $scope.vc.trackers.AmortizationTableItem.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUYOI3312_16.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QUYOI3312_16");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUYOI3312_16.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUYOI3312_16.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QUYOI3312_16.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUYOI3312_16 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUYOI3312_16 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUYOI3312_16.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUYOI3312_16.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend = {
                title: 'BUSIN.DLB_BUSIN_NMEROPAWQ_57199',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884DVDE03 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 1,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Dividend.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Dividend.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.ExpirationDate = {
                title: 'BUSIN.DLB_BUSIN_FEHVNCINO_77589',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884EPTI34 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormatPlaceholder}}",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Balance = {
                title: 'BUSIN.DLB_BUSIN_LDOECITAL_77904',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884BAAC22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Balance.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Balance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item1 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM164 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item1.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item1.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item2 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE219 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item2.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item2.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item3 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM64 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item3.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item3.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item4 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM481 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item4.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item4.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item5 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITEM43 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item5.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item5.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item6 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM603 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item6.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item6.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item7 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE729 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item7.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item7.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item8 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM887 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item8.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item8.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item9 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM984 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item9.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item9.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item10 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TE1034 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item10.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item10.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item11 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM148 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item11.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item11.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item12 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884TEM155 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item12.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item12.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Item13 = {
                title: 'BUSIN.DLB_BUSIN_RUBROSYTF_19129',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITM128 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Item13.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Item13.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUYOI3312_16.column.Fee = {
                title: 'BUSIN.DLB_BUSIN_CUOTADPJP_65632',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884SHRE57 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 4,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_QUYOI3312_16.column.Fee.enabled",
                        'ng-class': "vc.viewState.QV_QUYOI3312_16.column.Fee.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUYOI3312_16.columns.push({
                    field: 'Dividend',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Dividend.title|translate:vc.viewState.QV_QUYOI3312_16.column.Dividend.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Dividend.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884DVDE03.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Dividend.element[dataItem.uid].style' ng-bind='kendo.toString(#=Dividend#, vc.viewState.QV_QUYOI3312_16.column.Dividend.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.ExpirationDate.element[dataItem.uid].style'>#=((ExpirationDate !== null) ? kendo.toString(ExpirationDate, 'd') : '')#</span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Balance.element[dataItem.uid].style' ng-bind='kendo.toString(#=Balance#, vc.viewState.QV_QUYOI3312_16.column.Balance.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item1.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item1#, vc.viewState.QV_QUYOI3312_16.column.Item1.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item2.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item2#, vc.viewState.QV_QUYOI3312_16.column.Item2.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item3.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item3#, vc.viewState.QV_QUYOI3312_16.column.Item3.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item4.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item4#, vc.viewState.QV_QUYOI3312_16.column.Item4.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item5.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item5#, vc.viewState.QV_QUYOI3312_16.column.Item5.format)'></span>",
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
                    field: 'Item6',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item6.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item6.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item6.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884IEM603.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item6.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item6#, vc.viewState.QV_QUYOI3312_16.column.Item6.format)'></span>",
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
                    field: 'Item7',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Item7.title|translate:vc.viewState.QV_QUYOI3312_16.column.Item7.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Item7.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884ITE729.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item7.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item7#, vc.viewState.QV_QUYOI3312_16.column.Item7.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item8.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item8#, vc.viewState.QV_QUYOI3312_16.column.Item8.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item9.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item9#, vc.viewState.QV_QUYOI3312_16.column.Item9.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item10.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item10#, vc.viewState.QV_QUYOI3312_16.column.Item10.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item11.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item11#, vc.viewState.QV_QUYOI3312_16.column.Item11.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item12.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item12#, vc.viewState.QV_QUYOI3312_16.column.Item12.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Item13.element[dataItem.uid].style' ng-bind='kendo.toString(#=Item13#, vc.viewState.QV_QUYOI3312_16.column.Item13.format)'></span>",
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
                    field: 'Fee',
                    title: '{{vc.viewState.QV_QUYOI3312_16.column.Fee.title|translate:vc.viewState.QV_QUYOI3312_16.column.Fee.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.width,
                    format: $scope.vc.viewState.QV_QUYOI3312_16.column.Fee.format,
                    editor: $scope.vc.grids.QV_QUYOI3312_16.AT_MRI884SHRE57.control,
                    template: "<span ng-class='vc.viewState.QV_QUYOI3312_16.column.Fee.element[dataItem.uid].style' ng-bind='kendo.toString(#=Fee#, vc.viewState.QV_QUYOI3312_16.column.Fee.format)'></span>",
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
            $scope.vc.viewState.QV_QUYOI3312_16.toolbar = {}
            $scope.vc.grids.QV_QUYOI3312_16.toolbar = [];
            //ViewState - Group: [Grupo Invisible]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_19",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Invisible]',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.AmortizationTableHeader = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Description: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.AmortizationTableHeader = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_HERAMITE_8244();
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
                    model: $scope.vc.types.AmortizationTableHeader
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_HERAM8244_92").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_HERAMITE_8244 = $scope.vc.model.AmortizationTableHeader;
            $scope.vc.trackers.AmortizationTableHeader = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationTableHeader);
            $scope.vc.model.AmortizationTableHeader.bind('change', function(e) {
                $scope.vc.trackers.AmortizationTableHeader.track(e);
            });
            $scope.vc.grids.QV_HERAM8244_92 = {};
            $scope.vc.grids.QV_HERAM8244_92.queryId = 'Q_HERAMITE_8244';
            $scope.vc.viewState.QV_HERAM8244_92 = {
                style: undefined
            };
            $scope.vc.viewState.QV_HERAM8244_92.column = {};
            $scope.vc.grids.QV_HERAM8244_92.events = {
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
                    $scope.vc.trackers.AmortizationTableHeader.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_HERAM8244_92.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_HERAM8244_92");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_HERAM8244_92.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_HERAM8244_92.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_HERAM8244_92.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_HERAM8244_92 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_HERAM8244_92 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_HERAM8244_92.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_HERAM8244_92.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_HERAM8244_92.column.Description = {
                title: 'Description',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            $scope.vc.viewState.QV_HERAM8244_92.toolbar = {}
            $scope.vc.grids.QV_HERAM8244_92.toolbar = []; //ViewState - Group: Pestaña de Excepciones
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_08",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EXCEPCONS_52292",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Excepciones
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_24",
                hasId: true,
                componentStyle: "",
                label: 'Excepciones',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_26",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Exceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    mnemonic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "mnemonic", ''),
                        validation: {
                            mnemonicRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "description", ''),
                        validation: {
                            descriptionRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    detail: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "detail", '')
                    },
                    Aproved: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Aproved", false),
                        validation: {
                            AprovedRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });;
            $scope.vc.model.Exceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UERXCPTS_4756();
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
                    model: $scope.vc.types.Exceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UERXC4756_18").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UERXCPTS_4756 = $scope.vc.model.Exceptions;
            $scope.vc.trackers.Exceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Exceptions);
            $scope.vc.model.Exceptions.bind('change', function(e) {
                $scope.vc.trackers.Exceptions.track(e);
            });
            $scope.vc.grids.QV_UERXC4756_18 = {};
            $scope.vc.grids.QV_UERXC4756_18.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_UERXC4756_18) && expandedRowUidActual !== expandedRowUid_QV_UERXC4756_18) {
                    var gridWidget = $('#QV_UERXC4756_18').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_UERXC4756_18);
                }
                expandedRowUid_QV_UERXC4756_18 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_UERXC4756_18', args);
                if (angular.isDefined($scope.vc.grids.QV_UERXC4756_18.view)) {
                    $scope.vc.grids.QV_UERXC4756_18.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_UERXC4756_18.customView)) {
                    $scope.vc.grids.QV_UERXC4756_18.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_UERXC4756_18'/>"
            };
            $scope.vc.grids.QV_UERXC4756_18.queryId = 'Q_UERXCPTS_4756';
            $scope.vc.viewState.QV_UERXC4756_18 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UERXC4756_18.column = {};
            var expandedRowUid_QV_UERXC4756_18;
            $scope.vc.grids.QV_UERXC4756_18.events = {
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
                    $scope.vc.trackers.Exceptions.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UERXC4756_18.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UERXC4756_18");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UERXC4756_18 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UERXC4756_18 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_UERXC4756_18.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_UERXC4756_18.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_UERXC4756_18.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Exceptions",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_UERXC4756_18", args);
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
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_UERXC4756_18 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UERXC4756_18.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UERXC4756_18.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic = {
                title: 'BUSIN.DLB_BUSIN_NEMNICOZH_18160',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4826_NONI821',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513NONI25 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.mnemonic.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4826_NONI821",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_NEMNICOZH_18160') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.mnemonic.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_24,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.mnemonic.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.mnemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4826_RTIO046',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513RTIO01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4826_RTIO046",
                        'maxlength': 50,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_DESCRIPCI_06123') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_24,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.description.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.detail = {
                title: 'BUSIN.DLB_BUSIN_DETAILVPQ_18459',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4826_DETA006',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513DETA22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.detail.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4826_DETA006",
                        'maxlength': 500,
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.detail.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_24,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.detail.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.detail.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.Aproved = {
                title: 'BUSIN.DLB_BUSIN_AUTORIZAR_89338',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4826_EULT340',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513EULT52 = {
                control: function(container, options) {
                    $scope.options_QV_UERXC4756_18 = options;
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Aproved.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4826_EULT340",
                        'ng-class': 'vc.viewState.QV_UERXC4756_18.column.Aproved.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'mnemonic',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.mnemonic.title|translate:vc.viewState.QV_UERXC4756_18.column.mnemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513NONI25.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.mnemonic.element[dataItem.uid].style'>#if (mnemonic !== null) {# #=mnemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.mnemonic.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.mnemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.description.title|translate:vc.viewState.QV_UERXC4756_18.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.description.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.description.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513RTIO01.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.description.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'detail',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.detail.title|translate:vc.viewState.QV_UERXC4756_18.column.detail.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.detail.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.detail.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513DETA22.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.detail.element[dataItem.uid].style'>#if (detail !== null) {# #=detail# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.detail.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.detail.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.detail.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'Aproved',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.Aproved.title|translate:vc.viewState.QV_UERXC4756_18.column.Aproved.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_UERXC4756_18', 'Aproved', $scope.vc.grids.QV_UERXC4756_18.AT_EXC513EULT52.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_UERXC4756_18', 'Aproved'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.Aproved.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.Aproved.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.hidden
                });
            }
            $scope.vc.viewState.QV_UERXC4756_18.toolbar = {}
            $scope.vc.grids.QV_UERXC4756_18.toolbar = [];
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_27",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4827_0000833",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AUTORIZAR_89338",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Detalle de Excepciones
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_25",
                hasId: true,
                componentStyle: "",
                htmlSection: true,
                label: 'Detalle de Excepciones',
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.VariableExceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    },
                    VariableDescription: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.VariableExceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_EAIBLEEP_2309();
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
                    model: $scope.vc.types.VariableExceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_EAIBL2309_87").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EAIBLEEP_2309 = $scope.vc.model.VariableExceptions;
            $scope.vc.trackers.VariableExceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariableExceptions);
            $scope.vc.model.VariableExceptions.bind('change', function(e) {
                $scope.vc.trackers.VariableExceptions.track(e);
            });
            $scope.vc.grids.QV_EAIBL2309_87 = {};
            $scope.vc.grids.QV_EAIBL2309_87.queryId = 'Q_EAIBLEEP_2309';
            $scope.vc.viewState.QV_EAIBL2309_87 = {
                style: undefined
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column = {};
            $scope.vc.grids.QV_EAIBL2309_87.events = {
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
                    $scope.vc.trackers.VariableExceptions.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_EAIBL2309_87.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_EAIBL2309_87");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_EAIBL2309_87.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_EAIBL2309_87.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_EAIBL2309_87.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_EAIBL2309_87 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_EAIBL2309_87 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_EAIBL2309_87.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RSCP88 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableDescription.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableName.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableName.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableDescription',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableDescription.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RSCP88.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableDescription.element[dataItem.uid].style'>#if (VariableDescription !== null) {# #=VariableDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableDescription.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableDescription.hidden
                });
            }
            $scope.vc.viewState.QV_EAIBL2309_87.toolbar = {}
            $scope.vc.grids.QV_EAIBL2309_87.toolbar = [];
            //ViewState - Group: Pestaña para Garantías
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_09",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_GARANTASQ_18496",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Collateral = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    productValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Collateral", "productValue", 0)
                    },
                    collateralCode: {
                        type: "string",
                        editable: true
                    },
                    residualNet: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Collateral", "residualNet", 0)
                    },
                    collateralDescription: {
                        type: "string",
                        editable: true
                    },
                    dateLastAppraisal: {
                        type: "date",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.Collateral = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_YCLAERAL_9320();
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
                    model: $scope.vc.types.Collateral
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_YCLAE9320_92").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_YCLAERAL_9320 = $scope.vc.model.Collateral;
            $scope.vc.trackers.Collateral = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Collateral);
            $scope.vc.model.Collateral.bind('change', function(e) {
                $scope.vc.trackers.Collateral.track(e);
            });
            $scope.vc.grids.QV_YCLAE9320_92 = {};
            $scope.vc.grids.QV_YCLAE9320_92.queryId = 'Q_YCLAERAL_9320';
            $scope.vc.viewState.QV_YCLAE9320_92 = {
                style: undefined
            };
            $scope.vc.viewState.QV_YCLAE9320_92.column = {};
            $scope.vc.grids.QV_YCLAE9320_92.events = {
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
                    $scope.vc.trackers.Collateral.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_YCLAE9320_92.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_YCLAE9320_92");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_YCLAE9320_92.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_YCLAE9320_92.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_YCLAE9320_92.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_YCLAE9320_92 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_YCLAE9320_92 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_YCLAE9320_92.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_YCLAE9320_92.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_YCLAE9320_92.column.productValue = {
                title: 'BUSIN.DLB_BUSIN_LRODPORAE_42875',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4809_PDUV794',
                element: []
            };
            $scope.vc.grids.QV_YCLAE9320_92.AT_COL763PDUV73 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.productValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4809_PDUV794",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_YCLAE9320_92.column.productValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_YCLAE9320_92.column.productValue.format",
                        'k-decimals': "vc.viewState.QV_YCLAE9320_92.column.productValue.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,5",
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.productValue.enabled",
                        'ng-class': "vc.viewState.QV_YCLAE9320_92.column.productValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_YCLAE9320_92.column.collateralCode = {
                title: 'BUSIN.DLB_BUSIN_CIGEARNTA_66805',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_YCLAE9320_92.AT_COL763OLAD86 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 64,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.collateralCode.enabled",
                        'ng-class': "vc.viewState.QV_YCLAE9320_92.column.collateralCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_YCLAE9320_92.column.residualNet = {
                title: 'BUSIN.DLB_BUSIN_NETRESDUA_03049',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4809_DUET803',
                element: []
            };
            $scope.vc.grids.QV_YCLAE9320_92.AT_COL763DUET15 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.residualNet.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4809_DUET803",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_YCLAE9320_92.column.residualNet.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_YCLAE9320_92.column.residualNet.format",
                        'k-decimals': "vc.viewState.QV_YCLAE9320_92.column.residualNet.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,5",
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.residualNet.enabled",
                        'ng-class': "vc.viewState.QV_YCLAE9320_92.column.residualNet.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_YCLAE9320_92.column.collateralDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_YCLAE9320_92.AT_COL763CLAP75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 255,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.collateralDescription.enabled",
                        'ng-class': "vc.viewState.QV_YCLAE9320_92.column.collateralDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal = {
                title: 'BUSIN.DLB_BUSIN_HAELIMALU_07421',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "d",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_YCLAE9320_92.AT_COL763TPRL18 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'kendo-ext-date-picker': "",
                        placeholder: "{{dateFormatPlaceholder}}",
                        'ng-disabled': "!vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.enabled",
                        'ng-class': "vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_YCLAE9320_92.columns.push({
                    field: 'productValue',
                    title: '{{vc.viewState.QV_YCLAE9320_92.column.productValue.title|translate:vc.viewState.QV_YCLAE9320_92.column.productValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_YCLAE9320_92.column.productValue.width,
                    format: $scope.vc.viewState.QV_YCLAE9320_92.column.productValue.format,
                    editor: $scope.vc.grids.QV_YCLAE9320_92.AT_COL763PDUV73.control,
                    template: "<span ng-class='vc.viewState.QV_YCLAE9320_92.column.productValue.element[dataItem.uid].style' ng-bind='kendo.toString(#=productValue#, vc.viewState.QV_YCLAE9320_92.column.productValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_YCLAE9320_92.column.productValue.style",
                        "title": "{{vc.viewState.QV_YCLAE9320_92.column.productValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_YCLAE9320_92.column.productValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_YCLAE9320_92.columns.push({
                    field: 'collateralCode',
                    title: '{{vc.viewState.QV_YCLAE9320_92.column.collateralCode.title|translate:vc.viewState.QV_YCLAE9320_92.column.collateralCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_YCLAE9320_92.column.collateralCode.width,
                    format: $scope.vc.viewState.QV_YCLAE9320_92.column.collateralCode.format,
                    editor: $scope.vc.grids.QV_YCLAE9320_92.AT_COL763OLAD86.control,
                    template: "<span ng-class='vc.viewState.QV_YCLAE9320_92.column.collateralCode.element[dataItem.uid].style'>#if (collateralCode !== null) {# #=collateralCode# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_YCLAE9320_92.column.collateralCode.style",
                        "title": "{{vc.viewState.QV_YCLAE9320_92.column.collateralCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_YCLAE9320_92.column.collateralCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_YCLAE9320_92.columns.push({
                    field: 'residualNet',
                    title: '{{vc.viewState.QV_YCLAE9320_92.column.residualNet.title|translate:vc.viewState.QV_YCLAE9320_92.column.residualNet.titleArgs}}',
                    width: $scope.vc.viewState.QV_YCLAE9320_92.column.residualNet.width,
                    format: $scope.vc.viewState.QV_YCLAE9320_92.column.residualNet.format,
                    editor: $scope.vc.grids.QV_YCLAE9320_92.AT_COL763DUET15.control,
                    template: "<span ng-class='vc.viewState.QV_YCLAE9320_92.column.residualNet.element[dataItem.uid].style' ng-bind='kendo.toString(#=residualNet#, vc.viewState.QV_YCLAE9320_92.column.residualNet.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_YCLAE9320_92.column.residualNet.style",
                        "title": "{{vc.viewState.QV_YCLAE9320_92.column.residualNet.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_YCLAE9320_92.column.residualNet.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_YCLAE9320_92.columns.push({
                    field: 'collateralDescription',
                    title: '{{vc.viewState.QV_YCLAE9320_92.column.collateralDescription.title|translate:vc.viewState.QV_YCLAE9320_92.column.collateralDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_YCLAE9320_92.column.collateralDescription.width,
                    format: $scope.vc.viewState.QV_YCLAE9320_92.column.collateralDescription.format,
                    editor: $scope.vc.grids.QV_YCLAE9320_92.AT_COL763CLAP75.control,
                    template: "<span ng-class='vc.viewState.QV_YCLAE9320_92.column.collateralDescription.element[dataItem.uid].style'>#if (collateralDescription !== null) {# #=collateralDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_YCLAE9320_92.column.collateralDescription.style",
                        "title": "{{vc.viewState.QV_YCLAE9320_92.column.collateralDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_YCLAE9320_92.column.collateralDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_YCLAE9320_92.columns.push({
                    field: 'dateLastAppraisal',
                    title: '{{vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.title|translate:vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.titleArgs}}',
                    width: $scope.vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.width,
                    format: $scope.vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.format,
                    editor: $scope.vc.grids.QV_YCLAE9320_92.AT_COL763TPRL18.control,
                    template: "<span ng-class='vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.element[dataItem.uid].style'>#=((dateLastAppraisal !== null) ? kendo.toString(dateLastAppraisal, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.style",
                        "title": "{{vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_YCLAE9320_92.column.dateLastAppraisal.hidden
                });
            }
            $scope.vc.viewState.QV_YCLAE9320_92.toolbar = {}
            $scope.vc.grids.QV_YCLAE9320_92.toolbar = [];
            //ViewState - Group: Pestaña para Polizas
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_12",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PLIZASYSD_39259",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Insurance = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    insuranceCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Insurance", "insuranceCode", ''),
                        validation: {
                            insuranceCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    insuranceType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Insurance", "insuranceType", ''),
                        validation: {
                            insuranceTypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    insuranceCompany: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Insurance", "insuranceCompany", ''),
                        validation: {
                            insuranceCompanyRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    insuranceValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Insurance", "insuranceValue", 0),
                        validation: {
                            insuranceValueRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });;
            $scope.vc.model.Insurance = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUNURACE_2482();
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
                    model: $scope.vc.types.Insurance
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QUNUR2482_02").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUNURACE_2482 = $scope.vc.model.Insurance;
            $scope.vc.trackers.Insurance = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Insurance);
            $scope.vc.model.Insurance.bind('change', function(e) {
                $scope.vc.trackers.Insurance.track(e);
            });
            $scope.vc.grids.QV_QUNUR2482_02 = {};
            $scope.vc.grids.QV_QUNUR2482_02.queryId = 'Q_QUNURACE_2482';
            $scope.vc.viewState.QV_QUNUR2482_02 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUNUR2482_02.column = {};
            $scope.vc.grids.QV_QUNUR2482_02.events = {
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
                    $scope.vc.trackers.Insurance.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUNUR2482_02.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QUNUR2482_02");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUNUR2482_02.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUNUR2482_02.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QUNUR2482_02.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUNUR2482_02 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUNUR2482_02 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUNUR2482_02.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUNUR2482_02.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCode = {
                title: 'BUSIN.DLB_BUSIN_CDGODEPZA_22237',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4812_NROD218',
                element: []
            };
            $scope.vc.grids.QV_QUNUR2482_02.AT_INS408NROD63 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4812_NROD218",
                        'maxlength': 40,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CDGODEPZA_22237') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QUNUR2482_02.column.insuranceCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,6",
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceCode.enabled",
                        'ng-class': "vc.viewState.QV_QUNUR2482_02.column.insuranceCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceType = {
                title: 'BUSIN.DLB_BUSIN_TIPOXAASN_24763',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4812_IRAY659',
                element: []
            };
            $scope.vc.grids.QV_QUNUR2482_02.AT_INS408IRAY49 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4812_IRAY659",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TIPOXAASN_24763') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QUNUR2482_02.column.insuranceType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,6",
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceType.enabled",
                        'ng-class': "vc.viewState.QV_QUNUR2482_02.column.insuranceType.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCompany = {
                title: 'BUSIN.DLB_BUSIN_ASEGURAOA_80576',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4812_ECOY392',
                element: []
            };
            $scope.vc.grids.QV_QUNUR2482_02.AT_INS408ECOY49 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4812_ECOY392",
                        'maxlength': 64,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ASEGURAOA_80576') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,6",
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.enabled",
                        'ng-class': "vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceValue = {
                title: 'BUSIN.DLB_BUSIN_VLORPLIZA_22777',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4812_NSAU042',
                element: []
            };
            $scope.vc.grids.QV_QUNUR2482_02.AT_INS408NSAU61 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4812_NSAU042",
                        'maxlength': 23,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_VLORPLIZA_22777') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QUNUR2482_02.column.insuranceValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QUNUR2482_02.column.insuranceValue.format",
                        'k-decimals': "vc.viewState.QV_QUNUR2482_02.column.insuranceValue.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,6",
                        'ng-disabled': "!vc.viewState.QV_QUNUR2482_02.column.insuranceValue.enabled",
                        'ng-class': "vc.viewState.QV_QUNUR2482_02.column.insuranceValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUNUR2482_02.columns.push({
                    field: 'insuranceCode',
                    title: '{{vc.viewState.QV_QUNUR2482_02.column.insuranceCode.title|translate:vc.viewState.QV_QUNUR2482_02.column.insuranceCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCode.width,
                    format: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCode.format,
                    editor: $scope.vc.grids.QV_QUNUR2482_02.AT_INS408NROD63.control,
                    template: "<span ng-class='vc.viewState.QV_QUNUR2482_02.column.insuranceCode.element[dataItem.uid].style'>#if (insuranceCode !== null) {# #=insuranceCode# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUNUR2482_02.column.insuranceCode.style",
                        "title": "{{vc.viewState.QV_QUNUR2482_02.column.insuranceCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUNUR2482_02.columns.push({
                    field: 'insuranceType',
                    title: '{{vc.viewState.QV_QUNUR2482_02.column.insuranceType.title|translate:vc.viewState.QV_QUNUR2482_02.column.insuranceType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceType.width,
                    format: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceType.format,
                    editor: $scope.vc.grids.QV_QUNUR2482_02.AT_INS408IRAY49.control,
                    template: "<span ng-class='vc.viewState.QV_QUNUR2482_02.column.insuranceType.element[dataItem.uid].style'>#if (insuranceType !== null) {# #=insuranceType# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUNUR2482_02.column.insuranceType.style",
                        "title": "{{vc.viewState.QV_QUNUR2482_02.column.insuranceType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUNUR2482_02.columns.push({
                    field: 'insuranceCompany',
                    title: '{{vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.title|translate:vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.width,
                    format: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.format,
                    editor: $scope.vc.grids.QV_QUNUR2482_02.AT_INS408ECOY49.control,
                    template: "<span ng-class='vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.element[dataItem.uid].style'>#if (insuranceCompany !== null) {# #=insuranceCompany# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.style",
                        "title": "{{vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceCompany.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUNUR2482_02.columns.push({
                    field: 'insuranceValue',
                    title: '{{vc.viewState.QV_QUNUR2482_02.column.insuranceValue.title|translate:vc.viewState.QV_QUNUR2482_02.column.insuranceValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceValue.width,
                    format: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceValue.format,
                    editor: $scope.vc.grids.QV_QUNUR2482_02.AT_INS408NSAU61.control,
                    template: "<span ng-class='vc.viewState.QV_QUNUR2482_02.column.insuranceValue.element[dataItem.uid].style' ng-bind='kendo.toString(#=insuranceValue#, vc.viewState.QV_QUNUR2482_02.column.insuranceValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUNUR2482_02.column.insuranceValue.style",
                        "title": "{{vc.viewState.QV_QUNUR2482_02.column.insuranceValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QUNUR2482_02.column.insuranceValue.hidden
                });
            }
            $scope.vc.viewState.QV_QUNUR2482_02.toolbar = {}
            $scope.vc.grids.QV_QUNUR2482_02.toolbar = []; //ViewState - Group: Pestaña Beneficios
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_20",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BENEFITSR_44066",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Rate = {
                AccordingTariffRate: $scope.vc.channelDefaultValues("Rate", "AccordingTariffRate"),
                ProposedRate: $scope.vc.channelDefaultValues("Rate", "ProposedRate")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_21",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rate, Attribute: AccordingTariffRate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4821_CIRE384",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ACORNTFRA_08286",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Role
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_22",
                hasId: true,
                componentStyle: "",
                label: 'Role',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ManagersPoints = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CheckBoolean: {
                        type: "boolean"
                    },
                    Check: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ManagersPoints", "Check", '')
                    },
                    Role: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ManagersPoints", "Role", '')
                    },
                    SalePoints: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ManagersPoints", "SalePoints", '')
                    },
                    IdRole: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ManagersPoints", "IdRole", 0)
                    },
                    Processed: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ManagersPoints", "Processed", 0)
                    }
                }
            });;
            $scope.vc.model.ManagersPoints = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_MARPNTEY_5915();
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ManagersPoints',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_MARPN5915_10', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                    model: $scope.vc.types.ManagersPoints
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_MARPN5915_10").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_MARPNTEY_5915 = $scope.vc.model.ManagersPoints;
            $scope.vc.trackers.ManagersPoints = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ManagersPoints);
            $scope.vc.model.ManagersPoints.bind('change', function(e) {
                $scope.vc.trackers.ManagersPoints.track(e);
            });
            $scope.vc.model.ManagersPoints.bind('change', function(e) {
                if (e.action !== null && e.action !== '' && e.action === "itemchange") {
                    if (e.items.length > 0) {
                        var item = e.items[0];
                        if ((typeof item.CheckBoolean !== 'undefined') && ((String(item.CheckBoolean) === 'true' && item.Check == '0') || (String(item.CheckBoolean) === 'false' && item.Check == '1') || ((String(item.CheckBoolean) === 'true' || String(item.CheckBoolean) === 'false' && item.Check == '')))) {
                            if (String(item.CheckBoolean) === 'true') {
                                item.set('Check', '1');
                            } else {
                                item.set('Check', '0');
                            }
                        }
                    }
                }
            });
            $scope.vc.grids.QV_MARPN5915_10 = {};
            $scope.vc.grids.QV_MARPN5915_10.queryId = 'Q_MARPNTEY_5915';
            $scope.vc.viewState.QV_MARPN5915_10 = {
                style: undefined
            };
            $scope.vc.viewState.QV_MARPN5915_10.column = {};
            $scope.vc.grids.QV_MARPN5915_10.events = {
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
                    $scope.vc.trackers.ManagersPoints.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_MARPN5915_10.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_MARPN5915_10");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_MARPN5915_10.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_MARPN5915_10.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_MARPN5915_10.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_MARPN5915_10 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_MARPN5915_10 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_MARPN5915_10.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_MARPN5915_10.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_MARPN5915_10.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "ManagersPoints",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_MARPN5915_10", args);
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
            $scope.vc.grids.QV_MARPN5915_10.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_MARPN5915_10.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_MARPN5915_10.column.Check = {
                title: 'BUSIN.DLB_BUSIN_AUTHORIZD_41383',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4822_CECK199',
                element: []
            };
            $scope.vc.grids.QV_MARPN5915_10.AT_AAE501CECK86 = {
                control: function(container, options) {
                    $scope.options_QV_MARPN5915_10 = options;
                    if (!angular.isDefined($scope.options_QV_MARPN5915_10.model.CheckBoolean)) {
                        if ($scope.options_QV_MARPN5915_10.model.Check === '1') {
                            $scope.options_QV_MARPN5915_10.model.CheckBoolean = true;
                        } else {
                            $scope.options_QV_MARPN5915_10.model.CheckBoolean = false;
                        }
                    }
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': 'CheckBoolean',
                        'data-bind': "value: CheckBoolean",
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.Check.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-true-value': "'1'",
                        'ng-false-value': "'0'",
                        'ng-model': 'options_QV_MARPN5915_10.model.Check',
                        'ng-class': 'vc.viewState.QV_MARPN5915_10.column.Check.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_MARPN5915_10.column.Role = {
                title: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4822_0000456',
                element: []
            };
            $scope.vc.grids.QV_MARPN5915_10.AT_AAE501ROLE87 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.Role.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4822_0000456",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_MARPN5915_10.column.Role.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_20,1",
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.Role.enabled",
                        'ng-class': "vc.viewState.QV_MARPN5915_10.column.Role.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_MARPN5915_10.column.SalePoints = {
                title: 'BUSIN.DLB_BUSIN_PINTSSALE_28815',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4822_SEPI194',
                element: []
            };
            $scope.vc.grids.QV_MARPN5915_10.AT_AAE501SEPI72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.SalePoints.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4822_SEPI194",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_MARPN5915_10.column.SalePoints.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_20,1",
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.SalePoints.enabled",
                        'ng-class': "vc.viewState.QV_MARPN5915_10.column.SalePoints.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_MARPN5915_10.column.IdRole = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4822_IDOL227',
                element: []
            };
            $scope.vc.grids.QV_MARPN5915_10.AT_AAE501IDOL31 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.IdRole.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_OVECRDTRQE4822_IDOL227",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_MARPN5915_10.column.IdRole.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_MARPN5915_10.column.IdRole.format",
                        'k-decimals': "vc.viewState.QV_MARPN5915_10.column.IdRole.decimals",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_20,1",
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.IdRole.enabled",
                        'ng-class': "vc.viewState.QV_MARPN5915_10.column.IdRole.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_MARPN5915_10.column.Processed = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4822_0000714',
                element: []
            };
            $scope.vc.grids.QV_MARPN5915_10.AT_AAE501PREE53 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.Processed.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'id': "VA_OVECRDTRQE4822_0000714",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_MARPN5915_10.column.Processed.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_MARPN5915_10.column.Processed.format",
                        'k-decimals': "vc.viewState.QV_MARPN5915_10.column.Processed.decimals",
                        'data-cobis-group': "Group,GR_OVECRDTRQE48_20,1",
                        'ng-disabled': "!vc.viewState.QV_MARPN5915_10.column.Processed.enabled",
                        'ng-class': "vc.viewState.QV_MARPN5915_10.column.Processed.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_MARPN5915_10.columns.push({
                    field: 'Check',
                    title: '{{vc.viewState.QV_MARPN5915_10.column.Check.title|translate:vc.viewState.QV_MARPN5915_10.column.Check.titleArgs}}',
                    width: $scope.vc.viewState.QV_MARPN5915_10.column.Check.width,
                    format: $scope.vc.viewState.QV_MARPN5915_10.column.Check.format,
                    editor: $scope.vc.grids.QV_MARPN5915_10.AT_AAE501CECK86.control,
                    template: function(dataItem) {
                        var checked = "";
                        var valueBoolean = "false";
                        if (String(dataItem.Check) === "1") {
                            checked = "checked='checked'";
                            valueBoolean = "true";
                        }
                        return "<input name='Check' type='checkbox' value='" + valueBoolean + "' " + checked + " disabled='disabled' ng-class='vc.viewState.QV_MARPN5915_10.column.Check.element[dataItem.uid].style' /> ";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_MARPN5915_10.column.Check.style",
                        "title": "{{vc.viewState.QV_MARPN5915_10.column.Check.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_MARPN5915_10.column.Check.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_MARPN5915_10.columns.push({
                    field: 'Role',
                    title: '{{vc.viewState.QV_MARPN5915_10.column.Role.title|translate:vc.viewState.QV_MARPN5915_10.column.Role.titleArgs}}',
                    width: $scope.vc.viewState.QV_MARPN5915_10.column.Role.width,
                    format: $scope.vc.viewState.QV_MARPN5915_10.column.Role.format,
                    editor: $scope.vc.grids.QV_MARPN5915_10.AT_AAE501ROLE87.control,
                    template: "<span ng-class='vc.viewState.QV_MARPN5915_10.column.Role.element[dataItem.uid].style'>#if (Role !== null) {# #=Role# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_MARPN5915_10.column.Role.style",
                        "title": "{{vc.viewState.QV_MARPN5915_10.column.Role.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_MARPN5915_10.column.Role.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_MARPN5915_10.columns.push({
                    field: 'SalePoints',
                    title: '{{vc.viewState.QV_MARPN5915_10.column.SalePoints.title|translate:vc.viewState.QV_MARPN5915_10.column.SalePoints.titleArgs}}',
                    width: $scope.vc.viewState.QV_MARPN5915_10.column.SalePoints.width,
                    format: $scope.vc.viewState.QV_MARPN5915_10.column.SalePoints.format,
                    editor: $scope.vc.grids.QV_MARPN5915_10.AT_AAE501SEPI72.control,
                    template: "<span ng-class='vc.viewState.QV_MARPN5915_10.column.SalePoints.element[dataItem.uid].style'>#if (SalePoints !== null) {# #=SalePoints# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_MARPN5915_10.column.SalePoints.style",
                        "title": "{{vc.viewState.QV_MARPN5915_10.column.SalePoints.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_MARPN5915_10.column.SalePoints.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_MARPN5915_10.columns.push({
                    field: 'IdRole',
                    title: '{{vc.viewState.QV_MARPN5915_10.column.IdRole.title|translate:vc.viewState.QV_MARPN5915_10.column.IdRole.titleArgs}}',
                    width: $scope.vc.viewState.QV_MARPN5915_10.column.IdRole.width,
                    format: $scope.vc.viewState.QV_MARPN5915_10.column.IdRole.format,
                    editor: $scope.vc.grids.QV_MARPN5915_10.AT_AAE501IDOL31.control,
                    template: "<span ng-class='vc.viewState.QV_MARPN5915_10.column.IdRole.element[dataItem.uid].style' ng-bind='kendo.toString(#=IdRole#, vc.viewState.QV_MARPN5915_10.column.IdRole.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_MARPN5915_10.column.IdRole.style",
                        "title": "{{vc.viewState.QV_MARPN5915_10.column.IdRole.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_MARPN5915_10.column.IdRole.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_MARPN5915_10.columns.push({
                    field: 'Processed',
                    title: '{{vc.viewState.QV_MARPN5915_10.column.Processed.title|translate:vc.viewState.QV_MARPN5915_10.column.Processed.titleArgs}}',
                    width: $scope.vc.viewState.QV_MARPN5915_10.column.Processed.width,
                    format: $scope.vc.viewState.QV_MARPN5915_10.column.Processed.format,
                    editor: $scope.vc.grids.QV_MARPN5915_10.AT_AAE501PREE53.control,
                    template: "<span ng-class='vc.viewState.QV_MARPN5915_10.column.Processed.element[dataItem.uid].style' ng-bind='kendo.toString(#=Processed#, vc.viewState.QV_MARPN5915_10.column.Processed.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_MARPN5915_10.column.Processed.style",
                        "title": "{{vc.viewState.QV_MARPN5915_10.column.Processed.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_MARPN5915_10.column.Processed.hidden
                });
            }
            $scope.vc.viewState.QV_MARPN5915_10.column.edit = {
                element: []
            };
            $scope.vc.grids.QV_MARPN5915_10.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_MARPN5915_10.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_MARPN5915_10.toolbar = {}
            $scope.vc.grids.QV_MARPN5915_10.toolbar = [];
            //ViewState - Group: Tasa2
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_23",
                hasId: true,
                componentStyle: "",
                label: 'Tasa2',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Rate, Attribute: ProposedRate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4823_OSEE169",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OPOSEDRAE_72814",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: RoleHierarchyGroup
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_28",
                hasId: true,
                componentStyle: "",
                label: 'RoleHierarchyGroup',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.RoleHierarchy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    HierarchyId: {
                        type: "number",
                        editable: true
                    },
                    RoleHierarchyIdIni: {
                        type: "number",
                        editable: true
                    },
                    RoleHierarchyDescIni: {
                        type: "string",
                        editable: true
                    },
                    RoleHierarchyIdEnd: {
                        type: "number",
                        editable: true
                    },
                    RoleHierarchyDescEnd: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.RoleHierarchy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUELEEHY_6533();
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
                    model: $scope.vc.types.RoleHierarchy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QUELE6533_24").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUELEEHY_6533 = $scope.vc.model.RoleHierarchy;
            $scope.vc.trackers.RoleHierarchy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RoleHierarchy);
            $scope.vc.model.RoleHierarchy.bind('change', function(e) {
                $scope.vc.trackers.RoleHierarchy.track(e);
            });
            $scope.vc.grids.QV_QUELE6533_24 = {};
            $scope.vc.grids.QV_QUELE6533_24.queryId = 'Q_QUELEEHY_6533';
            $scope.vc.viewState.QV_QUELE6533_24 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUELE6533_24.column = {};
            $scope.vc.grids.QV_QUELE6533_24.events = {
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
                    $scope.vc.trackers.RoleHierarchy.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUELE6533_24.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QUELE6533_24");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUELE6533_24.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUELE6533_24.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QUELE6533_24.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUELE6533_24 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUELE6533_24 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUELE6533_24.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUELE6533_24.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUELE6533_24.column.HierarchyId = {
                title: 'HierarchyId',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUELE6533_24.AT_OLH364EACH78 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_QUELE6533_24.column.HierarchyId.enabled",
                        'ng-class': "vc.viewState.QV_QUELE6533_24.column.HierarchyId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni = {
                title: 'RoleHierarchyIdIni',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUELE6533_24.AT_OLH364CIDI86 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.enabled",
                        'ng-class': "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni = {
                title: 'RoleHierarchyDescIni',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUELE6533_24.AT_OLH364OHAD95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 400,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.enabled",
                        'ng-class': "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd = {
                title: 'RoleHierarchyIdEnd',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUELE6533_24.AT_OLH364RERR36 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.enabled",
                        'ng-class': "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd = {
                title: 'RoleHierarchyDescEnd',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUELE6533_24.AT_OLH364RRCN94 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 400,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.enabled",
                        'ng-class': "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUELE6533_24.columns.push({
                    field: 'HierarchyId',
                    title: '{{vc.viewState.QV_QUELE6533_24.column.HierarchyId.title|translate:vc.viewState.QV_QUELE6533_24.column.HierarchyId.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUELE6533_24.column.HierarchyId.width,
                    format: $scope.vc.viewState.QV_QUELE6533_24.column.HierarchyId.format,
                    editor: $scope.vc.grids.QV_QUELE6533_24.AT_OLH364EACH78.control,
                    template: "<span ng-class='vc.viewState.QV_QUELE6533_24.column.HierarchyId.element[dataItem.uid].style' ng-bind='kendo.toString(#=HierarchyId#, vc.viewState.QV_QUELE6533_24.column.HierarchyId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUELE6533_24.column.HierarchyId.style",
                        "title": "{{vc.viewState.QV_QUELE6533_24.column.HierarchyId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUELE6533_24.column.HierarchyId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUELE6533_24.columns.push({
                    field: 'RoleHierarchyIdIni',
                    title: '{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.title|translate:vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.width,
                    format: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.format,
                    editor: $scope.vc.grids.QV_QUELE6533_24.AT_OLH364CIDI86.control,
                    template: "<span ng-class='vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.element[dataItem.uid].style' ng-bind='kendo.toString(#=RoleHierarchyIdIni#, vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.style",
                        "title": "{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdIni.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUELE6533_24.columns.push({
                    field: 'RoleHierarchyDescIni',
                    title: '{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.title|translate:vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.width,
                    format: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.format,
                    editor: $scope.vc.grids.QV_QUELE6533_24.AT_OLH364OHAD95.control,
                    template: "<span ng-class='vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.element[dataItem.uid].style'>#if (RoleHierarchyDescIni !== null) {# #=RoleHierarchyDescIni# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.style",
                        "title": "{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescIni.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUELE6533_24.columns.push({
                    field: 'RoleHierarchyIdEnd',
                    title: '{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.title|translate:vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.width,
                    format: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.format,
                    editor: $scope.vc.grids.QV_QUELE6533_24.AT_OLH364RERR36.control,
                    template: "<span ng-class='vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.element[dataItem.uid].style' ng-bind='kendo.toString(#=RoleHierarchyIdEnd#, vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.style",
                        "title": "{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyIdEnd.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUELE6533_24.columns.push({
                    field: 'RoleHierarchyDescEnd',
                    title: '{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.title|translate:vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.width,
                    format: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.format,
                    editor: $scope.vc.grids.QV_QUELE6533_24.AT_OLH364RRCN94.control,
                    template: "<span ng-class='vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.element[dataItem.uid].style'>#if (RoleHierarchyDescEnd !== null) {# #=RoleHierarchyDescEnd# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.style",
                        "title": "{{vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUELE6533_24.column.RoleHierarchyDescEnd.hidden
                });
            }
            $scope.vc.viewState.QV_QUELE6533_24.toolbar = {}
            $scope.vc.grids.QV_QUELE6533_24.toolbar = [];
            //ViewState - Group: Pestaña Fuente de Ingresos
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_29",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FUENTEDLI_58290",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.SourceRevenueCustomer = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    IdClient: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "IdClient", 0),
                        validation: {
                            IdClientRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Rol: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Rol", ''),
                        validation: {
                            RolRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Type", ''),
                        validation: {
                            TypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Sector: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "Sector", ''),
                        validation: {
                            SectorRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    SubSector: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "SubSector", ''),
                        validation: {
                            SubSectorRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    EconomicActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SourceRevenueCustomer", "EconomicActivity", ''),
                        validation: {
                            EconomicActivityRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    Clarification: {
                        type: "string",
                        editable: true
                    },
                    descriptionActivity: {
                        type: "string",
                        editable: true
                    }
                }
            });;
            $scope.vc.model.SourceRevenueCustomer = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_RURCECER_2364();
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
                    model: $scope.vc.types.SourceRevenueCustomer
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_RURCE2364_74").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RURCECER_2364 = $scope.vc.model.SourceRevenueCustomer;
            $scope.vc.trackers.SourceRevenueCustomer = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.SourceRevenueCustomer);
            $scope.vc.model.SourceRevenueCustomer.bind('change', function(e) {
                $scope.vc.trackers.SourceRevenueCustomer.track(e);
            });
            $scope.vc.grids.QV_RURCE2364_74 = {};
            $scope.vc.grids.QV_RURCE2364_74.queryId = 'Q_RURCECER_2364';
            $scope.vc.viewState.QV_RURCE2364_74 = {
                style: undefined
            };
            $scope.vc.viewState.QV_RURCE2364_74.column = {};
            $scope.vc.grids.QV_RURCE2364_74.events = {
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
                    $scope.vc.trackers.SourceRevenueCustomer.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_RURCE2364_74.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_RURCE2364_74");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_RURCE2364_74.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_RURCE2364_74.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_RURCE2364_74.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_RURCE2364_74 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_RURCE2364_74 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_RURCE2364_74.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_RURCE2364_74.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_RURCE2364_74.column.IdClient = {
                title: 'BUSIN.DLB_BUSIN_CUTOMEROD_75260',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4829_DCLN872',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755DCLN75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.IdClient.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4829_DCLN872",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_CUTOMEROD_75260') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.IdClient.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_RURCE2364_74.column.IdClient.format",
                        'k-decimals': "vc.viewState.QV_RURCE2364_74.column.IdClient.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,9",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.IdClient.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.IdClient.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Rol = {
                title: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4829_ROLU965',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4829_ROLU965 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4829_ROLU965_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4829_ROLU965_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OVECRDTRQE4829_ROLU965',
                                'cr_cat_deudor',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4829_ROLU965'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4829_ROLU965_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_ROLU965");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4829_ROLU965_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_ROLU965");
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
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755ROLU15 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Rol.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4829_ROLU965",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.Rol.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4829_ROLU965",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.Rol.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_ROLEVJMGD_53686') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Rol.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,9",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TYPEYLJIK_10770',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4829_TYPE041',
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755TYPE77 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4829_TYPE041",
                        'maxlength': 4,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TYPEYLJIK_10770') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,9",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Sector = {
                title: 'BUSIN.DLB_BUSIN_WUIWWCGVG_35342',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4829_SCOR285',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4829_SCOR285 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4829_SCOR285_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4829_SCOR285_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OVECRDTRQE4829_SCOR285',
                                'cl_sector_economico',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4829_SCOR285'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4829_SCOR285_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_SCOR285");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4829_SCOR285_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_SCOR285");
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
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755SCOR68 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Sector.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4829_SCOR285",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.Sector.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4829_SCOR285",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.Sector.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_WUIWWCGVG_35342') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.Sector.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,9",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.SubSector = {
                title: 'BUSIN.DLB_BUSIN_SSECTCTID_26184',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4829_STOR133',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4829_STOR133 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4829_STOR133_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4829_STOR133_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OVECRDTRQE4829_STOR133',
                                'cl_subsector_ec',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4829_STOR133'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4829_STOR133_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_STOR133");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4829_STOR133_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_STOR133");
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
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755STOR39 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.SubSector.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4829_STOR133",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.SubSector.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4829_STOR133",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.SubSector.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_SSECTCTID_26184') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.SubSector.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,9",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity = {
                title: 'BUSIN.DLB_BUSIN_TIVDECOIA_60481',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_OVECRDTRQE4829_OCIT120',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4829_OCIT120 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4829_OCIT120_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4829_OCIT120_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OVECRDTRQE4829_OCIT120',
                                'cl_actividad_ec',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4829_OCIT120'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4829_OCIT120_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_OCIT120");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4829_OCIT120_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_RURCE2364_74", "VA_OVECRDTRQE4829_OCIT120");
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
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755OCIT66 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.EconomicActivity.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4829_OCIT120",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_RURCE2364_74.column.EconomicActivity.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4829_OCIT120",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_RURCE2364_74.column.EconomicActivity.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TIVDECOIA_60481') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.validationCode}}",
                        'dsgrequired': "",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,9",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.Clarification = {
                title: 'BUSIN.DLB_BUSIN_ALARACIFI_82775',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755LRIN62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.Clarification.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.Clarification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity = {
                title: 'BUSIN.DLB_BUSIN_ESIELATII_72943',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_RURCE2364_74.AT_RER755ATVY95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_RURCE2364_74.column.descriptionActivity.enabled",
                        'ng-class': "vc.viewState.QV_RURCE2364_74.column.descriptionActivity.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'IdClient',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.IdClient.title|translate:vc.viewState.QV_RURCE2364_74.column.IdClient.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.IdClient.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.IdClient.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755DCLN75.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.IdClient.element[dataItem.uid].style' ng-bind='kendo.toString(#=IdClient#, vc.viewState.QV_RURCE2364_74.column.IdClient.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.IdClient.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.IdClient.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.IdClient.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Rol',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Rol.title|translate:vc.viewState.QV_RURCE2364_74.column.Rol.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Rol.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Rol.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755ROLU15.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Rol.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4829_ROLU965.get(dataItem.Rol).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Rol.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Rol.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Rol.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Type.title|translate:vc.viewState.QV_RURCE2364_74.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Type.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Type.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755TYPE77.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Type.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Sector',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Sector.title|translate:vc.viewState.QV_RURCE2364_74.column.Sector.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Sector.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Sector.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755SCOR68.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Sector.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4829_SCOR285.get(dataItem.Sector).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Sector.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Sector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Sector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'SubSector',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.SubSector.title|translate:vc.viewState.QV_RURCE2364_74.column.SubSector.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.SubSector.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.SubSector.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755STOR39.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.SubSector.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4829_STOR133.get(dataItem.SubSector).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.SubSector.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.SubSector.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.SubSector.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'EconomicActivity',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.title|translate:vc.viewState.QV_RURCE2364_74.column.EconomicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755OCIT66.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.EconomicActivity.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4829_OCIT120.get(dataItem.EconomicActivity).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.EconomicActivity.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.EconomicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.EconomicActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'Clarification',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.Clarification.title|translate:vc.viewState.QV_RURCE2364_74.column.Clarification.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.Clarification.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.Clarification.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755LRIN62.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.Clarification.element[dataItem.uid].style'>#if (Clarification !== null) {# #=Clarification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.Clarification.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.Clarification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.Clarification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_RURCE2364_74.columns.push({
                    field: 'descriptionActivity',
                    title: '{{vc.viewState.QV_RURCE2364_74.column.descriptionActivity.title|translate:vc.viewState.QV_RURCE2364_74.column.descriptionActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity.width,
                    format: $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity.format,
                    editor: $scope.vc.grids.QV_RURCE2364_74.AT_RER755ATVY95.control,
                    template: "<span ng-class='vc.viewState.QV_RURCE2364_74.column.descriptionActivity.element[dataItem.uid].style'>#if (descriptionActivity !== null) {# #=descriptionActivity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_RURCE2364_74.column.descriptionActivity.style",
                        "title": "{{vc.viewState.QV_RURCE2364_74.column.descriptionActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_RURCE2364_74.column.descriptionActivity.hidden
                });
            }
            $scope.vc.viewState.QV_RURCE2364_74.toolbar = {}
            $scope.vc.grids.QV_RURCE2364_74.toolbar = [];
            //ViewState - Group: Pestaña de Distribucion de Linea
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_30",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TIBUCNEEA_07829",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DistributionLine = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CreditType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "CreditType", '')
                    },
                    Currency: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "Currency", 0)
                    },
                    AmountProposed: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "AmountProposed", 0)
                    },
                    Quote: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "Quote", 0)
                    },
                    AmountLocalCurrency: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "AmountLocalCurrency", 0)
                    },
                    Module: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DistributionLine", "Module", '')
                    }
                }
            });;
            $scope.vc.model.DistributionLine = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QERISUIL_7170();
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DistributionLine',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERIS7170_82', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DistributionLine',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERIS7170_82', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DistributionLine',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QERIS7170_82', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.DistributionLine
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QERIS7170_82").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QERISUIL_7170 = $scope.vc.model.DistributionLine;
            $scope.vc.trackers.DistributionLine = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DistributionLine);
            $scope.vc.model.DistributionLine.bind('change', function(e) {
                $scope.vc.trackers.DistributionLine.track(e);
            });
            $scope.vc.grids.QV_QERIS7170_82 = {};
            $scope.vc.grids.QV_QERIS7170_82.queryId = 'Q_QERISUIL_7170';
            $scope.vc.viewState.QV_QERIS7170_82 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QERIS7170_82.column = {};
            $scope.vc.grids.QV_QERIS7170_82.events = {
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
                    $scope.vc.trackers.DistributionLine.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QERIS7170_82.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QERIS7170_82");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QERIS7170_82.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QERIS7170_82.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QERIS7170_82.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QERIS7170_82 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QERIS7170_82 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QERIS7170_82.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QERIS7170_82.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QERIS7170_82.column.CreditType = {
                title: 'BUSIN.DLB_BUSIN_CREDITYPE_12941',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4830_RITT981',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4830_RITT981 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4830_RITT981_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4830_RITT981_values = [];
                            $scope.vc.loadCatalog(
                                'VA_OVECRDTRQE4830_RITT981', function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4830_RITT981'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4830_RITT981_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_OVECRDTRQE4830_RITT981");
                            },
                            options.data.filter, null, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4830_RITT981_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_OVECRDTRQE4830_RITT981");
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
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478RITT46 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.CreditType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4830_RITT981",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QERIS7170_82.column.CreditType.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4830_RITT981",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QERIS7170_82.column.CreditType.template",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.CreditType.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,10",
                        'k-on-change': "vc.change(kendoEvent,'VA_OVECRDTRQE4830_RITT981',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_OVECRDTRQE4830_RITT981',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4830_CUCY033',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_OVECRDTRQE4830_CUCY033 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_OVECRDTRQE4830_CUCY033_values)) {
                            $scope.vc.catalogs.VA_OVECRDTRQE4830_CUCY033_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_OVECRDTRQE4830_CUCY033',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_OVECRDTRQE4830_CUCY033'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_OVECRDTRQE4830_CUCY033_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_OVECRDTRQE4830_CUCY033");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_OVECRDTRQE4830_CUCY033_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_QERIS7170_82", "VA_OVECRDTRQE4830_CUCY033");
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
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478CUCY65 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4830_CUCY033",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QERIS7170_82.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_OVECRDTRQE4830_CUCY033",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QERIS7170_82.column.Currency.template",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.Currency.validationCode}}",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,10",
                        'k-on-change': "vc.change(kendoEvent,'VA_OVECRDTRQE4830_CUCY033',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_OVECRDTRQE4830_CUCY033',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed = {
                title: 'BUSIN.DLB_BUSIN_AMNRPOSED_26320',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4830_AONO775',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478AONO09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountProposed.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4830_AONO775",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.AmountProposed.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERIS7170_82.column.AmountProposed.format",
                        'k-decimals': "vc.viewState.QV_QERIS7170_82.column.AmountProposed.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_OVECRDTRQE4830_AONO775',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.events.focus($event,'VA_OVECRDTRQE4830_AONO775',this.dataItem,'" + options.field + "')",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,10",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountProposed.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.AmountProposed.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.Quote = {
                title: 'BUSIN.DLB_BUSIN_QUOTEGHSS_49243',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4830_QOTE850',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478QOTE39 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Quote.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4830_QOTE850",
                        'maxlength': 7,
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.Quote.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERIS7170_82.column.Quote.format",
                        'k-decimals': "vc.viewState.QV_QERIS7170_82.column.Quote.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,10",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Quote.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.Quote.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency = {
                title: 'BUSIN.DLB_BUSIN_OTLCLCREY_32226',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4830_AREN166',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478AREN75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4830_AREN166",
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.format",
                        'k-decimals': "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.decimals",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,10",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QERIS7170_82.column.Module = {
                title: 'BUSIN.DLB_BUSIN_MODULEFIQ_49292',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_OVECRDTRQE4830_MODL421',
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.AT_STR478MODL65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Module.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_OVECRDTRQE4830_MODL421",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QERIS7170_82.column.Module.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "TabbedLayout,GR_OVECRDTRQE48_04,10",
                        'ng-disabled': "!vc.viewState.QV_QERIS7170_82.column.Module.enabled",
                        'ng-class': "vc.viewState.QV_QERIS7170_82.column.Module.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'CreditType',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.CreditType.title|translate:vc.viewState.QV_QERIS7170_82.column.CreditType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.CreditType.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.CreditType.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478RITT46.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.CreditType.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4830_RITT981.get(dataItem.CreditType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.CreditType.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.CreditType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.CreditType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.Currency.title|translate:vc.viewState.QV_QERIS7170_82.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.Currency.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.Currency.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478CUCY65.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_OVECRDTRQE4830_CUCY033.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.Currency.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'AmountProposed',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.AmountProposed.title|translate:vc.viewState.QV_QERIS7170_82.column.AmountProposed.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478AONO09.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.AmountProposed.element[dataItem.uid].style' ng-bind='kendo.toString(#=AmountProposed#, vc.viewState.QV_QERIS7170_82.column.AmountProposed.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.AmountProposed.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.AmountProposed.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.AmountProposed.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'Quote',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.Quote.title|translate:vc.viewState.QV_QERIS7170_82.column.Quote.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.Quote.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.Quote.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478QOTE39.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.Quote.element[dataItem.uid].style' ng-bind='kendo.toString(#=Quote#, vc.viewState.QV_QERIS7170_82.column.Quote.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.Quote.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.Quote.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.Quote.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'AmountLocalCurrency',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.title|translate:vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478AREN75.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.element[dataItem.uid].style' ng-bind='kendo.toString(#=AmountLocalCurrency#, vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.AmountLocalCurrency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QERIS7170_82.columns.push({
                    field: 'Module',
                    title: '{{vc.viewState.QV_QERIS7170_82.column.Module.title|translate:vc.viewState.QV_QERIS7170_82.column.Module.titleArgs}}',
                    width: $scope.vc.viewState.QV_QERIS7170_82.column.Module.width,
                    format: $scope.vc.viewState.QV_QERIS7170_82.column.Module.format,
                    editor: $scope.vc.grids.QV_QERIS7170_82.AT_STR478MODL65.control,
                    template: "<span ng-class='vc.viewState.QV_QERIS7170_82.column.Module.element[dataItem.uid].style'>#if (Module !== null) {# #=Module# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QERIS7170_82.column.Module.style",
                        "title": "{{vc.viewState.QV_QERIS7170_82.column.Module.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QERIS7170_82.column.Module.hidden
                });
            }
            $scope.vc.viewState.QV_QERIS7170_82.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_QERIS7170_82.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_QERIS7170_82.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_QERIS7170_82.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_QERIS7170_82.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: 61
            });
            $scope.vc.viewState.QV_QERIS7170_82.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_QERIS7170_82.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-image-button' " + "ng-show = 'vc.viewState.QV_QERIS7170_82.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_OVECRDTRQE48_30.disabled?true:false' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\"> " + "<span class='glyphicon glyphicon-plus-sign'></span></button>"
            }];
            $scope.vc.model.IndexSizeActivity = {
                Patrimony: $scope.vc.channelDefaultValues("IndexSizeActivity", "Patrimony"),
                Sales: $scope.vc.channelDefaultValues("IndexSizeActivity", "Sales"),
                PersonalNumber: $scope.vc.channelDefaultValues("IndexSizeActivity", "PersonalNumber"),
                IndexSizeActivity: $scope.vc.channelDefaultValues("IndexSizeActivity", "IndexSizeActivity"),
                AnnualSales: $scope.vc.channelDefaultValues("IndexSizeActivity", "AnnualSales"),
                ProductiveAssets: $scope.vc.channelDefaultValues("IndexSizeActivity", "ProductiveAssets"),
                ParameterFixedIncome: $scope.vc.channelDefaultValues("IndexSizeActivity", "ParameterFixedIncome"),
                BtnCalculate: $scope.vc.channelDefaultValues("IndexSizeActivity", "BtnCalculate"),
                sizeCompany: $scope.vc.channelDefaultValues("IndexSizeActivity", "sizeCompany")
            };
            //ViewState - Group: Recalculo de Indice
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_31",
                hasId: true,
                componentStyle: "",
                label: 'Recalculo de Indice',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: Patrimony
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_ATRN348",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PATRIONIO_19030",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: Sales
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_0000709",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VENTASTMS_38146",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: PersonalNumber
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_0000495",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ROENLOUAO_93609",
                haslabelArgs: true,
                format: "###########",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: IndexSizeActivity
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_0000609",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NDAAOCIID_54450",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: AnnualSales
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_0000135",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VETSNULES_35157",
                haslabelArgs: true,
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: ProductiveAssets
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_0000641",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_IVOPUCTOS_02893",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: IndexSizeActivity, Attribute: BtnCalculate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4831_NEIY294",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RECALCLAE_50980",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.QueryCentral = {
                ReportMonthCIC: $scope.vc.channelDefaultValues("QueryCentral", "ReportMonthCIC"),
                ReportMonthINFOCRED: $scope.vc.channelDefaultValues("QueryCentral", "ReportMonthINFOCRED"),
                LevelIndebtedness: $scope.vc.channelDefaultValues("QueryCentral", "LevelIndebtedness")
            };
            //ViewState - Group: QueryCentral
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_32",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CONULTNRL_07189",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: QueryCentral, Attribute: ReportMonthCIC
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4832_OTHC831",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ONTEAROCI_36413",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QueryCentral, Attribute: ReportMonthINFOCRED
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4832_MICE384",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MOTOADINF_06914",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QueryCentral, Attribute: LevelIndebtedness
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4832_EDNE863",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_INREDVELS_81702",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4832_EDNE863 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4832_EDNE863 !== "undefined") {}
            $scope.vc.model.FeeRate = {
                costCategory: $scope.vc.channelDefaultValues("FeeRate", "costCategory"),
                factorFrom: $scope.vc.channelDefaultValues("FeeRate", "factorFrom"),
                factorTo: $scope.vc.channelDefaultValues("FeeRate", "factorTo"),
                percentage: $scope.vc.channelDefaultValues("FeeRate", "percentage"),
                percentageNew: $scope.vc.channelDefaultValues("FeeRate", "percentageNew"),
                maxValue: $scope.vc.channelDefaultValues("FeeRate", "maxValue"),
                minValue: $scope.vc.channelDefaultValues("FeeRate", "minValue"),
                commission: $scope.vc.channelDefaultValues("FeeRate", "commission"),
                currency: $scope.vc.channelDefaultValues("FeeRate", "currency"),
                minimum: $scope.vc.channelDefaultValues("FeeRate", "minimum")
            };
            //ViewState - Group: Porcentaje de Comision
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_33",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ORCETAJDI_03142",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: FeeRate, Attribute: costCategory
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_CCGR491",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AEGRACSTO_78529",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4833_CCGR491 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OVECRDTRQE4833_CCGR491', 'ce_categoria', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4833_CCGR491'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4833_CCGR491");
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
            //ViewState - Entity: FeeRate, Attribute: factorFrom
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_FCTO562",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FACTOESDE_34564",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000622",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: percentage
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_RCEE196",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PORCENTJE_31752",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000459",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000373",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: factorTo
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_FORO729",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FACTORHAA_30289",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000375",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: minValue
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_NALE922",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ALORMNIMO_30715",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: maxValue
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_ALUE668",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_VLORMXIMO_06351",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000479",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000302",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: percentageNew
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_PRNT414",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PORCENTJE_28614",
                haslabelArgs: true,
                format: "#,##0.00",
                suffix: "\%",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000056",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000681",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: commission
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_MION737",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AORACULDO_25417",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FeeRate, Attribute: currency
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_CURE565",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4833_CURE565 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OVECRDTRQE4833_CURE565', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4833_CURE565'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4833_CURE565");
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
            //ViewState - Entity: FeeRate, Attribute: minimum
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_IMUM383",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_MNIMODJBW_27031",
                haslabelArgs: true,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4833_IMUM383 = new kendo.data.DataSource({
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
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4833_IMUM383 !== "undefined") {}
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4833_0000032",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ACEPTARXV_30181",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo - Rebaja De Tasas]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_34",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BAAPOELET_96138",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ApprovalCriteriaQuestion = {
                internalScore: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "internalScore"),
                otherDebtCICQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "otherDebtCICQuestion"),
                sharedEntityQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "sharedEntityQuestion"),
                comparedExplusiveCustomerQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "comparedExplusiveCustomerQuestion"),
                currentRateFIE: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "currentRateFIE"),
                customerCPOPQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "customerCPOPQuestion"),
                recordsMatchingQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "recordsMatchingQuestion"),
                customerNoCPOPQuestion: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "customerNoCPOPQuestion"),
                previousRateFIE: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "previousRateFIE"),
                maximumDiscountCustomerType: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "maximumDiscountCustomerType"),
                applyRebateCROP: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "applyRebateCROP"),
                tariffRate: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "tariffRate"),
                rebateCustomerType: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rebateCustomerType"),
                proposedRate: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "proposedRate"),
                rateApply: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rateApply"),
                rebateRequest: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rebateRequest"),
                rebate: $scope.vc.channelDefaultValues("ApprovalCriteriaQuestion", "rebate")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_35",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: internalScore
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4835_LSOR644",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PUNTNITRN_79604",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_36",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4836_0000518",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Questions
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_37",
                hasId: true,
                componentStyle: "",
                label: 'Questions',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: otherDebtCICQuestion
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4837_RIEN735",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OIIOSSGIC_37865",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4837_RIEN735 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4837_RIEN735 !== "undefined") {}
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: sharedEntityQuestion
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4837_AEET493",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EEEEDOTDA_66437",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4837_AEET493 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4837_AEET493 !== "undefined") {}
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: comparedExplusiveCustomerQuestion
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4837_AETE007",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_AASNTEXUI_60948",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4837_AETE007 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4837_AETE007 !== "undefined") {}
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: customerCPOPQuestion
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4837_OCPN834",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LLNOLTSOP_45393",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4837_OCPN834 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4837_OCPN834 !== "undefined") {}
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: recordsMatchingQuestion
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4837_RORT295",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SIAEETSOS_91345",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4837_RORT295 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4837_RORT295 !== "undefined") {}
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: customerNoCPOPQuestion
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4837_OQSO471",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LIIORODIG_90118",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4837_OQSO471 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4837_OQSO471 !== "undefined") {}
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_38",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4838_0000078",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: ComercialRebateRequest
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_42",
                hasId: true,
                componentStyle: "",
                label: 'ComercialRebateRequest',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: rebateRequest
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4842_EBEQ592",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EBAEEUSTO_71878",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4842_EBEQ592 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OVECRDTRQE4842_EBEQ592', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OVECRDTRQE4842_EBEQ592'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OVECRDTRQE4842_EBEQ592");
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
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: rebate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4842_REAT914",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_REBATEOMY_36756",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_43",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4843_0000071",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Results
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_39",
                hasId: true,
                componentStyle: "",
                label: 'Results',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: previousRateFIE
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_RURF573",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_IFNTEROFE_04252",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: currentRateFIE
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_RTIE056",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_FIACTUALF_50955",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: maximumDiscountCustomerType
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_MITR815",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ABJTPRTEC_99923",
                haslabelArgs: true,
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: applyRebateCROP
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_PBTR708",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LEBOPS1PO_78419",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_OVECRDTRQE4839_PBTR708 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_OVECRDTRQE4839_PBTR708 !== "undefined") {}
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: tariffRate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_TRAE789",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SEGNARIAI_00834",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: rebateCustomerType
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_REYE670",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_BAAPOELET_96138",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: proposedRate
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4839_OPRA900",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TASPROPUT_71907",
                haslabelArgs: true,
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_40",
                hasId: true,
                componentStyle: "",
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4840_0000422",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Action
            $scope.vc.createViewState({
                id: "GR_OVECRDTRQE48_41",
                hasId: true,
                componentStyle: "",
                label: 'Action',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApprovalCriteriaQuestion, Attribute: rateApply
            $scope.vc.createViewState({
                id: "VA_OVECRDTRQE4841_TPPY065",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_APICARTAA_76297",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_79_APVER36_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_79_APVER36_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Save
            $scope.vc.createViewState({
                id: "CM_APVER36SAE19",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                haslabelArgs: true,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2")
            };
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
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_VIWLNEHADE4804_RTAY467.read();
                    $scope.vc.catalogs.VA_VIWLNEHADE4804_COMT755.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256.read();
                    $scope.vc.catalogs.VA_ININGOTONE0435_ANOP470.read();
                    $scope.vc.catalogs.VA_ININGOTONE0435_CURA309.read();
                    $scope.vc.catalogs.VA_ININGOTONE0435_EITY549.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4806_CRCY669.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4815_XAYM524.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4817_CLUA993.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4817_FAID036.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4818_ECVE659.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4829_ROLU965.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4829_SCOR285.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4829_STOR133.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4829_OCIT120.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4830_RITT981.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4830_CUCY033.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4832_EDNE863.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4833_IMUM383.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4837_RIEN735.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4837_AEET493.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4837_AETE007.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4837_OCPN834.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4837_RORT295.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4837_OQSO471.read();
                    $scope.vc.catalogs.VA_OVECRDTRQE4839_PBTR708.read();
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
                $scope.vc.render('VC_APVER36_PPDET_074');
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
    var cobisMainModule = cobis.createModule("VC_APVER36_PPDET_074", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_APVER36_PPDET_074", {
            templateUrl: "VC_APVER36_PPDET_074_FORM.html",
            controller: "VC_APVER36_PPDET_074_CTRL",
            labelId: "BUSIN.DLB_BUSIN_PRNELUDDD_81422",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_APVER36_PPDET_074?" + $.param(search);
            }
        });
        VC_APVER36_PPDET_074(cobisMainModule);
    }]);
} else {
    VC_APVER36_PPDET_074(cobisMainModule);
}