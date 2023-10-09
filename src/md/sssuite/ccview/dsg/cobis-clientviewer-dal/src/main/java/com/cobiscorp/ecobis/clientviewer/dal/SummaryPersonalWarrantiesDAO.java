package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public interface SummaryPersonalWarrantiesDAO {

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 8. Personal Guarantees
	/**
	 * Get a summary personal warranties
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryPersonalWarranties(
			SummaryIdDTO key);

}