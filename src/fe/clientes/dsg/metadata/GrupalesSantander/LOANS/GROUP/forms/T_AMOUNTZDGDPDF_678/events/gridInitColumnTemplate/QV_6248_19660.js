task.gridInitColumnTemplate.QV_6248_19660 = function(idColumn, gridInitColumnTemplateEventArgs) {
    if (angular.isDefined(gridInitColumnTemplateEventArgs.commons.api.vc.parentVc)) {
        stage = gridInitColumnTemplateEventArgs.commons.api.vc.parentVc.customDialogParameters.Task.urlParams.Etapa;
    } else {
        stage = "";
    }
    if (idColumn == 'creditBureau') {
        return "<div class='cb-indicator cb-flex cb-column'>" +
            "<div class='cb-flex cb-grow cb-center cb-middle cb-indicator-value'>{{dataItem.creditBureau}}</div>" +
            "<div ng-show='{{dataItem.riskLevel == \"VERDE\"}}' style='background-color:green;height:3px;'></div>" +
            "<div ng-show='{{dataItem.riskLevel == \"AMARILLO\"}}' style='background-color:yellow;height:3px;'></div>" +
            "<div ng-show='{{dataItem.riskLevel == \"ROJO\"}}' style='background-color:red;height:3px;'></div>" +
            "<div class='cb-footer-label'>{{'LOANS.LBL_LOANS_NIVELDERI_38662'|translate}}</div>" +
            "</div>";
    }

   
    if (idColumn == 'amount' && stage != 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.amount\" id=\"VA_TEXTINPUTBOXSRP_129190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.amount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.amount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.amount.decimals\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'amount')\" tabindex=\"10000\"></input>";
    } else if (idColumn == 'amount' && stage == 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.amount\"  disabled=\"disabled\" id=\"VA_TEXTINPUTBOXSRP_129190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.amount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.amount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.amount.decimals\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'amount')\" tabindex=\"10000\"></input>";
    }


    if (idColumn == 'authorizedAmount' && stage != 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.authorizedAmount\" id=\"VA_TEXTINPUTBOXLEH_921190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.authorizedAmount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.authorizedAmount.decimals\"  k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'authorizedAmount')\"></input>";
    } else if (idColumn == 'authorizedAmount' && stage == 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.authorizedAmount\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXLEH_921190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.authorizedAmount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.authorizedAmount.decimals\"  k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'authorizedAmount')\"></input>";
    }

    if (idColumn == 'voluntarySavings' && (stage != 'CONSULTA' && stage != 'APROBAR')) {
        return "<input type=\"text\" ng-model=\"dataItem.voluntarySavings\" id=\"VA_TEXTINPUTBOXUPR_288190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.voluntarySavings.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.voluntarySavings.decimals\" ></input>";
    } else if (idColumn == 'voluntarySavings' && (stage == 'CONSULTA' || stage == 'APROBAR')) {
        return "<input type=\"text\" ng-model=\"dataItem.voluntarySavings\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXUPR_288190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.voluntarySavings.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.voluntarySavings.decimals\" ></input>";
    }

    if (idColumn == 'proposedMaximumSaving') {
        return "<input type=\"text\" ng-model=\"dataItem.proposedMaximumSaving\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXWXN_691190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.proposedMaximumSaving.decimals\" ></input>";
    }
    //if(idColumn == 'NombreColumna'){
    //  return  "#=nombreColumna#" ;
    //}  
    if (idColumn == 'increment') {
        return "<input type=\"text\" ng-model=\"dataItem.increment\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXAFW_332190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.increment.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.increment.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.increment.decimals\" ></input>";
    }

    if (idColumn === 'safePackage' && stage == 'APROBAR') {
        cobis.showMessageWindow.loading(true);
        return "<input id=\"VA_TEXTINPUTBOXYVS_120190\" kendo-ext-combo-box=\"comboBox.VA_TEXTINPUTBOXYVS_120190\" k-data-source=\"vc.catalogs.VA_TEXTINPUTBOXYVS_120190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.safePackage.validationCode}}\" ng-model=\"dataItem.safePackage\"  k-auto-bind=\"true\" k-ng-delay=\"vc.afterInitData\"  k-data-text-field=\"'value'\" k-data-value-field=\"'code'\" k-index=0 />";

    }


};