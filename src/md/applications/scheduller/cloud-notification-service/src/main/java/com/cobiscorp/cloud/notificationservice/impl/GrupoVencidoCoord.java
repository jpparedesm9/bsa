package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.GruposVencidosCoord;
import com.cobiscorp.cloud.notificationservice.dto.GruposVencidosCoord.Coordinador;
import com.cobiscorp.cloud.notificationservice.dto.report.GrupoVencido;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class GrupoVencidoCoord extends NotificationGeneric implements Job {

	private static final Logger logger = Logger.getLogger(GrupoVencidoCoord.class);

	@Override
	public List<?> xmlToDTO(File inputData) {

		List<Coordinador> coordinadorList = new ArrayList<GruposVencidosCoord.Coordinador>();

		try {
			JaxbUtil jxb = new JaxbUtil();

			GruposVencidosCoord grupos = new GruposVencidosCoord();
			grupos = (GruposVencidosCoord) jxb.unmarshall(grupos, inputData);
			coordinadorList = grupos.getCoordinador();

		} catch (Exception e) {
			logger.error("ERROR xmlToDTO -->", e);
		}
		return coordinadorList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		Coordinador coordinador = (Coordinador) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("FECHA", new Date());
		parameters.put("NOMBRE_GRUPO", coordinador.getGvCoordName());

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		Integer coordId;
		String nombreCoordinador;
		Integer grupoId;
		String grupo;
		Integer asesorId;
		String nombreAsesor;
		Integer cuotasVencidas;
		BigDecimal valorVencido;
		BigDecimal cuotaActual;

		Coordinador coordinador = (Coordinador) inputDto;
		nombreCoordinador = coordinador.getGvCoordName();
		coordId = coordinador.getGvCoordId();

		List<GrupoVencido> grupoVencidoList = new ArrayList<GrupoVencido>();

		for (GruposVencidosCoord.Coordinador.Asesor asesor : coordinador.getAsesor()) {
			nombreAsesor = asesor.getGvAsesorName();
			asesorId = asesor.getGvAsesorId();

			for (GruposVencidosCoord.Coordinador.Asesor.Grupo itemg : asesor.getGrupo()) {

				grupoId = Integer.valueOf(itemg.getGvGrupoId());
				grupo = itemg.getGvGrupoName();
				cuotasVencidas = itemg.getGvCuotasVencidas();
				valorVencido = itemg.getGvSaldoExigible();
				cuotaActual = itemg.getGvCuotaActual();

				GrupoVencido grupoVencido = new GrupoVencido(coordId, nombreCoordinador, grupoId, grupo, asesorId, nombreAsesor, null, null, cuotasVencidas, valorVencido,
						cuotaActual);

				grupoVencidoList.add(grupoVencido);
			}
		}

		return grupoVencidoList;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		Coordinador coordinador = (Coordinador) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();

		parameters.put("EMAIL_TO", coordinador.getGvCoordEmail());
		parameters.put("ID_GRUPO", coordinador.getGvCoordId());
		parameters.put("NOMBRE_GRUPO", coordinador.getGvCoordName());
		parameters.put("SUBJECT", "Cartera grupal vencida");

		return parameters;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			logger.debug("JobName: " + arg0.getJobDetail().getName());
			GenerateReport.generateReport(arg0.getJobDetail().getName(), null);
		} catch (Exception ex) {
			logger.error("Exception: " + ex);
		}

	}

}
