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

import com.cobiscorp.cloud.notificationservice.dto.GruposVencidosGerent;
import com.cobiscorp.cloud.notificationservice.dto.GruposVencidosGerent.Gerente;
import com.cobiscorp.cloud.notificationservice.dto.report.GrupoVencido;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class GrupoVencidoGerent extends NotificationGeneric implements Job {
	private static final Logger logger = Logger.getLogger(GrupoVencidoGerent.class);

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {

		Gerente gerente = (Gerente) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("FECHA", new Date());
		parameters.put("NOMBRE_GRUPO", gerente.getGvGerenteName());

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
		String nombreGerente;
		Integer gerenteId;

		Gerente gerente = (Gerente) inputDto;
		gerenteId = gerente.getGvGerenteId();
		nombreGerente = gerente.getGvGerenteName();
		List<GrupoVencido> grupoVencidoList = new ArrayList<GrupoVencido>();

		for (GruposVencidosGerent.Gerente.Coordinador coordinador : gerente.getCoordinador()) {

			nombreCoordinador = coordinador.getGvCoordName();
			coordId = coordinador.getGvCoordId();

			for (GruposVencidosGerent.Gerente.Coordinador.Asesor asesor : coordinador.getAsesor()) {

				nombreAsesor = asesor.getGvAsesorName();
				asesorId = asesor.getGvAsesorId();

				for (GruposVencidosGerent.Gerente.Coordinador.Asesor.Grupo itemGrupo : asesor.getGrupo()) {

					grupoId = Integer.valueOf(itemGrupo.getGvGrupoId());
					grupo = itemGrupo.getGvGrupoName();
					cuotasVencidas = itemGrupo.getGvCuotasVencidas();
					valorVencido = itemGrupo.getGvSaldoExigible();
					cuotaActual = itemGrupo.getGvCuotaActual();

					GrupoVencido grupoVencido = new GrupoVencido(coordId, nombreCoordinador, grupoId, grupo, asesorId, nombreAsesor, gerenteId, nombreGerente, cuotasVencidas,
							valorVencido, cuotaActual);
					grupoVencidoList.add(grupoVencido);
				}
			}
		}

		return grupoVencidoList;
	}

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Gerente> gerenteList = new ArrayList<GruposVencidosGerent.Gerente>();
		try {
			JaxbUtil jxb = new JaxbUtil();

			GruposVencidosGerent grupos = new GruposVencidosGerent();
			grupos = (GruposVencidosGerent) jxb.unmarshall(grupos, inputData);
			gerenteList = grupos.getGerente();

		} catch (Exception e) {
			logger.error("ERROR xmlToDTO -->", e);
		}
		return gerenteList;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {

		Gerente gerente = (Gerente) inputDto;

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("EMAIL_TO", gerente.getGvGerenteEmail());
		parameters.put("ID_GRUPO", gerente.getGvGerenteId());
		parameters.put("NOMBRE_GRUPO", gerente.getGvGerenteName());
		parameters.put("SUBJECT", "Cartera grupal vencida");

		return parameters;
	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			logger.debug("JobName: " + arg0.getJobDetail().getName());
			GenerateReport.generateReport(arg0.getJobDetail().getName(),null);
		} catch (Exception ex) {
			logger.error("Exception: " + ex);
		}
		
	}
}
