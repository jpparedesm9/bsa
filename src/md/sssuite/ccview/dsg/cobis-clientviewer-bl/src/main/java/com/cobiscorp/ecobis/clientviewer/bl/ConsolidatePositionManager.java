package com.cobiscorp.ecobis.clientviewer.bl;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;

public interface ConsolidatePositionManager {
/**
 * Get query consolidated position by customer
 * @param customer <code>Integer</code>
 * @return List <code>ConsolidatePositionDTO</code>
 */
	public List<ConsolidatePositionDTO> getQueryConsolidatedPosition(Integer customer);

}
