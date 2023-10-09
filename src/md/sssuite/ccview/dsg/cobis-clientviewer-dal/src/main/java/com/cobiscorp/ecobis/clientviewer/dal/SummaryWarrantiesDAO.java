package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.OwnWarrantyTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.WarrantyTmpDTO;

public interface SummaryWarrantiesDAO {

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 7. Garantias
	/**
	 * Get a summary warranties
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List<code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryWarranties(SummaryIdDTO key);

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 5. GARANTIAS
	/**
	 * Get all warranties
	 * 
	 * @param spid
	 *            <code>Integer</code>
	 * @return List<code>WarrantyTmp</code>
	 */
	public abstract List<WarrantyTmpDTO> getAllWarranties(Integer spid);

	/**
	 * Delete all warranties
	 * 
	 * @param spid
	 *            <code>Integer</code>
	 */
	public abstract void deleteAllWarranties(Integer spid);

	// 11. PAGARES
	/**
	 * Get all promissory notes
	 * 
	 * @param spid
	 *            <code>Integer</code>
	 * @return List<code>OwnWarrantyTmp</code>
	 */
	public abstract List<OwnWarrantyTmpDTO> getAllPromissoryNotes(Integer spid);

	/**
	 * Delete all promissory notes
	 * 
	 * @param spid
	 *            List<OwnWarrantyTmp>
	 */
	public abstract void deleteAllPromissoryNotes(Integer spid);
}