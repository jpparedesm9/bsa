package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.ConsolidatePositionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.DebtTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RequestRejectedTmpDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryDebtsDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public interface SummaryDebtsDAO {

	/* CONSOLIDATED POSITION - sp_vista360 */
	// 1. Deudas Indirectas
	/**
	 * Get a summary of indirect Credits by Id
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryIndirectCredit(SummaryIdDTO key);

	// 2. Deudas Sobregiros
	/**
	 * Get a summary of overdrafts
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummayOverdrafts(SummaryIdDTO key);

	// 3. Deudas Contingentes
	/**
	 * Get a summary of contingencies
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryCEXContingencies(SummaryIdDTO key);

	// 4. Deudas Cartera
	/**
	 * Get a summary of debts
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List <code>ConsolidatePositionDTO</code>
	 */
	public abstract List<ConsolidatePositionDTO> getSummaryDebts(SummaryIdDTO key);

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 4. SOBREGIROS
	/**
	 * Get all overdrafts by Id
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List<code>SummaryDebtsDTO</code>
	 */
	public abstract List<SummaryDebtsDTO> getAllOverdrafts(SummaryIdDTO key);

	// 7. CEX
	/**
	 * Get all contingencies.
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @return List<code>SummaryDebtsDTO</code>
	 */
	public abstract List<SummaryDebtsDTO> getAllContingencies(SummaryIdDTO key);

	// 13. CCA
	/**
	 * Get all debit loans by id
	 * 
	 * @param spid
	 *            <code>Integer</code>
	 * @param debtsType
	 *            <code>String</code>
	 * @return List<code>DebtTmpDTO</code>
	 */
	public abstract List<SummaryDebtsDTO> getAllDebtsLoans(Integer spid, String debtsType, String user, String sesn, Integer customer);

	/**
	 * Get all debit loans by id
	 * 
	 * @param spid
	 *            <code>Integer</code>
	 * @param debtsType
	 *            <code>String</code>
	 * @return List<code>DebtTmpDTO</code>
	 */
	public abstract List<DebtTmpDTO> getIndirects(Integer spid, String debtsType);

	/**
	 * Obtiene las solicitudes rechazadas
	 * 
	 * @param spid
	 * @return Lista de DebtTmpDTO
	 */
	public abstract List<RequestRejectedTmpDTO> getRequestRejected(Integer spid);

	/**
	 * Delete all debit loans by id
	 * 
	 * @param spid
	 *            <code>Integer</code>
	 */
	public abstract void deleteAllDebtsLoans(Integer spid);

	/**
	 * Get pledge amount
	 * 
	 * @param user
	 *            <code>String</code>
	 * @param sesn
	 *            <code>Integer</code>
	 * @param typeGarBack
	 *            <code>String</code>
	 * @param typeGarBack2
	 *            <code>String</code>
	 * @return <code>Double</code>
	 */
	public abstract Double getPledgeAmount(String user, Integer sesn, String typeGarBack, String typeGarBack2);

	/**
	 * Get pledge amount operation
	 * 
	 * @param user
	 *            <code>String</code>
	 * @param sesn
	 *            <code>Integer</code>
	 * @return Double
	 */
	public abstract Double getPledgeAmountOperation(String user, Integer sesn);

	/**
	 * Get the maximum amount of debit
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @param groupId
	 *            <code>Integer</code>
	 * @param processId
	 *            <code>Integer</code>
	 * @return List<code>SummaryDebts</code>
	 */
	public List<SummaryDebtsDTO> getMaxDebtAmounts(SummaryIdDTO key, Integer groupId, Integer processId);

	/**
	 * Get the maximum amount of debit
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @param groupId
	 *            <code>Integer</code>
	 * @param processId
	 *            <code>Integer</code>
	 * @return List<code>SummaryDebts</code>
	 */
	public List<SummaryDebtsDTO> getCustomerRisk(SummaryIdDTO key);

	/**
	 * Get the maximum amount of amount deals (ambiguous word)
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @param groupId
	 *            <code>Integer</code>
	 * @param processId
	 *            <code>Integer</code>
	 * @return List<code>SummaryDebts</code>
	 */
	public List<SummaryDebtsDTO> getTotalAmountDeal(SummaryIdDTO key);

	/**
	 * Get the maximum amount of amount deals (ambiguous word)
	 * 
	 * @param key
	 *            <code>SummaryId</code>
	 * @param groupId
	 *            <code>Integer</code>
	 * @param processId
	 *            <code>Integer</code>
	 * @return List<code>SummaryDebts</code>
	 */
	public List<SummaryDebtsDTO> getTotalDealAditional(SummaryIdDTO key);

	/**
	 * Obtiene las solicitudes en curso de cartera
	 * 
	 * @param spid
	 * @return Lista de DebtTmpDTO
	 */
	public abstract List<DebtTmpDTO> getAllInProgresRequest(Integer spid);

}