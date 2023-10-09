package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.SummaryIdDTO;
import com.cobiscorp.ecobis.clientviewer.dto.SummaryOtherDTO;

public interface SummaryOthersDAO {

	/* QUERY PRODUCTS BY CLIENT ID - sp_bp_products */
	// 10. Other contingencies
	public abstract List<SummaryOtherDTO> getAllOtherContingencies(SummaryIdDTO key);

}