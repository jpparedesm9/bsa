(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);

    app.controller("clientviewer.debtsController", ['$scope',
   '$rootScope', '$filter',
      function ($scope, $rootScope, $filter) {
            $rootScope.spid = 0;
            var currentLoan = $rootScope.productsLoans;
			
            $scope.overdrafts = new kendo.data.DataSource({
                data: $rootScope.productsOverdraft,
                schema: {
                    model: {
                        fields: {
                            clientName: {
                                type: "string"
                            },
                            descriptionType: {
                                type: "string"
                            },
                            numberOperation: {
                                type: "string"
                            },
                            currencyDescription: {
                                type: "string"
                            },
                            amountRisk: {
                                type: "number"
                            },
                            usedAmount: {
                                type: "number"
                            }
                        }
                    }
                }
            });

            $scope.overdraftsColumns = [
                {
                    field: "clientName",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                    width: "130px",
                    hidden: "false"
                },
                {
                    field: "descriptionType",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION'),
                    width: "130px"
                },
                {
                    field: "numberOperation",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'),
                    width: "200px"
                },
                {
                    field: "currencyDescription",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESCRIPTION'),
                    width: "130px"
                },
                {
                    field: "usedAmount",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
                },
                {
                    field: "avaliable",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_AVALIABLE_AMOUNT'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
                }
              ];

            $scope.isVisibleDebtsOverdrafts = ($rootScope.productsOverdraft != null && $rootScope.productsOverdraft.length > 0);

            $scope.loans = new kendo.data.DataSource({
                data: $rootScope.productsLoans,
                schema: {
                    model: {
                        fields: {
                            clientName: {
                                type: "string"
                            },
                            operationType: {
                                type: "string"
                            },
                            operation: {
                                type: "string"
                            },
                            rol: {
                                type: "string"
                            },
                            dateApt: {
                                type: "datetime"
                            },
                            dateVto: {
                                type: "datetime"
                            },
                            currencyDesc: {
                                type: "string"
                            },
                            amountCapital: {
                                type: "number"
                            },
                            balance_due: {
                                type: "number"
                            },
                            balance: {
                                type: "number"
                            },
                            rate: {
                                type: "string"
                            },
                            state: {
                                type: "string"
                            }
                        }
                    }
                }
            });

            $scope.loansColumns = [
                {
                    field: "clientName",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                    width: "130px",
                    hidden: "false"
                },
                {
                    field: "operationType",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION'),
                    width: "130px"
                },
                {
                    field: "operation",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'),
                    width: "200px"
                },
                {
                    field: "rol",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_ROL'),
                    width: "80px"
                },
                {
                    field: "dateApt",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                    width: "100px"
                },
                {
                    field: "dateVto",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                    width: "100px"
                },
                {
                    field: "currencyDesc",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESCRIPTION'),
                    width: "100px"
                },
                {
                    field: "amountCapital",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_ORIGINAL_AMOUNT'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
                },
                {
                    field: "balance_due",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_BALANCE_DUE'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
                },
                {
                    field: "balance",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_BALANCE'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
                },
                {
                    field: "rate",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'),
                    width: "80px"
                },
                {
                    field: "state",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                    width: "100px"
                }
             ];

            $scope.isVisibleDebtsLoans = ($rootScope.productsLoans != null && $rootScope.productsLoans.length > 0);
			
   }]);
}());