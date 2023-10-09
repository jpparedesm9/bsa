package com.cobiscorp.cloud.notificationservice.impl;

import com.cobiscorp.cloud.scheduler.utils.CopyFileJob;
import com.cobiscorp.cloud.scheduler.utils.FileExchangeJob;
import com.cobiscorp.cloud.scheduler.utils.FileJob;
import com.cobiscorp.cloud.scheduler.utils.UploadFileJob;
import com.cobiscorp.cloud.scheduler.utils.dto.FileExchangeResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class CopiaReportePagos extends NotificationGeneric implements Job {
    private static final Logger logger = Logger.getLogger(CopiaReportePagos.class);
    private static final String messageOk = "EXTRACCION EXITOSA DE REPORTES DE PAGOS !!";
    InputStream inputStreamPropertiesFile = null;
    private String nameFilter;

    @Override
    public List<?> xmlToDTO(File inputData) {
        return null;
    }

    @Override
    public Map<String, Object> setParameterToJasper(Object inputDto) {
        return null;
    }

    @Override
    public List<?> setCollection(Object inputDto) {
        return null;
    }

    @Override
    public Map<String, Object> setParameterToSendMail(Object inputDto) {
        return null;
    }

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        CopyFileJob copyFileJob = new CopyFileJob(FileJob.Job.CPYRP);
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("JobName: " + jobExecutionContext.getJobDetail().getName());
            }
          
            extractInsuranceReports(copyFileJob);
        } catch (Exception ex) {
            logger.error("Error al ejecutar la Extracción de Reportes de Pagos: ", ex);
            copyFileJob.sendMail(ex.getMessage());
        }
    }

    private void extractInsuranceReports(CopyFileJob copyFileJob) {
        FileExchangeResponse fileExchangeResponse = copyFileJob.copyFiles();

        if (fileExchangeResponse.isSuccess()) {
            logger.info(messageOk);
            copyFileJob.sendMail(messageOk);
        } else {
            throw new COBISInfrastructureRuntimeException(fileExchangeResponse.getErrorMessage());
        }
    }
    
    FilenameFilter textFilter = new FilenameFilter() {
		public boolean accept(File dir, String name) {
			String fileExt;
			String startFileName;
			Integer index;
			Integer digit;
			index = nameFilter.indexOf("_");
			fileExt = nameFilter.substring(nameFilter.indexOf("."), nameFilter.length());
			digit = (nameFilter.substring(0, nameFilter.indexOf("_")).length());

			if (name.endsWith(fileExt)) {
				startFileName = name.substring(0, index);
				if (startFileName.length() == digit) {
					try {
						Integer.parseInt(startFileName);
						return true;
					} catch (NumberFormatException e) {
						return false;
					}
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	};
}
