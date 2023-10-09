package com.cobiscorp.ecobis.clientviewer;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;

public interface ConsolidatePositionService {
	/**
	 * Get information of consolidate position by customer id
	 * @param customer
	 * @return list <code>ConsolidatePositionDTO</code>
	 */
	List<ConsolidatePositionDTO> queryConsolidatedPosition(Integer customer);
}
