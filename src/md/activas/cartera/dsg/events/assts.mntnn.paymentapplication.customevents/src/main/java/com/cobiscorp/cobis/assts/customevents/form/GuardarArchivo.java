package com.cobiscorp.cobis.assts.customevents.form;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.PaymentApplication;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.common.IDesignerConstant;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GuardarArchivo extends BaseEvent implements IExecuteCommand{
	
	private static final ILogger logger = LogFactory
			.getLogger(GuardarArchivo.class);

	public GuardarArchivo(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest entities,IExecuteCommandEventArgs arg1) {
		logger.logDebug("con break mta >>>");
		 File archivo = null ;
 		FileReader leer = null;
 		BufferedReader buffer= null;
		
         try {
            logger.logDebug("path >>>"+ SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH));
            
            //Inicio
            
            String linea = "";
            archivo = new File(SessionManager.getSession().get(IDesignerConstant.UPLOAD_FILE_PATH)+"");
    		leer = new FileReader(archivo);
    		buffer =  new BufferedReader(leer);
    		DataEntityList archivoList = new DataEntityList();
    		SimpleDateFormat sdf =  new SimpleDateFormat("dd/MM/yyyy");
    		int cont =0;
    		while ((linea = buffer.readLine()) != null) {
    			String[] valores = parsear(linea);
    			
    			cont = cont + 1;
    			
    				DataEntity item = new DataEntity();
    				logger.logDebug("PaymentApplication.PROCESSDATE >>>" + sdf.parse(valores[0]));
					item.set(PaymentApplication.PROCESSDATE, sdf.parse(valores[0]));
					item.set(PaymentApplication.SENDDATE, sdf.parse(valores[1]));
					item.set(PaymentApplication.IDENTIFICATION, valores[2]);
					item.set(PaymentApplication.TYPEIDENTIFICATION, valores[3]);
					item.set(PaymentApplication.DEBITACCOUNT, valores[4]);
					item.set(PaymentApplication.RECORDACCOUNT, valores[5]);
					item.set(PaymentApplication.GROUPREFERENCE, valores[6]);
					if(!"".equals(valores[7])){
						item.set(PaymentApplication.OPERATION, Integer.parseInt("40"));					
					}else{
						item.set(PaymentApplication.OPERATION, 0);
					}
					if(!"".equals(valores[8])){
						item.set(PaymentApplication.BANK, valores[8]);
					}
					if(!"".equals(valores[9])){
						item.set(PaymentApplication.DEBITAMOUNT,new BigDecimal(10));
					}else{
						item.set(PaymentApplication.DEBITAMOUNT, new BigDecimal(0));
					}
					item.set(PaymentApplication.DEBITEDAMOUNT, new BigDecimal(0));
					item.set(PaymentApplication.PAYMENTTYPE, valores[10]);
					if(!"".equals(valores[12])){
						item.set(PaymentApplication.STATEMENT,  valores[11].charAt(0));
					}
					else{
						item.set(PaymentApplication.STATEMENT, '0');
					}
					item.set(PaymentApplication.TRANSACTION, valores[13]);
    				
					archivoList.add(item);
				   			
    			logger.logDebug("PaymentApplication.OPERATION >>>" + valores[7]  +" - "+ cont );
    			logger.logDebug("linea>>>" + linea);
    		}
    		logger.logDebug("salio mta>>>");
    		entities.setEntityList(PaymentApplication.ENTITY_NAME, archivoList);
 

            //Fin
            
 
        } catch (Exception e) {
            logger.logError("error en el archivo" , e);
            arg1.setSuccess(false);
            arg1.getMessageManager().showInfoMsg("Error al subir el archivo, consultar al administrador");
        }finally{
        	try{
	        	if (buffer !=null){
	        		buffer.close();
	        	}
        	}catch(Exception ex){
    			logger.logError("error en el archivo" , ex);
    	        arg1.setSuccess(false);
    	        arg1.getMessageManager().showInfoMsg("Error al cerrar el buffer del archivo, consultar al administrador");
    		}
        	try{
	        	if (leer !=null){
	        		leer.close();
	        	}
        	}catch(Exception ex){
    			logger.logError("error en el archivo" , ex);
    	        arg1.setSuccess(false);
    	        arg1.getMessageManager().showInfoMsg("Error al cerrar el archivo, consultar al administrador");
    		}
    		
        }
        
	}
	
	
	
	public  String[] parsear (String cadena){
		String[] valores  = new String[14];
		int posicion=0;

		for (int i = 0; i < valores.length; i++) {
			posicion = cadena.indexOf(124);
			valores[i]= cadena.substring(0,posicion);
			cadena = cadena.substring(posicion+1);
			System.out.println("valores : " + valores[i]);
		}
		valores[13]= cadena;
		System.out.println("valores : " + valores[13]);		
		return valores;
		
	}

}
