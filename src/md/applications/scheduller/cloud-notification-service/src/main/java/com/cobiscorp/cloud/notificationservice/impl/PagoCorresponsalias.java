package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.PagoCorresponsal;
import com.cobiscorp.cloud.notificationservice.dto.report.Pago;
import com.cobiscorp.cloud.notificationservice.dto.report.PagoCorresponsalGrupalDTO;
import com.cobiscorp.cloud.scheduler.utils.BarCodeGenerator;
import com.cobiscorp.cloud.scheduler.utils.GeneracionReporteCorresponsal;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport.GenerateReportProperties;
import com.cobiscorp.cloud.scheduler.utils.Util;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class PagoCorresponsalias extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(PagoCorresponsalias.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa xmlToDTO");
		}

		List<PagoCorresponsalGrupalDTO> pagosCorresponsal = new ArrayList<PagoCorresponsalGrupalDTO>();
		BarCodeGenerator barCodeGenerator = new BarCodeGenerator();
		try {
			JaxbUtil jxb = new JaxbUtil();

			PagoCorresponsal pagoCorresponsal = new PagoCorresponsal();
			pagoCorresponsal = (PagoCorresponsal) jxb.unmarshall(pagoCorresponsal, inputData);
			List<PagoCorresponsal.Grupo> grupos = pagoCorresponsal.getGrupo();

			if (grupos != null) {
				for (PagoCorresponsal.Grupo grupo : grupos) {
					List<PagoCorresponsal.Grupo.Referencia> referencias = new ArrayList<PagoCorresponsal.Grupo.Referencia>();
					for (PagoCorresponsal.Grupo.Referencia referencia : grupo.getReferencia()) {
						referencia.setBarCode(barCodeGenerator.createBarCode128(referencia.getReferencia(), grupo.getOficina(), referencia.getInstitucion()));
						LOGGER.debug("referencia:" + referencia);
						LOGGER.debug("referencia barcode:" + referencia.getBarCode());
						referencias.add(referencia);
					}
					pagosCorresponsal.add(new PagoCorresponsalGrupalDTO(grupo, referencias));
				}
			}

		} catch (Exception ex) {
			LOGGER.error("ERROR xmlToDTO -->", ex);
		}
		return pagosCorresponsal;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		return GeneracionReporteCorresponsal.setParameterToJasperPagoCorresponsalGrupal(inputDto);
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		return GeneracionReporteCorresponsal.setCollectionPagoCorresponsalGrupal(inputDto);
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}
		PagoCorresponsalGrupalDTO pagoCorresponsal = (PagoCorresponsalGrupalDTO) inputDto;
		PagoCorresponsal.Grupo objDatos = (PagoCorresponsal.Grupo) pagoCorresponsal.getGrupo();

		Map<String, Object> parameters = new HashMap<String, Object>();

		String emailTO = "";
		String emailCC = "";
		String emailBCC = "";
		String subject = " "; /* Se agrega en el SP(sp_notifica_grupo) */
		String saltoLinea = "],\r\n";
		String listClient = "";

		if (objDatos.getDestEmail1() != null && !objDatos.getDestEmail1().trim().isEmpty()) {
			emailTO = objDatos.getDestEmail1();
			listClient = listClient.concat(objDatos.getDestNombre1()).concat(" [").concat(objDatos.getDestCargo1()).concat(saltoLinea);
		}

		if (objDatos.getDestEmail2() != null && !objDatos.getDestEmail2().trim().isEmpty()) {
			emailCC = objDatos.getDestEmail2().concat("; ");
			listClient = listClient.concat(objDatos.getDestNombre2()).concat(" [").concat(objDatos.getDestCargo2()).concat(saltoLinea);
		}

		if (objDatos.getDestEmail3() != null && !objDatos.getDestEmail3().trim().isEmpty()) {
			emailCC = emailCC.concat(objDatos.getDestEmail3().concat("; "));
			listClient = listClient.concat(objDatos.getDestNombre3()).concat(" [").concat(objDatos.getDestCargo3()).concat(saltoLinea);
		}

		if (objDatos.getDestEmail4() != null && !objDatos.getDestEmail4().trim().isEmpty()) {
			emailCC = emailCC.concat(objDatos.getDestEmail4().concat("; "));
			listClient = listClient.concat(objDatos.getDestNombre4()).concat(" [").concat(objDatos.getDestCargo4()).concat(saltoLinea);
		}

		if (objDatos.getDestEmail5() != null && !objDatos.getDestEmail5().trim().isEmpty()) {
			emailCC = emailCC.concat(objDatos.getDestEmail5());
			listClient = listClient.concat(objDatos.getDestNombre5()).concat(" [").concat(objDatos.getDestCargo5()).concat(saltoLinea);
		}

		listClient = listClient.concat("Grupo ").concat(objDatos.getNombreGrupo());

		parameters.put("ID_GRUPO", new Integer(objDatos.getGrupoId()));
		parameters.put("NOMBRE_GRUPO", listClient);
		parameters.put("EMAIL_TO", emailTO);
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject);

		return parameters;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			GenerateReportProperties property = GenerateReport.getProperties(arg0.getJobDetail().getName());

			LOGGER.debug("Jasper Name: " + property.getNameJasper());
			GenerateReport.generateReport(arg0.getJobDetail().getName(), null);
		} catch (Exception ex) {
			LOGGER.error("Exception: " + ex);
		}
	}
}
