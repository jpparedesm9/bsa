package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.card.dto.CardData;

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
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.bl.ConsolidatePositionManager;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryPersonalWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.Utils;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.external.services.extractor.ExternalExtractor;
import com.cobiscorp.ecobis.external.services.utils.ConvertTCREMessageUtil;


public class ConsolidatePositionManagerImpl implements ConsolidatePositionManager {
	private static ILogger logger = LogFactory.getLogger(ConsolidatePositionManagerImpl.class);
	private ICacheManager cacheManager;
	private SummaryDebtsDAO summaryDebtsDAO;
	private SummaryWarrantiesDAO summaryWarrantiesDAO;
	private SummaryPersonalWarrantiesDAO summaryPersonalWarrantiesDAO;
	private SummaryInvestmentsDAO summaryInvestmentsDAO;
	private SummaryCreditsDAO summaryCreditsDAO;
	private CobisStoredProcedureUtils cobisStoredProcedureUtils;

	public static final String DATABASE_NAME = "SYBCTS";

	private class MutableDouble {
		private double value = 0;

		public MutableDouble(double value) {
			this.value = value;
		}

		public double getValue() {
			return this.value;
		}

		public void setValue(double value) {
			this.value = value;
		}

	}

	@SuppressWarnings("unchecked")
	public List<ConsolidatePositionDTO> getQueryConsolidatedPosition(Integer customer) {
		try {
			logger.logDebug(MessageManager.getString("CONSOLIDATEPOSITIONMANAGER.001", "getQueryConsolidatedPosition"));

			SummaryIdDTO key = new SummaryIdDTO();

			CobisContext context = (CobisContext) ContextManager.getContext();
			String sesn = context.getSession().getSessionNumber();
			String user = context.getSession().getUser();

			List<ConsolidatePositionDTO> consolidatePosition = new ArrayList<ConsolidatePositionDTO>();

			key.setSequence(Integer.parseInt(sesn));
			key.setUser(user);
			key.setCustomer(customer);

			if (logger.isDebugEnabled()) {
				logger.logDebug("--> KEY --> " + key.toString());
			}

			// Servicio externo para pintar grafico
			// ICache wCache =
			// cacheManager.getCache(CACHE_WEB_SERVICES_CREDIT_CARD);
			//
			// if(wCache.get("mapaTarjetas")!=null){
			// logger.logInfo("INICIO MAPA CACHE");
			// logger.logInfo( "MAPA CACHE: " + (List<Map<String,
			// Object>>)wCache.get("mapaTarjetas"));
			// logger.logInfo("FIN MAPA CACHE");
			// //List<SummaryDebtsDTO> debtsCreditCard = new
			// ArrayList<SummaryDebtsDTO>();
			// // for(Map<String, Object>
			// aux:(List<Map<String,Object>>)wCache.get("mapaTarjetas")){
			// // //SummaryDebtsDTO creditCard = new SummaryDebtsDTO();
			// // for(Map.Entry<String, Object> entry: aux.entrySet()){
			// // if(entry.getKey().equalsIgnoreCase("SaldoDisponible")){
			// // logger.logInfo("SaldoDisponible : " + entry.getValue());
			// // sumTotalCreditCardContingent +=
			// Double.parseDouble(entry.getValue().toString());
			// // }
			// // }
			// // }
			// }
			/*
			 * ConvertTCREMessageUtil wConverter = new ConvertTCREMessageUtil();
			 * logger.logInfo(
			 * "Servicio Externo de Trajetas de credito INICIO POSICION CONSOLIDADA"
			 * ); ComponentLocator locator = ComponentLocator
			 * .getInstance(SPJavaOrchestrationBase.class); IProvider provider =
			 * (IProvider) locator.find(IProvider.class); IProcedureRequest
			 * procedureRequest = new ProcedureRequestAS();
			 * procedureRequest.addFieldInHeader("externalProvider",
			 * ICOBISTS.HEADER_STRING_TYPE, "1");
			 * procedureRequest.addFieldInHeader("channel",
			 * ICOBISTS.HEADER_STRING_TYPE, "8");
			 * procedureRequest.addFieldInHeader(ICOBISTS.HEADER_TRN,
			 * ICOBISTS.HEADER_STRING_TYPE, "2");
			 * procedureRequest.addFieldInHeader
			 * ("com.cobiscorp.cobis.csp.services.ICSPExecutorConnector",
			 * ICOBISTS.HEADER_STRING_TYPE,
			 * "(service.identifier=CreditCardConectorQuery)");
			 * procedureRequest.addFieldInHeader("csp.skip.transformation",
			 * ICOBISTS.HEADER_STRING_TYPE, ICOBISTS.YES);
			 * procedureRequest.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT,
			 * ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
			 * 
			 * procedureRequest.addInputParam("@i_operacion",
			 * ICTSTypes.SYBVARCHAR, "C");
			 * procedureRequest.addInputParam("@i_codigo_cliente",
			 * ICTSTypes.SYBVARCHAR, customer.toString());
			 * 
			 * IProcedureResponse wProcedureResp = provider
			 * .executeProvider(procedureRequest);
			 * wProcedureResp.getReturnCode(); logger.logInfo("Codigo de ERROR"
			 * + wProcedureResp.getReturnCode());
			 * logger.logInfo("XML RESPUESTA->>>>>>" +
			 * wProcedureResp.readValueParam("@o_message"));
			 * 
			 * String respuesta = wProcedureResp.readValueParam("@o_message");
			 * logger.logInfo("Respuesta de consultar Tarjetas: " + respuesta);
			 * 
			 * wConverter.read(respuesta); logger.logInfo("CODIGO RESPUESTA: " +
			 * wConverter.getCodigoRespuesta());
			 * logger.logInfo("MENSAJE RESPUESTA: " +
			 * wConverter.getMensajeRespuesta());
			 * 
			 * for(Map<String, Object> aux: wConverter.getListaMapas()){
			 * 
			 * for (Map.Entry<String, Object> entry : aux.entrySet()) {
			 * if(entry.getKey().equalsIgnoreCase("SaldoDisponible")){
			 * logger.logInfo("Saldo Disponible Posicion Consolidada: " +
			 * entry.getValue()); //sumTotalCreditCardContingent +=
			 * Double.parseDouble(entry.getValue().toString()); }else
			 * if(entry.getKey().equalsIgnoreCase("MontoUtilizado")){
			 * logger.logInfo("Monto Utilizado Posicion Consolidada: " +
			 * entry.getValue()); //sumaTotalCreditCardDebt +=
			 * Double.parseDouble(entry.getValue().toString()); } }
			 * 
			 * 
			 * 
			 * }
			 */

			consolidatePosition.addAll(summaryDebtsDAO.getSummaryIndirectCredit(key)); // 1
			consolidatePosition.addAll(summaryDebtsDAO.getSummayOverdrafts(key)); // 2
			consolidatePosition.addAll(summaryDebtsDAO.getSummaryCEXContingencies(key)); // 3
			consolidatePosition.addAll(summaryDebtsDAO.getSummaryDebts(key)); // 4
			consolidatePosition.addAll(summaryInvestmentsDAO.getSummaryFixedTerms(key)); // 5
			consolidatePosition.addAll(summaryInvestmentsDAO.getSummaryAccounts(key)); // 6
			consolidatePosition.addAll(summaryWarrantiesDAO.getSummaryWarranties(key)); // 7
			consolidatePosition.addAll(summaryPersonalWarrantiesDAO.getSummaryPersonalWarranties(key)); // 8
			consolidatePosition.addAll(summaryCreditsDAO.getSummaryContingencies(key)); // 9

			// inicializar a cero sumatoria de tarjetas antes de consultar
			MutableDouble summaryDebtsCard = new MutableDouble(0);
			MutableDouble summaryContingentsCards = new MutableDouble(0);

			consolidatePosition.addAll(getSummaryDebtsCards(customer, summaryDebtsCard)); // 1
			consolidatePosition.addAll(getSummaryContingentsCards(customer, summaryContingentsCards)); // 1
			
			// 1. Customer Risk
			List<SummaryCreditsDTO> customerRiskCredits = summaryCreditsDAO.getCustomerRiskCredits(key);
			double sumCredts = 0;
			for (SummaryCreditsDTO summaryCreditsDTO : customerRiskCredits) {
				if ("C".equals(summaryCreditsDTO.getConType().trim()) || "V".equals(summaryCreditsDTO.getConType().trim())) {
					sumCredts = sumCredts + summaryCreditsDTO.getRiskAmount();
				}
			}

			logger.logDebug(MessageManager.getString("CONSOLIDATEPOSITIONMANAGER.004", "Riesgo"));

			// Method for search item
			CobisStoredProcedure storedProcedure = this.cobisStoredProcedureUtils.getStoredProcedureInstance(DATABASE_NAME);
			storedProcedure.setDatabase("cob_credito");
			storedProcedure.setName("sp_situacion_consulta");
			storedProcedure.setSkipUndeclaredResults(true);

			this.cobisStoredProcedureUtils.setContextParameters(DATABASE_NAME, storedProcedure);

			storedProcedure.addInParam("@s_user", Types.VARCHAR, user);
			storedProcedure.addInParam("@s_ssn", Types.INTEGER, sesn);
			storedProcedure.addInParam("@s_sesn", Types.INTEGER, sesn);
			storedProcedure.addInParam("@i_cliente", Types.INTEGER, customer);
			storedProcedure.addInParam("@i_operacion", Types.CHAR, "C");
			storedProcedure.addInParam("@i_retorna", Types.CHAR, "S");
			storedProcedure.addInParam("@i_usuario", Types.VARCHAR, user);
			storedProcedure.addInParam("@i_secuencia", Types.INTEGER, sesn);
			storedProcedure.addInParam("@i_vista_360", Types.CHAR, "S");

			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("IDS", new CobisRowMapper<Map<String, BigDecimal>>() {
				public Map<String, BigDecimal> mapRow(ResultSet rs, int rowNum) throws SQLException {
					Map<String, BigDecimal> ids = new HashMap<String, BigDecimal>();
					ids.put("MontoTotal", rs.getBigDecimal(1));
					ids.put("DeudaDirecta", rs.getBigDecimal(2));
					ids.put("DeudaIndirecta", rs.getBigDecimal(3));
					ids.put("DeudaContingente", rs.getBigDecimal(4));
					return ids;
				}
			});

			Map<String, Object> resultMap = storedProcedure.execute();

			List<BigDecimal> listIds = new ArrayList<BigDecimal>();
			listIds.add(((Map<String, BigDecimal>) ((List<Map<String, BigDecimal>>) resultMap.get("IDS")).get(0)).get("MontoTotal"));
			listIds.add(((Map<String, BigDecimal>) ((List<Map<String, BigDecimal>>) resultMap.get("IDS")).get(0)).get("DeudaDirecta"));

			listIds.add(((Map<String, BigDecimal>) ((List<Map<String, BigDecimal>>) resultMap.get("IDS")).get(0)).get("DeudaIndirecta"));
			listIds.add(((Map<String, BigDecimal>) ((List<Map<String, BigDecimal>>) resultMap.get("IDS")).get(0)).get("DeudaContingente"));

			double contigentTotal = 0;
			double directRiskTotal = 0;
			double indirectRiskTotal = 0;
			double totalRisk = 0;

			// 2. Contingente
			ConsolidatePositionDTO contingent = new ConsolidatePositionDTO();
			contigentTotal += listIds.get(3).doubleValue() + summaryContingentsCards.getValue();
			contingent.setAmount(contigentTotal);
			contingent.setName("Contingent");
			contingent.setProduct("Riesgo");
			consolidatePosition.add(contingent); // 10

			// 3. Indirecto
			ConsolidatePositionDTO indirect = new ConsolidatePositionDTO();
			indirectRiskTotal += listIds.get(2).doubleValue();
			indirect.setAmount(indirectRiskTotal);
			indirect.setName("IndirectRisk");
			indirect.setProduct("Riesgo");
			consolidatePosition.add(indirect); // 11

			// 4. Directo
			ConsolidatePositionDTO direct = new ConsolidatePositionDTO();
			directRiskTotal += listIds.get(1).doubleValue() + summaryDebtsCard.getValue();
			direct.setAmount(directRiskTotal);
			direct.setName("DirectRisk");
			direct.setProduct("Riesgo");
			consolidatePosition.add(direct); // 12

			// 5. tramite total amount
			List<SummaryDebtsDTO> totalAmountDeal = summaryDebtsDAO.getTotalAmountDeal(key);
			double totalAmountRisk = 0;
			for (SummaryDebtsDTO summaryDebtsDTO : totalAmountDeal) {
				totalAmountRisk = totalAmountRisk + summaryDebtsDTO.getAmountRisk();
			}

			// 6. DirectRisk Aditional
			List<SummaryDebtsDTO> indirectCustomerRiskAditional = summaryDebtsDAO.getTotalDealAditional(key);
			double sumRiskaditional = 0;
			for (SummaryDebtsDTO summaryDebtsDTO : indirectCustomerRiskAditional) {
				sumRiskaditional = sumRiskaditional + summaryDebtsDTO.getAmountRisk();
			}

			// Suma 1 con 2 con 3 con 6 TotalRisk
			ConsolidatePositionDTO risk = new ConsolidatePositionDTO();
			totalRisk = listIds.get(0).doubleValue() + summaryDebtsCard.getValue() + summaryContingentsCards.getValue();
			risk.setAmount(totalRisk);
			risk.setName("TotalRisk");
			risk.setProduct("Riesgo");
			consolidatePosition.add(risk); // 13

			return consolidatePosition;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CONSOLIDATEPOSITIONMANAGER.003"), ex);
			throw new BusinessException(7300017, "An error occurred at obtaining the Consolidated Position information");
		} finally {
			logger.logDebug(MessageManager.getString("CONSOLIDATEPOSITIONMANAGER.002", "getQueryConsolidatedPosition"));
		}
	}

	public List<ConsolidatePositionDTO> getSummaryDebtsCards(Integer customer, MutableDouble summaryDebtsCards) {
		List<ConsolidatePositionDTO> creditCardDebtsList = new ArrayList<ConsolidatePositionDTO>();
		logger.logInfo("Entra al metodo getSummaryDebtsTarj");
		try {

			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getSummaryDebtsTarj"));
			ExternalExtractor obj = new ExternalExtractor();
			@SuppressWarnings("unchecked")
			List<SummaryDebtsDTO> creditCardDebts = (List<SummaryDebtsDTO>) obj.getObject("(extservice.type=creditCardDataDeudas)", customer);
			for (SummaryDebtsDTO aux : creditCardDebts) {
				logger.logInfo("aux.getTypeCon(): " + aux.getTypeCon());
				logger.logInfo("aux.getProduct(): " + aux.getProduct());
				logger.logInfo("aux.getDescriptionType(): " + aux.getDescriptionType());
				logger.logInfo("aux.getAmounLocalMoney(): " + aux.getAmounLocalMoney());
				logger.logInfo("aux.getNumberOperation(): " + aux.getNumberOperation());
				logger.logInfo("aux.getState(): " + aux.getState());
				logger.logInfo("aux.getAvailable: " + aux.getAvailable());

				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO("DEUDAS", validateData(aux.getProduct()),
						validateData(aux.getDescriptionType()), validateDataDouble(aux.getAmounLocalMoney()), validateData(aux.getNumberOperation()),
						validateData(aux.getState()), validateDataDouble(aux.getAvailable()), validateData(aux.getTradeMark()));
				creditCardDebtsList.add(consolidatePositionDTO);

				// suma de deudas de tarjeta
				summaryDebtsCards.setValue(summaryDebtsCards.getValue() + consolidatePositionDTO.getAmount());
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.006"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getSummaryDebts"));
		}
		return creditCardDebtsList;
	}

	public List<ConsolidatePositionDTO> getSummaryContingentsCards(Integer customer, MutableDouble summaryContingentsCards) {
		List<ConsolidatePositionDTO> creditCardDebtsList = new ArrayList<ConsolidatePositionDTO>();
		logger.logInfo("Entra al metodo getSummaryDebtsTarj");
		try {

			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.001", "getSummaryContingentsTarj"));
			ExternalExtractor obj = new ExternalExtractor();
			@SuppressWarnings("unchecked")
			List<SummaryDebtsDTO> creditCardsContingents = (List<SummaryDebtsDTO>) obj.getObject("(extservice.type=creditCardData)", customer);
			for (SummaryDebtsDTO aux : creditCardsContingents) {
				logger.logInfo("aux.getTypeCon(): " + aux.getTypeCon());
				logger.logInfo("aux.getProduct(): " + aux.getProduct());
				logger.logInfo("aux.getDescriptionType(): " + aux.getDescriptionType());
				logger.logInfo("aux.getAmounLocalMoney(): " + aux.getAmounLocalMoney());
				logger.logInfo("aux.getNumberOperation(): " + aux.getNumberOperation());
				logger.logInfo("aux.getState(): " + aux.getState());
				logger.logInfo("aux.getAvailable: " + aux.getAvailable());
				ConsolidatePositionDTO consolidatePositionDTO = new ConsolidatePositionDTO("CONTINGENTES", validateData(aux.getProduct()),
						validateData(aux.getDescriptionType()), validateDataDouble(aux.getAvailable()), validateData(aux.getNumberOperation()),
						validateData(aux.getState()), validateDataDouble(aux.getAvailable()), validateData(aux.getTradeMark()));
				creditCardDebtsList.add(consolidatePositionDTO);

				// suma de contingentes de tarjeta
				summaryContingentsCards.setValue(summaryContingentsCards.getValue() + consolidatePositionDTO.getAmount());
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SUMMARYDEBTSDAO.006"), ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator");
		} finally {
			logger.logDebug(MessageManager.getString("SUMMARYDEBTSDAO.002", "getSummaryDebts"));
		}
		return creditCardDebtsList;
	}

	private String validateData(Object obj) {
		return obj == null ? "" : obj.toString();

	}

	private Double validateDataDouble(Object obj) {
		return (Double) (obj == null ? null : obj);
	}

	public SummaryDebtsDAO getSummaryDebtsDAO() {
		return summaryDebtsDAO;
	}

	public void setSummaryDebtsDAO(SummaryDebtsDAO summaryDebtsDAO) {
		this.summaryDebtsDAO = summaryDebtsDAO;
	}

	public SummaryWarrantiesDAO getSummaryWarrantiesDAO() {
		return summaryWarrantiesDAO;
	}

	public void setSummaryWarrantiesDAO(SummaryWarrantiesDAO summaryWarrantiesDAO) {
		this.summaryWarrantiesDAO = summaryWarrantiesDAO;
	}

	public SummaryPersonalWarrantiesDAO getSummaryPersonalWarrantiesDAO() {
		return summaryPersonalWarrantiesDAO;
	}

	public void setSummaryPersonalWarrantiesDAO(SummaryPersonalWarrantiesDAO summaryPersonalWarrantiesDAO) {
		this.summaryPersonalWarrantiesDAO = summaryPersonalWarrantiesDAO;
	}

	public SummaryInvestmentsDAO getSummaryInvestmentsDAO() {
		return summaryInvestmentsDAO;
	}

	public void setSummaryInvestmentsDAO(SummaryInvestmentsDAO summaryInvestmentsDAO) {
		this.summaryInvestmentsDAO = summaryInvestmentsDAO;
	}

	public SummaryCreditsDAO getSummaryCreditsDAO() {
		return summaryCreditsDAO;
	}

	public void setSummaryCreditsDAO(SummaryCreditsDAO summaryCreditsDAO) {
		this.summaryCreditsDAO = summaryCreditsDAO;
	}

	public CobisStoredProcedureUtils getCobisStoredProcedureUtils() {
		return cobisStoredProcedureUtils;
	}

	public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
	}

	public ICacheManager getCacheManager() {
		return cacheManager;
	}

	public void setCacheManager(ICacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

}
