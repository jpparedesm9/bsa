//Entity: DisbursementReports
//DisbursementReports.code (TextInputButton) View: DisbursementReportsForm
task.textInputButtonEvent.VA_CODEIFTEIURYYBF_915245 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = 'B\u00FAsqueda de Operaciones Grupales';
    nav.address = {
        moduleId: 'ASSTS'
        , subModuleId: 'CMMNS'
        , taskId: 'T_ASSTSDOHFZMES_451'
        , taskVersion: '1.0.0'
        , viewContainerId: 'VC_LOANSEARUG_773451'
    };
    nav.queryParameters = {
        mode: 1
    };
    nav.modalProperties = {
        size: 'lg'
        , callFromGrid: false
    };
};