package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.PagoCorresponsal;
import com.cobiscorp.cloud.notificationservice.dto.report.PagoCorresponsalGrupalDTO;
import com.cobiscorp.cloud.scheduler.utils.BarCodeGenerator;
import com.cobiscorp.cloud.scheduler.utils.GeneracionReporteCorresponsal;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class PagoGarantiaLiquida extends NotificationGeneric implements Job {

	private static final Logger LOGGER = Logger.getLogger(PagoGarantiaLiquida.class);
	private static final int HEADER_COLUMNS = 18;
	private static final int DETAIL_COLUMNS_CG = 7;
	private static final int DETAIL_COLUMNS = 4;

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		return GeneracionReporteCorresponsal.setParameterToJasperPagoCorresponsalGrupal(inputDto);
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		return GeneracionReporteCorresponsal.setCollectionPagoCorresponsalGrupal(inputDto);
	}

	@Override
	public List<?> xmlToDTO(File inputData) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail");
		}

		List<PagoCorresponsal.Grupo> liquidCollateralList = new ArrayList<PagoCorresponsal.Grupo>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			PagoCorresponsal liquidCollateral = new PagoCorresponsal();
			liquidCollateral = (PagoCorresponsal) jxb.unmarshall(liquidCollateral, inputData);
			liquidCollateralList = liquidCollateral.getGrupo();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO -->", e);
		}
		return liquidCollateralList;

	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		PagoCorresponsalGrupalDTO garantiaLiquida = (PagoCorresponsalGrupalDTO) inputDto;
		PagoCorresponsal.Grupo objDatos = (PagoCorresponsal.Grupo) garantiaLiquida.getGrupo();

		Map<String, Object> parameters = new HashMap<String, Object>();

		String emailCC = "";
		String emailBCC = "";
		String subject = ""; /* Se agrega en el SP(sp_notifica_grupo) */

		parameters.put("ID_GRUPO", new Integer(objDatos.getGrupoId()));

		StringBuffer emailTO = new StringBuffer();
		emailTO.append(objDatos.getDestEmail1() == null ? "" : objDatos.getDestEmail1());
		emailTO.append(";");
		emailTO.append(objDatos.getDestEmail2() == null ? "" : objDatos.getDestEmail2());
		emailTO.append(";");
		emailTO.append(objDatos.getDestEmail3() == null ? "" : objDatos.getDestEmail3());
		parameters.put("NOMBRE_GRUPO", objDatos.getNombreGrupo());
		parameters.put("EMAIL_TO", emailTO.toString());
		parameters.put("EMAIL_CC", emailCC);
		parameters.put("EMAIL_BCC", emailBCC);
		parameters.put("SUBJECT", subject);

		return parameters;

	}

	public void executeByTransaction(JobExecutionContext arg0) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByTransaction PagoGarantiaLiquida");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		int countResults = 0;

		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executeNotification(cn, executeSP, "Q", null, null);
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator();

			while (result.next()) {
				Integer transaction = result.getInt(1);
				LOGGER.debug("Tramite: " + transaction);
				CallableStatement executeSPXml = null, executeSPXml1 = null;
				String office = "";
				try {
					LOGGER.debug("primera llamada al sp sp_genera_xml_gar_liquida");
					String queryXml = "{ call cob_cartera..sp_genera_xml_gar_liquida(?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					executeSPXml.setInt(1, transaction);
					executeSPXml.setString(2, "I");
					executeSPXml.execute();

					LOGGER.debug("segunda llamada al sp sp_genera_xml_gar_liquida");
					String queryXml1 = "{ call cob_cartera..sp_genera_xml_gar_liquida(?,?) }";
					executeSPXml1 = cn.prepareCall(queryXml1);
					executeSPXml1.setInt(1, transaction);
					executeSPXml1.setString(2, "F");

					boolean hasResults = executeSPXml1.execute();

					List<PagoCorresponsal.Grupo> grupos = new ArrayList<PagoCorresponsal.Grupo>();
					List<PagoCorresponsal.Grupo.DetallePagos> detallePagos = new ArrayList<PagoCorresponsal.Grupo.DetallePagos>();
					List<PagoCorresponsal.Grupo.Referencia> referencias = new ArrayList<PagoCorresponsal.Grupo.Referencia>();
					LOGGER.debug("hasResults:" + hasResults);

					while (hasResults) {
						ResultSet rs = executeSPXml1.getResultSet();
						LOGGER.debug("rs:" + rs);
						if (rs != null) {
							while (rs.next()) {
								ResultSetMetaData rsmd = rs.getMetaData();
								LOGGER.debug("rsmd:" + rsmd);
								LOGGER.debug("rsmd.getColumnCount() 0  --> " + rsmd.getColumnCount());
								if (rsmd != null && rsmd.getColumnCount() == HEADER_COLUMNS) {
									if (LOGGER.isDebugEnabled()) {
										LOGGER.debug("CABECERA --> ");

										for (int i = 1; i <= rsmd.getColumnCount(); i++) {
											LOGGER.debug("column [" + i + "]" + (rs == null || rs.getObject(i) == null ? "" : rs.getObject(i).toString()));
										}

									}
									PagoCorresponsal.Grupo grupo = new PagoCorresponsal.Grupo();
									grupo.setGrupoId(rs.getInt(1));
									grupo.setNombreGrupo(rs.getString(2));
									XMLGregorianCalendar fechaProceso = toXMLGregorianCalendar(rs.getDate(3));
									grupo.setFechaProceso(fechaProceso);
									XMLGregorianCalendar fechaLiquid = toXMLGregorianCalendar(rs.getDate(4));
									grupo.setFechaLiq(fechaLiquid);
									XMLGregorianCalendar fechaVenc = toXMLGregorianCalendar(rs.getDate(5));
									grupo.setFechaVenc(fechaVenc);
									grupo.setMoneda(rs.getInt(6));
									grupo.setNumPago(rs.getInt(7));
									grupo.setMonto(rs.getBigDecimal(8));
									grupo.setDestNombre1(rs.getString(9));
									grupo.setDestCargo1(rs.getString(10));
									grupo.setDestEmail1(rs.getString(11));
									grupo.setDestNombre2(rs.getString(12));
									grupo.setDestCargo2(rs.getString(13));
									grupo.setDestEmail2(rs.getString(14));
									grupo.setDestNombre3(rs.getString(15));
									grupo.setDestCargo3(rs.getString(16));
									grupo.setDestEmail3(rs.getString(17));
									grupo.setOficina(rs.getString(18));
									office = rs.getString(18);
									grupos.add(grupo);

								} else if (rsmd != null && rsmd.getColumnCount() == DETAIL_COLUMNS_CG) {
									if (LOGGER.isDebugEnabled()) {
										LOGGER.debug("DETALLE Cliente Grupo --> ");

										for (int i = 1; i <= rsmd.getColumnCount(); i++) {
											LOGGER.debug("column [" + i + "]" + (rs == null || rs.getObject(i) == null ? "" : rs.getObject(i).toString()));
										}

									}
									
									PagoCorresponsal.Grupo.DetallePagos dtPagos = new PagoCorresponsal.Grupo.DetallePagos();
									LOGGER.debug("Resultset 1: " + rs.getMetaData().toString());
									LOGGER.debug("Resultset columnas: " + rs.getMetaData().getColumnCount());
									dtPagos.setNombreCliente(rs.getString(2));
									dtPagos.setSeguroVida(rs.getDouble(3));
									dtPagos.setAsistenciaMedica(rs.getDouble(4));
									dtPagos.setPagoAdelantado(rs.getDouble(5));
									dtPagos.setGrupoId(rs.getInt(6));
									detallePagos.add(dtPagos);

								} else if (rsmd != null && rsmd.getColumnCount() == DETAIL_COLUMNS) {
									if (LOGGER.isDebugEnabled()) {
										LOGGER.debug("DETALLE --> ");

										for (int i = 1; i <= rsmd.getColumnCount(); i++) {
											LOGGER.debug("column [" + i + "]" + (rs == null || rs.getObject(i) == null ? "" : rs.getObject(i).toString()));
										}

									}
									PagoCorresponsal.Grupo.Referencia referencia = new PagoCorresponsal.Grupo.Referencia();
									LOGGER.debug("Resultset 2: " + rs.getMetaData().toString());
									LOGGER.debug("Resultset columnas: " + rs.getMetaData().getColumnCount());
									referencia.setInstitucion(rs.getString(1));
									referencia.setReferencia(rs.getString(2));
									referencia.setNroConvenio(rs.getString(3) == null ? "" : rs.getString(3));
									referencia.setGrupoId(rs.getInt(4));
									referencia.setBarCode(barCodeGenerator.createBarCode128(rs.getString(2), office, rs.getString(1)));
									referencias.add(referencia);

								}
								countResults++;
								LOGGER.debug("countResults: " + countResults);
							}

							hasResults = executeSPXml1.getMoreResults();
							rs.close();

						} else {
							hasResults = false;
						}

					}
					List<PagoCorresponsalGrupalDTO> garantiasLiquidas = new ArrayList<PagoCorresponsalGrupalDTO>();
					for (PagoCorresponsal.Grupo grupo : grupos) {

						List<PagoCorresponsal.Grupo.DetallePagos> detClientePorGrp = new ArrayList<PagoCorresponsal.Grupo.DetallePagos>();
						for (PagoCorresponsal.Grupo.DetallePagos dtPagoGrp : detallePagos) {
							if (grupo.getGrupoId() == dtPagoGrp.getGrupoId()) {
								detClientePorGrp.add(dtPagoGrp);
							}
						}

						List<PagoCorresponsal.Grupo.Referencia> referenciasPorGrp = new ArrayList<PagoCorresponsal.Grupo.Referencia>();
						for (PagoCorresponsal.Grupo.Referencia referencia : referencias) {
							if (grupo.getGrupoId() == referencia.getGrupoId()) {
								referenciasPorGrp.add(referencia);
							}
						}
						garantiasLiquidas.add(new PagoCorresponsalGrupalDTO(grupo, detClientePorGrp, referenciasPorGrp));
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(transaction), garantiasLiquidas);

					executeNotification(cn, executeSP, "U", transaction, "T");// Estado
																				// Terminado
				} catch (Exception e) {
					LOGGER.error("Exception:", e);
					executeNotification(cn, executeSP, "U", transaction, "F");// Estado
																				// Fallido
				} finally {

					if (executeSPXml != null) {
						executeSPXml.close();
					}
					if (executeSPXml1 != null) {
						executeSPXml1.close();
					}
				}
			}
		} catch (

		Exception e) {
			LOGGER.error("ERROR executeByTransaction -->", e);
		} finally {
			ConnectionManager.saveConnection(cn);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByTransaction");
			}
		}

	}

	public ResultSet executeNotification(Connection cn, CallableStatement executeSP, String operation, Integer transaction, String status) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotification");
		}
		String query = "{ call cob_cartera..sp_qr_ns_garantia_liquida(?,?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			if (transaction == null) {
				executeSP.setNull(2, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(2, transaction);
			}
			executeSP.setString(3, status);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			LOGGER.error("ERROR executeNotification -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotification");
			}
		}

	}

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		try {
			LOGGER.debug("JobName: " + arg0.getJobDetail().getName());

			executeByTransaction(arg0);
		} catch (Exception ex) {
			LOGGER.error("Exception: ", ex);
		}

	}

	public static XMLGregorianCalendar toXMLGregorianCalendar(Date date) {
		GregorianCalendar gCalendar = new GregorianCalendar();
		gCalendar.setTime(date);
		XMLGregorianCalendar xmlCalendar = null;
		try {
			xmlCalendar = DatatypeFactory.newInstance().newXMLGregorianCalendar(gCalendar);
		} catch (DatatypeConfigurationException ex) {
			LOGGER.error("Exception: ", ex);
		}
		return xmlCalendar;
	}

}