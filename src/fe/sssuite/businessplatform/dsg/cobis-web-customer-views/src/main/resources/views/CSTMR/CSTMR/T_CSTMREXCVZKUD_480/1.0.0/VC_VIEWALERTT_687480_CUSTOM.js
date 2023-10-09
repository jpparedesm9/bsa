/* variables locales de T_CSTMREXCVZKUD_480*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.viewalertsform;
    

    //"TaskId": "T_CSTMREXCVZKUD_480"


    //gridAfterLeaveInLineRow QueryView: QV_3983_71432
        //Evento GridAfterLeavenlineRow: Se ejecuta después de aceptar la edición o inserción en línea de la grilla.
        task.gridAfterLeaveInLineRow.QV_3983_71432 = function (entities,gridAfterLeaveInLineRowEventArgs) {
            gridAfterLeaveInLineRowEventArgs.commons.execServer = false;
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
            gridAfterLeaveInLineRowEventArgs.commons.api.grid.refresh('QV_3983_71432');
            
        };

//gridBeforeEnterInLineRow QueryView: QV_3983_71432
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_3983_71432 = function (entities,gridBeforeEnterInLineRowEventArgs) {
            gridBeforeEnterInLineRowEventArgs.commons.execServer = false;
            
            gridBeforeEnterInLineRowEventArgs.commons.api.viewState.focus('VA_TEXTINPUTBOXWBE_947760');
            
        };

//Entity: WarningRisk
    //WarningRisk.statusAlert (ComboBox) View: ViewAlertsForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXBZI_516760 = function( entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
               
        
        if((changedEventArgs.newValue === 'NR') || (changedEventArgs.newValue === 'SR')){
            //changedEventArgs.commons.api.grid.enabledColumn('QV_3983_71432','observations');
            //changedEventArgs.commons.api.grid.addCellStyle('QV_3983_71432', changedEventArgs.rowData,'observations', 'Disable_CTR');
            changedEventArgs.commons.api.grid.enabledColumn('QV_3983_71432','observations');
            changedEventArgs.commons.api.grid.showColumn('QV_3983_71432', 'observations');
            
        } else {
            //changedEventArgs.commons.api.grid.disabledColumn('QV_3983_71432','observations');
           // changedEventArgs.commons.api.grid.removeCellStyle('QV_3983_71432', changedEventArgs.rowData,'observations', 'Disable_CTR');
            changedEventArgs.commons.api.grid.disabledColumn('QV_3983_71432','observations');
            changedEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
            
        }
        changedEventArgs.commons.api.ext.timeout(function() { //Aplicar el estilo en toda el area de todas las celdas marcadas
                $('.Disable_CTR').closest('td').addClass('Disable_CTR');
            },1000);
    };

//Entity: HeaderWarningRisk
    //HeaderWarningRisk. (Button) View: ViewAlertsForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONNUZBDYR_446760 = function(  entities, executeCommandEventArgs ) {
       /* if(entities.HeaderWarningRisk.startDate!=null && entities.HeaderWarningRisk.finishDate!=null &&     entities.HeaderWarningRisk.typeAlert!=null )
        {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('Se debe realizar la b\u00fasqueda por Fecha o por Tipo de Operaci\u00f3n',true);
            executeCommandEventArgs.commons.execServer = false;
        }*/
   

    
        //executeCommandEventArgs.commons.serverParameters.HeaderWarningRisk = true;
    };

//WarningRiskQuery Entity: 
    task.executeQuery.Q_WARNINGK_3983 = function(executeQueryEventArgs){
        
        		if((executeQueryEventArgs.parameters.listType=='') ||(executeQueryEventArgs.parameters.listType==' ' ))
		{
			executeQueryEventArgs.parameters.listType=null
		}
          if(executeQueryEventArgs.parameters.alertDate!=null && executeQueryEventArgs.parameters.consultDate!=null &&     executeQueryEventArgs.parameters.listType!=null )
        {
            executeQueryEventArgs.commons.messageHandler.showMessagesError('Se debe realizar la b\u00fasqueda por Fecha o por Tipo de Operaci\u00f3n',true);
            executeQueryEventArgs.commons.execServer = false;
        }
        else
        {
         executeQueryEventArgs.commons.execServer = true;
        }
        //executeQueryEventArgs.commons.serverParameters. = true;
        
    };

//gridRowRendering QueryView: QV_3983_71432
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_3983_71432 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            
           /*  var secuencial=0;
            for(var i=0;i<entities.WarningRisk._data.length;i++)
            {
				secuencial=secuencial+1;
                entities.WarningRisk._data[i].alertCode=secuencial;
            }
            */
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ViewAlertsForm
    task.initData.VC_VIEWALERTT_687480 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
        
    };

//gridRowUpdating QueryView: QV_3983_71432
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_3983_71432 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            //gridRowUpdatingEventArgs.commons.serverParameters.WarningRisk = true;
        };

//gridRowUpdating QueryView: QV_3983_71432
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdatingCallback.QV_3983_71432 = function (entities,gridRowUpdatingCallbackEventArgs) {
            gridRowUpdatingCallbackEventArgs.commons.execServer = false;
            gridRowUpdatingCallbackEventArgs.commons.api.grid.hideColumn('QV_3983_71432', 'observations');
           
        };




}));