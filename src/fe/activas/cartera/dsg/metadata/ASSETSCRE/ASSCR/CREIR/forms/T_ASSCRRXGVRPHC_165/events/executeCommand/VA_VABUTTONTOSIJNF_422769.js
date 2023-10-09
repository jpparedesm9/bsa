// (Button) 
    task.executeCommand.VA_VABUTTONTOSIJNF_422769 = function(  entities, executeCommandEventArgs ) {
        
        var ejecuta = 0;
        var i=0;
        var PalabraValidar='NO TENGO';
        var day;
        var mounth;
        var year;
        var j=0;
        
        if(entities.Amount.amountApproved===null || entities.Amount.amountApproved===undefined)
            {
                executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELMONTOTR_31505', true);
                ejecuta=1
            }
        
        for( i=0; i<entities.CallCenterQuestion._data.length;i++)
            {
				if(entities.CallCenterQuestion._data[i].noTengo==='S')
				{
                    if(entities.CallCenterQuestion._data[i].answer==undefined)
                        {
                          entities.CallCenterQuestion._data[i].answer='';  
                        }
                if(((entities.CallCenterQuestion._data[i].answer.toUpperCase().replace(' ','')).localeCompare(PalabraValidar.toUpperCase().replace(' ','') ))==0)
                    {
                       entities.CallCenterQuestion._data[i].answer='';
                    }
				}
            }
        
        for( i=0; i<entities.CallCenterQuestion._data.length;i++)
            {
                if(entities.CallCenterQuestion._data[i].answer===null ||entities.CallCenterQuestion._data[i].answer===undefined)
                    {
                      executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_LARESPUAA_62535'+'', true); 
                        ejecuta=1
                    }
                if(ejecuta==1)
                    {
                      break;  
                    }
            }
        
        for( i=0; i<entities.CallCenterQuestion._data.length;i++)
            {
                if(entities.CallCenterQuestion._data[i].typeAnswer==='F' &&    entities.CallCenterQuestion._data[i].answer!=undefined )
                    {
                        var dateBirth
                        var date = entities.CallCenterQuestion._data[i].answer;
                        var separador = "/";
                        var arregloDeSubCadenas = date.split(separador);
                        day    =arregloDeSubCadenas[0];
                        mounth =arregloDeSubCadenas[1];
                        year   =arregloDeSubCadenas[2];
                        
                        dateBirth=mounth+"/"+day+"/"+year;
                        entities.CallCenterQuestion._data[i].answer=dateBirth;

                    }
            }        
        
        

        
        if(ejecuta==1)
            {
               executeCommandEventArgs.commons.execServer = false; 
            }
        else
            {
                   executeCommandEventArgs.commons.execServer = true;
            }

 
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };