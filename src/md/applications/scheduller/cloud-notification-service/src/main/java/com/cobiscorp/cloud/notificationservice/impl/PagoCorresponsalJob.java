package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.dto.CorresponsalPayment;
import com.cobiscorp.cloud.notificationservice.dto.CorresponsalPayment.Payment;
import com.cobiscorp.cloud.notificationservice.dto.report.CorresponsalPaymentDTO;
import com.cobiscorp.cloud.scheduler.utils.BarCodeGenerator;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;
import com.lowagie.text.pdf.Barcode;

public class PagoCorresponsalJob extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(PagoCorresponsalJob.class);
	private static String office = "";
	private static final int HEADER_COLUMNS = 9;
	private static final int DETAIL_COLUMNS = 3;

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<Payment> paymentsList = new ArrayList<Payment>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			CorresponsalPayment corresponsalPayment = new CorresponsalPayment();
			corresponsalPayment = (CorresponsalPayment) jxb.unmarshall(corresponsalPayment, inputData);
			paymentsList = corresponsalPayment.getPayment();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO --> PagoCorresponsalJob :", e);
		}
		return paymentsList;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToJasper");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			if (inputDto != null) {

				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Ingresa setParameterToJasper");
				}
				CorresponsalPaymentDTO correspPayment = (CorresponsalPaymentDTO) inputDto;
				Payment objDatos = correspPayment == null ? null : correspPayment.getPayment();
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("setParameterToJasper fichaPago." + correspPayment);
				}

				if (objDatos != null) {

					DecimalFormat df = new DecimalFormat("$###,###.00");
					DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
					dfs.setDecimalSeparator('.');
					dfs.setGroupingSeparator(',');
					df.setDecimalFormatSymbols(dfs);

					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("objDatos*");
						LOGGER.debug("objDatos.getCLIENTNAME()" + objDatos.getCLIENTNAME());
						LOGGER.debug("objDatos.getFEENUMBER()" + objDatos.getFEENUMBER());
						LOGGER.debug("objDatos.getEFFECTIVEDATE()" + objDatos.getEFFECTIVEDATE());
						LOGGER.debug("objDatos.getAMOUNT()" + objDatos.getAMOUNT());
					}

					parameters.put("FECINICIOCREDITO", objDatos.getSTARTDATE().toGregorianCalendar().getTime());
					parameters.put("NOMBRECLIENTE", objDatos.getCLIENTNAME());
					parameters.put("FECVIGENCIA", objDatos.getEFFECTIVEDATE().toGregorianCalendar().getTime());
					parameters.put("MONTOPAGO", objDatos.getAMOUNT());
					parameters.put("SUCURSAL", objDatos.getOFFICE());
					parameters.put("NOPAGO", objDatos.getFEENUMBER());
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToJasper - PagoCorresponsalJob");
			}
		}

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollection - PagoCorresponsalJob");
		}
		List<CorresponsalPaymentDTO> dataCollection = new ArrayList<CorresponsalPaymentDTO>();
		try {

			if (inputDto != null) {
				CorresponsalPaymentDTO pagoCorresponsal = (CorresponsalPaymentDTO) inputDto;
				dataCollection.add(pagoCorresponsal);
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setCollection - PagoCorresponsalJob");
			}
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail - PagoCorresponsalJob");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			CorresponsalPaymentDTO objDatos = (CorresponsalPaymentDTO) inputDto;
			if (objDatos != null) {
				Payment payment = objDatos.getPayment();

				String emailCC = "";
				String emailBCC = "";
				// si existe id grupo, recuperar
				parameters.put("ID_GRUPO", new Integer(0));
				parameters.put("NOMBRE_GRUPO", "GRUPAL");
				// parameters.put("MENSAJE", objDatos.getNgMensaje());
				parameters.put("EMAIL_TO", payment.getMAIL());
				parameters.put("EMAIL_CC", emailCC);
				parameters.put("EMAIL_BCC", emailBCC);
				parameters.put("SUBJECT", "FICHA DE PAGO");
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza PagoCorresponsalJob");
			}
		}
		return parameters;
	}

	public void executeByCode(JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByCode-PagoCorresponsalJob");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		int countResults = 0;
		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executeCorresponsalPayment(cn, executeSP, "Q", null, null);
			BarCodeGenerator barCodeGenerator = new BarCodeGenerator();

			while (result.next()) {

				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("PagoCorresponsalJob - result");
				}

				String banco = result.getString(1);
				String estado = result.getString(2);

				CallableStatement executeSPXml = null;
				try {
					// 1fecha
					// 2grupo
					// 3opcion
					// 4banco
					// 5sendMail

					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("PagoCorresponsalJob - result banco " + banco);
						LOGGER.debug("PagoCorresponsalJob - result estado " + estado);

					}

					String queryXml1 = "{ call cob_cartera..sp_gen_ref_cuota_vigente(?,?,?,?,?)  }";
					executeSPXml = cn.prepareCall(queryXml1);
					executeSPXml.setNull(1, java.sql.Types.DATE);
					executeSPXml.setNull(2, java.sql.Types.INTEGER);
					executeSPXml.setString(3, "Q");
					executeSPXml.setString(4, banco);
					executeSPXml.setNull(5, java.sql.Types.VARCHAR);

					boolean hasResults1 = executeSPXml.execute();
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("PagoCorresponsalJob - Genera");
					}

					String queryXml = "{ call cob_cartera..sp_cons_ref_cuota_vigente(?)  }";
					executeSPXml = cn.prepareCall(queryXml);

					executeSPXml.setString(1, banco);

					boolean hasResults = executeSPXml.execute();

					List<CorresponsalPayment.Payment> fichas = new ArrayList<CorresponsalPayment.Payment>();
					List<CorresponsalPayment.Payment.Referencia> referencias = new ArrayList<CorresponsalPayment.Payment.Referencia>();
					while (hasResults) {
						ResultSet rs = executeSPXml.getResultSet();
						while (rs.next()) {
							LOGGER.debug("PagoCorresponsalJOb - rs: " + rs.getMetaData());

							ResultSetMetaData rsmd = rs.getMetaData();
							if ( rsmd != null && rsmd.getColumnCount() == HEADER_COLUMNS) {

								if (LOGGER.isDebugEnabled()) {
									LOGGER.debug("CABECERA --> ");

									for (int i = 1; i <= rsmd.getColumnCount(); i++) {
										LOGGER.debug("column [" + i + "]" + (rs == null || rs.getObject(i) == null ? "" : rs.getObject(i).toString()));
									}
								}
								CorresponsalPayment.Payment payment = new CorresponsalPayment.Payment();
								GregorianCalendar gc = new GregorianCalendar();
								gc.setTime(rs.getDate(1));
								XMLGregorianCalendar gcStartDate = DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
								payment.setSTARTDATE(gcStartDate);
								payment.setCLIENTNAME(rs.getString(2));
								GregorianCalendar gc2 = new GregorianCalendar();
								gc2.setTime(rs.getDate(3));
								XMLGregorianCalendar gcEffectiveDate = DatatypeFactory.newInstance().newXMLGregorianCalendar(gc2);
								payment.setEFFECTIVEDATE(gcEffectiveDate);
								payment.setFEENUMBER(rs.getInt(4));
								payment.setAMOUNT(new BigDecimal(rs.getDouble(5)));
								payment.setOFFICE(rs.getString(6));
								office = rs.getString(6);
								String mails = rs.getString(7);
								if (rs.getString(8) != null) {
									mails = mails + ";" + rs.getString(8);
								}
								if (rs.getString(9) != null) {
									mails = mails + ";" + rs.getString(9);
								}
								payment.setMAIL(mails);

								fichas.add(payment);

							} else if (rsmd != null && rsmd.getColumnCount() == DETAIL_COLUMNS) {
								if (LOGGER.isDebugEnabled()) {
									LOGGER.debug("DETALLE --> ");
									for (int i = 1; i <= rsmd.getColumnCount(); i++) {
										LOGGER.debug("column [" + i + "]" + (rs == null || rs.getObject(i) == null ? "" : rs.getObject(i).toString()));
									}

								}
								CorresponsalPayment.Payment.Referencia referencia = new CorresponsalPayment.Payment.Referencia();
								referencia.setInstitucion(rs.getString(1));
								referencia.setReferencia(rs.getString(2));
								referencia.setNroConvenio(rs.getString(3));
								referencia.setBarCode(barCodeGenerator.createBarCode128(rs.getString(2), office, rs.getString(1)));
								// referencia.setCliente(rs.getInt(4));
								LOGGER.debug("BarCode:" + referencia.getBarCode());
								referencias.add(referencia);
							}

						}
						rs.close();
						hasResults = executeSPXml.getMoreResults();
						countResults++;
					}
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("PagoCorresponsalJob - fichas " + fichas.size());
					}

					List<CorresponsalPaymentDTO> refPaymentCards = new ArrayList<CorresponsalPaymentDTO>();
					for (CorresponsalPayment.Payment paymentCard : fichas) {
						List<CorresponsalPayment.Payment.Referencia> referencesList = new ArrayList<CorresponsalPayment.Payment.Referencia>();
						for (CorresponsalPayment.Payment.Referencia reference : referencias) {
							referencesList.add(reference);
						}
						refPaymentCards.add(new CorresponsalPaymentDTO(paymentCard, referencesList));
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(), String.valueOf(banco), refPaymentCards);
					executeCorresponsalPayment(cn, executeSP, "U", banco, "T");// Estado
																				// Terminado
				} catch (Exception e) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Ingresa excepcion - PaymentCard" + e.getStackTrace());
					}

					LOGGER.error("Error - PaymentCard: ", e);
					executeCorresponsalPayment(cn, executeSP, "U", banco, "F");// Estado
																				// Fallido
				}
			}

		} catch (Exception e) {
			LOGGER.error("ERROR executeByCode General. PaymentCard -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión. PaymentCard : ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeByCode General. PaymentCard");
			}
		}
	}

	public ResultSet executeCorresponsalPayment(Connection cn, CallableStatement executeSP, String operation, String banco, String status) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("PagoCorresponsalJob - executeCorresponsalPayment");
		}
		// 1 operacion
		// 2 banco
		// 3 estado
		String query = "{ call cob_cartera..sp_ns_corresponsal_pago(?,?,?) }";

		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			if (banco == null) {
				executeSP.setNull(2, java.sql.Types.VARCHAR);
			} else {
				executeSP.setString(2, banco);
			}
			if (status == null) {
				executeSP.setNull(3, java.sql.Types.VARCHAR);

			} else {
				executeSP.setString(3, status);
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
