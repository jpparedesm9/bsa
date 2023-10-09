(function () {
    'use strict';

    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);

    app.controller("clientviewer.standbyController", ['$scope', '$rootScope', '$filter',
      function ($scope, $rootScope, $filter) {
            $rootScope.spid = 0;
                $scope.changeDate = function (dataS) {
                    for (var i in dataS) {
                        var dateChangeApt = null;
                        var dateChangeVto = null;

                        if (null != dataS[i].date_apt) {
                            dateChangeApt = new Date($filter('date')(parseInt(dataS[i].date_apt.substring(dataS[i].date_apt.indexOf("(") + 1, dataS[i].date_apt.indexOf(")")), "dd-MM-yyyy")));
                        } else {

                            var wdataS = dataS[i].openingDate.split("/");
                            dateChangeApt = new Date(wdataS[2], wdataS[1] - 1, wdataS[0]);
                        }

                        if (null != dataS[i].date_vto) {
                            dateChangeVto = new Date($filter('date')(parseInt(dataS[i].date_vto.substring(6, 18), "dd/MM/yyyy")));
                        } else {
                            dateChangeVto = new Date($filter('date')(parseInt(dataS[i].expirationDate.substring(dataS[i].expirationDate.indexOf("(") + 1, dataS[i].expirationDate.indexOf(")")), "dd/MM/yyyy")));
                        }
                        dataS[i].date_apt = dateChangeApt.toLocaleDateString();
                        dataS[i].date_vto = dateChangeVto.toLocaleDateString();

                    }
                    return dataS;
                };

                $scope.creditLine = new kendo.data.DataSource({

                    data: $scope.changeDate($rootScope.productsCredits),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                type_op_desc: {
                                    type: "string"
                                },
                                line: {
                                    type: "string"
                                },
                                date_apt: {
                                    type: "string"
                                },
                                date_vto: {
                                    type: "string"
                                },
                                money_desc: {
                                    type: "string"
                                },
                                amount_orig: {
                                    type: "number"
                                },
                                available: {
                                    type: "number"
                                },

                                capital_balance: {
                                    type: "string"
                                },
                                state: {
                                    type: "string"
                                }


                            }
                        }
                    }
                });

                $scope.creditlineColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "130px",
                        hidden: "true"
                    },
                    {
                        field: "type_op_desc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION')
                    },
                    {
                        field: "line",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_LINE')
                    },
                    {
                        field: "date_apt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_OPENNING')
                    },
                    {
                        field: "date_vto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DUE_DATE')
                    },
                    {
                        field: "money_desc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_MONEY_DESCRIPTION')
                    },
                    {
                        field: "amount_orig",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_APPROVED'),
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }

                    },
                    {
                        field: "available",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AVAILABLE'),
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "capital_balance",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CAPITAL_BALANCE')
                    },
                    {
                        field: "state",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATE')
                    }];

                $scope.isVisibleStandbyCreditLine = ($rootScope.productsCredits != null && $rootScope.productsCredits.length > 0);


                $scope.domesticCreditLetters;
                $scope.importCreditLetter;
                $scope.standbyCreditLetter;
                $scope.bankEndorsement;
                $scope.foreingBankEndorsement;
                $scope.bankGuarantee;
                $scope.externalGuarantee;

                $scope.initData = function () {
                    $scope.loadStandByCredit()
                };

                $scope.loadStandByCredit = function () {

                    var series_Contingencies = $rootScope.productsContingencies;
                    var series_CCD = new Array();
                    var series_CCI = new Array();
                    var series_STB = new Array();
                    var series_AVB = new Array();
                    var series_AVE = new Array();
                    var series_GRA = new Array();
                    var series_GRB = new Array();
                    for (var i = 0; i < series_Contingencies.length; i++) {
                        if (series_Contingencies[i].type_operation == "CCD") {
                            series_CCD.push(series_Contingencies[i])
                        } else if (series_Contingencies[i].type_operation == "CCI") {
                            series_CCI.push(series_Contingencies[i])
                        } else if (series_Contingencies[i].type_operation == "STB") {
                            series_STB.push(series_Contingencies[i])
                        } else if (series_Contingencies[i].type_operation == "AVB") {
                            series_AVB.push(series_Contingencies[i])
                        } else if (series_Contingencies[i].type_operation == "AVE") {
                            series_AVE.push(series_Contingencies[i])
                        } else if (series_Contingencies[i].type_operation == "GRA") {
                            series_GRA.push(series_Contingencies[i])
                        } else if (series_Contingencies[i].type_operation == "GRB") {
                            series_GRB.push(series_Contingencies[i])
                        }
                    }

                    cobis.userContext.setValue("series_CCD", series_CCD);
                    cobis.userContext.setValue("series_CCI", series_CCI);
                    cobis.userContext.setValue("series_STB", series_STB);
                    cobis.userContext.setValue("series_AVB", series_AVB);
                    cobis.userContext.setValue("series_AVE", series_AVE);
                    cobis.userContext.setValue("series_GRA", series_GRA);
                    cobis.userContext.setValue("series_GRB", series_GRB);

                    $scope.domesticCreditLetters = new kendo.data.DataSource({
                        data: $scope.changeDate(cobis.userContext.getValue('series_CCD')),

                        schema: {
                            model: {
                                fields: {
                                    clientName: {
                                        type: "string"
                                    },
                                    type_op_desc: {
                                        type: "string"
                                    },
                                    operation: {
                                        type: "string"
                                    },
                                    date_apt: {
                                        type: "string"
                                    },
                                    date_vto: {
                                        type: "string"
                                    },
                                    money_desc: {
                                        type: "string"
                                    },
                                    amount_orig: {
                                        type: "number"
                                    },
                                    beneficiary: {
                                        type: "string"
                                    }
                                }
                            }
                        }
                    });
                    $scope.importCreditLetter = new kendo.data.DataSource({

                        data: $scope.changeDate(cobis.userContext.getValue('series_CCI')),
                        schema: $scope.domesticCreditLetters.schema
                    });
                    $scope.standbyCreditLetter = new kendo.data.DataSource({
                        data: $scope.changeDate(cobis.userContext.getValue('series_STB')),
                        schema: $scope.domesticCreditLetters.schema
                    });
                    $scope.bankEndorsement = new kendo.data.DataSource({
                        data: $scope.changeDate(cobis.userContext.getValue('series_AVB')),
                        schema: $scope.domesticCreditLetters.schema
                    });
                    $scope.foreingBankEndorsement = new kendo.data.DataSource({
                        data: $scope.changeDate(cobis.userContext.getValue('series_AVE')),
                        schema: $scope.domesticCreditLetters.schema
                    });
                    $scope.bankGuarantee = new kendo.data.DataSource({
                        data: $scope.changeDate(cobis.userContext.getValue('series_GRA')),
                        schema: $scope.domesticCreditLetters.schema
                    });
                    $scope.externalGuarantee = new kendo.data.DataSource({
                        data: $scope.changeDate(cobis.userContext.getValue('series_GRB')),
                        schema: $scope.domesticCreditLetters.schema
                    });

                    $scope.contingenciesColumns = [
                        {
                            field: "clientName",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                            width: "130px",
                            hidden: "true"
                    },
                        {
                            field: "type_op_desc",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION')
                    },
                        {
                            field: "operation",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_LINE')
                    },
                        {
                            field: "date_apt",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_OPENNING')
                    },
                        {
                            field: "date_vto",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_DUE_DATE')
                    },
                        {
                            field: "money_desc",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_MONEY_DESCRIPTION')
                    },
                        {
                            field: "amount_orig",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_APPROVED'),
                            format: "{0:n}",
                            attributes: {
                                style: "text-align:right;"
                            }
                    },
                        {
                            field: "beneficiary",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_BENEFICIARY')
                    }];


                    $scope.isVisibleStandbyDomesticCreditLetter = (cobis.userContext.getValue('CCD') != null && cobis.userContext.getValue('CCD').length > 0);
                    $scope.isVisibleStandbyImportCreditLetter = (cobis.userContext.getValue('CCI') != null && cobis.userContext.getValue('CCI').length > 0);
                    $scope.isVisibleStandbyCreditLetter = (cobis.userContext.getValue('STB') != null && cobis.userContext.getValue('STB').length > 0);
                    $scope.isVisibleBankEndorsement = (cobis.userContext.getValue('AVB') != null && cobis.userContext.getValue('AVB').length > 0);
                    $scope.isVisibleStandbyforeingBankEndorsement = (cobis.userContext.getValue('AVE') != null && cobis.userContext.getValue('AVE').length > 0);
                    $scope.isVisibleStandbyBankGuarantee = (cobis.userContext.getValue('GRA') != null && cobis.userContext.getValue('GRA').length > 0);
                    $scope.isVisibleStandbyExternalGuarantee = (cobis.userContext.getValue('GRB') != null && cobis.userContext.getValue('GRB').length > 0);


                }
            
 }]);

}());