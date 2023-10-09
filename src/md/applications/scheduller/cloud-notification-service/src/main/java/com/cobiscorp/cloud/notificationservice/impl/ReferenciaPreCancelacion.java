package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.ReferenciasPreCancelaciones;
import com.cobiscorp.cloud.notificationservice.dto.ReferenciasPreCancelaciones.PreCancelacion;
import com.cobiscorp.cloud.notificationservice.dto.report.PrecancelacionDTO;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class ReferenciaPreCancelacion extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(ReferenciaPreCancelacion.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<PreCancelacion> referenciaList = new ArrayList<ReferenciasPreCancelaciones.PreCancelacion>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			ReferenciasPreCancelaciones precancelacion = new ReferenciasPreCancelaciones();
			precancelacion = (ReferenciasPreCancelaciones) jxb.unmarshall(precancelacion, inputData);
			referenciaList = precancelacion.getPreCancelacion();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}
		return referenciaList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToJasper");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			if (inputDto != null) {
				PrecancelacionDTO precancelacion = (PrecancelacionDTO) inputDto;
				PreCancelacion objDatos = precancelacion == null ? null : precancelacion.getPrecancelacion();
				if (objDatos != null) {

					parameters.put("FECINICIOCREDITO", objDatos.getPrFechaLiq());
					parameters.put("NOMBRECLIENTE", objDatos.getPrNombreCl());
					parameters.put("FECVIGENCIA", objDatos.getPrFechaVen());
					parameters.put("MONTOPAGO", objDatos.getPrMontoPre());
					parameters.put("SUCURSAL", objDatos.getPrNombreOf());
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToJasper");
			}
		}

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollection");
		}
		List<PrecancelacionDTO> dataCollection = new ArrayList<PrecancelacionDTO>();
		try {

			if (inputDto != null) {
				PrecancelacionDTO pagoCorresponsal = (PrecancelacionDTO) inputDto;
				dataCollection.add(pagoCorresponsal);
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setCollection");
			}
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			PrecancelacionDTO objDatos = (PrecancelacionDTO) inputDto;
			if (objDatos != null) {
				PreCancelacion precancelacion = objDatos.getPrecancelacion();

				String emailCC = "";
				String emailBCC = "";
				parameters.put("ID_GRUPO", new Integer(0));
				parameters.put("NOMBRE_GRUPO", "Sonia Rojas");
				parameters.put("EMAIL_TO", precancelacion.getPrMail());
				parameters.put("EMAIL_CC", emailCC);
				parameters.put("EMAIL_BCC", emailBCC);
				parameters.put("SUBJECT", "REFERENCIA PRECANCELACION DE PRESTAMO");
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToSendMail");
			}
		}
		return parameters;
	}

	public void executeByCode(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByCode General");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		int countResults = 0;
		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executePreCancelacion(cn, executeSP, "Q", null, null, null);

			while (result.next()) {
				Integer codigo = result.getInt(1);
				Integer banco = result.getInt(2);
				LOGGER.debug("Código de Notificación: " + codigo);
				LOGGER.debug("Banco de Referencia: " + banco);
				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cob_cartera..sp_genera_xml_precancela_refer(?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setInt(1, codigo);
					executeSPXml.setInt(2, banco);
					executeSPXml.setString(3, "G");

					boolean hasResults = executeSPXml.execute();

					List<ReferenciasPreCancelaciones.PreCancelacion> precancelaciones = new ArrayList<ReferenciasPreCancelaciones.PreCancelacion>();
					List<ReferenciasPreCancelaciones.PreCancelacion.Referencia> referencias = new ArrayList<ReferenciasPreCancelaciones.PreCancelacion.Referencia>();

					while (hasResults) {

						ResultSet rs = executeSPXml.getResultSet();
						if (rs != null) {
							while (rs.next()) {
								ResultSetMetaData rsmd = rs.getMetaData();

								if (countResults == 0) {
									if (LOGGER.isDebugEnabled()) {
										LOGGER.debug("CABECERA --> ");
										if (rsmd != null && rsmd.getColumnCount() > 0) {
											for (int i = 1; i < rsmd.getColumnCount(); i++) {
												LOGGER.debug("column [" + i + "]" + rs.getObject(i) == null ? "" : rs.getObject(i).toString());
											}
										}

									}
									ReferenciasPreCancelaciones.PreCancelacion preCancelacion = new ReferenciasPreCancelaciones.PreCancelacion();
									preCancelacion.setPrCliente(rs.getInt(1));
									preCancelacion.setPrFechaLiq(rs.getString(2));
									preCancelacion.setPrNombreCl(rs.getString(3));
									preCancelacion.setPrFechaVen(rs.getString(4));
									DecimalFormat df = new DecimalFormat("###,###.00");
									DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
									dfs.setDecimalSeparator('.');
									dfs.setGroupingSeparator(',');
									df.setDecimalFormatSymbols(dfs);
								
									preCancelacion.setPrMontoPre(df.format(new BigDecimal(rs.getString(5))));
									preCancelacion.setPrNombreOf(rs.getString(6));
									preCancelacion.setPrMail(rs.getString(7));
									precancelaciones.add(preCancelacion);
								} else {

									if (LOGGER.isDebugEnabled()) {
										LOGGER.debug("DETALLE --> ");
										if (rsmd != null && rsmd.getColumnCount() > 0) {
											for (int i = 1; i < rsmd.getColumnCount(); i++) {
												LOGGER.debug("column [" + i + "]" + rs.getObject(i) == null ? "" : rs.getObject(i).toString());
											}
										}
									}
									ReferenciasPreCancelaciones.PreCancelacion.Referencia referencia = new ReferenciasPreCancelaciones.PreCancelacion.Referencia();
									referencia.setInstitucion(rs.getString(1));
									referencia.setReferencia(rs.getString(2));
									referencia.setNroConvenio(rs.getString(3));
									referencia.setCliente(rs.getInt(4));
									referencias.add(referencia);
								}
							}

							hasResults = executeSPXml.getMoreResults();
							rs.close();
							countResults++;
							LOGGER.debug("countResults: " + countResults);
							
						} else {
							hasResults = false;
						}

					}

					List<PrecancelacionDTO> refPrecancelaciones = new ArrayList<PrecancelacionDTO>();
					for (ReferenciasPreCancelaciones.PreCancelacion precancelacion : precancelaciones) {
						List<ReferenciasPreCancelaciones.PreCancelacion.Referencia> referenciasPorPrecancelacion = new ArrayList<ReferenciasPreCancelaciones.PreCancelacion.Referencia>();
						for (ReferenciasPreCancelaciones.PreCancelacion.Referencia referencia : referencias) {

							if (precancelacion.getPrCliente() == referencia.getCliente()) {
								referenciasPorPrecancelacion.add(referencia);
							}
						}
						refPrecancelaciones.add(new PrecancelacionDTO(precancelacion, referenciasPorPrecancelacion));
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(codigo) + "_" + String.valueOf(banco), refPrecancelaciones);
					executePreCancelacion(cn, executeSP, "U", codigo, "T", banco);// Estado
																					// Terminado
				} catch (Exception e) {
					LOGGER.error("Error: " , e);
					executePreCancelacion(cn, executeSP, "U", codigo, "F", banco);// Estado
																					// Fallido
				}
			}

		} catch (Exception e) {
			LOGGER.error("ERROR executeByCode General -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByCode General");
			}
		}

	}

	public ResultSet executePreCancelacion(Connection cn, CallableStatement executeSP, String operation, Integer codigo, String status, Integer banco) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executePreCancelacion General");
		}
		String query = "{ call cob_cartera..sp_qr_ns_precancela_refer(?,?,?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			if (codigo == null) {
				executeSP.setNull(2, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(2, codigo);
			}
			executeSP.setString(3, status);

			if (banco == null) {
				executeSP.setNull(4, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(4, banco);
			}
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotification General -->", ex);
			throw ex;
		} finally {

			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification General");
			}
		}

	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());
			executeByCode(arg0);
		} catch (Exception ex) {
			LOGGER.error("Exception: " + ex);
		}

	}

}
