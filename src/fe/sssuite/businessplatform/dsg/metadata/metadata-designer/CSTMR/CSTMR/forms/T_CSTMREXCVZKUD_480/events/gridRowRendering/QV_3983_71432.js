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