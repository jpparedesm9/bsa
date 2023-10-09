//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.customercomposite = designerEvents.api.customercomposite || designer.dsgEvents();

function VC_CUSTOMEROI_208680(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CUSTOMEROI_208680_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CUSTOMEROI_208680_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CUSTOMERCOETP_680",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CUSTOMEROI_208680",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CUSTOMERCOETP_680",
        designerEvents.api.customercomposite,
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
                vcName: 'VC_CUSTOMEROI_208680'
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
                    taskId: 'T_CUSTOMERCOETP_680',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CustomerTmp: "CustomerTmp",
                    VirtualAddress: "VirtualAddress",
                    PhysicalAddress: "PhysicalAddress",
                    Context: "Context",
                    EconomicInformation: "EconomicInformation",
                    DemographicData: "DemographicData",
                    SpousePerson: "SpousePerson",
                    ScannedDocumentsDetail: "ScannedDocumentsDetail",
                    DocumentsUpload: "DocumentsUpload",
                    GeneralData: "GeneralData",
                    OriginalHeader: "OriginalHeader",
                    NaturalPerson: "NaturalPerson",
                    Person: "Person",
                    Parameters: "Parameters",
                    Entity2: "Entity2",
                    RelationPerson: "RelationPerson",
                    RelationContext: "RelationContext",
                    Business: "Business",
                    CustomerTmpBusiness: "CustomerTmpBusiness",
                    ComplementaryRequestData: "ComplementaryRequestData"
                },
                entities: {
                    CustomerTmp: {
                        code: 'AT42_CODEBJDS376',
                        paramVamail: 'AT42_PARAMVLI376',
                        _pks: [],
                        _entityId: 'EN_CUSTOMEPP_376',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VirtualAddress: {
                        addressTypeDescription: 'AT31_PHYSICPD566',
                        addressId: 'AT41_PHYSICRE566',
                        addressType: 'AT77_ADDRESPP566',
                        addressDescription: 'AT84_COUNTRYY566',
                        personSecuential: 'AT85_PERSONNA566',
                        _pks: [],
                        _entityId: 'EN_PHYSICADS_566',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PhysicalAddress: {
                        sameAddressHome: 'AT12_SAMEADRO495',
                        countryCode: 'AT17_VIRTUASI495',
                        directionNumberInternal: 'AT20_DIRECTEI495',
                        longitude: 'AT34_LONGITDE495',
                        addressTypeDescription: 'AT34_PHYSICDE495',
                        addressType: 'AT41_ADDRESYS495',
                        neigborhoodCode: 'AT41_NEIGBOOE495',
                        provinceCode: 'AT42_PROVINDE495',
                        cityPoblation: 'AT46_CITYPOAT495',
                        reference: 'AT47_REFERECE495',
                        street: 'AT47_STREETBU495',
                        isShippingAddress: 'AT50_ISSHIPAS495',
                        isChecked: 'AT52_ISCHECDD495',
                        parishDescription: 'AT53_PARISHOI495',
                        paramVASMS: 'AT55_PARAMVMA495',
                        cityDescription: 'AT64_CITYDEPC495',
                        mail: 'AT66_MAILCDOZ495',
                        addressId: 'AT68_ADDRESDI495',
                        latitude: 'AT69_DEGREEDD495',
                        postalCode: 'AT69_POSTALOO495',
                        addressDescription: 'AT71_ADDRESIE495',
                        urbanType: 'AT71_URBANTEP495',
                        ownershipType: 'AT72_OWNERSHY495',
                        addressMessage: 'AT74_ADDRESSE495',
                        countryDescription: 'AT74_VIRTUARS495',
                        monthsInForce: 'AT75_MONTHSNE495',
                        residenceTime: 'AT78_RESIDEET495',
                        isMainAddress: 'AT79_ISMAINDE495',
                        neighborhoodcode: 'AT80_NEIGHBDR495',
                        neighborhood: 'AT81_NEIGHBHR495',
                        cityCode: 'AT83_CITYCODE495',
                        provinceDescription: 'AT85_PROVINEP495',
                        businessCode: 'AT87_BUSINESD495',
                        department: 'AT87_DEPARTNM495',
                        personSecuential: 'AT90_PERSONNN495',
                        directionNumber: 'AT91_DIRECTIO495',
                        parishCode: 'AT92_PARISHCO495',
                        numberOfResidents: 'AT95_NUMBERSR495',
                        _pks: [],
                        _entityId: 'EN_VIRTUALEA_495',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        flag1: 'AT15_APPLICTM215',
                        flag2: 'AT15_FLAG2FIG215',
                        flag3: 'AT19_FLAG3XYE215',
                        renapoByCurp: 'AT21_RENAPORP215',
                        parents: 'AT25_PARENTSS215',
                        channel: 'AT29_CHANNELL215',
                        couple: 'AT33_COUPLEPS215',
                        married: 'AT41_MARRIEDD215',
                        minimumAge: 'AT41_MINIMUAG215',
                        accountIndividual: 'AT44_ACCOUNND215',
                        freeUnion: 'AT52_FREEUNNI215',
                        nameReport: 'AT52_NAMERERP215',
                        collectiveLevel: 'AT55_COLLECET215',
                        officeName: 'AT61_OFFICEAE215',
                        maximumAge: 'AT62_MAXIMUAA215',
                        son: 'AT70_SONFRKEM215',
                        mailState: 'AT79_MAILSTTT215',
                        defaultCountry: 'AT84_DEFAULYR215',
                        collective: 'AT85_COLLECVI215',
                        generateReport: 'AT85_GENERATP215',
                        roleEnabledQueryAccount: 'AT86_ROLEENBO215',
                        addressState: 'AT89_ADDRESST215',
                        renapo: 'AT89_RENAPOOT215',
                        printReport: 'AT90_PRINTRRT215',
                        roleEnabledDataModRequest: 'AT90_ROLEENUD215',
                        _pks: [],
                        _entityId: 'EN_CREDITLBQ_215',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    EconomicInformation: {
                        hasOtherIncome: 'AT10_HASOTHNE754',
                        personType: 'AT22_PERSONEP754',
                        operatingCost: 'AT23_OPERATTO754',
                        availableTotal: 'AT31_AVAILAAL754',
                        expenseLevel: 'AT32_EXPENSEE754',
                        liabilities: 'AT33_LIABILEI754',
                        personSecuential: 'AT33_PERSONNN754',
                        monthlyTrxAmount: 'AT38_MONTHLAU754',
                        assets: 'AT45_ASSETSIP754',
                        categoryALM: 'AT53_CATEGOLM754',
                        tutorId: 'AT54_TUTORIDD754',
                        monthlyIncome: 'AT56_MONTHLOI754',
                        availableIncome: 'AT64_AVAILAMN754',
                        businessYears: 'AT66_BUSINEAA754',
                        availableBalance: 'AT70_AVAILAAL754',
                        tutorName: 'AT74_TUTORNEA754',
                        isLinked: 'AT75_ISLINKDE754',
                        otherIncomes: 'AT77_OTHERINO754',
                        sales: 'AT81_SALESVIV754',
                        otherIncomeSource: 'AT84_OTHERIRC754',
                        relationId: 'AT85_RELATIDI754',
                        salesCost: 'AT87_SALESCOO754',
                        businessIncome: 'AT92_BUSINEOO754',
                        availableResults: 'AT94_AVAILABE754',
                        retentionSubject: 'AT94_RETENTCN754',
                        internalQualification: 'AT96_INTERNIQ754',
                        _pks: [],
                        _entityId: 'EN_ECONOMIOT_754',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DemographicData: {
                        profession: 'AT12_PROFESON602',
                        residenceCountry: 'AT18_COUNTRSR602',
                        disabilityType: 'AT30_DISABIYL602',
                        hasDisability: 'AT44_HASDISIB602',
                        personSecuential: 'AT49_PERSONST602',
                        whichProfession: 'AT60_WHICHPRE602',
                        studiesLevel: 'AT62_STUDIEVE602',
                        housingType: 'AT73_HOUSINTY602',
                        template: 'AT87_TEMPLATT602',
                        dependents: 'AT90_DEPENDTS602',
                        _pks: ['profession'],
                        _entityId: 'EN_DEMOGRADH_602',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    SpousePerson: {
                        personSecuential: 'AT12_PERSONNA845',
                        documentNumber: 'AT17_DOCUMETN845',
                        documentTypeDescription: 'AT23_DOCUMEEP845',
                        secondName: 'AT28_SECONDME845',
                        phone: 'AT33_PHONEXES845',
                        secondSurname: 'AT35_SECONDAR845',
                        expirationDate: 'AT36_EXPIRAAO845',
                        birthDate: 'AT37_BIRTHDEA845',
                        genderCode: 'AT37_GENDEROD845',
                        personType: 'AT43_PERSONYY845',
                        firstName: 'AT58_FIRSTNMA845',
                        surname: 'AT69_SURNAMEE845',
                        genderDescription: 'AT82_GENDERNE845',
                        countryOfBirth: 'AT90_COUNTRHY845',
                        documentType: 'AT93_DOCUMEYY845',
                        identificationRFC: 'AT96_IDENTICN845',
                        _pks: [],
                        _entityId: 'EN_SPOUSEPNN_845',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ScannedDocumentsDetail: {
                        customerName: 'AT22_CUSTOMEM612',
                        typeRequest: 'AT35_TYPERESQ612',
                        uploaded: 'AT46_UPLOADDE612',
                        file: 'AT47_FILEOVTQ612',
                        processInstance: 'AT65_PROCESNA612',
                        extension: 'AT70_EXTENSIN612',
                        documentId: 'AT88_DOCUMEDI612',
                        customerId: 'AT97_CUSTOMIR612',
                        description: 'AT98_DESCRIPT612',
                        _pks: [],
                        _entityId: 'EN_SCANNEDCL_612',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DocumentsUpload: {
                        uploads: 'AT35_UPLOADSS493',
                        processInstance: 'AT36_PROCESES493',
                        clientId: 'AT59_CLIENTDI493',
                        _pks: [],
                        _entityId: 'EN_DOCUMENTO_493',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GeneralData: {
                        loanType: 'AT50_LOANTYPE827',
                        paymentFrecuencyName: 'AT58_PAYMENCU827',
                        productTypeName: 'AT58_PRODUCYP827',
                        clientId: 'AT60_CLIENTDD827',
                        symbolCurrency: 'AT62_SYMBOLEY827',
                        vinculado: 'AT63_VINCULAO827',
                        sectorNeg: 'AT82_SECTOREE827',
                        _pks: [],
                        _entityId: 'EN_GENERALAA_827',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OriginalHeader: {
                        currencyRequested: 'AT15_CURRENER498',
                        iDRequested: 'AT19_IDREQUET498',
                        term: 'AT24_TERMMYXW498',
                        subType: 'AT29_SUBTYPEE498',
                        amountAproved: 'AT30_AMOUNTPD498',
                        applicationNumber: 'AT43_APPLICNN498',
                        category: 'AT64_CATEGORY498',
                        amountRequested: 'AT71_AMOUNTEU498',
                        initialDate: 'AT71_INITIAEA498',
                        productType: 'AT73_PRODUCYY498',
                        operationNumber: 'AT75_OPERATNN498',
                        officerName: 'AT81_OFFICEAA498',
                        paymentFrequency: 'AT99_PAYMENYR498',
                        _pks: [],
                        _entityId: 'EN_ORIGINARE_498',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    NaturalPerson: {
                        nameGroup: 'AT12_NAMEGRPU593',
                        secondSurname: 'AT12_SECONDUU593',
                        birthDate: 'AT16_BIRTHDET593',
                        secondName: 'AT16_SECONDMN593',
                        hasAlert: 'AT19_HASALETT593',
                        surname: 'AT19_SURNAMEE593',
                        maritalStatusDescription: 'AT21_MARITAPC593',
                        bioCIC: 'AT22_BIOCICTP593',
                        indefinite: 'AT22_INDEFIII593',
                        nationalityCode: 'AT22_NATIONLY593',
                        santanderAccount: 'AT24_SANTANDD593',
                        firstName: 'AT25_FIRSTNME593',
                        individualRisk: 'AT26_INDIVIRL593',
                        hasPartner: 'AT27_HASPARTN593',
                        bioOCR: 'AT29_BIOOCRXM593',
                        documentTypeDescription: 'AT30_DOCUMENN593',
                        hasListBlack: 'AT31_HASLISAK593',
                        monthsInForce: 'AT33_MONTHSIN593',
                        personPEP: 'AT33_PERSONEP593',
                        chargePub: 'AT34_CHARGEPU593',
                        technologicalDegree: 'AT34_TECHNOEI593',
                        personType: 'AT35_PERSONYP593',
                        spouse: 'AT35_SPOUSEQQ593',
                        officerCode: 'AT36_OFFICEDR593',
                        statusCode: 'AT36_STATUSCE593',
                        age: 'AT38_AGEXSCCY593',
                        bioHasFingerprint: 'AT38_BIOHASII593',
                        accountIndividual: 'AT39_ACCOUNIT593',
                        documentNumber: 'AT40_DOCUMENN593',
                        marriedSurname: 'AT43_MARRIERM593',
                        countryCode: 'AT44_COUNTRBF593',
                        bioReaderKey: 'AT45_BIOREAER593',
                        expirationDate: 'AT45_EXPIRANN593',
                        email: 'AT55_EMAILJMM593',
                        riskLevel: 'AT58_RISKLEEE593',
                        personSecuential: 'AT62_PERSONTA593',
                        genderDescription: 'AT64_MARITATS593',
                        identificationRFC: 'AT65_IDENTIIN593',
                        isLinked: 'AT68_LINKEDKL593',
                        nationalityCodeAux: 'AT68_NATIONXA593',
                        relChargePub: 'AT71_RELCHAPE593',
                        genderCode: 'AT72_GENDERUC593',
                        santanderCode: 'AT73_SANTANDD593',
                        bioIdentificationType: 'AT74_BIOIDEOA593',
                        maritalStatusCode: 'AT74_MARITASO593',
                        numCycles: 'AT76_NUMCYCEE593',
                        bioEmissionNumber: 'AT79_BIOEMIRN593',
                        documentType: 'AT81_DOCUMETE593',
                        hasProblems: 'AT82_HASPROBL593',
                        publicPerson: 'AT85_PUBLICSO593',
                        knownAs: 'AT87_KNOWNASS593',
                        nivelColectivo: 'AT89_NIVELCOT593',
                        countyOfBirth: 'AT92_COUNTYRF593',
                        idGroup: 'AT92_IDGROUPP593',
                        bioRenapoResult: 'AT93_BIORENSR593',
                        colectivo: 'AT93_COLECTVV593',
                        relationId: 'AT94_RELATINI593',
                        branchCode: 'AT98_BRANCHOC593',
                        creditBureau: 'AT98_CREDITUU593',
                        _pks: [],
                        _entityId: 'EN_NATURALES_593',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Person: {
                        statusCode: 'AT26_STATUSCE767',
                        fullName: 'AT38_FULLNAEE767',
                        blocked: 'AT42_BLOCKEDD767',
                        operation: 'AT42_OPERATII767',
                        typePerson: 'AT61_TYPEPERS767',
                        office: 'AT75_OFFICEMF767',
                        santanderCode: 'AT76_SANTANRC767',
                        official: 'AT77_OFFICILL767',
                        personSecuential: 'AT89_PERSONCA767',
                        _pks: [],
                        _entityId: 'EN_PERSONUDL_767',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Parameters: {
                        minimumAge: 'AT43_MINIMUAE311',
                        screenMode: 'AT50_SCREENMD311',
                        allowUpdateNames: 'AT79_ALLOWUNA311',
                        idExpiration: 'AT93_IDEXPIRT311',
                        refresGrid: 'AT97_REFRESDR311',
                        _pks: [],
                        _entityId: 'EN_PARAMETER_311',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Entity2: {
                        attribute1: 'AT02_1VJEZBOL806',
                        _pks: [],
                        _entityId: 'EN_2GIDTYAGL_806',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RelationPerson: {
                        secuentialPersonLeft: 'AT23_UBCXGLUZ414',
                        namePersonLeft: 'AT26_NAMEPEOS414',
                        namePersonRight: 'AT35_NAMEPEHT414',
                        nameRelation: 'AT64_NAMEREIO414',
                        secuentialPersonRight: 'AT80_SECUENLR414',
                        side: 'AT90_SIDEPBTC414',
                        relationId: 'AT95_RELATIII414',
                        _pks: [],
                        _entityId: 'EN_RELATIOSS_414',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    RelationContext: {
                        secuential: 'AT60_SECUENII716',
                        relatioId: 'AT67_RELATIIO716',
                        _pks: [],
                        _entityId: 'EN_RELATIONC_716',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Business: {
                        colony: 'AT11_COLONYKL830',
                        customerCode: 'AT13_CUSTOMER830',
                        phone: 'AT13_PHONEWJC830',
                        economicActivity: 'AT14_ECONOMVA830',
                        street: 'AT17_STREETFK830',
                        economicActivityDesc: 'AT22_ECONOMVC830',
                        typeLocal: 'AT22_TYPELOAC830',
                        mountlyIncomes: 'AT27_MOUNTLEO830',
                        areEntrepreneur: 'AT35_AREENTPE830',
                        numberOfBusiness: 'AT46_NUMBERSI830',
                        postalCode: 'AT48_POSTALCE830',
                        whichResource: 'AT48_WHICHRCE830',
                        timeBusinessAddress: 'AT53_TIMEBUES830',
                        state: 'AT60_STATEHSX830',
                        timeActivity: 'AT61_TIMEACYI830',
                        resources: 'AT72_RESOUREC830',
                        country: 'AT73_COUNTRYY830',
                        code: 'AT77_CODESODR830',
                        municipality: 'AT78_MUNICILL830',
                        dateBusiness: 'AT82_CREDITAA830',
                        creditDestination: 'AT87_CREDITIO830',
                        turnaround: 'AT90_TURNARDO830',
                        locations: 'AT91_LOCATIOO830',
                        names: 'AT98_NAMESVED830',
                        _pks: [],
                        _entityId: 'EN_BUSINESSS_830',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CustomerTmpBusiness: {
                        code: 'AT51_CODEUXLP105',
                        _pks: [],
                        _entityId: 'EN_CUSTOMEIR_105',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ComplementaryRequestData: {
                        bureauBackground: 'AT15_BUREAUCK873',
                        recruitmentChannel: 'AT15_RECRUINL873',
                        landlineOne: 'AT18_LANDLIEN873',
                        electronicSignature: 'AT40_ELECTRUS873',
                        professionalActivity: 'AT40_PROFESVC873',
                        customerCode: 'AT47_CUSTOMDE873',
                        landlineTwo: 'AT52_LANDLITN873',
                        personNameMessages: 'AT52_PERSONEA873',
                        ifeNumber: 'AT63_IFENUMBE873',
                        country: 'AT66_COUNTRYY873',
                        passportNumber: 'AT84_PASSPOUR873',
                        phoneErrands: 'AT84_PHONEERN873',
                        isCryptoUsed: 'AT85_ISCRYPEO873',
                        _pks: [],
                        _entityId: 'EN_COMPLEMRR_873',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_SCANNELD_7463 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_SCANNELD_7463 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_SCANNELD_7463_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_SCANNELD_7463_filters;
                    parametersAux = {
                        customerId: filters.customerId,
                        processInstance: filters.processInstance,
                        typeRequest: filters.typeRequest
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SCANNEDCL_612',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_SCANNELD_7463',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['customerId'] = this.filters.customerId;
                            this.parameters['processInstance'] = this.filters.processInstance;
                            this.parameters['typeRequest'] = this.filters.typeRequest;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_SCANNELD_7463_filters = {};
            $scope.vc.queryProperties.Q_RELATION_6114 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_RELATION_6114 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RELATION_6114_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RELATION_6114_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RELATIOSS_414',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RELATION_6114',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_RELATION_6114_filters = {};
            $scope.vc.queryProperties.Q_BUSINESS_6359 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_BUSINESS_6359 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_BUSINESS_6359_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_BUSINESS_6359_filters;
                    parametersAux = {
                        code: filters.code
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_BUSINESSS_830',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_BUSINESS_6359',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['code'] = this.filters.code;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_BUSINESS_6359_filters = {};
            $scope.vc.queryProperties.Q_VIRTUALD_9303 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_VIRTUALD_9303 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_VIRTUALD_9303_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_VIRTUALD_9303_filters;
                    parametersAux = {
                        addressId: filters.addressId,
                        personalSecuential: filters.personalSecuential
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PHYSICADS_566',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_VIRTUALD_9303',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['addressId'] = this.filters.addressId;
                            this.parameters['personalSecuential'] = this.filters.personalSecuential;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_VIRTUALD_9303_filters = {};
            $scope.vc.queryProperties.Q_PHYSICDS_4851 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_PHYSICDS_4851 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PHYSICDS_4851_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PHYSICDS_4851_filters;
                    parametersAux = {
                        addressId: filters.addressId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_VIRTUALEA_495',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PHYSICDS_4851',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['addressId'] = this.filters.addressId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_PHYSICDS_4851_filters = {};
            var defaultValues = {
                CustomerTmp: {},
                VirtualAddress: {},
                PhysicalAddress: {},
                Context: {},
                EconomicInformation: {},
                DemographicData: {},
                SpousePerson: {},
                ScannedDocumentsDetail: {},
                DocumentsUpload: {},
                GeneralData: {},
                OriginalHeader: {},
                NaturalPerson: {},
                Person: {},
                Parameters: {},
                Entity2: {},
                RelationPerson: {},
                RelationContext: {},
                Business: {},
                CustomerTmpBusiness: {},
                ComplementaryRequestData: {}
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
                $scope.vc.execute("temporarySave", VC_CUSTOMEROI_208680, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CUSTOMEROI_208680, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CUSTOMEROI_208680, data, function() {});
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
            $scope.vc.viewState.VC_CUSTOMEROI_208680 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_CUSTOMEROI_208680",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_MANTENIED_75126",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_NPSSYEMMIT_755680",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LegalPersonHeader
            $scope.vc.createViewState({
                id: "VC_GFYMYAUYRL_480749",
                hasId: true,
                componentStyle: [],
                label: 'LegalPersonHeader',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1579
            $scope.vc.createViewState({
                id: "G_LEGALPEOEE_264688",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1579',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1852
            $scope.vc.createViewState({
                id: "G_LEGALPEARR_339688",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1852',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_LEGALPEARR_339688-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_DDRWXFYTSU_498680",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: CustomerGeneralInfForm
            $scope.vc.createViewState({
                id: "VC_KXWIBTYNCU_272226",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INACINGEE_61728",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Person = {
                statusCode: $scope.vc.channelDefaultValues("Person", "statusCode"),
                fullName: $scope.vc.channelDefaultValues("Person", "fullName"),
                blocked: $scope.vc.channelDefaultValues("Person", "blocked"),
                operation: $scope.vc.channelDefaultValues("Person", "operation"),
                typePerson: $scope.vc.channelDefaultValues("Person", "typePerson"),
                office: $scope.vc.channelDefaultValues("Person", "office"),
                santanderCode: $scope.vc.channelDefaultValues("Person", "santanderCode"),
                official: $scope.vc.channelDefaultValues("Person", "official"),
                personSecuential: $scope.vc.channelDefaultValues("Person", "personSecuential")
            };
            //ViewState - Group: Group1954
            $scope.vc.createViewState({
                id: "G_CUSTOMEGNN_387213",
                hasId: true,
                componentStyle: [],
                label: 'Group1954',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Person, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_9366OENXNWUBACV_720213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SECUENCCN_71871",
                format: "##########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Person, Attribute: santanderCode
            $scope.vc.createViewState({
                id: "VA_SANTANDERCODEEE_700213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOSAAA_38846",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Person, Attribute: typePerson
            $scope.vc.createViewState({
                id: "VA_TYPEPERSONLSDIM_548213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPONLGNZ_38251",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEPERSONLSDIM_548213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPEPERSONLSDIM_548213', 'cl_tipo_persona', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPEPERSONLSDIM_548213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TYPEPERSONLSDIM_548213");
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
            //ViewState - Entity: Person, Attribute: statusCode
            $scope.vc.createViewState({
                id: "VA_STATUSCODEMPXFC_766213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOXKN_15577",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_STATUSCODEMPXFC_766213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_STATUSCODEMPXFC_766213', 'cl_estados_ente', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_STATUSCODEMPXFC_766213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_STATUSCODEMPXFC_766213");
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
            //ViewState - Entity: Person, Attribute: blocked
            $scope.vc.createViewState({
                id: "VA_BLOCKEDZUOBRBYZ_833213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOXKN_15577",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1753
            $scope.vc.createViewState({
                id: "G_CUSTOMEEIR_814213",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1753',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.NaturalPerson = {
                nameGroup: $scope.vc.channelDefaultValues("NaturalPerson", "nameGroup"),
                secondSurname: $scope.vc.channelDefaultValues("NaturalPerson", "secondSurname"),
                birthDate: $scope.vc.channelDefaultValues("NaturalPerson", "birthDate"),
                secondName: $scope.vc.channelDefaultValues("NaturalPerson", "secondName"),
                hasAlert: $scope.vc.channelDefaultValues("NaturalPerson", "hasAlert"),
                surname: $scope.vc.channelDefaultValues("NaturalPerson", "surname"),
                maritalStatusDescription: $scope.vc.channelDefaultValues("NaturalPerson", "maritalStatusDescription"),
                bioCIC: $scope.vc.channelDefaultValues("NaturalPerson", "bioCIC"),
                indefinite: $scope.vc.channelDefaultValues("NaturalPerson", "indefinite"),
                nationalityCode: $scope.vc.channelDefaultValues("NaturalPerson", "nationalityCode"),
                santanderAccount: $scope.vc.channelDefaultValues("NaturalPerson", "santanderAccount"),
                firstName: $scope.vc.channelDefaultValues("NaturalPerson", "firstName"),
                individualRisk: $scope.vc.channelDefaultValues("NaturalPerson", "individualRisk"),
                hasPartner: $scope.vc.channelDefaultValues("NaturalPerson", "hasPartner"),
                bioOCR: $scope.vc.channelDefaultValues("NaturalPerson", "bioOCR"),
                documentTypeDescription: $scope.vc.channelDefaultValues("NaturalPerson", "documentTypeDescription"),
                hasListBlack: $scope.vc.channelDefaultValues("NaturalPerson", "hasListBlack"),
                monthsInForce: $scope.vc.channelDefaultValues("NaturalPerson", "monthsInForce"),
                personPEP: $scope.vc.channelDefaultValues("NaturalPerson", "personPEP"),
                chargePub: $scope.vc.channelDefaultValues("NaturalPerson", "chargePub"),
                technologicalDegree: $scope.vc.channelDefaultValues("NaturalPerson", "technologicalDegree"),
                personType: $scope.vc.channelDefaultValues("NaturalPerson", "personType"),
                spouse: $scope.vc.channelDefaultValues("NaturalPerson", "spouse"),
                officerCode: $scope.vc.channelDefaultValues("NaturalPerson", "officerCode"),
                statusCode: $scope.vc.channelDefaultValues("NaturalPerson", "statusCode"),
                age: $scope.vc.channelDefaultValues("NaturalPerson", "age"),
                bioHasFingerprint: $scope.vc.channelDefaultValues("NaturalPerson", "bioHasFingerprint"),
                accountIndividual: $scope.vc.channelDefaultValues("NaturalPerson", "accountIndividual"),
                documentNumber: $scope.vc.channelDefaultValues("NaturalPerson", "documentNumber"),
                marriedSurname: $scope.vc.channelDefaultValues("NaturalPerson", "marriedSurname"),
                countryCode: $scope.vc.channelDefaultValues("NaturalPerson", "countryCode"),
                bioReaderKey: $scope.vc.channelDefaultValues("NaturalPerson", "bioReaderKey"),
                expirationDate: $scope.vc.channelDefaultValues("NaturalPerson", "expirationDate"),
                email: $scope.vc.channelDefaultValues("NaturalPerson", "email"),
                riskLevel: $scope.vc.channelDefaultValues("NaturalPerson", "riskLevel"),
                personSecuential: $scope.vc.channelDefaultValues("NaturalPerson", "personSecuential"),
                genderDescription: $scope.vc.channelDefaultValues("NaturalPerson", "genderDescription"),
                identificationRFC: $scope.vc.channelDefaultValues("NaturalPerson", "identificationRFC"),
                isLinked: $scope.vc.channelDefaultValues("NaturalPerson", "isLinked"),
                nationalityCodeAux: $scope.vc.channelDefaultValues("NaturalPerson", "nationalityCodeAux"),
                relChargePub: $scope.vc.channelDefaultValues("NaturalPerson", "relChargePub"),
                genderCode: $scope.vc.channelDefaultValues("NaturalPerson", "genderCode"),
                santanderCode: $scope.vc.channelDefaultValues("NaturalPerson", "santanderCode"),
                bioIdentificationType: $scope.vc.channelDefaultValues("NaturalPerson", "bioIdentificationType"),
                maritalStatusCode: $scope.vc.channelDefaultValues("NaturalPerson", "maritalStatusCode"),
                numCycles: $scope.vc.channelDefaultValues("NaturalPerson", "numCycles"),
                bioEmissionNumber: $scope.vc.channelDefaultValues("NaturalPerson", "bioEmissionNumber"),
                documentType: $scope.vc.channelDefaultValues("NaturalPerson", "documentType"),
                hasProblems: $scope.vc.channelDefaultValues("NaturalPerson", "hasProblems"),
                publicPerson: $scope.vc.channelDefaultValues("NaturalPerson", "publicPerson"),
                knownAs: $scope.vc.channelDefaultValues("NaturalPerson", "knownAs"),
                nivelColectivo: $scope.vc.channelDefaultValues("NaturalPerson", "nivelColectivo"),
                countyOfBirth: $scope.vc.channelDefaultValues("NaturalPerson", "countyOfBirth"),
                idGroup: $scope.vc.channelDefaultValues("NaturalPerson", "idGroup"),
                bioRenapoResult: $scope.vc.channelDefaultValues("NaturalPerson", "bioRenapoResult"),
                colectivo: $scope.vc.channelDefaultValues("NaturalPerson", "colectivo"),
                relationId: $scope.vc.channelDefaultValues("NaturalPerson", "relationId"),
                branchCode: $scope.vc.channelDefaultValues("NaturalPerson", "branchCode"),
                creditBureau: $scope.vc.channelDefaultValues("NaturalPerson", "creditBureau")
            };
            //ViewState - Group: Group2980
            $scope.vc.createViewState({
                id: "G_CUSTOMEEAN_819213",
                hasId: true,
                componentStyle: [],
                label: 'Group2980',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: firstName
            $scope.vc.createViewState({
                id: "VA_FIRSTNAMEFPYKAF_649213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondName
            $scope.vc.createViewState({
                id: "VA_SECONDNAMESJJYD_721213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDOEN_22809",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: surname
            $scope.vc.createViewState({
                id: "VA_SURNAMESONBWSJR_285213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondSurname
            $scope.vc.createViewState({
                id: "VA_SECONDSURNAMEEE_733213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: santanderCode
            $scope.vc.createViewState({
                id: "VA_SANTANDERCODEEE_693213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOSAAA_38846",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_DOCUMENTTYPEAQM_964213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_IDENTIFII_74621",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTTYPEAQM_964213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_DOCUMENTTYPEAQM_964213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTTYPEAQM_964213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTTYPEAQM_964213");
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
            //ViewState - Entity: NaturalPerson, Attribute: documentNumber
            $scope.vc.createViewState({
                id: "VA_DOCUMENTNUMBRRE_960213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODOCM_93257",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: identificationRFC
            $scope.vc.createViewState({
                id: "VA_IDENTIFICATICCC_741213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RFCCGUEPZ_59640",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioRenapoResult
            $scope.vc.createViewState({
                id: "VA_BIORENAPORESTLT_770213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADORAO_58902",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BIORENAPORESTLT_770213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BIORENAPORESTLT_770213', 'cl_respuesta_renapo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BIORENAPORESTLT_770213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BIORENAPORESTLT_770213");
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
            //ViewState - Entity: NaturalPerson, Attribute: expirationDate
            $scope.vc.createViewState({
                id: "VA_EXPIRATIONDAEET_157213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VENCIMIIC_88444",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: indefinite
            $scope.vc.createViewState({
                id: "VA_INDEFINITEHGXSF_717213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INDEFINDD_73604",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: genderCode
            $scope.vc.createViewState({
                id: "VA_GENDERCODEUTLBL_276213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GENEROEHS_60662",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GENDERCODEUTLBL_276213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GENDERCODEUTLBL_276213', 'cl_sexo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GENDERCODEUTLBL_276213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GENDERCODEUTLBL_276213");
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
            //ViewState - Entity: NaturalPerson, Attribute: birthDate
            $scope.vc.createViewState({
                id: "VA_BIRTHDATEEXJMQR_157213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETE_15731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: age
            $scope.vc.createViewState({
                id: "VA_AGEBOBZMCLMVRPC_425213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_EDADCZEWZ_28093",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: nationalityCodeAux
            $scope.vc.createViewState({
                id: "VA_NATIONALITYCEUD_733213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NACIONADA_99184",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NATIONALITYCEUD_733213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NATIONALITYCEUD_733213', 'cl_nacionalidad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NATIONALITYCEUD_733213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NATIONALITYCEUD_733213");
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
            //ViewState - Entity: NaturalPerson, Attribute: nationalityCode
            $scope.vc.createViewState({
                id: "VA_NATIONALITYCEDE_860213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASDENACT_53001",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NATIONALITYCEDE_860213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_NATIONALITYCEDE_860213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_NATIONALITYCEDE_860213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NATIONALITYCEDE_860213");
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
            //ViewState - Entity: NaturalPerson, Attribute: countyOfBirth
            $scope.vc.createViewState({
                id: "VA_COUNTYOFBIRTHHH_881213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DENACIMTN_68832",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COUNTYOFBIRTHHH_881213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COUNTYOFBIRTHHH_881213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COUNTYOFBIRTHHH_881213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COUNTYOFBIRTHHH_881213");
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
            //ViewState - Entity: NaturalPerson, Attribute: maritalStatusCode
            $scope.vc.createViewState({
                id: "VA_MARITALSTATUDCC_635213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOCLI_62371",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_MARITALSTATUDCC_635213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_MARITALSTATUDCC_635213', 'cl_ecivil', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_MARITALSTATUDCC_635213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_MARITALSTATUDCC_635213");
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
            //ViewState - Entity: NaturalPerson, Attribute: branchCode
            $scope.vc.createViewState({
                id: "VA_BRANCHCODEYMGYZ_548213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SUCURSANE_97906",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BRANCHCODEYMGYZ_548213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BRANCHCODEYMGYZ_548213', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BRANCHCODEYMGYZ_548213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BRANCHCODEYMGYZ_548213");
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
            //ViewState - Entity: NaturalPerson, Attribute: officerCode
            $scope.vc.createViewState({
                id: "VA_OFFICERCODEBNMM_892213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OFICIALOO_32160",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFFICERCODEBNMM_892213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFFICERCODEBNMM_892213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFFICERCODEBNMM_892213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICERCODEBNMM_892213");
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
            //ViewState - Group: Group2415
            $scope.vc.createViewState({
                id: "G_CUSTOMENEF_379213",
                hasId: true,
                componentStyle: [],
                label: 'Group2415',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioIdentificationType
            $scope.vc.createViewState({
                id: "VA_BIOIDENTIFICPON_671213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOIDENA_34496",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BIOIDENTIFICPON_671213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BIOIDENTIFICPON_671213', 'cl_tipo_identif_bio', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BIOIDENTIFICPON_671213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BIOIDENTIFICPON_671213");
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
            //ViewState - Entity: NaturalPerson, Attribute: bioEmissionNumber
            $scope.vc.createViewState({
                id: "VA_BIOEMISSIONNRER_925213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROEMSS_16133",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioOCR
            $scope.vc.createViewState({
                id: "VA_BIOOCRWLTNZPKPV_627213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OCRTSJTOG_74280",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioReaderKey
            $scope.vc.createViewState({
                id: "VA_BIOREADERKEYGIL_809213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CLAVEELEC_39076",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioCIC
            $scope.vc.createViewState({
                id: "VA_BIOCICLKEOYOTBY_860213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CICQWKFMH_28550",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioHasFingerprint
            $scope.vc.createViewState({
                id: "VA_BIOHASFINGERRRR_235213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PERSONAST_97760",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1900
            $scope.vc.createViewState({
                id: "G_CUSTOMEEAG_441213",
                hasId: true,
                componentStyle: [],
                label: 'Group1900',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: hasProblems
            $scope.vc.createViewState({
                id: "VA_HASPROBLEMSUGXJ_814213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_EMPROBLOE_40030",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: personPEP
            $scope.vc.createViewState({
                id: "VA_PERSONPEPVOMMIN_199213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PERSONAPP_72606",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: chargePub
            $scope.vc.createViewState({
                id: "VA_CHARGEPUBGMPRKN_954213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_QUFUNCIEA_15102",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1595",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: publicPerson
            $scope.vc.createViewState({
                id: "VA_PUBLICPERSONWEB_369213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_USTEDOAHN_97623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: relChargePub
            $scope.vc.createViewState({
                id: "VA_RELCHARGEPUBFLT_742213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_QUPARENOT_52722",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RELCHARGEPUBFLT_742213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RELCHARGEPUBFLT_742213', 'cl_parentesco', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RELCHARGEPUBFLT_742213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RELCHARGEPUBFLT_742213");
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
                id: "Spacer2440",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: accountIndividual
            $scope.vc.createViewState({
                id: "VA_ACCOUNTINDIVIDU_206213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CUENTAILI_97010",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONRNZGSZY_345213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RCUENTAKR_41365",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: numCycles
            $scope.vc.createViewState({
                id: "VA_2243MMLUVKLVURR_784213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NROSDECET_24618",
                format: "####",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: hasPartner
            $scope.vc.createViewState({
                id: "VA_2752DHFODUBOKGB_166213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PARTNERHY_33027",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: hasListBlack
            $scope.vc.createViewState({
                id: "VA_2792JAYJXHGFXEG_699213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_LISTASNEE_99868",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONQGYEKJY_245213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_AUXLULFCN_62992",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: creditBureau
            $scope.vc.createViewState({
                id: "VA_CREDITBUREAUEXI_626213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BURCRDITT_49242",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: riskLevel
            $scope.vc.createViewState({
                id: "VA_RISKLEVELAWDYSV_480213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELRISE_12098",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: individualRisk
            $scope.vc.createViewState({
                id: "VA_INDIVIDUALRISSK_753213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RIESGOINL_38927",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: technologicalDegree
            $scope.vc.createViewState({
                id: "VA_TECHNOLOGICALDE_495213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTECNOIO_72518",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: colectivo
            $scope.vc.createViewState({
                id: "VA_COLECTIVOXQJYTJ_296213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOMEROO_32945",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COLECTIVOXQJYTJ_296213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_COLECTIVOXQJYTJ_296213', 'cl_tipo_mercado', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_COLECTIVOXQJYTJ_296213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COLECTIVOXQJYTJ_296213");
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
            //ViewState - Entity: NaturalPerson, Attribute: nivelColectivo
            $scope.vc.createViewState({
                id: "VA_8271RNPIOCKBAMC_691213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELCLVE_85366",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_8271RNPIOCKBAMC_691213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_8271RNPIOCKBAMC_691213', 'cl_nivel_cliente_colectivo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_8271RNPIOCKBAMC_691213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_8271RNPIOCKBAMC_691213");
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
            $scope.vc.model.Context = {
                flag1: $scope.vc.channelDefaultValues("Context", "flag1"),
                flag2: $scope.vc.channelDefaultValues("Context", "flag2"),
                flag3: $scope.vc.channelDefaultValues("Context", "flag3"),
                renapoByCurp: $scope.vc.channelDefaultValues("Context", "renapoByCurp"),
                parents: $scope.vc.channelDefaultValues("Context", "parents"),
                channel: $scope.vc.channelDefaultValues("Context", "channel"),
                couple: $scope.vc.channelDefaultValues("Context", "couple"),
                married: $scope.vc.channelDefaultValues("Context", "married"),
                minimumAge: $scope.vc.channelDefaultValues("Context", "minimumAge"),
                accountIndividual: $scope.vc.channelDefaultValues("Context", "accountIndividual"),
                freeUnion: $scope.vc.channelDefaultValues("Context", "freeUnion"),
                nameReport: $scope.vc.channelDefaultValues("Context", "nameReport"),
                collectiveLevel: $scope.vc.channelDefaultValues("Context", "collectiveLevel"),
                officeName: $scope.vc.channelDefaultValues("Context", "officeName"),
                maximumAge: $scope.vc.channelDefaultValues("Context", "maximumAge"),
                son: $scope.vc.channelDefaultValues("Context", "son"),
                mailState: $scope.vc.channelDefaultValues("Context", "mailState"),
                defaultCountry: $scope.vc.channelDefaultValues("Context", "defaultCountry"),
                collective: $scope.vc.channelDefaultValues("Context", "collective"),
                generateReport: $scope.vc.channelDefaultValues("Context", "generateReport"),
                roleEnabledQueryAccount: $scope.vc.channelDefaultValues("Context", "roleEnabledQueryAccount"),
                addressState: $scope.vc.channelDefaultValues("Context", "addressState"),
                renapo: $scope.vc.channelDefaultValues("Context", "renapo"),
                printReport: $scope.vc.channelDefaultValues("Context", "printReport"),
                roleEnabledDataModRequest: $scope.vc.channelDefaultValues("Context", "roleEnabledDataModRequest")
            };
            //ViewState - Group: Group1715
            $scope.vc.createViewState({
                id: "G_CUSTOMEFRR_977213",
                hasId: true,
                componentStyle: [],
                label: 'Group1715',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1874",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: DemographicForm
            $scope.vc.createViewState({
                id: "VC_FTDSYJBGDX_891186",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DATOSDERI_13011",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.DemographicData = {
                profession: $scope.vc.channelDefaultValues("DemographicData", "profession"),
                residenceCountry: $scope.vc.channelDefaultValues("DemographicData", "residenceCountry"),
                disabilityType: $scope.vc.channelDefaultValues("DemographicData", "disabilityType"),
                hasDisability: $scope.vc.channelDefaultValues("DemographicData", "hasDisability"),
                personSecuential: $scope.vc.channelDefaultValues("DemographicData", "personSecuential"),
                whichProfession: $scope.vc.channelDefaultValues("DemographicData", "whichProfession"),
                studiesLevel: $scope.vc.channelDefaultValues("DemographicData", "studiesLevel"),
                housingType: $scope.vc.channelDefaultValues("DemographicData", "housingType"),
                template: $scope.vc.channelDefaultValues("DemographicData", "template"),
                dependents: $scope.vc.channelDefaultValues("DemographicData", "dependents")
            };
            //ViewState - Group: Group1810
            $scope.vc.createViewState({
                id: "G_DEMOGRAHHH_501794",
                hasId: true,
                componentStyle: [],
                label: 'Group1810',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DemographicData, Attribute: residenceCountry
            $scope.vc.createViewState({
                id: "VA_4568EAAYMQKOEGY_628794",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASDEREIA_19070",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_4568EAAYMQKOEGY_628794 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_4568EAAYMQKOEGY_628794', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_4568EAAYMQKOEGY_628794'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_4568EAAYMQKOEGY_628794");
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
            //ViewState - Entity: DemographicData, Attribute: studiesLevel
            $scope.vc.createViewState({
                id: "VA_2936ZMJTGKVZWYV_843794",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELDEIS_87966",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_2936ZMJTGKVZWYV_843794 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_2936ZMJTGKVZWYV_843794', 'cl_nivel_estudio', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_2936ZMJTGKVZWYV_843794'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_2936ZMJTGKVZWYV_843794");
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
            //ViewState - Entity: DemographicData, Attribute: profession
            $scope.vc.createViewState({
                id: "VA_5585RSUWJIOZDNO_500794",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OCUPACINN_44626",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_5585RSUWJIOZDNO_500794 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_5585RSUWJIOZDNO_500794', 'cl_profesion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_5585RSUWJIOZDNO_500794'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_5585RSUWJIOZDNO_500794");
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
            //ViewState - Entity: DemographicData, Attribute: dependents
            $scope.vc.createViewState({
                id: "VA_8667DCPWKDXLAAQ_828794",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DEPENDIEN_83687",
                format: "####",
                decimals: 0,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DemographicData, Attribute: template
            $scope.vc.createViewState({
                id: "VA_9304BAVPAVKRZGV_446794",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PLANTILAA_38600",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_9304BAVPAVKRZGV_446794 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: $filter('translate')('CSTMR.LBL_CSTMR_SIEWZFPWR_22116')
                        }, {
                            code: 'N',
                            value: $filter('translate')('CSTMR.LBL_CSTMR_NODLECHKU_87821')
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_9304BAVPAVKRZGV_446794");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: DemographicData, Attribute: whichProfession
            $scope.vc.createViewState({
                id: "VA_WHICHPROFESSINI_582794",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CULZFYLDO_13438",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: CustomerSpouseForm
            $scope.vc.createViewState({
                id: "VC_GQKQIIYSWN_251604",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CONYUGEXZ_74987",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.SpousePerson = {
                personSecuential: $scope.vc.channelDefaultValues("SpousePerson", "personSecuential"),
                documentNumber: $scope.vc.channelDefaultValues("SpousePerson", "documentNumber"),
                documentTypeDescription: $scope.vc.channelDefaultValues("SpousePerson", "documentTypeDescription"),
                secondName: $scope.vc.channelDefaultValues("SpousePerson", "secondName"),
                phone: $scope.vc.channelDefaultValues("SpousePerson", "phone"),
                secondSurname: $scope.vc.channelDefaultValues("SpousePerson", "secondSurname"),
                expirationDate: $scope.vc.channelDefaultValues("SpousePerson", "expirationDate"),
                birthDate: $scope.vc.channelDefaultValues("SpousePerson", "birthDate"),
                genderCode: $scope.vc.channelDefaultValues("SpousePerson", "genderCode"),
                personType: $scope.vc.channelDefaultValues("SpousePerson", "personType"),
                firstName: $scope.vc.channelDefaultValues("SpousePerson", "firstName"),
                surname: $scope.vc.channelDefaultValues("SpousePerson", "surname"),
                genderDescription: $scope.vc.channelDefaultValues("SpousePerson", "genderDescription"),
                countryOfBirth: $scope.vc.channelDefaultValues("SpousePerson", "countryOfBirth"),
                documentType: $scope.vc.channelDefaultValues("SpousePerson", "documentType"),
                identificationRFC: $scope.vc.channelDefaultValues("SpousePerson", "identificationRFC")
            };
            //ViewState - Group: Group1523
            $scope.vc.createViewState({
                id: "G_CUSTOMERES_756425",
                hasId: true,
                componentStyle: [],
                label: 'Group1523',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: firstName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTLP_404425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: secondName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXTU_738425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDONS_72239",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: surname
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXJTN_514425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: secondSurname
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPLP_556425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: phone
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXMPZ_379425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOVK_75532",
                validationCode: 97,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: birthDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDMSIZCP_990425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETE_15731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONOARJENM_541425",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARUC_79807",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONSTVQSJN_350425",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_HVDQINWTYF_467680",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DOCUMENAD_66478",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ScannedDocumentsDetail
            $scope.vc.createViewState({
                id: "VC_VXRFEIAPAN_762966",
                hasId: true,
                componentStyle: [],
                label: 'ScannedDocumentsDetail',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1710
            $scope.vc.createViewState({
                id: "G_SCANNEDCIM_218611",
                hasId: true,
                componentStyle: [],
                label: 'Group1710',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ScannedDocumentsDetail = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "description", '')
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerId", 0)
                    },
                    uploaded: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "uploaded", '')
                    },
                    file: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "file", '')
                    },
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "documentId", '')
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "extension", '')
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerName", '')
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "processInstance", 0)
                    },
                    typeRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "typeRequest", '')
                    }
                }
            });
            $scope.vc.model.ScannedDocumentsDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_SCANNELD_7463';
                            var queryRequest = $scope.vc.getRequestQuery_Q_SCANNELD_7463();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7463_28553',
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
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Insert,
                            nameEntityGrid: 'ScannedDocumentsDetail'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_7463_28553', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ScannedDocumentsDetail',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7463_28553', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                                    nameEntityGrid: 'ScannedDocumentsDetail'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_7463_28553', argsAfterLeave);
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
                    model: $scope.vc.types.ScannedDocumentsDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7463_28553").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_SCANNELD_7463 = $scope.vc.model.ScannedDocumentsDetail;
            $scope.vc.trackers.ScannedDocumentsDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ScannedDocumentsDetail);
            $scope.vc.model.ScannedDocumentsDetail.bind('change', function(e) {
                $scope.vc.trackers.ScannedDocumentsDetail.track(e);
            });
            $scope.vc.grids.QV_7463_28553 = {};
            $scope.vc.grids.QV_7463_28553.queryId = 'Q_SCANNELD_7463';
            $scope.vc.viewState.QV_7463_28553 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7463_28553.column = {};
            $scope.vc.grids.QV_7463_28553.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_7463_28553.events = {
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
                    $scope.vc.trackers.ScannedDocumentsDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7463_28553.selectedRow = e.model;
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
                        nameEntityGrid: 'ScannedDocumentsDetail',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_7463_28553", args, function() {
                        if (args.cancel) {
                            $("#QV_7463_28553").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'ScannedDocumentsDetail',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_7463_28553", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7463_28553");
                    $scope.vc.hideShowColumns("QV_7463_28553", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7463_28553 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7463_28553 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7463_28553.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7463_28553.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7463_28553.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7463_28553.column.description = {
                title: 'CSTMR.LBL_CSTMR_DOCUMENSS_43494',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGHR_415611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT98_DESCRIPT612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGHR_415611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.customerId = {
                title: 'customerId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQGR_507611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT97_CUSTOMIR612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQGR_507611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.customerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7463_28553.column.customerId.format",
                        'k-decimals': "vc.viewState.QV_7463_28553.column.customerId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.uploaded = {
                title: 'CSTMR.LBL_CSTMR_CARGADOUC_57638',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYWQ_841611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT46_UPLOADDE612 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_7463_28553.column.uploaded.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.file = {
                title: 'CSTMR.LBL_CSTMR_ARCHIVOYO_38473',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTFB_124611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT47_FILEOVTQ612 = {
                control: function(container, options) {
                    $scope.vc.viewState.QV_7463_28553.column.file.disabledUpload = false;
                    $scope.vc.uploaders.VA_TEXTINPUTBOXTFB_124611 = {
                        maxSizeInMB: 10,
                        relativePath: null,
                        confirmUpload: false,
                        visualAttributeModel: '',
                        queryViewId: 'QV_7463_28553',
                        gridFieldName: 'file',
                        fileUploadAPI: null
                    };
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.file.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "true",
                        'id': "VA_TEXTINPUTBOXTFB_124611",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.file.validationCode}}",
                        'class': "form-control"
                    });
                    var buttonUpload = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "vc.viewState.QV_7463_28553.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-mouseup': "vc.clickFileUploader('VA_TEXTINPUTBOXTFB_124611')",
                        'ng-mousedown': "vc.grids.QV_7463_28553.events.customRowClick($event, 'VA_TEXTINPUTBOXTFB_124611', 'ScannedDocumentsDetail', 'QV_7463_28553','DSG_UPLOAD_FILE_')"
                    });
                    var buttonSuccess = $('<button />', {
                        'class': "btn btn-primary btn-block",
                        'type': "button",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"
                    });
                    var buttonRemove = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-click': "vc.removeFile('VA_TEXTINPUTBOXTFB_124611')"
                    });
                    var divRow = $('<div/>', {
                        'class': "input-group"
                    });
                    var innerDivRow = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var innerDivRow1 = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var innerDivShow = $('<div/>', {
                        'ng-show': "vc.viewState.QV_7463_28553.column.file.disabledUpload"
                    });
                    var innerDivhide = $('<div/>', {
                        'ng-hide': "vc.viewState.QV_7463_28553.column.file.disabledUpload"
                    });
                    var spanImageUpload = $('<span />', {
                        'class': "glyphicon glyphicon-paperclip"
                    });
                    var spanImageRemove = $('<span />', {
                        'class': "glyphicon glyphicon-remove-circle"
                    });
                    var spanImageSuccess = $('<span />', {
                        'class': "glyphicon glyphicon-ok"
                    });
                    spanImageUpload.appendTo(buttonUpload);
                    buttonUpload.appendTo(innerDivhide);
                    innerDivhide.appendTo(innerDivRow);
                    spanImageSuccess.appendTo(buttonSuccess);
                    buttonSuccess.appendTo(innerDivShow);
                    innerDivShow.appendTo(innerDivRow);
                    spanImageRemove.appendTo(buttonRemove);
                    buttonRemove.appendTo(innerDivRow1);
                    textInput.appendTo(divRow);
                    innerDivRow.appendTo(divRow);
                    innerDivRow1.appendTo(divRow);
                    divRow.appendTo(container);
                    var textInputFile = $('<input />', {
                        'name': "VA_TEXTINPUTBOXTFB_124611_gridUploader",
                        'id': "VA_TEXTINPUTBOXTFB_124611_gridUploader",
                        'type': "file"
                    }).kendoUpload({
                        'async': {
                            saveUrl: '${contextPath}/cobis/web/cobis-designer-engine-web/actions/fileupload?'
                        },
                        'class': "form-control",
                        'upload': function(e) {
                            $scope.vc.onFileUpload(e, options.model, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'select': function(e) {
                            $scope.vc.onFileSelect(e, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'success': function(e) {
                            $scope.vc.onSuccess(e, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'multiple': false
                    });
                    var divRowUp = $('<div/>', {
                        'ng-hide': true
                    });
                    textInputFile.appendTo(divRowUp);
                    divRowUp.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYWP_542611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT88_DOCUMEDI612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYWP_542611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSGM_136611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT70_EXTENSIN612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSGM_136611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.customerName = {
                title: 'customerName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCEB_498611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT22_CUSTOMEM612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCEB_498611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.processInstance = {
                title: 'processInstance',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBPC_698611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT65_PROCESNA612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBPC_698611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7463_28553.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_7463_28553.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.typeRequest = {
                title: 'typeRequest',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJXS_260611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT35_TYPERESQ612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.typeRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJXS_260611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.typeRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.typeRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7463_28553.column.description.title|translate:vc.viewState.QV_7463_28553.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.description.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.description.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT98_DESCRIPT612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7463_28553\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.description.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_7463_28553.column.customerId.title|translate:vc.viewState.QV_7463_28553.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.customerId.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.customerId.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT97_CUSTOMIR612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_7463_28553\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_7463_28553.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7463_28553.column.customerId.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_7463_28553.column.uploaded.title|translate:vc.viewState.QV_7463_28553.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.uploaded.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.uploaded.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7463_28553', 'uploaded', $scope.vc.grids.QV_7463_28553.AT46_UPLOADDE612.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7463_28553', 'uploaded', "<span ng-class='vc.viewState.QV_7463_28553.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_7463_28553\", \"uploaded\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.uploaded.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_7463_28553.column.file.title|translate:vc.viewState.QV_7463_28553.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.file.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.file.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT47_FILEOVTQ612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_7463_28553\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.file.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_7463_28553.column.documentId.title|translate:vc.viewState.QV_7463_28553.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.documentId.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.documentId.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT88_DOCUMEDI612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_7463_28553\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.documentId.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.documentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_7463_28553.column.extension.title|translate:vc.viewState.QV_7463_28553.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.extension.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.extension.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT70_EXTENSIN612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_7463_28553\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.extension.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_7463_28553.column.customerName.title|translate:vc.viewState.QV_7463_28553.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.customerName.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.customerName.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT22_CUSTOMEM612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_7463_28553\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.customerName.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_7463_28553.column.processInstance.title|translate:vc.viewState.QV_7463_28553.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.processInstance.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.processInstance.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT65_PROCESNA612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_7463_28553\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_7463_28553.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7463_28553.column.processInstance.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'typeRequest',
                    title: '{{vc.viewState.QV_7463_28553.column.typeRequest.title|translate:vc.viewState.QV_7463_28553.column.typeRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.typeRequest.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.typeRequest.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT35_TYPERESQ612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.typeRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.typeRequest, \"QV_7463_28553\", \"typeRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.typeRequest.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.typeRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.typeRequest.hidden
                });
            }
            $scope.vc.viewState.QV_7463_28553.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7463_28553.column.cmdEdition = {};
            $scope.vc.viewState.QV_7463_28553.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7463_28553.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_7463_28553.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7463_28553.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_SCANNEDCIM_218611.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7463_28553.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611)) {
                    $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611 = {};
                }
                $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.hidden = false;
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'VA_GRIDROWCOMMMNDD_972611',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNDD_972611",
                        entity: "ScannedDocumentsDetail",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmndd':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNDD_972611\", " + "vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.enabled || vc.viewState.G_SCANNEDCIM_218611.disabled' " + "data-ng-click = 'vc.grids.QV_7463_28553.events.customRowClick($event, \"VA_GRIDROWCOMMMNDD_972611\", \"#:entity#\", \"QV_7463_28553\")' " + "title = \"{{vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.hidden
                });
            }
            $scope.vc.viewState.QV_7463_28553.toolbar = {}
            $scope.vc.grids.QV_7463_28553.toolbar = [];
            $scope.vc.model.DocumentsUpload = {
                uploads: $scope.vc.channelDefaultValues("DocumentsUpload", "uploads"),
                processInstance: $scope.vc.channelDefaultValues("DocumentsUpload", "processInstance"),
                clientId: $scope.vc.channelDefaultValues("DocumentsUpload", "clientId")
            };
            //ViewState - Group: Group2644
            $scope.vc.createViewState({
                id: "G_SCANNEDDSD_789611",
                hasId: true,
                componentStyle: [],
                label: 'Group2644',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1195",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1669
            $scope.vc.createViewState({
                id: "G_SCANNEDOLM_531611",
                hasId: true,
                componentStyle: [],
                label: 'Group1669',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1422",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONILJIEMT_921611",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VALIDARTO_98546",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: EconomicInfForm
            $scope.vc.createViewState({
                id: "VC_CFFKBKPJOS_961735",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CAPACIDGD_24431",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.EconomicInformation = {
                hasOtherIncome: $scope.vc.channelDefaultValues("EconomicInformation", "hasOtherIncome"),
                personType: $scope.vc.channelDefaultValues("EconomicInformation", "personType"),
                operatingCost: $scope.vc.channelDefaultValues("EconomicInformation", "operatingCost"),
                availableTotal: $scope.vc.channelDefaultValues("EconomicInformation", "availableTotal"),
                expenseLevel: $scope.vc.channelDefaultValues("EconomicInformation", "expenseLevel"),
                liabilities: $scope.vc.channelDefaultValues("EconomicInformation", "liabilities"),
                personSecuential: $scope.vc.channelDefaultValues("EconomicInformation", "personSecuential"),
                monthlyTrxAmount: $scope.vc.channelDefaultValues("EconomicInformation", "monthlyTrxAmount"),
                assets: $scope.vc.channelDefaultValues("EconomicInformation", "assets"),
                categoryALM: $scope.vc.channelDefaultValues("EconomicInformation", "categoryALM"),
                tutorId: $scope.vc.channelDefaultValues("EconomicInformation", "tutorId"),
                monthlyIncome: $scope.vc.channelDefaultValues("EconomicInformation", "monthlyIncome"),
                availableIncome: $scope.vc.channelDefaultValues("EconomicInformation", "availableIncome"),
                businessYears: $scope.vc.channelDefaultValues("EconomicInformation", "businessYears"),
                availableBalance: $scope.vc.channelDefaultValues("EconomicInformation", "availableBalance"),
                tutorName: $scope.vc.channelDefaultValues("EconomicInformation", "tutorName"),
                isLinked: $scope.vc.channelDefaultValues("EconomicInformation", "isLinked"),
                otherIncomes: $scope.vc.channelDefaultValues("EconomicInformation", "otherIncomes"),
                sales: $scope.vc.channelDefaultValues("EconomicInformation", "sales"),
                otherIncomeSource: $scope.vc.channelDefaultValues("EconomicInformation", "otherIncomeSource"),
                relationId: $scope.vc.channelDefaultValues("EconomicInformation", "relationId"),
                salesCost: $scope.vc.channelDefaultValues("EconomicInformation", "salesCost"),
                businessIncome: $scope.vc.channelDefaultValues("EconomicInformation", "businessIncome"),
                availableResults: $scope.vc.channelDefaultValues("EconomicInformation", "availableResults"),
                retentionSubject: $scope.vc.channelDefaultValues("EconomicInformation", "retentionSubject"),
                internalQualification: $scope.vc.channelDefaultValues("EconomicInformation", "internalQualification")
            };
            //ViewState - Group: Group2211
            $scope.vc.createViewState({
                id: "G_ECONOMICNC_571168",
                hasId: true,
                componentStyle: [],
                label: 'Group2211',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: isLinked
            $scope.vc.createViewState({
                id: "VA_ISLINKEDSVEOBYH_771168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTVINCAA_14113",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: relationId
            $scope.vc.createViewState({
                id: "VA_RELATIONIDYUDBN_824168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RELACINIU_38434",
                validationCode: 32,
                readOnly: designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RELATIONIDYUDBN_824168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RELATIONIDYUDBN_824168', 'cl_relacion_banco', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RELATIONIDYUDBN_824168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RELATIONIDYUDBN_824168");
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
                id: "Spacer1644",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: monthlyIncome
            $scope.vc.createViewState({
                id: "VA_MONTHLYINCOMEEE_603168",
                componentStyle: [],
                labelImageId: "",
                label: "CSTMR.LBL_CSTMR_INGRESOEE_14706",
                validationCode: 32,
                readOnly: designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_MONTHLYINCOMEEE_603168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_MONTHLYINCOMEEE_603168', 'cl_ingresos', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_MONTHLYINCOMEEE_603168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_MONTHLYINCOMEEE_603168");
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
            //ViewState - Entity: EconomicInformation, Attribute: expenseLevel
            $scope.vc.createViewState({
                id: "VA_EXPENSELEVELXRJ_569168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELDERR_11452",
                validationCode: 32,
                readOnly: designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_EXPENSELEVELXRJ_569168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_EXPENSELEVELXRJ_569168', 'cl_nivel_egresos', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_EXPENSELEVELXRJ_569168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_EXPENSELEVELXRJ_569168");
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
            //ViewState - Entity: EconomicInformation, Attribute: internalQualification
            $scope.vc.createViewState({
                id: "VA_INTERNALQUALIIN_988168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CALIFICIC_24274",
                validationCode: 0,
                readOnly: designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_INTERNALQUALIIN_988168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_INTERNALQUALIIN_988168', 'cl_calif_cliente', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_INTERNALQUALIIN_988168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_INTERNALQUALIIN_988168");
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
            //ViewState - Entity: EconomicInformation, Attribute: categoryALM
            $scope.vc.createViewState({
                id: "VA_CATEGORYALMSHLU_711168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CATEGORAL_64501",
                validationCode: 0,
                readOnly: designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CATEGORYALMSHLU_711168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CATEGORYALMSHLU_711168', 'cl_categoria_AML', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CATEGORYALMSHLU_711168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CATEGORYALMSHLU_711168");
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
            //ViewState - Entity: EconomicInformation, Attribute: tutorName
            $scope.vc.createViewState({
                id: "VA_TUTORIDJFWNDWTD_976168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TUTORCQTL_23866",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: EconomicInformation, Attribute: tutorId
            $scope.vc.createViewState({
                id: "VA_TUTORIDWKMKRBTA_743168",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: EconomicInformation, Attribute: retentionSubject
            $scope.vc.createViewState({
                id: "VA_RETENTIONSUBCTE_894168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SUJETODIC_23289",
                validationCode: 0,
                readOnly: designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RETENTIONSUBCTE_894168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI '
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_RETENTIONSUBCTE_894168");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: EconomicInformation, Attribute: businessYears
            $scope.vc.createViewState({
                id: "VA_BUSINESSYEARSSS_759168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ANTIGEDAE_89539",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BUSINESSYEARSSS_759168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BUSINESSYEARSSS_759168', 'cl_referencia_tiempo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BUSINESSYEARSSS_759168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BUSINESSYEARSSS_759168");
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
                id: "VA_VASEPARATORCLNA_498168",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: assets
            $scope.vc.createViewState({
                id: "VA_ASSETSGNFTVVLMX_315168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ACTIVOSGJ_12797",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: liabilities
            $scope.vc.createViewState({
                id: "VA_LIABILITIESUKBV_739168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASIVOSFC_99135",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: availableResults
            $scope.vc.createViewState({
                id: "VA_AVAILABLERESULL_397168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PATRIMONO_77827",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORLLAI_606168",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: hasOtherIncome
            $scope.vc.createViewState({
                id: "VA_HASOTHERINCOMME_557168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIENEOTRG_36443",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: otherIncomeSource
            $scope.vc.createViewState({
                id: "VA_OTHERINCOMESEEE_418168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FUENTEDIO_16326",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OTHERINCOMESEEE_418168 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OTHERINCOMESEEE_418168', 'cl_fuente_ingreso', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OTHERINCOMESEEE_418168'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OTHERINCOMESEEE_418168");
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
            //ViewState - Entity: EconomicInformation, Attribute: sales
            $scope.vc.createViewState({
                id: "VA_SALESPRFYEHZSYT_162168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OTROSINSS_59909",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: otherIncomes
            $scope.vc.createViewState({
                id: "VA_OTHERINCOMESTNU_586168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INGRESOVN_52343",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: availableIncome
            $scope.vc.createViewState({
                id: "VA_AVAILABLEINCEEE_385168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TOTALINRR_46442",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: salesCost
            $scope.vc.createViewState({
                id: "VA_SALESCOSTPAHABC_774168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GASTOFAAU_65086",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: operatingCost
            $scope.vc.createViewState({
                id: "VA_OPERATINGCOSTTT_884168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GASTONEAG_27341",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: availableTotal
            $scope.vc.createViewState({
                id: "VA_AVAILABLETOTAAL_435168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TOTALGASS_75990",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformation, Attribute: availableBalance
            $scope.vc.createViewState({
                id: "VA_AVAILABLEBALCNN_776168",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CAPACIDAG_38003",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: AddressForm
            $scope.vc.createViewState({
                id: "VC_BZHSCWLUJU_302769",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCIOE_39222",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1182
            $scope.vc.createViewState({
                id: "G_ADDRESSHQX_118566",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1182',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1973
            $scope.vc.createViewState({
                id: "G_ADDRESSXDI_956566",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1973',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_ADDRESSXDI_956566-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerTmp = {
                code: $scope.vc.channelDefaultValues("CustomerTmp", "code"),
                paramVamail: $scope.vc.channelDefaultValues("CustomerTmp", "paramVamail")
            };
            //ViewState - Group: Group1650
            $scope.vc.createViewState({
                id: "G_ADDRESSHTB_233566",
                hasId: true,
                componentStyle: [],
                label: 'Group1650',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: CustomerTmp, Attribute: code
            $scope.vc.createViewState({
                id: "VA_CODERWEMFUUBAQJ_654566",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGODEET_21744",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONYDIJDRL_132566",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARAUU_89471",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVQOBVO_763566",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_AUXLULFCN_62992",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group1485
            $scope.vc.createViewState({
                id: "G_ADDRESSRXH_631566",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCISE_23825",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PhysicalAddress = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    addressTypeDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressTypeDescription", '')
                    },
                    ownershipType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "ownershipType", '')
                    },
                    street: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "street", ''),
                        validation: {
                            streetRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    directionNumber: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "directionNumber", 0),
                        validation: {
                            directionNumberRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    directionNumberInternal: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "directionNumberInternal", 0)
                    },
                    parishDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "parishDescription", '')
                    },
                    postalCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "postalCode", ''),
                        validation: {
                            postalCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    cityDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "cityDescription", '')
                    },
                    provinceDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "provinceDescription", '')
                    },
                    residenceTime: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "residenceTime", 0)
                    },
                    numberOfResidents: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "numberOfResidents", 0)
                    },
                    addressId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressId", 0)
                    },
                    personSecuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "personSecuential", 0)
                    },
                    countryDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "countryDescription", '')
                    },
                    isMainAddress: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "isMainAddress", false)
                    },
                    isShippingAddress: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "isShippingAddress", false)
                    },
                    addressType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressType", ''),
                        validation: {
                            addressTypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    countryCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "countryCode", 0),
                        validation: {
                            countryCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    provinceCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "provinceCode", 0),
                        validation: {
                            provinceCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    cityCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "cityCode", 0),
                        validation: {
                            cityCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    addressDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressDescription", '')
                    },
                    parishCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "parishCode", 0),
                        validation: {
                            parishCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    neighborhood: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "neighborhood", '')
                    },
                    latitude: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "latitude", 0)
                    },
                    longitude: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "longitude", 0)
                    },
                    reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "reference", ''),
                        validation: {
                            referenceRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.PhysicalAddress = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_PHYSICDS_4851';
                            var queryRequest = $scope.vc.getRequestQuery_Q_PHYSICDS_4851();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_4851_97960',
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
                                            'pageSize': 10
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'PhysicalAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_4851_97960', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                            nameEntityGrid: 'PhysicalAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_4851_97960', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.PhysicalAddress
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_4851_97960").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PHYSICDS_4851 = $scope.vc.model.PhysicalAddress;
            $scope.vc.trackers.PhysicalAddress = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PhysicalAddress);
            $scope.vc.model.PhysicalAddress.bind('change', function(e) {
                $scope.vc.trackers.PhysicalAddress.track(e);
            });
            $scope.vc.grids.QV_4851_97960 = {};
            $scope.vc.grids.QV_4851_97960.queryId = 'Q_PHYSICDS_4851';
            $scope.vc.viewState.QV_4851_97960 = {
                style: undefined
            };
            $scope.vc.viewState.QV_4851_97960.column = {};
            $scope.vc.grids.QV_4851_97960.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_4851_97960.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.PhysicalAddress(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_ADDRESSTODDXS_302",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_ADDRESSITS_306302',
                        title: 'CSTMR.LBL_CSTMR_DIRECCINS_93646'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_4851_97960", dialogParameters);
                },
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
                        taskId: "T_ADDRESSTODDXS_302",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_ADDRESSITS_306302',
                        title: 'CSTMR.LBL_CSTMR_DIRECCINS_93646'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_4851_97960", dialogParameters);
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
                        nameEntityGrid: 'PhysicalAddress',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_4851_97960", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_4851_97960");
                    $scope.vc.hideShowColumns("QV_4851_97960", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_4851_97960.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_4851_97960.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_4851_97960.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_4851_97960 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_4851_97960 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_4851_97960.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_4851_97960.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_4851_97960.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription = {
                title: 'CSTMR.LBL_CSTMR_TIPODEDNN_99499',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCWF_391566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.ownershipType = {
                title: 'CSTMR.LBL_CSTMR_TIPOVIVII_94718',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYM_561566',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQYM_561566 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXQYM_561566',
                            'cl_tpropiedad',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQYM_561566'];
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
            $scope.vc.viewState.QV_4851_97960.column.street = {
                title: 'CSTMR.LBL_CSTMR_CALLEZGKG_90745',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXAAM_523566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.directionNumber = {
                title: 'CSTMR.LBL_CSTMR_NUMEROERE_80912',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXTRM_654566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal = {
                title: 'CSTMR.LBL_CSTMR_NUMEROIRR_97223',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEDV_219566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.parishDescription = {
                title: 'CSTMR.LBL_CSTMR_COLONIAHO_62033',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYZP_139566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.postalCode = {
                title: 'CSTMR.LBL_CSTMR_CPLTRUORJ_78149',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZGO_902566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.cityDescription = {
                title: 'CSTMR.LBL_CSTMR_MUNICIPLL_42320',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZWT_698566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.provinceDescription = {
                title: 'CSTMR.LBL_CSTMR_ESTADOWSN_97563',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXJY_416566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.residenceTime = {
                title: 'CSTMR.LBL_CSTMR_AOSDOMIIC_89661',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWTT_538566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.numberOfResidents = {
                title: 'CSTMR.LBL_CSTMR_PERSONANE_31281',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUJU_368566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.addressId = {
                title: 'CSTMR.LBL_CSTMR_NMEROBVNL_26453',
                titleArgs: {},
                tooltip: '',
                width: 75,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIJO_865566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.personSecuential = {
                title: 'personSecuential',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJOJ_503566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.countryDescription = {
                title: 'CSTMR.LBL_CSTMR_PASJNZPSV_26668',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZPB_139566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.isMainAddress = {
                title: 'isMainAddress',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXIUPMNOH_942566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.isShippingAddress = {
                title: 'isShippingAddress',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXYLUYHPM_737566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.addressType = {
                title: 'CSTMR.LBL_CSTMR_TIPODEDNN_99499',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZCX_337566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.countryCode = {
                title: 'countryCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXTCL_828566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.provinceCode = {
                title: 'provinceCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXRDK_707566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.cityCode = {
                title: 'cityCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXYIG_433566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.addressDescription = {
                title: 'CSTMR.LBL_CSTMR_DATOSCOON_45015',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBHJ_130566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.parishCode = {
                title: 'parishCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXKHQ_381566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.neighborhood = {
                title: 'neighborhood',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMAD_925566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.latitude = {
                title: 'latitude',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYBS_295566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.longitude = {
                title: 'longitude',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEIH_666566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.reference = {
                title: 'reference',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZOA_592566',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressTypeDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.addressTypeDescription.title|translate:vc.viewState.QV_4851_97960.column.addressTypeDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressTypeDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressTypeDescription, \"QV_4851_97960\", \"addressTypeDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressTypeDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressTypeDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'ownershipType',
                    title: '{{vc.viewState.QV_4851_97960.column.ownershipType.title|translate:vc.viewState.QV_4851_97960.column.ownershipType.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.ownershipType.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.ownershipType.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.ownershipType.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQYM_561566.get(dataItem.ownershipType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.ownershipType.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.ownershipType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.ownershipType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'street',
                    title: '{{vc.viewState.QV_4851_97960.column.street.title|translate:vc.viewState.QV_4851_97960.column.street.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.street.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.street.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.street.style' ng-bind='vc.getStringColumnFormat(dataItem.street, \"QV_4851_97960\", \"street\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.street.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.street.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.street.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'directionNumber',
                    title: '{{vc.viewState.QV_4851_97960.column.directionNumber.title|translate:vc.viewState.QV_4851_97960.column.directionNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.directionNumber.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.directionNumber.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.directionNumber.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.directionNumber, \"QV_4851_97960\", \"directionNumber\"):kendo.toString(#=directionNumber#, vc.viewState.QV_4851_97960.column.directionNumber.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.directionNumber.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.directionNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.directionNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'directionNumberInternal',
                    title: '{{vc.viewState.QV_4851_97960.column.directionNumberInternal.title|translate:vc.viewState.QV_4851_97960.column.directionNumberInternal.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.directionNumberInternal.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.directionNumberInternal, \"QV_4851_97960\", \"directionNumberInternal\"):kendo.toString(#=directionNumberInternal#, vc.viewState.QV_4851_97960.column.directionNumberInternal.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.directionNumberInternal.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.directionNumberInternal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'parishDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.parishDescription.title|translate:vc.viewState.QV_4851_97960.column.parishDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.parishDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.parishDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.parishDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.parishDescription, \"QV_4851_97960\", \"parishDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.parishDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.parishDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.parishDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'postalCode',
                    title: '{{vc.viewState.QV_4851_97960.column.postalCode.title|translate:vc.viewState.QV_4851_97960.column.postalCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.postalCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.postalCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.postalCode.style' ng-bind='vc.getStringColumnFormat(dataItem.postalCode, \"QV_4851_97960\", \"postalCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.postalCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.postalCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.postalCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'cityDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.cityDescription.title|translate:vc.viewState.QV_4851_97960.column.cityDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.cityDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.cityDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.cityDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.cityDescription, \"QV_4851_97960\", \"cityDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.cityDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.cityDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.cityDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'provinceDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.provinceDescription.title|translate:vc.viewState.QV_4851_97960.column.provinceDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.provinceDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.provinceDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.provinceDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.provinceDescription, \"QV_4851_97960\", \"provinceDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.provinceDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.provinceDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.provinceDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'residenceTime',
                    title: '{{vc.viewState.QV_4851_97960.column.residenceTime.title|translate:vc.viewState.QV_4851_97960.column.residenceTime.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.residenceTime.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.residenceTime.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.residenceTime.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.residenceTime, \"QV_4851_97960\", \"residenceTime\"):kendo.toString(#=residenceTime#, vc.viewState.QV_4851_97960.column.residenceTime.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.residenceTime.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.residenceTime.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.residenceTime.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'numberOfResidents',
                    title: '{{vc.viewState.QV_4851_97960.column.numberOfResidents.title|translate:vc.viewState.QV_4851_97960.column.numberOfResidents.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.numberOfResidents.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.numberOfResidents.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.numberOfResidents.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberOfResidents, \"QV_4851_97960\", \"numberOfResidents\"):kendo.toString(#=numberOfResidents#, vc.viewState.QV_4851_97960.column.numberOfResidents.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.numberOfResidents.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.numberOfResidents.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.numberOfResidents.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressId',
                    title: '{{vc.viewState.QV_4851_97960.column.addressId.title|translate:vc.viewState.QV_4851_97960.column.addressId.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressId.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressId.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.addressId, \"QV_4851_97960\", \"addressId\"):kendo.toString(#=addressId#, vc.viewState.QV_4851_97960.column.addressId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressId.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'personSecuential',
                    title: '{{vc.viewState.QV_4851_97960.column.personSecuential.title|translate:vc.viewState.QV_4851_97960.column.personSecuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.personSecuential.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.personSecuential.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.personSecuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.personSecuential, \"QV_4851_97960\", \"personSecuential\"):kendo.toString(#=personSecuential#, vc.viewState.QV_4851_97960.column.personSecuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.personSecuential.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.personSecuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.personSecuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'countryDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.countryDescription.title|translate:vc.viewState.QV_4851_97960.column.countryDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.countryDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.countryDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.countryDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.countryDescription, \"QV_4851_97960\", \"countryDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.countryDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.countryDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.countryDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'isMainAddress',
                    title: '{{vc.viewState.QV_4851_97960.column.isMainAddress.title|translate:vc.viewState.QV_4851_97960.column.isMainAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.isMainAddress.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.isMainAddress.format,
                    template: "<input name='isMainAddress' type='checkbox' value='#=isMainAddress#' #=isMainAddress?checked='checked':''# disabled='disabled' data-bind='value:isMainAddress' ng-class='vc.viewState.QV_4851_97960.column.isMainAddress.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.isMainAddress.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.isMainAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.isMainAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'isShippingAddress',
                    title: '{{vc.viewState.QV_4851_97960.column.isShippingAddress.title|translate:vc.viewState.QV_4851_97960.column.isShippingAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.isShippingAddress.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.isShippingAddress.format,
                    template: "<input name='isShippingAddress' type='checkbox' value='#=isShippingAddress#' #=isShippingAddress?checked='checked':''# disabled='disabled' data-bind='value:isShippingAddress' ng-class='vc.viewState.QV_4851_97960.column.isShippingAddress.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.isShippingAddress.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.isShippingAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.isShippingAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressType',
                    title: '{{vc.viewState.QV_4851_97960.column.addressType.title|translate:vc.viewState.QV_4851_97960.column.addressType.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressType.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressType.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressType.style' ng-bind='vc.getStringColumnFormat(dataItem.addressType, \"QV_4851_97960\", \"addressType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressType.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'countryCode',
                    title: '{{vc.viewState.QV_4851_97960.column.countryCode.title|translate:vc.viewState.QV_4851_97960.column.countryCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.countryCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.countryCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.countryCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.countryCode, \"QV_4851_97960\", \"countryCode\"):kendo.toString(#=countryCode#, vc.viewState.QV_4851_97960.column.countryCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.countryCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.countryCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.countryCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'provinceCode',
                    title: '{{vc.viewState.QV_4851_97960.column.provinceCode.title|translate:vc.viewState.QV_4851_97960.column.provinceCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.provinceCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.provinceCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.provinceCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.provinceCode, \"QV_4851_97960\", \"provinceCode\"):kendo.toString(#=provinceCode#, vc.viewState.QV_4851_97960.column.provinceCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.provinceCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.provinceCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.provinceCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'cityCode',
                    title: '{{vc.viewState.QV_4851_97960.column.cityCode.title|translate:vc.viewState.QV_4851_97960.column.cityCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.cityCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.cityCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.cityCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.cityCode, \"QV_4851_97960\", \"cityCode\"):kendo.toString(#=cityCode#, vc.viewState.QV_4851_97960.column.cityCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.cityCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.cityCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.cityCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.addressDescription.title|translate:vc.viewState.QV_4851_97960.column.addressDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressDescription, \"QV_4851_97960\", \"addressDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'parishCode',
                    title: '{{vc.viewState.QV_4851_97960.column.parishCode.title|translate:vc.viewState.QV_4851_97960.column.parishCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.parishCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.parishCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.parishCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.parishCode, \"QV_4851_97960\", \"parishCode\"):kendo.toString(#=parishCode#, vc.viewState.QV_4851_97960.column.parishCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.parishCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.parishCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.parishCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'neighborhood',
                    title: '{{vc.viewState.QV_4851_97960.column.neighborhood.title|translate:vc.viewState.QV_4851_97960.column.neighborhood.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.neighborhood.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.neighborhood.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.neighborhood.style' ng-bind='vc.getStringColumnFormat(dataItem.neighborhood, \"QV_4851_97960\", \"neighborhood\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.neighborhood.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.neighborhood.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.neighborhood.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'latitude',
                    title: '{{vc.viewState.QV_4851_97960.column.latitude.title|translate:vc.viewState.QV_4851_97960.column.latitude.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.latitude.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.latitude.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.latitude.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.latitude, \"QV_4851_97960\", \"latitude\"):kendo.toString(#=latitude#, vc.viewState.QV_4851_97960.column.latitude.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.latitude.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.latitude.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.latitude.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'longitude',
                    title: '{{vc.viewState.QV_4851_97960.column.longitude.title|translate:vc.viewState.QV_4851_97960.column.longitude.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.longitude.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.longitude.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.longitude.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.longitude, \"QV_4851_97960\", \"longitude\"):kendo.toString(#=longitude#, vc.viewState.QV_4851_97960.column.longitude.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.longitude.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.longitude.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.longitude.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'reference',
                    title: '{{vc.viewState.QV_4851_97960.column.reference.title|translate:vc.viewState.QV_4851_97960.column.reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.reference.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.reference.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.reference.style' ng-bind='vc.getStringColumnFormat(dataItem.reference, \"QV_4851_97960\", \"reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.reference.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.reference.hidden
                });
            }
            $scope.vc.viewState.QV_4851_97960.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.cmdEdition = {};
            $scope.vc.viewState.QV_4851_97960.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_4851_97960.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "PhysicalAddress",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_4851_97960.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_4851_97960.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSRXH_631566.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_4851_97960.events.customEdit($event, \"#:entity#\", grids.QV_4851_97960)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_4851_97960.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_4851_97960.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSRXH_631566.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_4851_97960.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_4851_97960.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_4851_97960.toolbar = [{
                "name": "create",
                "entity": "PhysicalAddress",
                "text": "",
                "template": "<button id = 'QV_4851_97960_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_4851_97960.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_ADDRESSRXH_631566.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_4851_97960.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Group: Group2117
            $scope.vc.createViewState({
                id: "G_ADDRESSLJO_139566",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCINT_97175",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.VirtualAddress = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    addressId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressId", 0)
                    },
                    personSecuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "personSecuential", 0)
                    },
                    addressType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressType", '')
                    },
                    addressTypeDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressTypeDescription", '')
                    },
                    addressDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressDescription", ''),
                        validation: {
                            addressDescriptionRegularExpression: function(input) {
                                return regularExpression(input);
                            },
                            addressDescriptionRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.VirtualAddress = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_VIRTUALD_9303';
                            var queryRequest = $scope.vc.getRequestQuery_Q_VIRTUALD_9303();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9303_67123',
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
                                            'pageSize': 10
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
                            nameEntityGrid: 'VirtualAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9303_67123', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                            nameEntityGrid: 'VirtualAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9303_67123', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                            nameEntityGrid: 'VirtualAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9303_67123', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.VirtualAddress
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9303_67123").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_VIRTUALD_9303 = $scope.vc.model.VirtualAddress;
            $scope.vc.trackers.VirtualAddress = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VirtualAddress);
            $scope.vc.model.VirtualAddress.bind('change', function(e) {
                $scope.vc.trackers.VirtualAddress.track(e);
            });
            $scope.vc.grids.QV_9303_67123 = {};
            $scope.vc.grids.QV_9303_67123.queryId = 'Q_VIRTUALD_9303';
            $scope.vc.viewState.QV_9303_67123 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9303_67123.column = {};
            $scope.vc.grids.QV_9303_67123.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_9303_67123.events = {
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
                    $scope.vc.trackers.VirtualAddress.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9303_67123.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'VirtualAddress',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_9303_67123", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9303_67123");
                    $scope.vc.hideShowColumns("QV_9303_67123", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9303_67123.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9303_67123.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9303_67123.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9303_67123 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9303_67123 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_9303_67123.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9303_67123.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9303_67123.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9303_67123.column.addressId = {
                title: 'CSTMR.LBL_CSTMR_NMEROBVNL_26453',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBQK_646566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT41_PHYSICRE566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBQK_646566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9303_67123.column.addressId.format",
                        'k-decimals': "vc.viewState.QV_9303_67123.column.addressId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.personSecuential = {
                title: 'CSTMR.LBL_CSTMR_NMEROBVNL_26453',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDYV_798566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT85_PERSONNA566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.personSecuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDYV_798566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.personSecuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9303_67123.column.personSecuential.format",
                        'k-decimals': "vc.viewState.QV_9303_67123.column.personSecuential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.personSecuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.addressType = {
                title: 'addressType',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKCY_211566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT77_ADDRESPP566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKCY_211566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription = {
                title: 'addressTypeDescription',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFTS_843566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT31_PHYSICPD566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressTypeDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFTS_843566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressTypeDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressTypeDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.addressDescription = {
                title: 'CSTMR.LBL_CSTMR_DIRECCIRV_56431',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 33,
                componentId: 'VA_TEXTINPUTBOXILB_303566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT84_COUNTRYY566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXILB_303566",
                        'regular-expression': "",
                        'regexppattern': "^[a-z0-9-_.]+@[a-z0-9-]+\.[a-z0-9-.]+$",
                        'data-regularExpression-msg': $filter('translate')('CSTMR.MSG_CSTMR_CORREOENI_83889'),
                        'required': '',
                        'data-required-msg': $filter('translate')('CSTMR.LBL_CSTMR_DIRECCIRV_56431') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-blur': "vc.change($event,'VA_TEXTINPUTBOXILB_303566',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXILB_303566',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressId',
                    title: '{{vc.viewState.QV_9303_67123.column.addressId.title|translate:vc.viewState.QV_9303_67123.column.addressId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressId.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressId.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT41_PHYSICRE566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.addressId, \"QV_9303_67123\", \"addressId\"):kendo.toString(#=addressId#, vc.viewState.QV_9303_67123.column.addressId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressId.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'personSecuential',
                    title: '{{vc.viewState.QV_9303_67123.column.personSecuential.title|translate:vc.viewState.QV_9303_67123.column.personSecuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.personSecuential.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.personSecuential.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT85_PERSONNA566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.personSecuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.personSecuential, \"QV_9303_67123\", \"personSecuential\"):kendo.toString(#=personSecuential#, vc.viewState.QV_9303_67123.column.personSecuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9303_67123.column.personSecuential.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.personSecuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.personSecuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressType',
                    title: '{{vc.viewState.QV_9303_67123.column.addressType.title|translate:vc.viewState.QV_9303_67123.column.addressType.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressType.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressType.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT77_ADDRESPP566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressType.style' ng-bind='vc.getStringColumnFormat(dataItem.addressType, \"QV_9303_67123\", \"addressType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressType.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressTypeDescription',
                    title: '{{vc.viewState.QV_9303_67123.column.addressTypeDescription.title|translate:vc.viewState.QV_9303_67123.column.addressTypeDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT31_PHYSICPD566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressTypeDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressTypeDescription, \"QV_9303_67123\", \"addressTypeDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressTypeDescription.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressTypeDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressDescription',
                    title: '{{vc.viewState.QV_9303_67123.column.addressDescription.title|translate:vc.viewState.QV_9303_67123.column.addressDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressDescription.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressDescription.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT84_COUNTRYY566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressDescription, \"QV_9303_67123\", \"addressDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressDescription.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressDescription.hidden
                });
            }
            $scope.vc.viewState.QV_9303_67123.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_9303_67123.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_9303_67123.column.cmdEdition = {};
            $scope.vc.viewState.QV_9303_67123.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_9303_67123.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_9303_67123.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9303_67123.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSLJO_139566.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_9303_67123.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9303_67123.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSLJO_139566.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_9303_67123.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566 = {
                    tooltip: '',
                    imageId: 'glyphicon glyphicon-ok',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566)) {
                    $scope.vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566 = {};
                }
                $scope.vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566.hidden = false;
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'VA_GRIDROWCOMMMDNA_449566',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMDNA_449566",
                        entity: "VirtualAddress",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmdna':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMDNA_449566\", " + "vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566.enabled || vc.viewState.G_ADDRESSLJO_139566.disabled' " + "data-ng-click = 'vc.grids.QV_9303_67123.events.customRowClick($event, \"VA_GRIDROWCOMMMDNA_449566\", \"#:entity#\", \"QV_9303_67123\")' " + "title = \"{{vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.VA_GRIDROWCOMMMDNA_449566.hidden
                });
            }
            $scope.vc.viewState.QV_9303_67123.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_9303_67123.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_9303_67123.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_ADDRESSLJO_139566.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Group: Group1878
            $scope.vc.createViewState({
                id: "G_ADDRESSXST_172566",
                hasId: true,
                componentStyle: [],
                label: 'Group1878',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1131",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: BusinessForm
            $scope.vc.createViewState({
                id: "VC_RRLBYDXROB_523114",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NEGOCIONN_71672",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1591
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_687304",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1591',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2643
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_428304",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group2643',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_428304-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerTmpBusiness = {
                code: $scope.vc.channelDefaultValues("CustomerTmpBusiness", "code")
            };
            //ViewState - Group: Group1257
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_972304",
                hasId: true,
                componentStyle: [],
                label: 'Group1257',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: CustomerTmpBusiness, Attribute: code
            $scope.vc.createViewState({
                id: "VA_CODEZGXWKDYWYYB_648304",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGODEET_21744",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONJPSJYQV_906304",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARAUU_89471",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2122
            $scope.vc.createViewState({
                id: "G_BUSINESSSS_110304",
                hasId: true,
                componentStyle: [],
                label: 'Group2122',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Business = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    names: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "names", '')
                    },
                    economicActivityDesc: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "economicActivityDesc", '')
                    },
                    timeActivity: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "timeActivity", 0)
                    },
                    timeBusinessAddress: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "timeBusinessAddress", 0),
                        validation: {
                            timeBusinessAddressRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    typeLocal: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "typeLocal", '')
                    },
                    resources: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "resources", '')
                    },
                    creditDestination: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "creditDestination", ''),
                        validation: {
                            creditDestinationRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    code: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "code", 0)
                    },
                    customerCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "customerCode", 0)
                    },
                    economicActivity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "economicActivity", '')
                    },
                    turnaround: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "turnaround", '')
                    },
                    dateBusiness: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "dateBusiness", new Date())
                    },
                    street: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "street", '')
                    },
                    numberOfBusiness: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "numberOfBusiness", 0)
                    },
                    colony: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "colony", '')
                    },
                    locations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "locations", '')
                    },
                    municipality: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "municipality", '')
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "state", '')
                    },
                    postalCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "postalCode", '')
                    },
                    country: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "country", '')
                    },
                    areEntrepreneur: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "areEntrepreneur", false)
                    },
                    phone: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "phone", '')
                    },
                    mountlyIncomes: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "mountlyIncomes", 0)
                    },
                    whichResource: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Business", "whichResource", '')
                    }
                }
            });
            $scope.vc.model.Business = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_BUSINESS_6359';
                            var queryRequest = $scope.vc.getRequestQuery_Q_BUSINESS_6359();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6359_40398',
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
                                            'pageSize': 10
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'Business',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6359_40398', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Business
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6359_40398").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_BUSINESS_6359 = $scope.vc.model.Business;
            $scope.vc.trackers.Business = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Business);
            $scope.vc.model.Business.bind('change', function(e) {
                $scope.vc.trackers.Business.track(e);
            });
            $scope.vc.grids.QV_6359_40398 = {};
            $scope.vc.grids.QV_6359_40398.queryId = 'Q_BUSINESS_6359';
            $scope.vc.viewState.QV_6359_40398 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6359_40398.column = {};
            $scope.vc.grids.QV_6359_40398.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_6359_40398.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.Business(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_BUSINESSPOPPU_722",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_BUSINESSPP_740722',
                        title: 'CSTMR.LBL_CSTMR_NEGOCIOSS_45525',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_6359_40398", dialogParameters);
                },
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
                        taskId: "T_BUSINESSPOPPU_722",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_BUSINESSPP_740722',
                        title: 'CSTMR.LBL_CSTMR_NEGOCIOSS_45525',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_6359_40398", dialogParameters);
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
                        nameEntityGrid: 'Business',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_6359_40398", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_6359_40398");
                    $scope.vc.hideShowColumns("QV_6359_40398", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6359_40398.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6359_40398.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6359_40398.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6359_40398 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6359_40398 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_6359_40398.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6359_40398.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6359_40398.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6359_40398.column.names = {
                title: 'CSTMR.LBL_CSTMR_NOMBREDEC_62486',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYD_971304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc = {
                title: 'CSTMR.LBL_CSTMR_ACTIVIDAA_39121',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYOY_865304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.timeActivity = {
                title: 'CSTMR.LBL_CSTMR_TIEMPODAA_42945',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCQL_755304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXCQL_755304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXCQL_755304',
                            'cl_referencia_tiempo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXCQL_755304'];
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
            $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress = {
                title: 'CSTMR.LBL_CSTMR_TIEMPOAOA_58383',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVKC_396304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXVKC_396304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXVKC_396304',
                            'cl_referencia_tiempo',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXVKC_396304'];
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
            $scope.vc.viewState.QV_6359_40398.column.typeLocal = {
                title: 'CSTMR.LBL_CSTMR_TIPODELAL_16702',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTMW_911304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXTMW_911304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXTMW_911304',
                            'cr_tipo_local',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXTMW_911304'];
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
            $scope.vc.viewState.QV_6359_40398.column.resources = {
                title: 'CSTMR.LBL_CSTMR_ORIGENLUE_60745',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXIK_422304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXXIK_422304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXXIK_422304',
                            'cl_recursos_credito',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXXIK_422304'];
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
            $scope.vc.viewState.QV_6359_40398.column.creditDestination = {
                title: 'CSTMR.LBL_CSTMR_DESTINOTR_63871',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXYPK_251304',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXYPK_251304 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXYPK_251304',
                            'cl_destino_credito',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXYPK_251304'];
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
            $scope.vc.viewState.QV_6359_40398.column.code = {
                title: 'code',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXETM_971304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.customerCode = {
                title: 'customerCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEWA_952304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.economicActivity = {
                title: 'CSTMR.LBL_CSTMR_ACTIVIDAA_39121',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCLL_749304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.turnaround = {
                title: 'CSTMR.LBL_CSTMR_GIROQYDVN_82921',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKWD_921304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.dateBusiness = {
                title: 'CSTMR.LBL_CSTMR_DESTINOTT_68123',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAEX_607304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.street = {
                title: 'street',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNWN_620304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness = {
                title: 'numberOfBusiness',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCUG_754304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.colony = {
                title: 'colony',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFNC_288304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.locations = {
                title: 'locations',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTTR_701304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.municipality = {
                title: 'municipality',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOZC_256304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.state = {
                title: 'state',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKBN_306304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.postalCode = {
                title: 'postalCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSQX_574304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.country = {
                title: 'country',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFSJ_501304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur = {
                title: 'CSTMR.LBL_CSTMR_ESEMPRENO_47778',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXEKDYYHM_687304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.phone = {
                title: 'phone',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWKG_843304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes = {
                title: 'mountlyIncomes',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMWQ_593304',
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.whichResource = {
                title: 'CSTMR.LBL_CSTMR_OTRORECSU_76656',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNSS_139304',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'names',
                    title: '{{vc.viewState.QV_6359_40398.column.names.title|translate:vc.viewState.QV_6359_40398.column.names.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.names.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.names.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.names.style' ng-bind='vc.getStringColumnFormat(dataItem.names, \"QV_6359_40398\", \"names\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.names.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.names.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.names.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'economicActivityDesc',
                    title: '{{vc.viewState.QV_6359_40398.column.economicActivityDesc.title|translate:vc.viewState.QV_6359_40398.column.economicActivityDesc.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.economicActivityDesc.style' ng-bind='vc.getStringColumnFormat(dataItem.economicActivityDesc, \"QV_6359_40398\", \"economicActivityDesc\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.economicActivityDesc.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.economicActivityDesc.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.economicActivityDesc.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'timeActivity',
                    title: '{{vc.viewState.QV_6359_40398.column.timeActivity.title|translate:vc.viewState.QV_6359_40398.column.timeActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.timeActivity.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.timeActivity.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.timeActivity.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXCQL_755304.get(dataItem.timeActivity).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.timeActivity.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.timeActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.timeActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'timeBusinessAddress',
                    title: '{{vc.viewState.QV_6359_40398.column.timeBusinessAddress.title|translate:vc.viewState.QV_6359_40398.column.timeBusinessAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.timeBusinessAddress.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXVKC_396304.get(dataItem.timeBusinessAddress).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.timeBusinessAddress.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.timeBusinessAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.timeBusinessAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'typeLocal',
                    title: '{{vc.viewState.QV_6359_40398.column.typeLocal.title|translate:vc.viewState.QV_6359_40398.column.typeLocal.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.typeLocal.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.typeLocal.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.typeLocal.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXTMW_911304.get(dataItem.typeLocal).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.typeLocal.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.typeLocal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.typeLocal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'resources',
                    title: '{{vc.viewState.QV_6359_40398.column.resources.title|translate:vc.viewState.QV_6359_40398.column.resources.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.resources.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.resources.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.resources.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXXIK_422304.get(dataItem.resources).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.resources.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.resources.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.resources.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'creditDestination',
                    title: '{{vc.viewState.QV_6359_40398.column.creditDestination.title|translate:vc.viewState.QV_6359_40398.column.creditDestination.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.creditDestination.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.creditDestination.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.creditDestination.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXYPK_251304.get(dataItem.creditDestination).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.creditDestination.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.creditDestination.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.creditDestination.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'code',
                    title: '{{vc.viewState.QV_6359_40398.column.code.title|translate:vc.viewState.QV_6359_40398.column.code.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.code.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.code.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.code.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.code, \"QV_6359_40398\", \"code\"):kendo.toString(#=code#, vc.viewState.QV_6359_40398.column.code.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.code.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.code.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.code.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'customerCode',
                    title: '{{vc.viewState.QV_6359_40398.column.customerCode.title|translate:vc.viewState.QV_6359_40398.column.customerCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.customerCode.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.customerCode.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.customerCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerCode, \"QV_6359_40398\", \"customerCode\"):kendo.toString(#=customerCode#, vc.viewState.QV_6359_40398.column.customerCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.customerCode.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.customerCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.customerCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'economicActivity',
                    title: '{{vc.viewState.QV_6359_40398.column.economicActivity.title|translate:vc.viewState.QV_6359_40398.column.economicActivity.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.economicActivity.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.economicActivity.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.economicActivity.style' ng-bind='vc.getStringColumnFormat(dataItem.economicActivity, \"QV_6359_40398\", \"economicActivity\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.economicActivity.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.economicActivity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.economicActivity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'turnaround',
                    title: '{{vc.viewState.QV_6359_40398.column.turnaround.title|translate:vc.viewState.QV_6359_40398.column.turnaround.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.turnaround.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.turnaround.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.turnaround.style' ng-bind='vc.getStringColumnFormat(dataItem.turnaround, \"QV_6359_40398\", \"turnaround\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.turnaround.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.turnaround.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.turnaround.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'dateBusiness',
                    title: '{{vc.viewState.QV_6359_40398.column.dateBusiness.title|translate:vc.viewState.QV_6359_40398.column.dateBusiness.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.dateBusiness.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.dateBusiness.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.dateBusiness.style'>#=((dateBusiness !== null) ? kendo.toString(dateBusiness, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.dateBusiness.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.dateBusiness.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.dateBusiness.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'street',
                    title: '{{vc.viewState.QV_6359_40398.column.street.title|translate:vc.viewState.QV_6359_40398.column.street.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.street.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.street.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.street.style' ng-bind='vc.getStringColumnFormat(dataItem.street, \"QV_6359_40398\", \"street\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.street.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.street.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.street.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'numberOfBusiness',
                    title: '{{vc.viewState.QV_6359_40398.column.numberOfBusiness.title|translate:vc.viewState.QV_6359_40398.column.numberOfBusiness.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.numberOfBusiness.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberOfBusiness, \"QV_6359_40398\", \"numberOfBusiness\"):kendo.toString(#=numberOfBusiness#, vc.viewState.QV_6359_40398.column.numberOfBusiness.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.numberOfBusiness.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.numberOfBusiness.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.numberOfBusiness.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'colony',
                    title: '{{vc.viewState.QV_6359_40398.column.colony.title|translate:vc.viewState.QV_6359_40398.column.colony.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.colony.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.colony.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.colony.style' ng-bind='vc.getStringColumnFormat(dataItem.colony, \"QV_6359_40398\", \"colony\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.colony.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.colony.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.colony.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'locations',
                    title: '{{vc.viewState.QV_6359_40398.column.locations.title|translate:vc.viewState.QV_6359_40398.column.locations.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.locations.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.locations.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.locations.style' ng-bind='vc.getStringColumnFormat(dataItem.locations, \"QV_6359_40398\", \"locations\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.locations.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.locations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.locations.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'municipality',
                    title: '{{vc.viewState.QV_6359_40398.column.municipality.title|translate:vc.viewState.QV_6359_40398.column.municipality.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.municipality.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.municipality.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.municipality.style' ng-bind='vc.getStringColumnFormat(dataItem.municipality, \"QV_6359_40398\", \"municipality\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.municipality.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.municipality.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.municipality.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_6359_40398.column.state.title|translate:vc.viewState.QV_6359_40398.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.state.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.state.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_6359_40398\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.state.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'postalCode',
                    title: '{{vc.viewState.QV_6359_40398.column.postalCode.title|translate:vc.viewState.QV_6359_40398.column.postalCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.postalCode.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.postalCode.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.postalCode.style' ng-bind='vc.getStringColumnFormat(dataItem.postalCode, \"QV_6359_40398\", \"postalCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.postalCode.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.postalCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.postalCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'country',
                    title: '{{vc.viewState.QV_6359_40398.column.country.title|translate:vc.viewState.QV_6359_40398.column.country.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.country.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.country.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.country.style' ng-bind='vc.getStringColumnFormat(dataItem.country, \"QV_6359_40398\", \"country\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.country.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.country.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.country.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'areEntrepreneur',
                    title: '{{vc.viewState.QV_6359_40398.column.areEntrepreneur.title|translate:vc.viewState.QV_6359_40398.column.areEntrepreneur.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur.format,
                    template: "<input name='areEntrepreneur' type='checkbox' value='#=areEntrepreneur#' #=areEntrepreneur?checked='checked':''# disabled='disabled' data-bind='value:areEntrepreneur' ng-class='vc.viewState.QV_6359_40398.column.areEntrepreneur.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.areEntrepreneur.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.areEntrepreneur.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.areEntrepreneur.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'phone',
                    title: '{{vc.viewState.QV_6359_40398.column.phone.title|translate:vc.viewState.QV_6359_40398.column.phone.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.phone.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.phone.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.phone.style' ng-bind='vc.getStringColumnFormat(dataItem.phone, \"QV_6359_40398\", \"phone\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.phone.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.phone.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.phone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'mountlyIncomes',
                    title: '{{vc.viewState.QV_6359_40398.column.mountlyIncomes.title|translate:vc.viewState.QV_6359_40398.column.mountlyIncomes.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.mountlyIncomes.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.mountlyIncomes, \"QV_6359_40398\", \"mountlyIncomes\"):kendo.toString(#=mountlyIncomes#, vc.viewState.QV_6359_40398.column.mountlyIncomes.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6359_40398.column.mountlyIncomes.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.mountlyIncomes.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.mountlyIncomes.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6359_40398.columns.push({
                    field: 'whichResource',
                    title: '{{vc.viewState.QV_6359_40398.column.whichResource.title|translate:vc.viewState.QV_6359_40398.column.whichResource.titleArgs}}',
                    width: $scope.vc.viewState.QV_6359_40398.column.whichResource.width,
                    format: $scope.vc.viewState.QV_6359_40398.column.whichResource.format,
                    template: "<span ng-class='vc.viewState.QV_6359_40398.column.whichResource.style' ng-bind='vc.getStringColumnFormat(dataItem.whichResource, \"QV_6359_40398\", \"whichResource\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6359_40398.column.whichResource.style",
                        "title": "{{vc.viewState.QV_6359_40398.column.whichResource.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6359_40398.column.whichResource.hidden
                });
            }
            $scope.vc.viewState.QV_6359_40398.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_6359_40398.column.cmdEdition = {};
            $scope.vc.viewState.QV_6359_40398.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_6359_40398.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "Business",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_6359_40398.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6359_40398.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_BUSINESSSS_110304.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_6359_40398.events.customEdit($event, \"#:entity#\", grids.QV_6359_40398)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_6359_40398.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6359_40398.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_BUSINESSSS_110304.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_6359_40398.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_6359_40398.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_6359_40398.toolbar = [{
                "name": "create",
                "entity": "Business",
                "text": "",
                "template": "<button id = 'QV_6359_40398_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_6359_40398.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_BUSINESSSS_110304.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_6359_40398.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }]; //ViewState - Container: RelationForm
            $scope.vc.createViewState({
                id: "VC_QQHYLHYLXD_897494",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RELACINNT_89657",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1399
            $scope.vc.createViewState({
                id: "G_RELATIONNN_434954",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1399',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2466",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2568
            $scope.vc.createViewState({
                id: "G_RELATIONNN_730954",
                hasId: true,
                componentStyle: [],
                label: 'Group2568',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RelationPerson = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    namePersonRight: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RelationPerson", "namePersonRight", '')
                    },
                    relationId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RelationPerson", "relationId", ''),
                        validation: {
                            relationIdRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    secuentialPersonRight: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RelationPerson", "secuentialPersonRight", 0)
                    },
                    secuentialPersonLeft: {
                        type: "number",
                        editable: true
                    },
                    namePersonLeft: {
                        type: "string",
                        editable: true
                    },
                    nameRelation: {
                        type: "string",
                        editable: true
                    },
                    side: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.RelationPerson = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_RELATION_6114';
                            var queryRequest = $scope.vc.getRequestQuery_Q_RELATION_6114();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6114_93961',
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RelationPerson',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6114_93961', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'RelationPerson',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_6114_93961', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.RelationPerson
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6114_93961").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RELATION_6114 = $scope.vc.model.RelationPerson;
            $scope.vc.trackers.RelationPerson = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RelationPerson);
            $scope.vc.model.RelationPerson.bind('change', function(e) {
                $scope.vc.trackers.RelationPerson.track(e);
            });
            $scope.vc.grids.QV_6114_93961 = {};
            $scope.vc.grids.QV_6114_93961.queryId = 'Q_RELATION_6114';
            $scope.vc.viewState.QV_6114_93961 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6114_93961.column = {};
            $scope.vc.grids.QV_6114_93961.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_6114_93961.events = {
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
                    $scope.vc.trackers.RelationPerson.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6114_93961.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'RelationPerson',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_6114_93961", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_6114_93961");
                    $scope.vc.hideShowColumns("QV_6114_93961", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6114_93961.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6114_93961.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6114_93961.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6114_93961 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6114_93961 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_6114_93961.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6114_93961.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6114_93961.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6114_93961.column.namePersonRight = {
                title: 'CSTMR.LBL_CSTMR_CLIENTEAG_28760',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJMD_724954',
                element: []
            };
            $scope.vc.grids.QV_6114_93961.AT35_NAMEPEHT414 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6114_93961.column.namePersonRight.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJMD_724954",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_6114_93961.column.namePersonRight.validationCode}}",
                        'class': "form-control"
                    });
                    var button = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "false",
                        'ng-class': "vc.viewState.QV_6114_93961.column.namePersonRight.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-click': "vc.clickTextInputButtonGrid('VA_TEXTINPUTBOXJMD_724954',vc.grids.QV_6114_93961.selectedRow)"
                    });
                    var divRow = $('<div/>', {
                        'class': "input-group"
                    });
                    var innerDivRow = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var spanImage = $('<span />', {
                        'class': "glyphicon glyphicon-align-justify"
                    });
                    spanImage.appendTo(button);
                    button.appendTo(innerDivRow);
                    textInput.appendTo(divRow);
                    innerDivRow.appendTo(divRow)
                    divRow.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6114_93961.column.relationId = {
                title: 'CSTMR.LBL_CSTMR_RELACINNV_87930',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXCLW_566954',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXCLW_566954 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXCLW_566954', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXCLW_566954'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
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
            $scope.vc.grids.QV_6114_93961.AT95_RELATIII414 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6114_93961.column.relationId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCLW_566954",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_6114_93961.column.relationId.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXCLW_566954",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_6114_93961.column.relationId.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('CSTMR.LBL_CSTMR_RELACINNV_87930') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_6114_93961.column.relationId.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'dsgrequired': "",
                        'placeholder': "vc.getPlaceHolder()",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight = {
                title: 'secuentialPersonRight',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZRU_978954',
                element: []
            };
            $scope.vc.grids.QV_6114_93961.AT80_SECUENLR414 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6114_93961.column.secuentialPersonRight.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZRU_978954",
                        'data-validation-code': "{{vc.viewState.QV_6114_93961.column.secuentialPersonRight.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6114_93961.column.secuentialPersonRight.format",
                        'k-decimals': "vc.viewState.QV_6114_93961.column.secuentialPersonRight.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6114_93961.column.secuentialPersonRight.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6114_93961.column.secuentialPersonLeft = {
                title: 'secuentialPersonLeft',
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
            $scope.vc.viewState.QV_6114_93961.column.namePersonLeft = {
                title: 'namePersonLeft',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.nameRelation = {
                title: 'nameRelation',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.side = {
                title: 'side',
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
                $scope.vc.grids.QV_6114_93961.columns.push({
                    field: 'namePersonRight',
                    title: '{{vc.viewState.QV_6114_93961.column.namePersonRight.title|translate:vc.viewState.QV_6114_93961.column.namePersonRight.titleArgs}}',
                    width: $scope.vc.viewState.QV_6114_93961.column.namePersonRight.width,
                    format: $scope.vc.viewState.QV_6114_93961.column.namePersonRight.format,
                    editor: $scope.vc.grids.QV_6114_93961.AT35_NAMEPEHT414.control,
                    template: "<span ng-class='vc.viewState.QV_6114_93961.column.namePersonRight.style' ng-bind='vc.getStringColumnFormat(dataItem.namePersonRight, \"QV_6114_93961\", \"namePersonRight\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6114_93961.column.namePersonRight.style",
                        "title": "{{vc.viewState.QV_6114_93961.column.namePersonRight.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6114_93961.column.namePersonRight.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6114_93961.columns.push({
                    field: 'relationId',
                    title: '{{vc.viewState.QV_6114_93961.column.relationId.title|translate:vc.viewState.QV_6114_93961.column.relationId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6114_93961.column.relationId.width,
                    format: $scope.vc.viewState.QV_6114_93961.column.relationId.format,
                    editor: $scope.vc.grids.QV_6114_93961.AT95_RELATIII414.control,
                    template: "<span ng-class='vc.viewState.QV_6114_93961.column.relationId.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXCLW_566954.get(dataItem.relationId).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6114_93961.column.relationId.style",
                        "title": "{{vc.viewState.QV_6114_93961.column.relationId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6114_93961.column.relationId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6114_93961.columns.push({
                    field: 'secuentialPersonRight',
                    title: '{{vc.viewState.QV_6114_93961.column.secuentialPersonRight.title|translate:vc.viewState.QV_6114_93961.column.secuentialPersonRight.titleArgs}}',
                    width: $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight.width,
                    format: $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight.format,
                    editor: $scope.vc.grids.QV_6114_93961.AT80_SECUENLR414.control,
                    template: "<span ng-class='vc.viewState.QV_6114_93961.column.secuentialPersonRight.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuentialPersonRight, \"QV_6114_93961\", \"secuentialPersonRight\"):kendo.toString(#=secuentialPersonRight#, vc.viewState.QV_6114_93961.column.secuentialPersonRight.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6114_93961.column.secuentialPersonRight.style",
                        "title": "{{vc.viewState.QV_6114_93961.column.secuentialPersonRight.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6114_93961.column.secuentialPersonRight.hidden
                });
            }
            $scope.vc.viewState.QV_6114_93961.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_6114_93961.column.cmdEdition = {};
            $scope.vc.viewState.QV_6114_93961.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_6114_93961.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_6114_93961.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_6114_93961.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_RELATIONNN_730954.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_6114_93961.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_6114_93961.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_6114_93961.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_6114_93961.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_RELATIONNN_730954.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            $scope.vc.model.Entity2 = {
                attribute1: $scope.vc.channelDefaultValues("Entity2", "attribute1")
            };
            //ViewState - Group: Group1128
            $scope.vc.createViewState({
                id: "G_RELATIONNN_320954",
                hasId: true,
                componentStyle: [],
                label: 'Group1128',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONAPPHYWK_615954",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ComplementaryRequestDataForm
            $scope.vc.createViewState({
                id: "VC_XISAWPDNOD_912400",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DATOSSOIP_61378",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.ComplementaryRequestData = {
                bureauBackground: $scope.vc.channelDefaultValues("ComplementaryRequestData", "bureauBackground"),
                recruitmentChannel: $scope.vc.channelDefaultValues("ComplementaryRequestData", "recruitmentChannel"),
                landlineOne: $scope.vc.channelDefaultValues("ComplementaryRequestData", "landlineOne"),
                electronicSignature: $scope.vc.channelDefaultValues("ComplementaryRequestData", "electronicSignature"),
                professionalActivity: $scope.vc.channelDefaultValues("ComplementaryRequestData", "professionalActivity"),
                customerCode: $scope.vc.channelDefaultValues("ComplementaryRequestData", "customerCode"),
                landlineTwo: $scope.vc.channelDefaultValues("ComplementaryRequestData", "landlineTwo"),
                personNameMessages: $scope.vc.channelDefaultValues("ComplementaryRequestData", "personNameMessages"),
                ifeNumber: $scope.vc.channelDefaultValues("ComplementaryRequestData", "ifeNumber"),
                country: $scope.vc.channelDefaultValues("ComplementaryRequestData", "country"),
                passportNumber: $scope.vc.channelDefaultValues("ComplementaryRequestData", "passportNumber"),
                phoneErrands: $scope.vc.channelDefaultValues("ComplementaryRequestData", "phoneErrands"),
                isCryptoUsed: $scope.vc.channelDefaultValues("ComplementaryRequestData", "isCryptoUsed")
            };
            //ViewState - Group: Group1249
            $scope.vc.createViewState({
                id: "G_COMPLEMETQ_738642",
                hasId: true,
                componentStyle: [],
                label: 'Group1249',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: ifeNumber
            $scope.vc.createViewState({
                id: "VA_IFENUMBERTXDDFK_481642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROINEE_29185",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: passportNumber
            $scope.vc.createViewState({
                id: "VA_PASSPORTNUMBEER_566642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROPAAS_57835",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: electronicSignature
            $scope.vc.createViewState({
                id: "VA_ELECTRONICSIGGU_426642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROSERF_57204",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: phoneErrands
            $scope.vc.createViewState({
                id: "VA_PHONEERRANDSTRD_116642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONODT_17424",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: personNameMessages
            $scope.vc.createViewState({
                id: "VA_PERSONNAMEMEAES_714642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBREPRD_10762",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: bureauBackground
            $scope.vc.createViewState({
                id: "VA_BUREAUBACKGRDDU_704642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CUENTACNU_97404",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BUREAUBACKGRDDU_704642 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BUREAUBACKGRDDU_704642', 'cr_sol_exp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BUREAUBACKGRDDU_704642'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BUREAUBACKGRDDU_704642");
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
            //ViewState - Entity: ComplementaryRequestData, Attribute: landlineOne
            $scope.vc.createViewState({
                id: "VA_LANDLINEONESMPZ_626642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOII_46772",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: landlineTwo
            $scope.vc.createViewState({
                id: "VA_LANDLINETWOBRCP_258642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOER_23297",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: professionalActivity
            $scope.vc.createViewState({
                id: "VA_PROFESSIONALTIT_578642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_LAACTIVIO_46153",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PROFESSIONALTIT_578642 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_PROFESSIONALTIT_578642', 'cl_actividad_profesional', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_PROFESSIONALTIT_578642'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                        }, {
                            filterType: 'contains'
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
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITEUSSN_522642",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_413642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DEMANERTO_74760",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: isCryptoUsed
            $scope.vc.createViewState({
                id: "VA_ISCRYPTOUSEDIBU_338642",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_ISCRYPTOUSEDIBU_338642 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: $filter('translate')('CSTMR.LBL_CSTMR_SIEWZFPWR_22116')
                        }, {
                            code: 'N',
                            value: $filter('translate')('CSTMR.LBL_CSTMR_NODLECHKU_87821')
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_ISCRYPTOUSEDIBU_338642 !== "undefined") {}
            //ViewState - Entity: ComplementaryRequestData, Attribute: recruitmentChannel
            $scope.vc.createViewState({
                id: "VA_RECRUITMENTCNEA_639642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CANALCOIT_52563",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ComplementaryRequestData, Attribute: country
            $scope.vc.createViewState({
                id: "VA_COUNTRYEPAXPVNH_275642",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASDSYTGI_62008",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CUSTOMERCOETP_680_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CUSTOMERCOETP_680_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command4
            $scope.vc.createViewState({
                id: "CM_TCUSTOME_T01",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TCUSTOME_T26",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                enabled: designer.constants.mode.None
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TCUSTOME_2_9",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SINCRONRZ_14543",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TCUSTOME_T6S",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RBURFSLGP_18941",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Command: Command5
            $scope.vc.createViewState({
                id: "CM_TCUSTOME_ROE",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RENAPOLGN_84509",
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.model.GeneralData = {
                loanType: $scope.vc.channelDefaultValues("GeneralData", "loanType"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("GeneralData", "paymentFrecuencyName"),
                productTypeName: $scope.vc.channelDefaultValues("GeneralData", "productTypeName"),
                clientId: $scope.vc.channelDefaultValues("GeneralData", "clientId"),
                symbolCurrency: $scope.vc.channelDefaultValues("GeneralData", "symbolCurrency"),
                vinculado: $scope.vc.channelDefaultValues("GeneralData", "vinculado"),
                sectorNeg: $scope.vc.channelDefaultValues("GeneralData", "sectorNeg")
            };
            $scope.vc.model.OriginalHeader = {
                currencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "currencyRequested"),
                iDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "iDRequested"),
                term: $scope.vc.channelDefaultValues("OriginalHeader", "term"),
                subType: $scope.vc.channelDefaultValues("OriginalHeader", "subType"),
                amountAproved: $scope.vc.channelDefaultValues("OriginalHeader", "amountAproved"),
                applicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "applicationNumber"),
                category: $scope.vc.channelDefaultValues("OriginalHeader", "category"),
                amountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "amountRequested"),
                initialDate: $scope.vc.channelDefaultValues("OriginalHeader", "initialDate"),
                productType: $scope.vc.channelDefaultValues("OriginalHeader", "productType"),
                operationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "operationNumber"),
                officerName: $scope.vc.channelDefaultValues("OriginalHeader", "officerName"),
                paymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "paymentFrequency")
            };
            $scope.vc.model.Parameters = {
                minimumAge: $scope.vc.channelDefaultValues("Parameters", "minimumAge"),
                screenMode: $scope.vc.channelDefaultValues("Parameters", "screenMode"),
                allowUpdateNames: $scope.vc.channelDefaultValues("Parameters", "allowUpdateNames"),
                idExpiration: $scope.vc.channelDefaultValues("Parameters", "idExpiration"),
                refresGrid: $scope.vc.channelDefaultValues("Parameters", "refresGrid")
            };
            $scope.vc.model.RelationContext = {
                secuential: $scope.vc.channelDefaultValues("RelationContext", "secuential"),
                relatioId: $scope.vc.channelDefaultValues("RelationContext", "relatioId")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQYM_561566.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXCQL_755304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXVKC_396304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXTMW_911304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXXIK_422304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXYPK_251304.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXCLW_566954.read();
                    $scope.vc.catalogs.VA_ISCRYPTOUSEDIBU_338642.read();
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
                $scope.vc.render('VC_CUSTOMEROI_208680');
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
    var cobisMainModule = cobis.createModule("VC_CUSTOMEROI_208680", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_CUSTOMEROI_208680", {
            templateUrl: "VC_CUSTOMEROI_208680_FORM.html",
            controller: "VC_CUSTOMEROI_208680_CTRL",
            labelId: "CSTMR.LBL_CSTMR_MANTENIED_75126",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CUSTOMEROI_208680?" + $.param(search);
            }
        });
        VC_CUSTOMEROI_208680(cobisMainModule);
    }]);
} else {
    VC_CUSTOMEROI_208680(cobisMainModule);
}