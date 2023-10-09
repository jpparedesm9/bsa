//"TaskId": "T_GENERALINANNN_443"
task.loadChart = function(entities, args){
    angular.forEach(entities.SummaryLoanStatus.data(), function (loanStatus) {
        loanStatus.statusAmortization = args.commons.api.viewState.translate(loanStatus.statusAmortization).toUpperCase();
    });

    var nav = args.commons.api.navigation;
    nav.customAddress = {
        id: "leftChart",
        url: "/ASSTS/QERYS/CHARTS/views/leftChart.html",
        useMinification: false
    };
    //CALL TO CONTROLLER
    nav.scripts = [{module: "ChartGeneralInfo", files: ["/ASSTS/QERYS/CHARTS/controllers/LeftChartCtrl.js"]}];
    nav.customDialogParameters = {};		
    nav.registerCustomView('G_GENERALOLN_670344');
};
