package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.IncumplimientoAvalista;
import com.cobiscorp.cloud.notificationservice.dto.report.Pago;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class IncumplimientoAval extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(IncumplimientoAval.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa xmlToDTO");
		}

		List<IncumplimientoAvalista.Incumplimiento> incumplimientoAvalList = new ArrayList<IncumplimientoAvalista.Incumplimiento>();
		try {
			JaxbUtil jxb = new JaxbUtil();

			IncumplimientoAvalista incumplimientoAval = new IncumplimientoAvalista();
			incumplimientoAval = (IncumplimientoAvalista) jxb.unmarshall(incumplimientoAval, inputData);
			incumplimientoAvalList = incumplimientoAval.getIncumplimiento();

		} catch (Exception ex) {
			LOGGER.error("ERROR xmlToDTO -->", ex);
		}
		return incumplimientoAvalList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToJasper");
		}

		IncumplimientoAvalista.Incumplimiento objDatos = (IncumplimientoAvalista.Incumplimiento) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("NOMBREGARANTE", objDatos.getNombreGarante());

		parameters.put("MONTO", objDatos.getMontoDeuda());

		parameters.put("NOCUOTAS", new Integer(objDatos.getDividendo()));

		parameters.put("FECHA", objDatos.getFechaVen().toGregorianCalendar().getTime());

		parameters.put("FUNCIONARIO", objDatos.getNombreOficial());

		parameters.put("CARGO", objDatos.getCargoOficial());

		parameters.put("FECHACARTA", objDatos.getCiudadOficina().concat(", ").concat(convertStringDate(objDatos.getFecha())));

		parameters.put("FECHAPRESTAMO", convertStringDate(objDatos.getFechaVen()));

		parameters.put("SIMBOLOMONEDA", objDatos.getSimbolo());

		parameters.put("NOMBRESUCURSAL", objDatos.getNombreOficina());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollection");
		}

		List<Pago> dataCollection = new ArrayList<Pago>();
		IncumplimientoAvalista.Incumplimiento incumplimiento = (IncumplimientoAvalista.Incumplimiento) inputDto;
		Pago varPago;

		varPago = new Pago(incumplimiento.getDireccionOficina(), incumplimiento.getOperacion().toString());
		dataCollection.add(varPago);

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}
		IncumplimientoAvalista.Incumplimiento incumplimiento = (IncumplimientoAvalista.Incumplimiento) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		String emailTO = incumplimiento.getMailGarante();
		String emailCC = "";
		String emailBCC = "";
		String subject = "Aviso por Pago de Préstamo";
		String listClient = incumplimiento.getNombreGarante();

		parameters.put("ID_GRUPO", incumplimiento.getGarante());
		parameters.put("NOMBRE_GRUPO", listClient);
		parameters.put("EMAIL_TO", emailTO);
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject);

		return parameters;
	}

	private String convertStringDate(XMLGregorianCalendar varDate) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa convertStringDate");
		}

		String stringDate = "";

		try {
			stringDate = "00".substring(String.valueOf(varDate.getDay()).length()).concat(String.valueOf(varDate.getDay()).concat(" de").concat(returnMonthString(varDate)))
					.concat("del ").concat(String.valueOf(varDate.getYear()));
		} catch (Exception ex) {
			LOGGER.error("ERROR convertStringDate", ex);
		} finally {
			return stringDate;
		}
	}

	private String returnMonthString(XMLGregorianCalendar varDate) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa returnMonthString");
		}

		String stringMonth = "";

		try {
			switch (varDate.getMonth()) {
			case 1:
				stringMonth = "Enero";
				break;
			case 2:
				stringMonth = "Febrero";
				break;
			case 3:
				stringMonth = "Marzo";
				break;
			case 4:
				stringMonth = "Abril";
				break;
			case 5:
				stringMonth = "Mayo";
				break;
			case 6:
				stringMonth = "Junio";
				break;
			case 7:
				stringMonth = "Julio";
				break;
			case 8:
				stringMonth = "Agosto";
				break;
			case 9:
				stringMonth = "Septiembre";
				break;
			case 10:
				stringMonth = "Octubre";
				break;
			case 11:
				stringMonth = "Noviembre";
				break;
			case 12:
				stringMonth = "Diciembre";
				break;
			default:
				stringMonth = "Otros";
				break;
			}
		} catch (Exception ex) {
			LOGGER.error("ERROR returnMonthString", ex);
		} finally {
			return " ".concat(stringMonth).concat(" ");
		}
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
