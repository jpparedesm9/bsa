package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.AffiliateDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;

public interface AffiliationsDAO {

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 12. GlobalNet
	public abstract List<AffiliateDTO> getAllAffiliations(SummaryIdDTO key);

}