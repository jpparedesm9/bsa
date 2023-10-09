package com.cobiscorp.cloud.scheduler.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.notificationservice.dto.PagoCorresponsal;
import com.cobiscorp.cloud.notificationservice.dto.VencimientosCuotas;
import com.cobiscorp.cloud.notificationservice.dto.VencimientosProxCuota;
import com.cobiscorp.cloud.notificationservice.dto.report.PagoCorresponsalGrupalDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.PagoCorresponsalIndividualDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.VencimientosProxCuotaDTO;

public class GeneracionReporteCorresponsal {

	private static final Logger LOGGER = Logger.getLogger(GeneracionReporteCorresponsal.class);

	public static List<?> setCollectionPagoCorresponsalGrupal(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollectionPagoCorresponsal");
		}
		List<PagoCorresponsalGrupalDTO> dataCollection = new ArrayList<PagoCorresponsalGrupalDTO>();
		try {

			if (inputDto != null) {
				PagoCorresponsalGrupalDTO pagoCorresponsal = (PagoCorresponsalGrupalDTO) inputDto;
				dataCollection.add(pagoCorresponsal);
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setCollectionPagoCorresponsal");
			}
		}

		return dataCollection;
	}

	public static List<?> setCollectionPagoCorresponsalIndividual(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollectionPagoCorresponsalIndividual");
		}
		List<PagoCorresponsalIndividualDTO> dataCollection = new ArrayList<PagoCorresponsalIndividualDTO>();
		try {

			if (inputDto != null) {
				PagoCorresponsalIndividualDTO pagoCorresponsal = (PagoCorresponsalIndividualDTO) inputDto;
				dataCollection.add(pagoCorresponsal);
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setCollectionPagoCorresponsalIndividual");
			}
		}

		return dataCollection;
	}

	public static Map<String, Object> setParameterToJasperPagoCorresponsalGrupal(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToJasperPagoCorresponsal");
		}

		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			LOGGER.debug("inputDto: " + inputDto);
			if (inputDto != null) {
				PagoCorresponsalGrupalDTO pagoCorresponal = (PagoCorresponsalGrupalDTO) inputDto;
				PagoCorresponsal.Grupo objDatos = pagoCorresponal == null ? null : pagoCorresponal.getGrupo();
				if (objDatos != null) {
					parameters.put("FECINICIOCREDITO", objDatos.getFechaLiq() == null ? null
							: objDatos.getFechaLiq().toGregorianCalendar().getTime());
					parameters.put("NOMBRECLIENTE", objDatos.getNombreGrupo());
					parameters.put("FECVIGENCIA", objDatos.getFechaVenc() == null ? null
							: objDatos.getFechaVenc().toGregorianCalendar().getTime());
					parameters.put("NOPAGO", objDatos.getNumPago());
					parameters.put("MONTOPAGO", objDatos.getMonto());
					parameters.put("SUCURSAL", objDatos.getOficina());
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToJasperPagoCorresponsal");
			}
		}

		return parameters;
	}

	public static Map<String, Object> setParameterToJasperPagoCorresponsalIndividual(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToJasperPagoCorresponsalIndividual");
		}

		Map<String, Object> parameters = new HashMap<String, Object>();
		try {

			if (inputDto != null) {
				PagoCorresponsalIndividualDTO pagoCorresponsal = (PagoCorresponsalIndividualDTO) inputDto;
				VencimientosCuotas.Prestamos objDatos = pagoCorresponsal == null ? null
						: pagoCorresponsal.getPrestamo();
				if (objDatos != null) {
					parameters.put("FECINICIOCREDITO", objDatos.getFechaLiq() == null ? null
							: objDatos.getFechaLiq().toGregorianCalendar().getTime());
					parameters.put("NOMBRECLIENTE", objDatos.getClienteName());
					parameters.put("FECVIGENCIA", objDatos.getFechaVig() == null ? null
							: objDatos.getFechaVig().toGregorianCalendar().getTime());
					parameters.put("NOPAGO", objDatos.getDividendo());
					parameters.put("MONTOPAGO", objDatos.getMonto());
					parameters.put("SUCURSAL", objDatos.getOficinaName());
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToJasperPagoCorresponsalIndividual");
			}
		}
		return parameters;
	}
	
	public static Map<String, Object> setParameterToJasperVencimientoProxCuota(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToJasperVencimientoProxCuota");
		}

		Map<String, Object> parameters = new HashMap<String, Object>();
		try {

			if (inputDto != null) {
				VencimientosProxCuotaDTO pagoCorresponsal = (VencimientosProxCuotaDTO) inputDto;
				VencimientosProxCuota.Prestamos objDatos = pagoCorresponsal == null ? null
						: pagoCorresponsal.getPrestamo();
				if (objDatos != null) {
					parameters.put("FECINICIOCREDITO", objDatos.getFechaLiq() == null ? null
							: objDatos.getFechaLiq().toGregorianCalendar().getTime());
					parameters.put("NOMBRECLIENTE", objDatos.getClienteName());
					parameters.put("FECVIGENCIA", objDatos.getFechaVig() == null ? null
							: objDatos.getFechaVig().toGregorianCalendar().getTime());
					parameters.put("NOPAGO", objDatos.getDividendo());
					parameters.put("MONTOPAGO", objDatos.getMonto());
					parameters.put("SUCURSAL", objDatos.getOficinaName());
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToJasperVencimientoProxCuota");
			}
		}
		return parameters;
	}
	
	public static List<?> setCollectionVencimientoProxCuota(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollectionVencimientoProxCuota");
		}
		List<VencimientosProxCuotaDTO> dataCollection = new ArrayList<VencimientosProxCuotaDTO>();
		try {

			if (inputDto != null) {
				VencimientosProxCuotaDTO pagoCorresponsal = (VencimientosProxCuotaDTO) inputDto;
				dataCollection.add(pagoCorresponsal);
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setCollectionVencimientoProxCuota");
			}
		}

		return dataCollection;
	}
}
