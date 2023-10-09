package com.cobiscorp.ecobis.clientviewer.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.ConsolidatePositionService;
import com.cobiscorp.ecobis.clientviewer.bl.ConsolidatePositionManager;
import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;

public class ConsolidatePositionServiceImpl implements ConsolidatePositionService {
	private static ILogger logger = LogFactory.getLogger(ConsolidatePositionServiceImpl.class);

	private ConsolidatePositionManager consolidatePositionManager;

	public ConsolidatePositionManager getConsolidatePositionManager() {
		return consolidatePositionManager;
	}

	public void setConsolidatePositionManager(ConsolidatePositionManager consolidatePositionManager) {
		this.consolidatePositionManager = consolidatePositionManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.clientviewer.ConsolidatePositionService#
	 * queryConsolidatedPosition(java.lang.Integer)
	 */
	public List<ConsolidatePositionDTO> queryConsolidatedPosition(Integer customer) {
		try {
			logger.logDebug("Execute queryConsolidatedPosition");
			return consolidatePositionManager.getQueryConsolidatedPosition(customer);
		} finally {
			logger.logDebug("Finaliza queryConsolidatedPosition");
		}

	}
}
