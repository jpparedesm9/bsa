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

import com.cobiscorp.cloud.notificationservice.dto.VencimientosProxCuota;
import com.cobiscorp.cloud.notificationservice.dto.VencimientosProxCuota.Prestamos;
import com.cobiscorp.cloud.notificationservice.dto.report.VencimientosProxCuotaDTO;
import com.cobiscorp.cloud.scheduler.utils.BarCodeGenerator;
import com.cobiscorp.cloud.scheduler.utils.GeneracionReporteCorresponsal;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class VencimientoProxCuota extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(VencimientoProxCuota.class);

	@Override
	public List<?> xmlToDTO(File inputData) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("VencimientoProxCuota -- Ingresa xmlToDTO");
		}

		List<VencimientosProxCuotaDTO> vencimientosProxCuotaDTO = new ArrayList<VencimientosProxCuotaDTO>();
		String office = "";
		BarCodeGenerator barCodeGenerator = new BarCodeGenerator();
		try {
			JaxbUtil jxb = new JaxbUtil();
			VencimientosProxCuota vencimientoCuota = new VencimientosProxCuota();
			vencimientoCuota = (VencimientosProxCuota) jxb.unmarshall(vencimientoCuota, inputData);
			List<VencimientosProxCuota.Prestamos> prestamos = vencimientoCuota.getPrestamos();
			if (prestamos != null) {
				for (VencimientosProxCuota.Prestamos prestamo : prestamos) {
					List<VencimientosProxCuota.Prestamos.Referencia> referencias = new ArrayList<VencimientosProxCuota.Prestamos.Referencia>();

					for (VencimientosProxCuota.Prestamos.Referencia referencia : prestamo.getReferencia()) {

						referencia.setBarCode(barCodeGenerator.createBarCode128(referencia.getReferencia(),
								prestamo.getOficinaName(), referencia.getInstitucion()));

						referencias.add(referencia);
					}
					vencimientosProxCuotaDTO.add(new VencimientosProxCuotaDTO(prestamo, referencias));
				}

			}

		} catch (Exception ex) {
			LOGGER.error("VencimientoProxCuota -- xmlToDTO -->", ex);
		}
		return vencimientosProxCuotaDTO;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		return GeneracionReporteCorresponsal.setParameterToJasperVencimientoProxCuota(inputDto);
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		return GeneracionReporteCorresponsal.setCollectionVencimientoProxCuota(inputDto);
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("VencimientoProxCuota -- Ingresa setParameterToSendMail");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			if (inputDto != null) {
				VencimientosProxCuotaDTO pagoCorresponsal = (VencimientosProxCuotaDTO) inputDto;
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
				LOGGER.debug("VencimientoProxCuota -- Finaliza setParameterToSendMail");
			}
		}
		return parameters;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("VencimientoProxCuota -- JobName: " + arg0.getJobDetail().getName());
			GenerateReport.generateReport(arg0.getJobDetail().getName(), null);
		} catch (Exception ex) {
			LOGGER.error("VencimientoProxCuota -- Exception: " + ex);
		}

	}

}
