package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

public class CopiaEstadoCuentaInterfactura extends Thread  implements Job {
    private static final Logger logger = Logger.getLogger(CopiaEstadoCuentaInterfactura.class);
    private static final String messageOk = "Copia de Archivos de Estado de Cuenta Interfactura Exitosa!";
    private String tipoOperacion;
	private CopyFileJob copyFileJob;
	
	public CopiaEstadoCuentaInterfactura(String tipoOperacion,CopyFileJob copyFileJob) {
		super();
		this.tipoOperacion = tipoOperacion;
		this.copyFileJob=copyFileJob;
	}

	public CopiaEstadoCuentaInterfactura() {
		super();
	}

	@Override
	public void execute(JobExecutionContext jobExecutionContext)
			throws JobExecutionException {
		if (logger.isDebugEnabled()) {
            logger.debug("JobName para Copia de archivos a la capa web: " + jobExecutionContext.getJobDetail().getName());
        }
		try {
			
			CopiaEstadoCuentaInterfactura cpxmlRevolvente=new CopiaEstadoCuentaInterfactura("REVOLVENTE", copyFileJob);
			cpxmlRevolvente.start();
			
			CopiaEstadoCuentaInterfactura cpxmlGrupal=new CopiaEstadoCuentaInterfactura("GRUPAL",copyFileJob);
			cpxmlGrupal.start();	
			
		} catch (Exception ex) {
			logger.error("Exception CopiaEstadoCuentaInterfactura: " , ex);
		}
		
	}
	
    private void extractInsuranceReports(CopyFileJob copyFileJob,String pattern) {
    	 FileExchangeResponse fileExchangeResponse = copyFileJob.copyFilesZipPattern(pattern);

         if (fileExchangeResponse.isSuccess()) {
             logger.info(messageOk);
             logger.debug("messageOk: "+messageOk);
             //copyFileJob.sendMail(messageOk);
         } else {
             throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
         }
    }
    
    @Override
	public void run() {
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
		
			String estadoGENXML = "";
			String timbrarXML = "";
			String generarPdf = "";
			String enviarEmail = "";

			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotificationGeneral(cn, executeSP, tipoOperacion);
			
			logger.debug("Tipo de Operacion Interfactura timbrado"+tipoOperacion);
			logger.debug("result: " + result);
			while (result.next()) {
				estadoGENXML = result.getString(1);
				timbrarXML = result.getString(2);
				generarPdf = result.getString(3);
				enviarEmail = result.getString(4);
				
				logger.debug("estadoGENXML Interfactura  para timbrar  "+tipoOperacion +": "+ estadoGENXML);
				logger.debug("timbrarXML Interfactura  para timbrar ***** "+ tipoOperacion +": "+ timbrarXML);
				logger.debug("generarPdf Interfactura  para timbrar " + tipoOperacion +": "+ generarPdf);
				logger.debug("enviarEmail Interfactura  para timbrar "+ tipoOperacion +": "+ enviarEmail);
			}
			
			logger.debug("Estado para el tipo de operacion Interfactura  en Timbrado:--> "+timbrarXML+" "+tipoOperacion);
			
			if(timbrarXML.equalsIgnoreCase("SI"))
			{
				 CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYIF);
			        try {
			      		
			        	
			            String pattern=obtenerPattern(copyFileJob,tipoOperacion);
			            logger.error("pattern que ingresa a buscar Interfactura  segun tipo Operacion "+tipoOperacion+": "+pattern);
			            extractInsuranceReports(copyFileJob,pattern);
			        } catch (Exception ex) {
			            logger.error("Error al copiar archivos de Interfactura : ", ex);
			            //copyFileJob.sendMail(ex.getMessage());
			        }
			}
			else
			{
				logger.debug("No se ejecuta ya que el parametro para timbrar xml de Interfactura  es : --> "+timbrarXML+""+tipoOperacion);
			}
			
		} catch (Exception ex) {
			logger.error("Exception: " ,ex);
		}finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				logger.error("Error al cerrar la conexión: ", e);
			}
		}

	}
    
	public static ResultSet executeNotificationGeneral(Connection cn, CallableStatement executeSP, String toperation) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Ingresa executeNotification General copia XML para Interfactura ");
		}
		String query = "{ call cob_conta_super..sp_admin_est_cta(?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, toperation);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			logger.error("ERROR executeNotification General en copia Xml Interfactura  -->", ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza executeNotification General copia  Xml Interfactura ");
			}
		}
		
	}
	
	public String obtenerPattern(CopyFileJob copyFileJob,String tipoOpercion)
	{
		String pattern=null;
		
		String[] patterns =  copyFileJob.getFileNamePattern().split("\\|");
        for (int i = 0; i < patterns.length; i++) {
        	 logger.debug("patterns copia Xml Interfactura " + i + " " + patterns[i]);
        }
        
        if(tipoOpercion.equalsIgnoreCase("GRUPAL"))
        {
        	 pattern=patterns[0];
        }
        
        if(tipoOpercion.equalsIgnoreCase("REVOLVENTE"))
        {
        	 pattern=patterns[1];
        }
		
		return pattern;
	}

}
