package com.cobiscorp.ecobis.external.services.bl.impl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import cobiscorp.ecobis.card.dto.CardData;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.cis.sp.java.orchestration.SPJavaOrchestrationBase;
import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.csp.domains.ICSP;
import com.cobiscorp.cobis.csp.services.inproc.IProvider;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobisv.commons.catalog.CobisCatalogRB;
import com.cobiscorp.ecobis.external.services.utils.ConvertTCREMessageUtil;

public class CreditCardManagerImpl {
	private static ILogger logger = LogFactory.getLogger(CreditCardManagerImpl.class);
	private ICTSServiceIntegration serviceIntegration;
	private static ICacheManager cacheManager;
	private static final String CACHE_WEB_SERVICES_CREDIT_CARD = "CacheCreditCardListResult";

	public static List<CardData> getCreditCardsContingents(Integer customer) {

		try {
			logger.logInfo("Servicio Externo CreditCard  --> getCreditCardsContingents");

			ConvertTCREMessageUtil wConverter = new ConvertTCREMessageUtil();

			// ICache wCache =
			// cacheManager.getCache(CACHE_WEB_SERVICES_CREDIT_CARD);
			// la clave del mapa deberia ser el identificador del cliente
			// validar si existe data en cache sino cargarla

			List<CardData> lstCardDataDTO = new ArrayList<CardData>();

			ComponentLocator locator = ComponentLocator.getInstance(SPJavaOrchestrationBase.class);
			IProvider provider = (IProvider) locator.find(IProvider.class);
			IProcedureRequest procedureRequest = new ProcedureRequestAS();
			procedureRequest.addFieldInHeader("externalProvider", ICOBISTS.HEADER_STRING_TYPE, "1");
			procedureRequest.addFieldInHeader("channel", ICOBISTS.HEADER_STRING_TYPE, "8");
			procedureRequest.addFieldInHeader(ICOBISTS.HEADER_TRN, ICOBISTS.HEADER_STRING_TYPE, "2");
			procedureRequest.addFieldInHeader("com.cobiscorp.cobis.csp.services.ICSPExecutorConnector", ICOBISTS.HEADER_STRING_TYPE,
					"(service.identifier=CreditCardConectorQuery)");
			procedureRequest.addFieldInHeader("csp.skip.transformation", ICOBISTS.HEADER_STRING_TYPE, ICOBISTS.YES);
			procedureRequest.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);

			procedureRequest.addInputParam("@i_operacion", ICTSTypes.SYBVARCHAR, "C");
			procedureRequest.addInputParam("@i_codigo_cliente", ICTSTypes.SYBVARCHAR, customer.toString());

			IProcedureResponse wProcedureResp = provider.executeProvider(procedureRequest);
			//wProcedureResp.getReturnCode();
			logger.logInfo("Codigo de ERROR" + wProcedureResp.getReturnCode());
			logger.logInfo("XML RESPUESTA->>>>>>" + wProcedureResp.readValueParam("@o_message"));

			String respuesta = wProcedureResp.readValueParam("@o_message");
			logger.logInfo("Respuesta de consultar Tarjetas: " + respuesta);

			wConverter.read(respuesta);
			logger.logInfo("CODIGO RESPUESTA: " + wConverter.getCodigoRespuesta());
			logger.logInfo("MENSAJE RESPUESTA: " + wConverter.getMensajeRespuesta());

			ResourceBundle wResourceBundle = CobisCatalogRB.getResourceBundle(Locale.getDefault(), "cl_moneda");

			for (Map<String, Object> aux : wConverter.getListaMapas()) {
				CardData carDataDTO = new CardData();

				for (Map.Entry<String, Object> entry : aux.entrySet()) {

					if (entry.getKey().equalsIgnoreCase("LimiteAprobado")) {
						carDataDTO.setLimiteAprobado(Double.parseDouble(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("CodigoCuenta")) {
						carDataDTO.setCodigoTarjeta(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("FechaActivacion")) {
						carDataDTO.setFechaCancela(convertStringToCalendar(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("NombreTarjeta")) {
						carDataDTO.setDescripcion(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Estado")) {
						carDataDTO.setEstado(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Mondeda")) {
						carDataDTO.setMoneda(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Oficina")) {
						carDataDTO.setOficina(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("CodigoLinea")) {
						carDataDTO.setCodigoLinea(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("TipoTarjeta")) {
						carDataDTO.setTipoTarjeta(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Marca")) {
						carDataDTO.setMarca(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("SaldoDisponible")) {
						carDataDTO.setSaldoDisponible(Double.parseDouble(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("FechaExpiracion")) {
						carDataDTO.setFechaExpira(convertStringToCalendar(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("Seguro")) {
						carDataDTO.setSeguro(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("MontoUtilizado")) {
						carDataDTO.setMontoUtilizado(Double.parseDouble(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("CodigoCuenta")) {
						carDataDTO.setCodigoTarjeta(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("TipoTarjeta")) {
						carDataDTO.setTipoTarjeta(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Marca")) {
						carDataDTO.setMarca(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("CuentaAsociada")) {
						carDataDTO.setCuentaAsociada(entry.getValue().toString());
					}

					Iterator<String> wIt = wResourceBundle.keySet().iterator();
					while (wIt.hasNext()) {
						String key = (String) wIt.next();
						String value = wResourceBundle.getString(key);

						logger.logDebug("CONT CURRENCY DESCRIPTION --> " + key + "-" + value);

						if (key != null && value != null && key.trim().equals(carDataDTO.getMoneda())) {
							carDataDTO.setMonedaDesc(value);
						}
					}

				}
				lstCardDataDTO.add(carDataDTO);
			}

			// Serializable wSerializable = (Serializable)
			// wConverter.getListaMapas();
			// wCache.put("mapaTarjetas", wSerializable);
			// }

			return lstCardDataDTO;

		} catch (Exception e) {

			logger.logError(e);
			logger.logError("Ocurrió un error al consultar las Tarjetas de Crédito");
			return new ArrayList<CardData>();

		} finally {
			logger.logDebug("Finaliza Consulta de Tarjetas de Crédito por Cliente");
		}
	}

	public static List<CardData> getCreditCardsDebts(Integer customer) {

		try {
			logger.logInfo("Servicio Externo de Trajetas de credito FIN --> getCreditCardsDebts");

			ConvertTCREMessageUtil wConverter = new ConvertTCREMessageUtil();

			// ICache wCache =
			// cacheManager.getCache(CACHE_WEB_SERVICES_CREDIT_CARD);
			// la clave del mapa deberia ser el identificador del cliente
			// validar si existe data en cache sino cargarla

			List<CardData> lstCardDataDTO = new ArrayList<CardData>();
			// if (wCache.get("mapaTarjetas") != null) {
			// logger.logInfo("INICIO MAPA CACHE");
			// logger.logInfo("MAPA CACHE: " + (List<Map<String, Object>>)
			// wCache.get("mapaTarjetas"));
			// logger.logInfo("FIN MAPA CACHE");
			//
			// for (Map<String, Object> aux : (List<Map<String, Object>>)
			// wCache.get("mapaTarjetas")) {
			// CardData carDataDTO = new CardData();
			//
			// for (Map.Entry<String, Object> entry : aux.entrySet()) {
			// if (entry.getKey().equalsIgnoreCase("LimiteAprobado")) {
			// carDataDTO.setLimiteAprobado(Double.parseDouble(entry.getValue().toString()));
			// } else if (entry.getKey().equalsIgnoreCase("CodigoCuenta")) {
			// carDataDTO.setCodigoTarjeta(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("FechaActivacion")) {
			// carDataDTO.setFechaCancela(convertStringToCalendar(entry.getValue().toString()));
			// } else if (entry.getKey().equalsIgnoreCase("NombreTarjeta")) {
			// carDataDTO.setDescripcion(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("Estado")) {
			// carDataDTO.setEstado(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("Moneda")) {
			// carDataDTO.setMoneda(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("Oficina")) {
			// carDataDTO.setOficina(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("CodigoLinea")) {
			// carDataDTO.setNumeroTarjeta(123);
			// } else if (entry.getKey().equalsIgnoreCase("TipoTarjeta")) {
			// carDataDTO.setTipoTarjeta(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("Marca")) {
			// carDataDTO.setMarca(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("SaldoDisponible")) {
			// carDataDTO.setSaldoDisponible(Double.parseDouble(entry.getValue().toString()));
			// } else if (entry.getKey().equalsIgnoreCase("FechaExpiracion")) {
			// carDataDTO.setFechaExpira(convertStringToCalendar(entry.getValue().toString()));
			// } else if (entry.getKey().equalsIgnoreCase("Seguro")) {
			// carDataDTO.setSeguro(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("MontoUtilizado")) {
			// carDataDTO.setMontoUtilizado(Double.parseDouble(entry.getValue().toString()));
			// }
			//
			// if (entry.getKey().equalsIgnoreCase("CodigoCuenta")) {
			// carDataDTO.setCodigoTarjeta(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("CodigoLinea")) {
			// carDataDTO.setCodigoLinea(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("TipoTarjeta")) {
			// carDataDTO.setTipoTarjeta(entry.getValue().toString());
			// } else if (entry.getKey().equalsIgnoreCase("Marca")) {
			// carDataDTO.setMarca(entry.getValue().toString());
			// }
			//
			// }
			// lstCardDataDTO.add(carDataDTO);
			// }
			//
			// } else {
			logger.logInfo("Servicio Externo de Trajetas de credito INICIO --> getCreditCardsDebts");

			ComponentLocator locator = ComponentLocator.getInstance(SPJavaOrchestrationBase.class);
			IProvider provider = (IProvider) locator.find(IProvider.class);
			IProcedureRequest procedureRequest = new ProcedureRequestAS();
			procedureRequest.addFieldInHeader("externalProvider", ICOBISTS.HEADER_STRING_TYPE, "1");
			procedureRequest.addFieldInHeader("channel", ICOBISTS.HEADER_STRING_TYPE, "8");
			procedureRequest.addFieldInHeader(ICOBISTS.HEADER_TRN, ICOBISTS.HEADER_STRING_TYPE, "2");
			procedureRequest.addFieldInHeader("com.cobiscorp.cobis.csp.services.ICSPExecutorConnector", ICOBISTS.HEADER_STRING_TYPE,
					"(service.identifier=CreditCardConectorQuery)");
			procedureRequest.addFieldInHeader("csp.skip.transformation", ICOBISTS.HEADER_STRING_TYPE, ICOBISTS.YES);
			procedureRequest.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);

			procedureRequest.addInputParam("@i_operacion", ICTSTypes.SYBVARCHAR, "C");
			procedureRequest.addInputParam("@i_codigo_cliente", ICTSTypes.SYBVARCHAR, customer.toString());
			// procedureRequest.addInputParam("@i_operacion_connector",
			// ICTSTypes.SYBVARCHAR, "consultaTarjetasCre");

			logger.logDebug("Provider------------> " + provider.getLogLevel());

			IProcedureResponse wProcedureResp = provider.executeProvider(procedureRequest);
			wProcedureResp.getReturnCode();
			logger.logInfo("Codigo de ERROR" + wProcedureResp.getReturnCode());
			logger.logInfo("XML RESPUESTA->>>>>>" + wProcedureResp.readValueParam("@o_message"));

			logger.logInfo(wProcedureResp.toString());
			String respuesta = wProcedureResp.readValueParam("@o_message");

			logger.logInfo("Respuesta de consultar Tarjetas: " + respuesta);

			wConverter.read(respuesta);
			logger.logInfo("CODIGO RESPUESTA: " + wConverter.getCodigoRespuesta());
			logger.logInfo("MENSAJE RESPUESTA: " + wConverter.getMensajeRespuesta());

			ResourceBundle wResourceBundle = CobisCatalogRB.getResourceBundle(Locale.getDefault(), "cl_moneda");

			for (Map<String, Object> aux : wConverter.getListaMapas()) {

				CardData carDataDTO = new CardData();

				for (Map.Entry<String, Object> entry : aux.entrySet()) {
					if (entry.getKey().equalsIgnoreCase("LimiteAprobado")) {
						carDataDTO.setLimiteAprobado(Double.parseDouble(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("CodigoCuenta")) {
						carDataDTO.setCodigoTarjeta(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("FechaActivacion")) {
						carDataDTO.setFechaCancela(convertStringToCalendar(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("NombreTarjeta")) {
						carDataDTO.setDescripcion(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Estado")) {
						carDataDTO.setEstado(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Mondeda")) {
						carDataDTO.setMoneda(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Oficina")) {
						carDataDTO.setOficina(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("CodigoLinea")) {
						carDataDTO.setNumeroTarjeta(entry.getKey().toString());
					} else if (entry.getKey().equalsIgnoreCase("CodigoLinea")) {
						carDataDTO.setCodigoLinea(entry.getKey().toString());
					} else if (entry.getKey().equalsIgnoreCase("TipoTarjeta")) {
						carDataDTO.setTipoTarjeta(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("Marca")) {
						carDataDTO.setMarca(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("SaldoDisponible")) {
						carDataDTO.setSaldoDisponible(Double.parseDouble(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("FechaExpiracion")) {
						carDataDTO.setFechaExpira(convertStringToCalendar(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("Seguro")) {
						carDataDTO.setSeguro(entry.getValue().toString());
					} else if (entry.getKey().equalsIgnoreCase("MontoUtilizado")) {
						carDataDTO.setMontoUtilizado(Double.parseDouble(entry.getValue().toString()));
					} else if (entry.getKey().equalsIgnoreCase("CuentaAsociada")) {
						carDataDTO.setCuentaAsociada(entry.getValue().toString());
					}

					Iterator<String> wIt = wResourceBundle.keySet().iterator();
					while (wIt.hasNext()) {
						String key = (String) wIt.next();
						String value = wResourceBundle.getString(key);

						logger.logDebug("DEB CURRENCY DESCRIPTION --> " + key + "-" + value);

						if (key != null && value != null && key.trim().equals(carDataDTO.getMoneda())) {
							carDataDTO.setMonedaDesc(value);
						}
					}
				}
				lstCardDataDTO.add(carDataDTO);
			}

			// Serializable wSerializable = (Serializable)
			// wConverter.getListaMapas();
			// wCache.put("mapaTarjetas", wSerializable);
			// }

			if (lstCardDataDTO != null) {
				logger.logDebug("CardResponse de Crédito size:" + lstCardDataDTO.size());
			}
			return lstCardDataDTO;
		} catch (Exception e) {
			logger.logError(e);
			logger.logError("Ocurrió un error al consultar las Tarjetas de Crédito");
			return new ArrayList<CardData>();
		} finally {
			logger.logDebug("Finaliza Consulta de Tarjetas de Crédito por Cliente");
		}
	}

	public static Calendar convertStringToCalendar(String fechaString) throws ParseException {
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Calendar cal = Calendar.getInstance();
		cal.setTime(df.parse(fechaString));
		return cal;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	public ICacheManager getCacheManager() {
		return cacheManager;
	}

	public void setCacheManager(ICacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

}
