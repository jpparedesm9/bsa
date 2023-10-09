package com.cobiscorp.ecobis.clientviewer;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.AsfiDTO;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO;
import com.cobiscorp.ecobis.clientviewer.dto.EnteDTO;
import com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RateDTO;
import java.util.List;

public interface IRateServices {

	public List<RateDTO> getRateByCustomerId(Integer idCustomer);

	public List<AsfiViewDTO> getAsfiByClientId(Integer customer);

	public List<InfoCredDTO> getInfoCredByClientId(Integer customer);
	
	public List<EnteDTO> getPortfolioRateByClientId(Integer customer);

}
