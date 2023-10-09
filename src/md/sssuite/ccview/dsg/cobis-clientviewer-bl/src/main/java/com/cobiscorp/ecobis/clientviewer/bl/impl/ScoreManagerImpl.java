package com.cobiscorp.ecobis.clientviewer.bl.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.clientviewer.bl.IScoreManager;
import com.cobiscorp.ecobis.clientviewer.bl.utils.MessageManager;
import com.cobiscorp.ecobis.clientviewer.dal.IScoreDAO;
import com.cobiscorp.ecobis.clientviewer.dal.entities.ClienteCalificacion;
import com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;
import com.cobiscorp.ecobis.commons.dal.CatalogDAO;
import com.cobiscorp.ecobis.commons.dal.entities.Catalog;

public class ScoreManagerImpl implements IScoreManager {
	/**
	 * @author aandy
	 */

	private static ILogger logger = LogFactory.getLogger(ScoreManagerImpl.class);
	IScoreDAO scoreDAO;
	CatalogDAO catalogDAO;

	// ScoreDTO scoreDTO;

	public IScoreDAO getScoreDAO() {
		return scoreDAO;
	}

	public void setScoreDAO(IScoreDAO iScoreDAO) {
		this.scoreDAO = iScoreDAO;
	}

	public CatalogDAO getCatalogDAO() {
		return catalogDAO;
	}

	public void setCatalogDAO(CatalogDAO catalogDAO) {
		this.catalogDAO = catalogDAO;
	}

	@Override
	public ScoreDTO getScoreCustomer(Integer idCustomer) {
		try {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.001", "getScoreCustomer"));

			return scoreDAO.getScoreCustomer(idCustomer);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMERMANAGER.002"), ex);
			throw new BusinessException(7300031, "Ocurrió un error al obtener la calificación del Cliente.");

		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.003", "getScoreCustomer"));
		}
	}
	
	@Override
	public ClienteCalificacionDTO getPunctuationCustomer(Integer idCustomer) {
		try {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.001", "getPunctuationCustomer"));

			return scoreDAO.getPunctuationCustomer(idCustomer);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SCORECUSTOMERMANAGER.002"), ex);
			throw new BusinessException(7300032, "Ocurrió un error al obtener la puntuación del Cliente.");

		} finally {
			logger.logDebug(MessageManager.getString("SCORECUSTOMERMANAGER.003", "getPunctuationCustomer"));
		}
	}

	private String getCatalogValue(List<Catalog> catalog, String code) {

		for (Catalog catalogValue : catalog) {
			if (catalogValue.getCode().equals(code)) {
				return catalogValue.getValue();
			}
		}

		return null;
	}

}
