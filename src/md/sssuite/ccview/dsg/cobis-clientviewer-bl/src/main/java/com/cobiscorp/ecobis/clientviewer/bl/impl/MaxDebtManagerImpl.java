package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.bl.MaxDebtManager;
import com.cobiscorp.ecobis.clientviewer.dal.RateDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryCreditsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryDebtsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryInvestmentsDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryPersonalWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.SummaryWarrantiesDAO;
import com.cobiscorp.ecobis.clientviewer.dal.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.MaxDebtDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.commons.dal.GeneralParameterDAO;
import com.cobiscorp.ecobis.commons.dal.entities.GeneralParameter;
import com.cobiscorp.ecobis.commons.dal.entities.GeneralParameterId;
import com.cobiscorp.ecobis.customer.commons.dal.CustomerDAO;

public class MaxDebtManagerImpl implements MaxDebtManager {

	CustomerDAO customerDAO;
	GeneralParameterDAO generalParameterDAO;
	RateDAO ratesDAO;
	SummaryDebtsDAO summaryDebtsDAO;
	SummaryCreditsDAO summaryCreditsDAO;
	SummaryInvestmentsDAO summaryInvestmentsDAO;
	SummaryPersonalWarrantiesDAO summaryPersonalWarrantiesDAO;
	SummaryWarrantiesDAO summaryWarrantiesDAO;
	CobisStoredProcedureUtils cobisStoredProcedureUtils;

	ConsolidatePositionManagerImpl consolidatePositionManager;

	private static ILogger logger = LogFactory.getLogger(MaxDebtManagerImpl.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.clientviewer.bl.MaxDebtManager#getMaxDebt(java.lang
	 * .Integer, java.lang.Integer)
	 */
	public MaxDebtDTO getMaxDebt(Integer customerCode, Integer groupCode) {
		consolidatePositionManager = new ConsolidatePositionManagerImpl();

		consolidatePositionManager.setSummaryCreditsDAO(summaryCreditsDAO);
		consolidatePositionManager.setSummaryDebtsDAO(summaryDebtsDAO);
		consolidatePositionManager.setSummaryWarrantiesDAO(summaryWarrantiesDAO);
		consolidatePositionManager.setSummaryPersonalWarrantiesDAO(summaryPersonalWarrantiesDAO);
		consolidatePositionManager.setSummaryInvestmentsDAO(summaryInvestmentsDAO);

		GeneralParameter objGenParam;
		GeneralParameterId objGenParamId = new GeneralParameterId();
		Double pat_bank = null;
		String gar_back = null;
		String gar_back2 = null;
		Integer group_ice = null;
		Integer porc_lim_ice = null;
		Float porc_lim = null;
		Double valor_lmax;
		Double valor_lmax_ice;
		Double pledgeAmount;
		Long countCustomerGroupIce;
		Double debtsAmount;

		((ConsolidatePositionManagerImpl) consolidatePositionManager).setSummaryCreditsDAO(summaryCreditsDAO);
		((ConsolidatePositionManagerImpl) consolidatePositionManager).setSummaryDebtsDAO(summaryDebtsDAO);
		((ConsolidatePositionManagerImpl) consolidatePositionManager).setSummaryInvestmentsDAO(summaryInvestmentsDAO);
		((ConsolidatePositionManagerImpl) consolidatePositionManager).setSummaryPersonalWarrantiesDAO(summaryPersonalWarrantiesDAO);
		((ConsolidatePositionManagerImpl) consolidatePositionManager).setSummaryWarrantiesDAO(summaryWarrantiesDAO);

		MaxDebtDTO maxDebtResponse = new MaxDebtDTO();

		try {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.001", "getMaxDebt"));

			CobisContext context = (CobisContext) ContextManager.getContext();
			String sesn = context.getSession().getSessionNumber();
			String user = context.getSession().getUser();

			/* Patrimonio tecnico / capital ajustado de la institucion */
			objGenParamId.setProduct("CRE");
			objGenParamId.setMnemonic("PTI");
			objGenParam = generalParameterDAO.getParameter(objGenParamId);
			if (objGenParam != null) {
				pat_bank = objGenParam.getFieldMoney();
			}

			if (pat_bank == null) {
				logger.logError(MessageManager.getString("CUSTOMERMANAGER.014"));

				throw new BusinessException(7300001, "An error occurred, there is no technical/capital legacy parameter");
			}

			/* Parametro moneda nacional */
			objGenParamId.setProduct("CRE");
			objGenParamId.setMnemonic("MLOCR");
			objGenParam = generalParameterDAO.getParameter(objGenParamId);

			/* Parametro tipo de Garantía para BackToBack */
			objGenParamId.setProduct("GAR");
			objGenParamId.setMnemonic("TGBB");
			objGenParam = generalParameterDAO.getParameter(objGenParamId);

			if (objGenParam != null) {
				gar_back = objGenParam.getFieldChar();
			}

			/* Parametro tipo de Garantía para BackToBack 2 */
			objGenParamId.setProduct("GAR");
			objGenParamId.setMnemonic("TGBB2");
			objGenParam = generalParameterDAO.getParameter(objGenParamId);
			if (objGenParam != null) {
				gar_back2 = objGenParam.getFieldChar();
			}

			/* Valida existencia de cotizaciones */
			if (ratesDAO.countRates() == null) {
				logger.logError(MessageManager.getString("CUSTOMERMANAGER.013"));
				throw new BusinessException(7300001, "An error occurred, there are no rates");
			}

			/* Obtener el código del grupo ICE */
			objGenParamId.setProduct("CLI");
			objGenParamId.setMnemonic("GRPICE");
			objGenParam = generalParameterDAO.getParameter(objGenParamId);
			if (objGenParam != null) {
				group_ice = objGenParam.getFieldInt();
			}

			if (group_ice == null) {
				logger.logError(MessageManager.getString("CUSTOMERMANAGER.015"));
				throw new BusinessException(7300001, "An error occurred, there is no ICE group parameter");
			}

			/* Obtener parametro del límite del grupo ICE */
			objGenParamId.setMnemonic("LIMICE");
			objGenParam = generalParameterDAO.getParameterByMnemonic(objGenParamId);
			if (objGenParam != null) {
				porc_lim_ice = objGenParam.getFieldTinyint();
			}

			if (porc_lim_ice == null) {
				logger.logError(MessageManager.getString("CUSTOMERMANAGER.016"));
				throw new BusinessException(7300001, "An error occurred, there is no ICE group limit parameter");
			}

			/* Obtener parametro del umbral del límite máximo */
			objGenParamId.setMnemonic("LPTMAX");
			objGenParam = generalParameterDAO.getParameterByMnemonic(objGenParamId);
			if (objGenParam != null) {
				porc_lim = objGenParam.getFieldFloat();
			}

			if (porc_lim == null) {
				logger.logError(MessageManager.getString("CUSTOMERMANAGER.017"));
				throw new BusinessException(7300001, "An error occurred, there is no maximum limit parameter");
			}

			valor_lmax = (pat_bank * porc_lim) / 100;
			valor_lmax_ice = (pat_bank * porc_lim_ice) / 100;

			logger.logDebug("valor_lmax:" + valor_lmax);
			logger.logDebug("valor_lmax_ice:" + valor_lmax_ice);

			if (customerCode == null && groupCode == null) {
				logger.logError(MessageManager.getString("CUSTOMERMANAGER.018"));
				throw new BusinessException(7300001, "An error occurred, there isn't a customer or group code");
			}

			/* Valido si viene el parámetro de entrada groupCode */
			if (groupCode == null) {
				/* Valida existencia de cliente deudor */
				if (customerDAO.countCustomer(customerCode) == null) {
					logger.logError(MessageManager.getString("CUSTOMERMANAGER.020"));
					throw new BusinessException(7300001, "An error occurred, there is no Customer");
				}
			} else {
				if (groupCode > 0) {
					if (customerDAO.countEconomicGroup(groupCode) == null) {
						logger.logError(MessageManager.getString("CUSTOMERMANAGER.021"));
						throw new BusinessException(7300001, "An error occurred, there is no Economic Group");
					}
				}
			}
			// logger.logError("*********** SESN ****************" + sesn);

			/* Verificar limites a nivel de deudor individual */
			consolidatePositionManager.setCobisStoredProcedureUtils(cobisStoredProcedureUtils);
			consolidatePositionManager.getQueryConsolidatedPosition(customerCode);

			/*
			 * Se buscar el monto del riesgo del cliente por customerCode o
			 * groupCode
			 */
			SummaryIdDTO key = new SummaryIdDTO();
			logger.logDebug("customerCode:" + customerCode);
			key.setCustomer(customerCode);
			logger.logDebug("sesn:" + sesn);
			key.setSequence(Integer.parseInt(sesn));
			logger.logDebug("user:" + user);
			key.setUser(user);
			logger.logDebug("groupCode" + groupCode);
			List<SummaryDebtsDTO> amountDebts = summaryDebtsDAO.getMaxDebtAmounts(key, groupCode, null);
			Double riskAmount = new Double(0);
			List<String> tipoOperacion = new ArrayList<String>();
			tipoOperacion.add("CCI");
			tipoOperacion.add("CCD");
			tipoOperacion.add("GRA");
			tipoOperacion.add("GRB");
			tipoOperacion.add("STB");
			tipoOperacion.add("AVB");
			tipoOperacion.add("AVE");
			for (SummaryDebtsDTO iterador : amountDebts) {

				logger.logDebug("iterador.getAmountRisk: " + iterador.getAmountRisk());
				if (((iterador.getState() != "CREDITO" && iterador.getState() != "NO VIGENTE") || iterador.getState() == null)) {
					if (iterador.getProduct() == "CCA" && iterador.getDebtsType() != "I") {
						riskAmount = riskAmount + iterador.getAmountRisk();
					}

					if (iterador.getProduct() == "CEX") {
						riskAmount = riskAmount + iterador.getAmountRisk();
					}
				}

				if (iterador.getProduct() == "SOB" && ((iterador.getState() != "CREDITO") || iterador.getState() == null)) {
					riskAmount = riskAmount + iterador.getAmountRisk();
				}

				if (((tipoOperacion.contains(iterador.getOperationType()) && iterador.getProduct() == "SOB") || iterador.getProduct() == "CCA")
						&& (iterador.getState() != "CREDITO" && iterador.getState() != "NO VIGENTE")) {
					riskAmount = riskAmount + iterador.getAmountRisk();
				}
				if (iterador.getDebtsType() == "I" && iterador.getProduct() == "CCA"
						&& ((iterador.getState() != "CREDITO" && iterador.getState() != "NO VIGENTE") || iterador.getState() == null)) {
					riskAmount = riskAmount + iterador.getAmountRisk();
				}

			}

			logger.logDebug("riskAmount" + riskAmount);

			List<SummaryCreditsDTO> amountCredits = summaryCreditsDAO.getMaxDebtAmounts(key, null);

			for (SummaryCreditsDTO iterador : amountCredits) {
				logger.logDebug("iterador.getRiskAmount: " + iterador.getRiskAmount());
				if ((iterador.getCustomer() == customerCode || (customerCode != null && groupCode != null)) && iterador.getConType() == "C"
						&& iterador.getConType() == "V") {
					riskAmount = riskAmount + iterador.getRiskAmount();
				}

				if (iterador.getCustomer() != null && groupCode != null && iterador.getConType() == "G") {
					riskAmount = riskAmount + iterador.getRiskAmount();
				}
			}

			logger.logDebug("riskAmount" + riskAmount);

			logger.logError("*********** RISK AMOUNT ****************" + riskAmount);

			pledgeAmount = summaryDebtsDAO.getPledgeAmount(user, Integer.parseInt(sesn), gar_back, gar_back2);
			logger.logDebug("pledgeAmount:" + pledgeAmount);

			if (pledgeAmount == null) {
				pledgeAmount = (double) 0;
			}

			if (pledgeAmount - riskAmount > valor_lmax) {
				maxDebtResponse.setExceedsLimit("S");
			} else {
				maxDebtResponse.setExceedsLimit("N");
			}

			maxDebtResponse.setLimitDebt(valor_lmax);

			/* Verificar limites a nivel de grupo economico */
			/*
			 * Si individualmente no excede del 20% del capital ajustado
			 * verifica por grupo economico para cada grupo al que pertenece
			 */
			if (maxDebtResponse.getExceedsLimit() == "N") {

				List<Integer> lstCodeGroup = customerDAO.getCodeGroupMembersByCustomer(customerCode);

				for (Integer codeGroup : lstCodeGroup) {

					/* Verificar limites a nivel de deudor individual */
					consolidatePositionManager.getQueryConsolidatedPosition(customerCode);

					pledgeAmount = summaryDebtsDAO.getPledgeAmount(user, Integer.parseInt(sesn), gar_back, gar_back2);

					if (pledgeAmount == null) {
						pledgeAmount = (double) 0;
					}

					if (pledgeAmount - riskAmount > valor_lmax) {
						maxDebtResponse.setExceedsLimit("S");
					} else {
						maxDebtResponse.setExceedsLimit("N");
					}

					if (maxDebtResponse.getExceedsLimit() == "S") {
						break;
					}
				}
			}

			/* Verificar limites a nivel del grupo vinculado */
			/*
			 * Si individualmente, o por grupo economico no excede del limite,
			 * verifica si esta en el grupo ICE
			 */
			countCustomerGroupIce = customerDAO.countCustomerGroup(customerCode, groupCode);

			if (maxDebtResponse.getExceedsLimit() == "N" && countCustomerGroupIce > 0) {

				pledgeAmount = summaryDebtsDAO.getPledgeAmountOperation(user, Integer.parseInt(sesn));

				if (pledgeAmount == null) {
					pledgeAmount = (double) 0;
				}

				if (pledgeAmount - riskAmount > valor_lmax_ice) {
					maxDebtResponse.setExceedsLimit("S");
				} else {
					maxDebtResponse.setExceedsLimit("N");
				}

				maxDebtResponse.setLimitDebt(valor_lmax_ice);
			}

			maxDebtResponse.setOkProcess("S");
			maxDebtResponse.setErrorCode(0);
			maxDebtResponse.setErrorDescription("");

			debtsAmount = pledgeAmount - riskAmount;

			// llamada a getQueryConsolidatedPosition para realizar la suma de
			// debts y contingents

			List<ConsolidatePositionDTO> consolidatePosition = consolidatePositionManager.getQueryConsolidatedPosition(customerCode);

			debtsAmount = 0.0;

			for (ConsolidatePositionDTO consolidatePositionDTO : consolidatePosition) {

				logger.logDebug("RIESGO --> " + consolidatePositionDTO.getProduct() + "--" + consolidatePositionDTO.getName() + "--"
						+ consolidatePositionDTO.getAmount());

				if (consolidatePositionDTO.getProduct().equalsIgnoreCase("Riesgo")) {
					if (consolidatePositionDTO.getName().equalsIgnoreCase("Contingent")) {
						debtsAmount = debtsAmount + consolidatePositionDTO.getAmount();
					} else if (consolidatePositionDTO.getName().equalsIgnoreCase("DirectRisk")) {
						debtsAmount = debtsAmount + consolidatePositionDTO.getAmount();
					}
				}
			}

			maxDebtResponse.setDebtAmount(debtsAmount);
			maxDebtResponse.setLimit(porc_lim);

			return maxDebtResponse;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("CUSTOMERMANAGER.012"), ex);
			throw new BusinessException(7300033, "An error occurred at getting maximun debt");
		} finally {
			logger.logDebug(MessageManager.getString("CUSTOMERMANAGER.002", "getMaxDebt"));
		}

	}

	public void setCustomerDAO(CustomerDAO customerDAO) {
		this.customerDAO = customerDAO;
	}

	public void setGeneralParameterDAO(GeneralParameterDAO generalParameterDAO) {
		this.generalParameterDAO = generalParameterDAO;
	}

	public void setRatesDAO(RateDAO ratesDAO) {
		this.ratesDAO = ratesDAO;
	}

	public void setSummaryDebtsDAO(SummaryDebtsDAO summaryDebtsDAO) {
		this.summaryDebtsDAO = summaryDebtsDAO;
	}

	public void setSummaryCreditsDAO(SummaryCreditsDAO summaryCreditsDAO) {
		this.summaryCreditsDAO = summaryCreditsDAO;
	}

	public void setSummaryInvestmentsDAO(SummaryInvestmentsDAO summaryInvestmentsDAO) {
		this.summaryInvestmentsDAO = summaryInvestmentsDAO;
	}

	public void setSummaryPersonalWarrantiesDAO(SummaryPersonalWarrantiesDAO summaryPersonalWarrantiesDAO) {
		this.summaryPersonalWarrantiesDAO = summaryPersonalWarrantiesDAO;
	}

	public void setSummaryWarrantiesDAO(SummaryWarrantiesDAO summaryWarrantiesDAO) {
		this.summaryWarrantiesDAO = summaryWarrantiesDAO;
	}

	public void setConsolidatePositionManager(ConsolidatePositionManagerImpl consolidatePositionManager) {
		this.consolidatePositionManager = consolidatePositionManager;
	}

	public CobisStoredProcedureUtils getCobisStoredProcedureUtils() {
		return cobisStoredProcedureUtils;
	}

	public void setCobisStoredProcedureUtils(CobisStoredProcedureUtils cobisStoredProcedureUtils) {
		this.cobisStoredProcedureUtils = cobisStoredProcedureUtils;
	}

}
