package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryInvestmentsDTO;

public interface SummaryInvestmentsDAO {

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 5. Pasivas - PFI
	/**
	 * Get a summary of fixed terms
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryFixedTerms(
			SummaryIdDTO key);

	// 6. Pasivas - Cuentas (Ahorros-Corrientes)
	/**
	 * Get a sumary of accounts
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryAccounts(
			SummaryIdDTO key);

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 1. Pasivas - Cuentas Corrientes
	/**
	 * Get all currents accounts
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List<code>SummaryInvestments/code>
	 */
	public abstract List<SummaryInvestmentsDTO> getAllCurrentsAccount(
			SummaryIdDTO key);

	// 2. Pasivas - Cuentas de Ahorro
	public abstract List<SummaryInvestmentsDTO> getAllSavingsAccount(
			SummaryIdDTO key);

	// 3. Pasivas - Plazo Fijo
	/**
	 * Get all fixed terms
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>SummaryInvestments></code>
	 */
	public abstract List<SummaryInvestmentsDTO> getAllFixedTerms(
			SummaryIdDTO key);
}