//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.genericapplication = designerEvents.api.genericapplication || designer.dsgEvents();

function VC_OIIRL51_CNLTO_343(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_OIIRL51_CNLTO_343_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_OIIRL51_CNLTO_343_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_FLCRE_82_OIIRL51",
            taskVersion: "1.0.0",
            viewContainerId: "VC_OIIRL51_CNLTO_343",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_82_OIIRL51",
        designerEvents.api.genericapplication,
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
                vcName: 'VC_OIIRL51_CNLTO_343'
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
                    taskId: 'T_FLCRE_82_OIIRL51',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    OriginalHeader: "OriginalHeader",
                    Context: "Context",
                    DebtorGeneral: "DebtorGeneral",
                    Alicuota: "Alicuota",
                    NewAliquot: "NewAliquot",
                    FieldByProductValues: "FieldByProductValues",
                    EntidadInfo: "EntidadInfo",
                    ApplicationInfoAux: "ApplicationInfoAux",
                    Aval: "Aval"
                },
                entities: {
                    OriginalHeader: {
                        maximumAmount: 'AT13_MAXIMUOM477',
                        amountRequestedOriginal: 'AT20_AMOUNTGE477',
                        frequency: 'AT28_FREQUENC477',
                        isCandidate: 'AT45_ISCANDII477',
                        displacement: 'AT36_GRACERHO477',
                        frequencyRevolving: 'AT54_FREQUEVL477',
                        bCBlackListsClient: 'AT74_BCBLACLS477',
                        previousCreditAmount: 'AT75_PREVIOIU477',
                        amountDisbursed: 'AT94_AMOUNTSS477',
                        termInd: 'AT94_TERMINDD477',
                        stageflux: 'AT_RIG477AGFX85',
                        RejectionExcuse: 'AT_RIG477AONC36',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        AmountApproved: 'AT_RIG477AUPR26',
                        CityCredit: 'AT_RIG477CIDI98',
                        Country: 'AT_RIG477COTR74',
                        CreditTarget: 'AT_RIG477CRET05',
                        IsWarrantyDestination: 'AT_RIG477DSIN93',
                        CreditSector: 'AT_RIG477EDCT30',
                        RejectionReason: 'AT_RIG477EIEA32',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Office: 'AT_RIG477FICE32',
                        OfficerName: 'AT_RIG477FNME01',
                        HousingCount: 'AT_RIG477GCUN35',
                        InitialDate: 'AT_RIG477IALT55',
                        IsDebtorOwner: 'AT_RIG477IBTO19',
                        ActivityNumber: 'AT_RIG477IIMB92',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        CityCode: 'AT_RIG477ITCE46',
                        ClientSector: 'AT_RIG477LIEN42',
                        AmountAprobed: 'AT_RIG477MICI25',
                        AmountCalculated: 'AT_RIG477MNLA18',
                        NumberLine: 'AT_RIG477NMLN54',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        OfficerId: 'AT_RIG477OERD27',
                        Province: 'AT_RIG477OINC84',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        AmountRequested: 'AT_RIG477OQUE10',
                        ProductType: 'AT_RIG477PEOE42',
                        PortfolioType: 'AT_RIG477POLY58',
                        Quota: 'AT_RIG477QUOA32',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        IDRequested: 'AT_RIG477RQSD66',
                        ProductFIE: 'AT_RIG477RUCE24',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Score: 'AT_RIG477SCOR35',
                        ScoreType: 'AT_RIG477SOET77',
                        TermLimit: 'AT_RIG477TEIM91',
                        Term: 'AT_RIG477TERM59',
                        ActivityDestination: 'AT_RIG477TETI07',
                        Type: 'AT_RIG477TYPE69',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        UserL: 'AT_RIG477USRL75',
                        RequestLine: 'AT_RIG477UTIN05',
                        Expromission: 'AT_RIG477XSIN84',
                        TypeRequest: 'AT_RIG477YPRU27',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Context: {
                        amountApproved: 'AT10_AMOUNTPP762',
                        channel: 'AT17_CHANNELL762',
                        officeName: 'AT22_OFFICEME762',
                        amountRequested: 'AT37_AMOUNTUE762',
                        cycleNumber: 'AT60_CYCLENEM762',
                        synchronize: 'AT88_SYNCHRZZ762',
                        enable: 'AT91_ENABLEZV762',
                        ApplicationSubject: 'AT_CON762ACAO34',
                        Application: 'AT_CON762APCI65',
                        Bookmark: 'AT_CON762BKAK11',
                        CustomerId: 'AT_CON762CSTE68',
                        RequestId: 'AT_CON762EUTD32',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        TaskSubject: 'AT_CON762TSUT41',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
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
                    Alicuota: {
                        Alicuota: 'AT_ALI010ALTA79',
                        AlicuotaCertificada: 'AT_ALI010CCAA81',
                        CtaAhorros: 'AT_ALI010TAOR48',
                        AlicuotaAhorro: 'AT_ALI010TCTC66',
                        CtaCertificada: 'AT_ALI010TTCD43',
                        _pks: [],
                        _entityId: 'EN_ALICUOTAT010',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    NewAliquot: {
                        ejecutivo: 'AT42_EJECUTIV835',
                        idEjecutivo: 'AT48_IDEJECIO835',
                        referencia: 'AT58_REFERENI835',
                        _pks: [],
                        _entityId: 'EN_NEWALIQOT_835',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    FieldByProductValues: {
                        value: 'AT_EYP548ALUE01',
                        requestId: 'AT_EYP548ETID93',
                        fieldId: 'AT_EYP548FELD94',
                        productId: 'AT_EYP548PDCI73',
                        _pks: [],
                        _entityId: 'EN_EYPRODULE548',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    EntidadInfo: {
                        nuevoDestino: 'AT32_NUEVODST519',
                        insurancePackage: 'AT44_INSURAPG519',
                        termMedicalAssistance: 'AT59_TERMMEAS519',
                        banca: 'AT71_BANCAONL519',
                        ubicacion: 'AT72_UBICACNI519',
                        geographicalDestination: 'AT80_GEOGRATD519',
                        fechaProceso: 'AT81_FECHAPOC519',
                        destEconomicoDescription: 'AT_ENI519EIIR12',
                        destinoEconomico: 'AT_ENI519ENEO19',
                        lineaCredito: 'AT_ENI519ERTO37',
                        destEconomicoBusqueda: 'AT_ENI519MIUS48',
                        destinoFinanciero: 'AT_ENI519OCRI94',
                        otroDestino: 'AT_ENI519OEIO78',
                        oficina: 'AT_ENI519ORTR52',
                        sector: 'AT_ENI519SETO20',
                        tipoProducto: 'AT_ENI519TIRC04',
                        _pks: [],
                        _entityId: 'EN_ENIDADINO519',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ApplicationInfoAux: {
                        ingresosMensuales: 'AT13_INGRESME240',
                        reasonNotAccepted: 'AT18_REASONCC240',
                        nivelColectivo: 'AT35_NIVELCLL240',
                        isEntrepreneurship: 'AT41_ISENTRUI240',
                        isPartner: 'AT42_ISPARTRR240',
                        monthlyPaymentCapacity: 'AT51_MONTHLCT240',
                        colectivo: 'AT53_COLECTIO240',
                        groupAcceptRenew: 'AT58_GROUPAWW240',
                        isPromotion: 'AT63_ISPROMIN240',
                        percentageGuarantee: 'AT86_PERCENGT240',
                        customerExperience: 'AT92_CUSTOMPC240',
                        _pks: [],
                        _entityId: 'EN_APPLICANF_240',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Aval: {
                        riskLevel: 'AT21_RISKLELE667',
                        rFC: 'AT26_RFCSSMOC667',
                        creditBureau: 'AT57_CREDITBA667',
                        bcBlacklists: 'AT79_BCBLACSI667',
                        customerName: 'AT85_CUSTOMAE667',
                        idCustomer: 'AT99_IDCUSTOR667',
                        _pks: [],
                        _entityId: 'EN_AVALGIHQU_667',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_BOREGEEL_0798 = {
                autoCrud: false
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
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_BOREGEEL_0798_filters = {};
            var defaultValues = {
                OriginalHeader: {},
                Context: {},
                DebtorGeneral: {},
                Alicuota: {},
                NewAliquot: {},
                FieldByProductValues: {},
                EntidadInfo: {},
                ApplicationInfoAux: {},
                Aval: {}
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
                $scope.vc.execute("temporarySave", VC_OIIRL51_CNLTO_343, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_OIIRL51_CNLTO_343, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_OIIRL51_CNLTO_343, data, function() {});
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
            $scope.vc.viewState.VC_OIIRL51_CNLTO_343 = {
                style: []
            }
            //ViewState - Container: GenericApplication
            $scope.vc.createViewState({
                id: "VC_OIIRL51_CNLTO_343",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_AYMENRQET_54450",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_VW_tittleProcess
            $scope.vc.createViewState({
                id: "VC_OIIRL51_EAERK_091",
                hasId: true,
                componentStyle: ["cabecera"],
                label: 'T_VW_tittleProcess',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.OriginalHeader = {
                maximumAmount: $scope.vc.channelDefaultValues("OriginalHeader", "maximumAmount"),
                amountRequestedOriginal: $scope.vc.channelDefaultValues("OriginalHeader", "amountRequestedOriginal"),
                frequency: $scope.vc.channelDefaultValues("OriginalHeader", "frequency"),
                isCandidate: $scope.vc.channelDefaultValues("OriginalHeader", "isCandidate"),
                displacement: $scope.vc.channelDefaultValues("OriginalHeader", "displacement"),
                frequencyRevolving: $scope.vc.channelDefaultValues("OriginalHeader", "frequencyRevolving"),
                bCBlackListsClient: $scope.vc.channelDefaultValues("OriginalHeader", "bCBlackListsClient"),
                previousCreditAmount: $scope.vc.channelDefaultValues("OriginalHeader", "previousCreditAmount"),
                amountDisbursed: $scope.vc.channelDefaultValues("OriginalHeader", "amountDisbursed"),
                termInd: $scope.vc.channelDefaultValues("OriginalHeader", "termInd"),
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                RejectionExcuse: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionExcuse"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                IsWarrantyDestination: $scope.vc.channelDefaultValues("OriginalHeader", "IsWarrantyDestination"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                IsDebtorOwner: $scope.vc.channelDefaultValues("OriginalHeader", "IsDebtorOwner"),
                ActivityNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityNumber"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                AmountAprobed: $scope.vc.channelDefaultValues("OriginalHeader", "AmountAprobed"),
                AmountCalculated: $scope.vc.channelDefaultValues("OriginalHeader", "AmountCalculated"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                PortfolioType: $scope.vc.channelDefaultValues("OriginalHeader", "PortfolioType"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                ProductFIE: $scope.vc.channelDefaultValues("OriginalHeader", "ProductFIE"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Score: $scope.vc.channelDefaultValues("OriginalHeader", "Score"),
                ScoreType: $scope.vc.channelDefaultValues("OriginalHeader", "ScoreType"),
                TermLimit: $scope.vc.channelDefaultValues("OriginalHeader", "TermLimit"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                ActivityDestination: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityDestination"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest")
            };
            //ViewState - Group: GrpTittleManual
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_02",
                hasId: true,
                componentStyle: ["cb-without-margins"],
                htmlSection: true,
                label: 'GrpTittleManual',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_02-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                amountApproved: $scope.vc.channelDefaultValues("Context", "amountApproved"),
                channel: $scope.vc.channelDefaultValues("Context", "channel"),
                officeName: $scope.vc.channelDefaultValues("Context", "officeName"),
                amountRequested: $scope.vc.channelDefaultValues("Context", "amountRequested"),
                cycleNumber: $scope.vc.channelDefaultValues("Context", "cycleNumber"),
                synchronize: $scope.vc.channelDefaultValues("Context", "synchronize"),
                enable: $scope.vc.channelDefaultValues("Context", "enable"),
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject")
            };
            //ViewState - Group: GrpContextHide
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_03",
                hasId: true,
                componentStyle: [],
                label: 'GrpContextHide',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_03-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: GrpVertical
            $scope.vc.createViewState({
                id: "VC_OIIRL51_SNNMB_699",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DEUDORESN_35493",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GrpTabGeneralData
            $scope.vc.createViewState({
                id: "VC_OIIRL51_TBRMT_122",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_INACINGEE_97154",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_HeaderView
            $scope.vc.createViewState({
                id: "VC_OIIRL51_GREEG_881",
                hasId: true,
                componentStyle: [],
                label: 'T_HeaderView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_03",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.EntidadInfo = {
                nuevoDestino: $scope.vc.channelDefaultValues("EntidadInfo", "nuevoDestino"),
                insurancePackage: $scope.vc.channelDefaultValues("EntidadInfo", "insurancePackage"),
                termMedicalAssistance: $scope.vc.channelDefaultValues("EntidadInfo", "termMedicalAssistance"),
                banca: $scope.vc.channelDefaultValues("EntidadInfo", "banca"),
                ubicacion: $scope.vc.channelDefaultValues("EntidadInfo", "ubicacion"),
                geographicalDestination: $scope.vc.channelDefaultValues("EntidadInfo", "geographicalDestination"),
                fechaProceso: $scope.vc.channelDefaultValues("EntidadInfo", "fechaProceso"),
                destEconomicoDescription: $scope.vc.channelDefaultValues("EntidadInfo", "destEconomicoDescription"),
                destinoEconomico: $scope.vc.channelDefaultValues("EntidadInfo", "destinoEconomico"),
                lineaCredito: $scope.vc.channelDefaultValues("EntidadInfo", "lineaCredito"),
                destEconomicoBusqueda: $scope.vc.channelDefaultValues("EntidadInfo", "destEconomicoBusqueda"),
                destinoFinanciero: $scope.vc.channelDefaultValues("EntidadInfo", "destinoFinanciero"),
                otroDestino: $scope.vc.channelDefaultValues("EntidadInfo", "otroDestino"),
                oficina: $scope.vc.channelDefaultValues("EntidadInfo", "oficina"),
                sector: $scope.vc.channelDefaultValues("EntidadInfo", "sector"),
                tipoProducto: $scope.vc.channelDefaultValues("EntidadInfo", "tipoProducto")
            };
            //ViewState - Group: GrpCredit
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_05",
                hasId: true,
                componentStyle: [],
                label: 'GrpCredit',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EntidadInfo, Attribute: oficina
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_ORTR915",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_OFICINAJD_61287",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_ORTR915 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ORIAHEADER8605_ORTR915', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_ORTR915'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8605_ORTR915");
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
            //ViewState - Entity: EntidadInfo, Attribute: tipoProducto
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_TIRC927",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_TIPOPROUC_25332",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_TIRC927 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8605_TIRC927', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_TIRC927'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8605_TIRC927");
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
            //ViewState - Entity: EntidadInfo, Attribute: banca
            $scope.vc.createViewState({
                id: "VA_BANCAEQGJPXCNHY_767R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SECTORHNT_83985",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BANCAEQGJPXCNHY_767R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BANCAEQGJPXCNHY_767R86', 'cl_banca_cliente', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BANCAEQGJPXCNHY_767R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BANCAEQGJPXCNHY_767R86");
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
            //ViewState - Entity: EntidadInfo, Attribute: geographicalDestination
            $scope.vc.createViewState({
                id: "VA_GEOGRAPHICALSIS_291R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_DESTINOOG_14742",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GEOGRAPHICALSIS_291R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GEOGRAPHICALSIS_291R86', 'cl_provincia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GEOGRAPHICALSIS_291R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GEOGRAPHICALSIS_291R86");
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
            //ViewState - Entity: EntidadInfo, Attribute: nuevoDestino
            $scope.vc.createViewState({
                id: "VA_NUEVODESTINOIJR_765R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DESTINOPJ_77271",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NUEVODESTINOIJR_765R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NUEVODESTINOIJR_765R86', 'cr_destino', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NUEVODESTINOIJR_765R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NUEVODESTINOIJR_765R86");
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
            //ViewState - Entity: EntidadInfo, Attribute: fechaProceso
            $scope.vc.createViewState({
                id: "VA_FECHAPROCESOHHQ_118R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FECHAPRSO_84086",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_0000790",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GRUOP_HEADER
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_02",
                hasId: true,
                componentStyle: [],
                label: 'GRUOP_HEADER',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: CurrencyRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_URQT595",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_RENEQESED_71054",
                label: "BUSIN.LBL_BUSIN_MONEDASDA_58672",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8602_URQT595 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8602_URQT595', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8602_URQT595'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8602_URQT595");
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
            //ViewState - Entity: OriginalHeader, Attribute: AmountRequested
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_OQUE134",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_AMOUTREED_14545",
                label: "BUSIN.DLB_BUSIN_MTOOCITAO_93139",
                format: "#,##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 104,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: amountDisbursed
            $scope.vc.createViewState({
                id: "VA_AMOUNTDISBURSEE_600R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MONOEEMOO_46223",
                format: "#,##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: AmountAprobed
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_MICI826",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_MNTAPRODO_28697",
                label: "BUSIN.LBL_BUSIN_MONTOAUZA_30681",
                format: "#,##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 68,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: maximumAmount
            $scope.vc.createViewState({
                id: "VA_MAXIMUMAMOUNTTT_215R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_MONTOMXIO_63957",
                format: "#,##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: OriginalHeader, Attribute: previousCreditAmount
            $scope.vc.createViewState({
                id: "VA_PREVIOUSCREDUOT_690R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_MONTODEET_85229",
                format: "#,##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group1977
            $scope.vc.createViewState({
                id: "G_HEADERVWEW_946R86",
                hasId: true,
                componentStyle: [],
                label: 'Group1977',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EntidadInfo, Attribute: insurancePackage
            $scope.vc.createViewState({
                id: "VA_INSURANCEPACKEG_674R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_PAQUETESU_28038",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_INSURANCEPACKEG_674R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_INSURANCEPACKEG_674R86', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_INSURANCEPACKEG_674R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_INSURANCEPACKEG_674R86");
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
            //ViewState - Entity: EntidadInfo, Attribute: termMedicalAssistance
            $scope.vc.createViewState({
                id: "VA_TERMMEDICALAISS_991R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_PLAZOASAI_88717",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TERMMEDICALAISS_991R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TERMMEDICALAISS_991R86', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TERMMEDICALAISS_991R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    catalogResponse = $scope.vc.convertCatalog(catalogResponse);
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TERMMEDICALAISS_991R86");
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
            //ViewState - Group: GrpContextHide
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_06",
                hasId: true,
                componentStyle: [],
                label: 'GrpContextHide',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: OriginalHeader, Attribute: Term
            $scope.vc.createViewState({
                id: "VA_TERMLJXTQBYRQKU_619R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TERMLJXTQBYRQKU_619R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TERMLJXTQBYRQKU_619R86', 'cr_plazo_grp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TERMLJXTQBYRQKU_619R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TERMLJXTQBYRQKU_619R86");
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
            //ViewState - Entity: OriginalHeader, Attribute: displacement
            $scope.vc.createViewState({
                id: "VA_GRACESXJNMOZNOH_634R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_GRACIAUCV_67014",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GRACESXJNMOZNOH_634R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GRACESXJNMOZNOH_634R86', 'cr_gracia_grp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GRACESXJNMOZNOH_634R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GRACESXJNMOZNOH_634R86");
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
            //ViewState - Entity: OriginalHeader, Attribute: PaymentFrequency
            $scope.vc.createViewState({
                id: "VA_PAYMENTFREQUECN_439R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PAYMENTFREQUECN_439R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_PAYMENTFREQUECN_439R86', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_PAYMENTFREQUECN_439R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_PAYMENTFREQUECN_439R86");
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
            //ViewState - Group: Group1539
            $scope.vc.createViewState({
                id: "G_HEADERVEEI_218R86",
                hasId: true,
                componentStyle: [],
                label: 'Group1539',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: frequency
            $scope.vc.createViewState({
                id: "VA_FREQUENCYLTUZDL_595R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_FREQUENCYLTUZDL_595R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_FREQUENCYLTUZDL_595R86', 'cr_tplazo_ind', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_FREQUENCYLTUZDL_595R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_FREQUENCYLTUZDL_595R86");
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
            //ViewState - Entity: OriginalHeader, Attribute: termInd
            $scope.vc.createViewState({
                id: "VA_TERMINDTMTELITU_695R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PLAZORQOZ_36959",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TERMINDTMTELITU_695R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TERMINDTMTELITU_695R86', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TERMINDTMTELITU_695R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TERMINDTMTELITU_695R86");
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
            //ViewState - Group: Group1850
            $scope.vc.createViewState({
                id: "G_HEADERVIIE_769R86",
                hasId: true,
                componentStyle: [],
                label: 'Group1850',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: frequencyRevolving
            $scope.vc.createViewState({
                id: "VA_7694PEJSETHIYUL_239R86",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RUECYTERM_46135",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_7694PEJSETHIYUL_239R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_7694PEJSETHIYUL_239R86', 'ca_periodicidad_lcr', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_7694PEJSETHIYUL_239R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_7694PEJSETHIYUL_239R86");
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
            //ViewState - Group: Group1357
            $scope.vc.createViewState({
                id: "G_HEADERVIWW_443R86",
                hasId: true,
                componentStyle: [],
                label: 'Group1357',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: bCBlackListsClient
            $scope.vc.createViewState({
                id: "VA_BCBLACKLISTSCLL_583R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_LISTASNEN_57708",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BCBLACKLISTSCLL_583R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_BCBLACKLISTSCLL_583R86");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: OriginalHeader, Attribute: AmountCalculated
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_MNLA393",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                format: "#,##0.00",
                suffix: "MX",
                decimals: 2,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORCSEN_968R86",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: OriginalHeader, Attribute: TermLimit
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8602_TEIM754",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.ApplicationInfoAux = {
                ingresosMensuales: $scope.vc.channelDefaultValues("ApplicationInfoAux", "ingresosMensuales"),
                reasonNotAccepted: $scope.vc.channelDefaultValues("ApplicationInfoAux", "reasonNotAccepted"),
                nivelColectivo: $scope.vc.channelDefaultValues("ApplicationInfoAux", "nivelColectivo"),
                isEntrepreneurship: $scope.vc.channelDefaultValues("ApplicationInfoAux", "isEntrepreneurship"),
                isPartner: $scope.vc.channelDefaultValues("ApplicationInfoAux", "isPartner"),
                monthlyPaymentCapacity: $scope.vc.channelDefaultValues("ApplicationInfoAux", "monthlyPaymentCapacity"),
                colectivo: $scope.vc.channelDefaultValues("ApplicationInfoAux", "colectivo"),
                groupAcceptRenew: $scope.vc.channelDefaultValues("ApplicationInfoAux", "groupAcceptRenew"),
                isPromotion: $scope.vc.channelDefaultValues("ApplicationInfoAux", "isPromotion"),
                percentageGuarantee: $scope.vc.channelDefaultValues("ApplicationInfoAux", "percentageGuarantee"),
                customerExperience: $scope.vc.channelDefaultValues("ApplicationInfoAux", "customerExperience")
            };
            //ViewState - Group: Group1692
            $scope.vc.createViewState({
                id: "G_HEADERVWWE_335R86",
                hasId: true,
                componentStyle: [],
                label: 'Group1692',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: isPromotion
            $scope.vc.createViewState({
                id: "VA_COMBOBOXTQEDQWM_929R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ESPROMONN_19127",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COMBOBOXTQEDQWM_929R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_COMBOBOXTQEDQWM_929R86");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: isEntrepreneurship
            $scope.vc.createViewState({
                id: "VA_COMBOBOXAURNLPO_247R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ESEMPRETI_61211",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COMBOBOXAURNLPO_247R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_COMBOBOXAURNLPO_247R86");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: percentageGuarantee
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLZA_843R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_PORCENTAA_43033",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: groupAcceptRenew
            $scope.vc.createViewState({
                id: "VA_COMBOBOXGTFCJFR_317R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_GRUPOACVN_44000",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COMBOBOXGTFCJFR_317R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_COMBOBOXGTFCJFR_317R86");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: isPartner
            $scope.vc.createViewState({
                id: "VA_ISPARTNERZBPHXB_883R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ESPARTNEE_11826",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ISPARTNERZBPHXB_883R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_ISPARTNERZBPHXB_883R86");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: reasonNotAccepted
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRXU_762R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_RAZNNOAPC_31235",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: customerExperience
            $scope.vc.createViewState({
                id: "VA_CUSTOMEREXPEIII_577R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_EXPERIEEC_82964",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ApplicationInfoAux, Attribute: nivelColectivo
            $scope.vc.createViewState({
                id: "VA_NIVELCOLECTIOVO_641R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_NIVELDEEN_30775",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NIVELCOLECTIOVO_641R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NIVELCOLECTIOVO_641R86', 'cl_nivel_cliente_colectivo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NIVELCOLECTIOVO_641R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NIVELCOLECTIOVO_641R86");
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
            //ViewState - Entity: ApplicationInfoAux, Attribute: monthlyPaymentCapacity
            $scope.vc.createViewState({
                id: "VA_INGRESOSMENSUUE_680R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CAPACIDPU_94388",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2950
            $scope.vc.createViewState({
                id: "G_HEADERVIEI_541R86",
                hasId: true,
                componentStyle: [],
                label: 'Group2950',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EntidadInfo, Attribute: lineaCredito
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_ERTO640",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CREDILINE_85557",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_ERTO640 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8605_ERTO640', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_ERTO640'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8605_ERTO640");
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
            //ViewState - Entity: EntidadInfo, Attribute: sector
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_SETO998",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SEGMENTOZ_60870",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_SETO998 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8605_SETO998', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_SETO998'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8605_SETO998");
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
            //ViewState - Entity: EntidadInfo, Attribute: destinoFinanciero
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_OCRI261",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FNAALPOEL_12452",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_OCRI261 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8605_OCRI261', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_OCRI261'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8605_OCRI261");
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
            //ViewState - Entity: EntidadInfo, Attribute: otroDestino
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_OEIO709",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DESTINOPJ_77271",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_OEIO709 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8605_OEIO709', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_OEIO709'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8605_OEIO709");
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
                id: "VA_ORIAHEADER8605_0000740",
                componentStyle: [],
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_EIIR755",
                componentStyle: [],
                imageId: "glyphicon glyphicon-align-justify",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: EntidadInfo, Attribute: destEconomicoBusqueda
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_MIUS039",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_OOMICPRPE_26369",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8605_MIUS039 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8605_MIUS039', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8605_MIUS039'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            maxRecords: 20,
                            filterType: 'contains'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: EntidadInfo, Attribute: destinoEconomico
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8605_ENEO318",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_OOMICPRPE_26369",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: EntidadInfo, Attribute: ubicacion
            $scope.vc.createViewState({
                id: "VA_UBICACIONCNXOET_652R86",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_DESTINOOG_14742",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_UBICACIONCNXOET_652R86 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_UBICACIONCNXOET_652R86', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_UBICACIONCNXOET_652R86'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_UBICACIONCNXOET_652R86");
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
                id: "Spacer1253",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: GrpTabAditionalInfo
            $scope.vc.createViewState({
                id: "VC_OIIRL51_PTONI_284",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_INACINAIL_35055",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_alicutoaView
            $scope.vc.createViewState({
                id: "VC_OIIRL51_RCUOA_445",
                hasId: true,
                componentStyle: [],
                label: 'T_alicutoaView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GrpGeneral
            $scope.vc.createViewState({
                id: "GR_AIUTOAVIEW91_02",
                hasId: true,
                componentStyle: [],
                label: 'GrpGeneral',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Alicuota = {
                Alicuota: $scope.vc.channelDefaultValues("Alicuota", "Alicuota"),
                AlicuotaCertificada: $scope.vc.channelDefaultValues("Alicuota", "AlicuotaCertificada"),
                CtaAhorros: $scope.vc.channelDefaultValues("Alicuota", "CtaAhorros"),
                AlicuotaAhorro: $scope.vc.channelDefaultValues("Alicuota", "AlicuotaAhorro"),
                CtaCertificada: $scope.vc.channelDefaultValues("Alicuota", "CtaCertificada")
            };
            //ViewState - Group: GrpAlicuota
            $scope.vc.createViewState({
                id: "GR_ORIAHEADER86_08",
                hasId: true,
                componentStyle: [],
                label: 'GrpAlicuota',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Alicuota, Attribute: Alicuota
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8608_ALTA466",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ALICOTABL_50131",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.catalogs.VA_ORIAHEADER8608_ALTA466 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8608_ALTA466', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8608_ALTA466'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, null, 0);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_ORIAHEADER8608_ALTA466 !== "undefined") {}
            //ViewState - Entity: Alicuota, Attribute: CtaCertificada
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8608_TTCD057",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CNCRTIABL_07186",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8608_TTCD057 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8608_TTCD057', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8608_TTCD057'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8608_TTCD057");
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
            //ViewState - Entity: Alicuota, Attribute: AlicuotaCertificada
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8608_CCAA829",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_AERTIICBL_89553",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8608_CCAA829 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8608_CCAA829', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8608_CCAA829'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8608_CCAA829");
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
            //ViewState - Entity: Alicuota, Attribute: CtaAhorros
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8608_TAOR020",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_UETAHOROB_42868",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8608_TAOR020 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8608_TAOR020', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8608_TAOR020'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8608_TAOR020");
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
            //ViewState - Entity: Alicuota, Attribute: AlicuotaAhorro
            $scope.vc.createViewState({
                id: "VA_ORIAHEADER8608_TCTC534",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_OTAAHOOSL_39722",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ORIAHEADER8608_TCTC534 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ORIAHEADER8608_TCTC534', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ORIAHEADER8608_TCTC534'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ORIAHEADER8608_TCTC534");
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
            $scope.vc.model.NewAliquot = {
                ejecutivo: $scope.vc.channelDefaultValues("NewAliquot", "ejecutivo"),
                idEjecutivo: $scope.vc.channelDefaultValues("NewAliquot", "idEjecutivo"),
                referencia: $scope.vc.channelDefaultValues("NewAliquot", "referencia")
            };
            //ViewState - Group: Group1946
            $scope.vc.createViewState({
                id: "G_ALICUTOWVE_602W91",
                hasId: true,
                componentStyle: [],
                label: 'Group1946',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NewAliquot, Attribute: referencia
            $scope.vc.createViewState({
                id: "VA_REFERENCIASNASR_958W91",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_REERENCIA_20799",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NewAliquot, Attribute: ejecutivo
            $scope.vc.createViewState({
                id: "VA_EJECUTIVOZUEHTQ_752W91",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_EJECUTIVOZUEHTQ_752W91 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_EJECUTIVOZUEHTQ_752W91', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_EJECUTIVOZUEHTQ_752W91'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_EJECUTIVOZUEHTQ_752W91");
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
            //ViewState - Group: GrpSeccionRenderizada
            $scope.vc.createViewState({
                id: "GR_AIUTOAVIEW91_04",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: "BUSIN.DLB_BUSIN_CFICNIIOA_41747",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "GR_AIUTOAVIEW91_04-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: GrpTabDebtors
            $scope.vc.createViewState({
                id: "VC_OIIRL51_GTDOS_515",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DEUDORESN_35493",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: T_BorrowerView
            $scope.vc.createViewState({
                id: "VC_OIIRL51_GPOOG_815",
                hasId: true,
                componentStyle: [],
                label: 'T_BorrowerView',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_BORRWRVIEW27_03",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: BorrowerGroup
            $scope.vc.createViewState({
                id: "GR_BORRWRVIEW27_83",
                hasId: true,
                componentStyle: [],
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
                    },
                    customerType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "customerType", '')
                    },
                    rfc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "rfc", '')
                    },
                    creditBureau: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "creditBureau", '')
                    },
                    riskLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebtorGeneral", "riskLevel", '')
                    }
                }
            });
            $scope.vc.model.DebtorGeneral = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_BOREGEEL_0798';
                            var queryRequest = $scope.vc.getRequestQuery_Q_BOREGEEL_0798();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_BOREG0798_55',
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'DebtorGeneral',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_BOREG0798_55', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                            nameEntityGrid: 'DebtorGeneral',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_BOREG0798_55', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.DebtorGeneral
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
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
            $scope.vc.grids.QV_BOREG0798_55.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_BOREG0798_55.events = {
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
                    $scope.vc.hideShowColumns("QV_BOREG0798_55", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_BOREG0798_55.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_BOREG0798_55 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_BOREG0798_55 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_BOREG0798_55.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_BOREG0798_55.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                    $(grid.tbody).off("click", "td");
                    $(grid.tbody).on("click", "td", function(event) {
                        if (!$scope.vc.isColumnOfButton(this)) {
                            $scope.vc.gridRowChange(grid, "DebtorGeneral", $scope);
                        }
                    });
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
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
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
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
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
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.CustomerName = {
                title: 'BUSIN.LBL_BUSIN_NOMBREQUW_22902',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
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
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_NAMEFDOFF_74379'|translate}}",
                        'id': "VA_BORRWRVIEW2783_CUST678",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.CustomerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.CustomerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Role = {
                title: 'BUSIN.LBL_BUSIN_ROLBPGPTF_33542',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_ROLEVJMGD_53686',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
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
                        $scope.vc.loadCatalogCobis(
                            'VA_BORRWRVIEW2783_ROLE954',
                            'cr_cat_deudor',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_BORRWRVIEW2783_ROLE954'];
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
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342ROLE73 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.Role.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_ROLEVJMGD_53686'|translate}}",
                        'id': "VA_BORRWRVIEW2783_ROLE954",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.Role.style',
                        'k-data-source': "vc.catalogs.VA_BORRWRVIEW2783_ROLE954",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.Role.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Role.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
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
                width: 140,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
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
                        $scope.vc.loadCatalogCobis(
                            'VA_BORRWRVIEW2783_DOTD256',
                            'cl_tipo_documento',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_BORRWRVIEW2783_DOTD256'];
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
            $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DOTD15 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TIPOOMETO_33623'|translate}}",
                        'id': "VA_BORRWRVIEW2783_DOTD256",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.style',
                        'k-data-source': "vc.catalogs.VA_BORRWRVIEW2783_DOTD256",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.template",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
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
                title: 'BUSIN.LBL_BUSIN_NMEROIDFE_94745',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_IFICTNBER_84824',
                width: 130,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
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
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_IFICTNBER_84824'|translate}}",
                        'id': "VA_BORRWRVIEW2783_IDEN901",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Identification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Identification.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.Qualification = {
                title: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_CALIFCAIN_39502',
                width: 0,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
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
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_CALIFCAIN_39502'|translate}}",
                        'id': "VA_BORRWRVIEW2783_UALN736",
                        'maxlength': 5,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.Qualification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.Qualification.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC = {
                title: 'BUSIN.DLB_BUSIN_FECHACICY_04196',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
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
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_BORRWRVIEW2783_DTCC540",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.DateCIC.validationCode}}",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.DateCIC.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.customerType = {
                title: 'BUSIN.LBL_BUSIN_TIPODHYWV_93685',
                titleArgs: {},
                tooltip: 'BUSIN.LBL_BUSIN_TIPODHYWV_93685',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLHN_200_83',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT38_CUSTOMER342 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.customerType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'title': "{{'BUSIN.LBL_BUSIN_TIPODHYWV_93685'|translate}}",
                        'id': "VA_TEXTINPUTBOXLHN_200_83",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.customerType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.customerType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.rfc = {
                title: 'BUSIN.LBL_BUSIN_RFCSUHLQM_72983',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVHR_216_83',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT94_RFCNDBHX342 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.rfc.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVHR_216_83",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.rfc.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.rfc.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.creditBureau = {
                title: 'BUSIN.LBL_BUSIN_BURCRDITO_63241',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHUV_230_83',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT45_CREDITUU342 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.creditBureau.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHUV_230_83",
                        'maxlength': 11,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.creditBureau.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.creditBureau.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_BOREG0798_55.column.riskLevel = {
                title: 'riskLevel',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEKJ_712_83',
                element: []
            };
            $scope.vc.grids.QV_BOREG0798_55.AT37_RISKLEVV342 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_BOREG0798_55.column.riskLevel.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEKJ_712_83",
                        'maxlength': 12,
                        'data-validation-code': "{{vc.viewState.QV_BOREG0798_55.column.riskLevel.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_BORRWRVIEW27_03,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_BOREG0798_55.column.riskLevel.style"
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.CustomerCode, \"QV_BOREG0798_55\", \"CustomerCode\"):kendo.toString(#=CustomerCode#, vc.viewState.QV_BOREG0798_55.column.CustomerCode.format)'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.CustomerName.style' ng-bind='vc.getStringColumnFormat(dataItem.CustomerName, \"QV_BOREG0798_55\", \"CustomerName\")'></span>",
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Role.style' ng-bind='vc.catalogs.VA_BORRWRVIEW2783_ROLE954.get(dataItem.Role).value'> </span>",
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.TypeDocumentId.style' ng-bind='vc.catalogs.VA_BORRWRVIEW2783_DOTD256.get(dataItem.TypeDocumentId).value'> </span>",
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
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Identification.style' ng-bind='vc.getStringColumnFormat(dataItem.Identification, \"QV_BOREG0798_55\", \"Identification\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Identification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Identification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Identification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'Qualification',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.Qualification.title|translate:vc.viewState.QV_BOREG0798_55.column.Qualification.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT_DEB342UALN46.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.Qualification.style' ng-bind='vc.getStringColumnFormat(dataItem.Qualification, \"QV_BOREG0798_55\", \"Qualification\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.Qualification.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.Qualification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.Qualification.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'DateCIC',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.DateCIC.title|translate:vc.viewState.QV_BOREG0798_55.column.DateCIC.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_BOREG0798_55', 'DateCIC', $scope.vc.grids.QV_BOREG0798_55.AT_DEB342DTCC73.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_BOREG0798_55', 'DateCIC', "<span ng-class='vc.viewState.QV_BOREG0798_55.column.DateCIC.style'>#=((DateCIC !== null) ? kendo.toString(DateCIC, 'd') : '')#</span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.DateCIC.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.DateCIC.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.DateCIC.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'customerType',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.customerType.title|translate:vc.viewState.QV_BOREG0798_55.column.customerType.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.customerType.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.customerType.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT38_CUSTOMER342.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.customerType.style' ng-bind='vc.getStringColumnFormat(dataItem.customerType, \"QV_BOREG0798_55\", \"customerType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.customerType.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.customerType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.customerType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'rfc',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.rfc.title|translate:vc.viewState.QV_BOREG0798_55.column.rfc.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.rfc.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.rfc.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT94_RFCNDBHX342.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.rfc.style' ng-bind='vc.getStringColumnFormat(dataItem.rfc, \"QV_BOREG0798_55\", \"rfc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.rfc.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.rfc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.rfc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'creditBureau',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.creditBureau.title|translate:vc.viewState.QV_BOREG0798_55.column.creditBureau.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.creditBureau.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.creditBureau.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_BOREG0798_55', 'creditBureau', $scope.vc.grids.QV_BOREG0798_55.AT45_CREDITUU342.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_BOREG0798_55', 'creditBureau', "<span ng-class='vc.viewState.QV_BOREG0798_55.column.creditBureau.style' ng-bind='vc.getStringColumnFormat(dataItem.creditBureau, \"QV_BOREG0798_55\", \"creditBureau\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.creditBureau.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.creditBureau.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.creditBureau.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_BOREG0798_55.columns.push({
                    field: 'riskLevel',
                    title: '{{vc.viewState.QV_BOREG0798_55.column.riskLevel.title|translate:vc.viewState.QV_BOREG0798_55.column.riskLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_BOREG0798_55.column.riskLevel.width,
                    format: $scope.vc.viewState.QV_BOREG0798_55.column.riskLevel.format,
                    editor: $scope.vc.grids.QV_BOREG0798_55.AT37_RISKLEVV342.control,
                    template: "<span ng-class='vc.viewState.QV_BOREG0798_55.column.riskLevel.style' ng-bind='vc.getStringColumnFormat(dataItem.riskLevel, \"QV_BOREG0798_55\", \"riskLevel\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_BOREG0798_55.column.riskLevel.style",
                        "title": "{{vc.viewState.QV_BOREG0798_55.column.riskLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_BOREG0798_55.column.riskLevel.hidden
                });
            }
            $scope.vc.viewState.QV_BOREG0798_55.column.cmdEdition = {};
            $scope.vc.viewState.QV_BOREG0798_55.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_BOREG0798_55.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: {
                    template: "<span class='cb-commands'></span>"
                },
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: $scope.vc.viewState.QV_BOREG0798_55.column.cmdEdition.hidden,
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
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_BOREG0798_55.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_BORRWRVIEW27_83.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_BOREG0798_55_719",
                "text": "{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}",
                "template": "<button id='CEQV_201_QV_BOREG0798_55_719' " + " ng-if='vc.viewState.QV_BOREG0798_55.toolbar.CEQV_201_QV_BOREG0798_55_719.visible' " + "ng-disabled = 'vc.viewState.GR_BORRWRVIEW27_83.disabled?true:false' " + "data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_BOREG0798_55_719\",\"DebtorGeneral\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand' title=\"{{'BUSIN.DLB_BUSIN_DELETEVPS_36022'|translate}}\"> #: text #</button>"
            }]; //ViewState - Container: GrpVertical
            $scope.vc.createViewState({
                id: "VC_ZVXQIUJDIP_665L51",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_AVALQIPBS_74862",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: Aval
            $scope.vc.createViewState({
                id: "VC_VUWZJBLTFU_511224",
                hasId: true,
                componentStyle: [],
                label: 'Aval',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Aval = {
                riskLevel: $scope.vc.channelDefaultValues("Aval", "riskLevel"),
                rFC: $scope.vc.channelDefaultValues("Aval", "rFC"),
                creditBureau: $scope.vc.channelDefaultValues("Aval", "creditBureau"),
                bcBlacklists: $scope.vc.channelDefaultValues("Aval", "bcBlacklists"),
                customerName: $scope.vc.channelDefaultValues("Aval", "customerName"),
                idCustomer: $scope.vc.channelDefaultValues("Aval", "idCustomer")
            };
            //ViewState - Group: Group1761
            $scope.vc.createViewState({
                id: "G_AVALYYFLUZ_643576",
                hasId: true,
                componentStyle: [],
                label: 'Group1761',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Aval, Attribute: customerName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGRN_916576",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_NOMBREQUW_22902",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONFUIXKXW_718576",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_BURNZSSWW_65851",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: Aval, Attribute: rFC
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTZP_819576",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_RFCSUHLQM_72983",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2511",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2481",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Aval, Attribute: bcBlacklists
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGOR_345576",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_BCYLISTAI_20806",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2202",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1738",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_82_OIIRL51_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_82_OIIRL51_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Save
            $scope.vc.createViewState({
                id: "CM_OIIRL51SVE80",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TFLCRE_8_TCR",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SINCRONIZ_41027",
                enabled: designer.constants.mode.All
            });
            //ViewState - Command: Print
            $scope.vc.createViewState({
                id: "CM_OIIRL51INT80",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_IMPRIMIRH_85279",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command5
            $scope.vc.createViewState({
                id: "CM_TFLCRE_8_IO1",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Command: Command4
            $scope.vc.createViewState({
                id: "CM_TFLCRE_8__II",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VALIDARCC_44212",
                enabled: designer.constants.mode.All
            });
            //ViewState - Command: Command6
            $scope.vc.createViewState({
                id: "CM_TFLCRE_8_925",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_GUARDAROG_36302",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.FieldByProductValues = {
                value: $scope.vc.channelDefaultValues("FieldByProductValues", "value"),
                requestId: $scope.vc.channelDefaultValues("FieldByProductValues", "requestId"),
                fieldId: $scope.vc.channelDefaultValues("FieldByProductValues", "fieldId"),
                productId: $scope.vc.channelDefaultValues("FieldByProductValues", "productId")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_ORIAHEADER8608_ALTA466.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_ROLE954.read();
                    $scope.vc.catalogs.VA_BORRWRVIEW2783_DOTD256.read();
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
                $scope.vc.render('VC_OIIRL51_CNLTO_343');
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
    var cobisMainModule = cobis.createModule("VC_OIIRL51_CNLTO_343", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_OIIRL51_CNLTO_343", {
            templateUrl: "VC_OIIRL51_CNLTO_343_FORM.html",
            controller: "VC_OIIRL51_CNLTO_343_CTRL",
            labelId: "BUSIN.DLB_BUSIN_AYMENRQET_54450",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_OIIRL51_CNLTO_343?" + $.param(search);
            }
        });
        VC_OIIRL51_CNLTO_343(cobisMainModule);
    }]);
} else {
    VC_OIIRL51_CNLTO_343(cobisMainModule);
}