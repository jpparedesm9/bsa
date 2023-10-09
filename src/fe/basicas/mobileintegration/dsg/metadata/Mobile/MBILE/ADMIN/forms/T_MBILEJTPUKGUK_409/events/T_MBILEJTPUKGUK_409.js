//"TaskId": "T_MBILEJTPUKGUK_409"
var processDate = new Date();

task.fechaProceso= function( email ){
    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function
(processDateServer) {
            processDate = new Date(processDateServer);
        });
};