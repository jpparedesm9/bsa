package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.bl.IRateManager;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.RateDAO;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiDTO;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO;
import com.cobiscorp.ecobis.clientviewer.dto.EnteDTO;
import com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RateDTO;

public class RateManagerImpl implements IRateManager {

	private static ILogger logger = LogFactory.getLogger(RateManagerImpl.class);
	private RateDAO rateDAO;

	@Override
	public List<RateDTO> getRateByClientId(Integer customer) {
		try {
			logger.logDebug("inicia getRateByClientId");

			return rateDAO.getRateByClientId(customer);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMERMANAGER.002"), ex);
			throw new BusinessException(7300027, "Ocurrió un error al obtener la calificación del Cliente");

		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.003", "getRateByClientId"));
		}
	}

	@Override
	public List<AsfiViewDTO> getAsfiByClientId(Integer customer) {
		try {
			logger.logDebug("inicia getAsfiByClientId");

			return rateDAO.getAsfiByClientId(customer);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMERMANAGER.004"), ex);
			throw new BusinessException(7300028, "Ocurrio un error al obtener la información de ASFI del Cliente");

		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.005", "getAsfiByClientId"));
		}
	}

	@Override
	public List<InfoCredDTO> getInfoCredByClientId(Integer customer) {
		try {
			logger.logDebug("inicia getInfoCredByClientId");

			return rateDAO.getInfoCredByClientId(customer);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMERMANAGER.006"), ex);
			throw new BusinessException(7300029, "Ocurrió un error al obtener la información de INFOCRED del Cliente");

		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.007", "getInfoCredByClientId"));
		}
	}

	@Override
	public List<EnteDTO> getPortfolioRateByClientId(Integer customer) {
		try {
			logger.logDebug("inicia getPortfolioRateByClientId");

			return rateDAO.getPortfolioRateByClientId(customer);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMERMANAGER.006"), ex);
			throw new BusinessException(7300030, "Ocurrió un error al obtener la calificación de cartera del Cliente");

		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.007", "getPortfolioRateByClientId"));
		}
	}

	public RateDAO getRateDAO() {
		return rateDAO;
	}

	public void setRateDAO(RateDAO rateDAO) {
		this.rateDAO = rateDAO;
	}

}
