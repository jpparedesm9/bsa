package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryCreditsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public interface SummaryCreditsDAO {

	/* CONSOLIDATED POSITION - sp_vista360 */		
	// 9. Contingentes
	/**
	 * Get a summary contingencies by id.
	 * @param key <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryContingencies(SummaryIdDTO key);
	
	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 6. Lineas de Credito
	/**
	 * Get all credit lines
	 * @param key <code>SummaryId</code>
	 * @return List <code>SummaryCredits</code>
	 */
	public abstract List<SummaryCreditsDTO> getAllCreditLines(SummaryIdDTO key);	
	/**
	 * Get the maximum amount of debit.
	 * @param key <code>SummaryId<code>
	 * @param processId <code>Integer</code>
	 * @return List <code>SummaryCredits</code>
	 */
	public List<SummaryCreditsDTO> getMaxDebtAmounts(SummaryIdDTO key, Integer processId);
	
	public List<SummaryCreditsDTO> getCustomerRiskCredits(SummaryIdDTO key);
	
}