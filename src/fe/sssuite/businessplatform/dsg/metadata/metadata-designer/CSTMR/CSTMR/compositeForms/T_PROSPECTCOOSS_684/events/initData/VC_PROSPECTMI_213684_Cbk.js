//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ProspectComposite
task.initDataCallback.VC_PROSPECTMI_213684 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function (processDate) {
        today = processDate;
        today = new Date(today);
    });
    
    if(initDataEventArgs.success){
        //Asignacion de la consulta de parametros
        edadMax = entities.Context.maximumAge;
        edadMin = entities.Context.minimumAge;
        casado = entities.Context.married;
        unionLibre = entities.Context.freeUnion;
        dirResidencia = entities.Context.flag2;
        dirNegocio = entities.Context.flag3;
    
        /* Req. 178652
        entities.NaturalPerson.colectivo = entities.Context.collective;*/
        entities.NaturalPerson.nivelColectivo = entities.Context.collectiveLevel;    
    }
    
};