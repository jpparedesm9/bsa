(function () {
    'use strict';


    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER, cobis.modules.CUSTOMER, 'ui.bootstrap']);

    app.controller("clientviewer.warrantiesController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams',
        function ($scope, $rootScope, $filter, $modal, $routeParams) {
            $rootScope.spid = 0;
			
            $scope.warrantiesColumns = [
                {
                    field: "warrantyType",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                    width: "130px"
                },
                {
                    field: "code",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_NUMBER_GUARANTEED'),
                    width: "150px"
                },
                {
                    field: "warrantyDescription",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                    width: "130px"
                },
                {
                    field: "initialValue",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_INICIAL_VALUE'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
},
                {
                    field: "actualValue",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENT_VALUE'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
},
                {
                    field: "percet",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_POR_MRC'),
                    width: "130px"
                },
                {
                    field: "state",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                    width: "130px"
                },
                {
                    field: "guarantor",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_WARRANTY_NAME'),
                    width: "130px"
                }];

            $scope.promissoryNotesColumns = [
                {
                    field: "type_op_desc",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                    width: "130px"
                },
                {
                    field: "number_guaranteed",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_NUMBER_GUARANTEED'),
                    width: "150px"
                },
                {
                    field: "money_desc",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                    width: "130px"
                },
                {
                    field: "inicial_value",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_INICIAL_VALUE'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
},
                {
                    field: "current_value",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENT_VALUE'),
                    width: "130px",
                    format: "{0:n}",
                    attributes: {
                        style: "text-align:right;"
                    }
},
                {
                    field: "state",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                    width: "130px"
                }];


            $scope.insurancePolicyColumns = [
                {
                    field: "type_op_desc",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                    width: "130px"
                },
                {
                    field: "insurance_company",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_INSURANCE_COMPANY'),
                    width: "130px"
                },
                {
                    field: "type_policy",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_POLICY'),
                    width: "130px"
                },
                {
                    field: "policy_number",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_POLICY_NUMBER'),
                    width: "130px"
                },
                {
                    field: "number_guaranteed",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_NUMBER_GUARANTEED'),
                    width: "150px"
                },
                {
                    field: "line",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_LINE'),
                    width: "130px"
                },
                {
                    field: "date_vto",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                    width: "130px"
                },
                {
                    field: "state",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                    width: "130px"
                }];


            $scope.warranties = {};
            $scope.isVisibleWarrantiesDet = true;
            $scope.isVisiblePromissoryNotesDet = true;
            $scope.isVisibleInsurancePolicyDet = true;

            //Use to format to date fields
            $scope.convertFields = function (data, type) {
                var currentAc = data;
                if (type == undefined) {
                    for (var i in currentAc) {
                        //new Date(currentAc[i].openingDate); 
                        var dateChange = new Date($filter('date')(parseInt(currentAc[i].date_vto.substring(6, 18), "dd/MM/yyyy"))).toLocaleDateString();
                        currentAc[i].date_vto = dateChange;
                    }
                } else {
                    for (var i in currentAc) {
                        var dateChange = new Date($filter('date')(parseInt(currentAc[i].date_vto.substring(6, 18), "dd/MM/yyyy")));
                        currentAc[i].date_vto = dateChange.toLocaleDateString();
                        if (currentAc[i].lastMovDate != null) {
                            dateChange = new Date($filter('date')(parseInt(currentAc[i].lastMovDate.substring(6, 18), "dd/MM/yyyy")));
                            currentAc[i].lastMovDate = dateChange.toLocaleDateString();
                        }
                    }
                }

                return currentAc;
            }


            $scope.warranties = new kendo.data.DataSource({
                data: $rootScope.productsGuarantees,
                schema: {
                    model: {
                        fields: {
                            type_op_desc: {
                                type: "string"
                            },
                            number_guaranteed: {
                                type: "number"
                            },
                            money_desc: {
                                type: "number"
                            },
                            inicial_value: {
                                type: "number"
                            },
                            current_value: {
                                type: "number"
                            },
                            por_mrc: {
                                type: "string"
                            },
                            state: {
                                type: "string"
                            },
                            warranty_name: {
                                type: "string"
                            }
                        }
                    }
                }
            });

            $scope.promissoryNotes = new kendo.data.DataSource({
                data: $rootScope.productsPromissoryNote,
                schema: {
                    model: {
                        fields: {
                            type_op_desc: {
                                type: "string"
                            },
                            number_guaranteed: {
                                type: "number"
                            },
                            money_desc: {
                                type: "number"
                            },
                            inicial_value: {
                                type: "number"
                            },
                            current_value: {
                                type: "number"
                            },
                            state: {
                                type: "string"
                            }
                        }
                    }
                }
            });



            $scope.insurancePolicy = new kendo.data.DataSource({
                data: $scope.convertFields($rootScope.productsInsurancePolicy),
                schema: {
                    model: {
                        fields: {
                            type_op_desc: {
                                type: "string"
                            },
                            insurance_company: {
                                type: "string"
                            },
                            type_policy: {
                                type: "string"
                            },
                            policy_number: {
                                type: "number"
                            },
                            number_guaranteed: {
                                type: "number"
                            },
                            line: {
                                type: "string"
                            },
                            date_vto: {
                                type: "string"
                            },
                            state: {
                                type: "string"
                            }
                        }
                    }
                }
            });


            $scope.isVisibleWarrantiesDet = ($rootScope.productsGuarantees != null &&
                $rootScope.productsGuarantees.length > 0);


            $scope.isVisiblePromissoryNotesDet = ($rootScope.productsPromissoryNote != null &&
                $rootScope.productsPromissoryNote.length > 0);

            $scope.isVisibleInsurancePolicyDet = ($rootScope.productsInsurancePolicy != null &&
                $rootScope.productsInsurancePolicy.length > 0);


		


       }]);
}());