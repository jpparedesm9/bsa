<!-- Designer Generator v 6.1.0 - release SPR 2016-20 14/10/2016 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.readjustmentloancabform;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************


    //**********************************************************
    //  Eventos de QUERY VIEW
    //********************************************************** 
    //QueryView: QV_5831_17646
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    //task.gridInitDetailTemplate.QV_5831_17646 = function(entities, gridInitDetailTemplateArgs) {
    //    // gridInitDetailTemplateArgs.commons.execServer = false;
    //};

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************    
    //hasDetail QueryView: QV_5831_17646
    //Evento GridInitDetailTemplate: Inicialización de datos del formulario del detalle de un registro de la grilla de datos 
    task.gridInitDetailTemplate.QV_5831_17646 = function(entities, gridInitDetailTemplateArgs) {
        // gridInitDetailTemplateArgs.commons.execServer = false;
        // gridInitDetailTemplateArgs.commons.serverParameters.entityName = true;
        
         gridInitDetailTemplateEventArgs.commons.execServer = false;
         //gridInitDetailTemplateEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
         //task.gridRow
         task.gridRowSelecting.QV_5831_17646(entities, gridInitDetailTemplateArgs);
          //banSelecting = true;
          var nav = gridInitDetailTemplateArgs.commons.api.navigation;
          //nav.label = gridInitDetailTemplateArgs.modelRow.nombreBanco;

          nav.address = {
              moduleId : 'ASSTS',
              subModuleId : 'MNTNN',
              taskId : 'T_REAJUSTEDEFTF_264',
              taskVersion : '1.0.0',
              viewContainerId : 'VC_REAJUSTEMF_738801'
          };
          
          nav.customDialogParameters = {
              //Obligacion : obligacionTMP,
              Nuevo : false
              //idInstanciaCliente : entities.Cliente.idInstanciaCliente
          };
          nav.openDetailTemplate('QV_5831_17646', gridInitDetailTemplateArgs.modelRow);
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
   //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
   //ViewContainer: undefined
   task.initData.VC_REAJUSTEMF_738801 = function (entities, initDataEventArgs){
       initDataEventArgs.commons.execServer = true;
       initDataEventArgs.commons.serverParameters.Loan = true;
       //initDataEventArgs.commons.serverParameters.ReadjustmentDetalilsLoan = true;
     
       //entities.ReadjustmentLoanCab = [{"fecha":"12/12/2016","mantCuota":"S", "secuencial":"S", "tipo":"N"},{"fecha":"12/12/2016","mantCuota":"S", "secuencial":"S", "tipo":"N"}];
    };

}());
