package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
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

import com.cobiscorp.cloud.notificationservice.dto.report.PaymentCardDTO;
import com.cobiscorp.cloud.notificationservice.dto.report.PrecancelacionDTO;
import com.cobiscorp.cloud.scheduler.utils.ConstantValue;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import com.cobiscorp.cloud.notificationservice.dto.FichasPagoLCR;
import com.cobiscorp.cloud.notificationservice.dto.FichasPagoLCR.FichaPago;


import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class PaymentCard  extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(PaymentCard.class);
	

	@Override
	public List<?> xmlToDTO(File inputData) {
		List<FichaPago> fichasPagoList = new ArrayList<FichasPagoLCR.FichaPago>();
		try {
			JaxbUtil jxb = new JaxbUtil();
			FichasPagoLCR fichaPagoLCR = new FichasPagoLCR();
			fichaPagoLCR = (FichasPagoLCR) jxb.unmarshall(fichaPagoLCR, inputData);
			fichasPagoList = fichaPagoLCR.getFichaPago();
		} catch (Exception e) {
			LOGGER.error("ERROR xmlToDTO --> PaymentCard :", e);
		}
		return fichasPagoList;
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
				PaymentCardDTO fichaPago = (PaymentCardDTO) inputDto;
				FichaPago objDatos = fichaPago == null ? null : fichaPago.getFichaPago();
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("setParameterToJasper fichaPago."+fichaPago);
				}
				
				if (objDatos != null) {
				
					DecimalFormat df = new DecimalFormat("$###,###.00");
					DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
					dfs.setDecimalSeparator('.');
					dfs.setGroupingSeparator(',');
					df.setDecimalFormatSymbols(dfs);
					
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("objDatos*");
						LOGGER.debug("objDatos.getPAGOMINIMO()"+objDatos.getPAGOMINIMO());
						LOGGER.debug("objDatos.getPAGOSININTERES()"+objDatos.getPAGOSININTERES());

					}
					
					parameters.put("PNextPaymentDate", objDatos.getFECHAPROXPAGO());
					parameters.put("PMinimiumPayment", objDatos.getPAGOMINIMO()==null? null: df.format(objDatos.getPAGOMINIMO()));
					parameters.put("PAmountNoInterests",objDatos.getPAGOSININTERES()==null ? null :  df.format(objDatos.getPAGOSININTERES()));
					parameters.put("PLoanId", objDatos.getCREDITO());
					parameters.put("PCustomerName",objDatos.getNOMBREDELCLIENTE());
					parameters.put("PUrlLogo", ConstantValue.URL_IMAGEN_TUIIO);
					parameters.put("PUrlInfoImage", ConstantValue.URL_IMAGEN_INFO_PAGO);
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setParameterToJasper - paymentCard");
			}
		}

		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setCollection - PaymentCard");
		}
		List<PaymentCardDTO> dataCollection = new ArrayList<PaymentCardDTO>();
		try {

			if (inputDto != null) {
				PaymentCardDTO pagoCorresponsal = (PaymentCardDTO) inputDto;
				dataCollection.add(pagoCorresponsal);
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setCollection - PaymentCard");
			}
		}

		return dataCollection;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa setParameterToSendMail - PaymentCad");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		try {
			PaymentCardDTO objDatos = (PaymentCardDTO) inputDto;
			if (objDatos != null) {
				FichaPago fichaPago = objDatos.getFichaPago();

				String emailCC = "";
				String emailBCC = "";
				parameters.put("ID_GRUPO", new Integer(0));
				parameters.put("NOMBRE_GRUPO", "LCR");
				// parameters.put("MENSAJE", objDatos.getNgMensaje());
				parameters.put("EMAIL_TO", fichaPago.getMAIL());
				parameters.put("EMAIL_CC", emailCC);
				parameters.put("EMAIL_BCC", emailBCC);
				parameters.put("SUBJECT", "FICHA DE PAGO - LCR");
			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza setPaymentCard");
			}
		}
		return parameters;
	}

	public void executeByCode (JobExecutionContext arg0) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeByCode-PaymentCard");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		int countResults = 0;
		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = executePaymentCard(cn, executeSP, "Q", null, null, null);

			if (LOGGER.isDebugEnabled()) {
			    LOGGER.debug("PaymentCard - executeSP: " + executeSP);
		    }
			while (result.next()) {

				if (LOGGER.isDebugEnabled()) {
			        LOGGER.debug("PaymentCard - result");
		        }

				Integer codigo = result.getInt(1);
				Integer banco = result.getInt(2);

				CallableStatement executeSPXml = null;
				try {
					String queryXml = "{ call cob_cartera..sp_lcr_ficha_pago(?,?,?,?,?,?,?) }";
					executeSPXml = cn.prepareCall(queryXml);
					
					executeSPXml.setNull(1, java.sql.Types.VARCHAR);
					executeSPXml.setNull(2, java.sql.Types.VARCHAR);
					executeSPXml.setString(3, "G");

					executeSPXml.setNull(4, java.sql.Types.VARCHAR);
					executeSPXml.setNull(5, java.sql.Types.TINYINT);
					if (codigo == null) {
						executeSPXml.setNull(6, java.sql.Types.INTEGER);
					} else {
						executeSPXml.setInt(6, codigo);
					}

					if (banco == null) {
						executeSPXml.setNull(7, java.sql.Types.INTEGER);
					} else {
						executeSPXml.setInt(7, banco);
					}

					boolean hasResults = executeSPXml.execute();
					
					List<FichasPagoLCR.FichaPago> fichas = new ArrayList<FichasPagoLCR.FichaPago>();
					List<FichasPagoLCR.FichaPago.Referencia> referencias = new ArrayList<FichasPagoLCR.FichaPago.Referencia>();
					while (hasResults) {
						ResultSet rs = executeSPXml.getResultSet();
						while (rs.next()) {
							LOGGER.debug("PaymentCard - rs: " + rs.getMetaData());

							if (countResults == 0) {
								FichasPagoLCR.FichaPago fichaPago = new FichasPagoLCR.FichaPago();
								fichaPago.setSECUENCIAL(rs.getInt(1));
								fichaPago.setFECHAPROXPAGO(rs.getString(2));
								fichaPago.setPAGOMINIMO(rs.getBigDecimal(3));
								fichaPago.setPAGOSININTERES(rs.getBigDecimal(4));
								fichaPago.setCREDITO(rs.getString(5));
								fichaPago.setNOMBREDELCLIENTE(rs.getString(6));
								fichaPago.setMAIL(rs.getString(7));
								fichaPago.setCLIENTE(rs.getInt(8));
								
								fichas.add(fichaPago);
							} else {

								FichasPagoLCR.FichaPago.Referencia referencia = new FichasPagoLCR.FichaPago.Referencia();
								referencia.setInstitucion(rs.getString(1));
								referencia.setReferencia(rs.getString(2));
								referencia.setNroConvenio(rs.getString(3));
								referencia.setCliente(rs.getInt(4));
								
								referencias.add(referencia);
							}
						}
						rs.close();
						hasResults = executeSPXml.getMoreResults();
						countResults++;
					}

					List<PaymentCardDTO> refPaymentCards = new ArrayList<PaymentCardDTO>();
					for (FichasPagoLCR.FichaPago paymentCard : fichas) {
						List<FichasPagoLCR.FichaPago.Referencia> referencesList = new ArrayList<FichasPagoLCR.FichaPago.Referencia>();
						for (FichasPagoLCR.FichaPago.Referencia reference : referencias) {
							
							if (paymentCard.getCLIENTE() == reference.getCliente()) {
									referencesList.add(reference);
							}
						}
						refPaymentCards.add(new PaymentCardDTO(paymentCard, referencesList));
					}

					GenerateReport.generateReport(arg0.getJobDetail().getName(),
							String.valueOf(codigo) + "_" + String.valueOf(banco), refPaymentCards);
					executePaymentCard(cn, executeSP, "U", codigo, "T", banco);// Estado Terminado
				} catch (Exception e) {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.debug("Ingresa excepcion - PaymentCard"+e.getStackTrace());
					}
					
					LOGGER.error("Error - PaymentCard: " , e);
					executePaymentCard(cn, executeSP, "U", codigo, "F", banco);// Estado Fallido
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
	
	public ResultSet executePaymentCard(Connection cn, CallableStatement executeSP, String operation, Integer codigo,
			String status, Integer banco) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("PaymentCard - executePaymentCard");
		}
		String query = "{ call cob_cartera..sp_lcr_ns_ficha_pago(?,?,?,?) }";
		
		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, operation);
			
			if (codigo == null) {
				executeSP.setNull(2, java.sql.Types.INTEGER);
			} else {
				executeSP.setInt(2, codigo);
			}
			
			if (codigo == null) {
				executeSP.setNull(3, java.sql.Types.VARCHAR);
			}else {
				executeSP.setString(3, status);	
			}
			
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
