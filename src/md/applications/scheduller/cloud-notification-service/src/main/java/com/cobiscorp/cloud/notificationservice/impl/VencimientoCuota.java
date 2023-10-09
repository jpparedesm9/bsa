package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.VencimientosCuotas;
import com.cobiscorp.cloud.notificationservice.dto.VencimientosCuotas.Prestamos;
import com.cobiscorp.cloud.notificationservice.dto.report.PagoCorresponsalIndividualDTO;
import com.cobiscorp.cloud.scheduler.utils.GeneracionReporteCorresponsal;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class VencimientoCuota extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(VencimientoCuota.class);

	@Override
	public List<?> xmlToDTO(File inputData) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa xmlToDTO");
		}

		List<PagoCorresponsalIndividualDTO> pagosCorresponsal = new ArrayList<PagoCorresponsalIndividualDTO>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			VencimientosCuotas vencimientoCuota = new VencimientosCuotas();
			vencimientoCuota = (VencimientosCuotas) jxb.unmarshall(vencimientoCuota, inputData);
			List<VencimientosCuotas.Prestamos> prestamos = vencimientoCuota.getPrestamos();
			if (prestamos != null) {
				for (VencimientosCuotas.Prestamos prestamo : prestamos) {
					pagosCorresponsal.add(new PagoCorresponsalIndividualDTO(prestamo, prestamo.getReferencia()));
				}
			}

		} catch (Exception ex) {
			LOGGER.error("ERROR xmlToDTO -->", ex);
		}
		return pagosCorresponsal;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		return GeneracionReporteCorresponsal.setParameterToJasperPagoCorresponsalIndividual(inputDto);
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		return GeneracionReporteCorresponsal.setCollectionPagoCorresponsalIndividual(inputDto);
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			if (inputDto != null) {
				PagoCorresponsalIndividualDTO pagoCorresponsal = (PagoCorresponsalIndividualDTO) inputDto;
				if (pagoCorresponsal != null) {
					Prestamos prestamo = (Prestamos) pagoCorresponsal.getPrestamo();
					parameters.put("EMAIL_TO", prestamo.getMail());
					parameters.put("ID_GRUPO", prestamo.getClienteId());
					parameters.put("NOMBRE_GRUPO", prestamo.getClienteName());
					parameters.put("SUBJECT", "Estado de Cuenta préstamo");
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToSendMail");
			}
		}
		return parameters;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			GenerateReport.generateReport(arg0.getJobDetail().getName(), null);
		} catch (Exception ex) {
			LOGGER.error("Exception: " + ex);
		}

	}

}
