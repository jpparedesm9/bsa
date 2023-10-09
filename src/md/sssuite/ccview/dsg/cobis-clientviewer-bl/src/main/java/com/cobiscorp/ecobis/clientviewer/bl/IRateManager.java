package com.cobiscorp.ecobis.clientviewer.bl;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.AsfiDTO;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO;
import com.cobiscorp.ecobis.clientviewer.dto.EnteDTO;
import com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RateDTO;

public interface IRateManager {

	public List<RateDTO> getRateByClientId(Integer customer);

	public List<AsfiViewDTO> getAsfiByClientId(Integer customer);

	public List<InfoCredDTO> getInfoCredByClientId(Integer customer);

	public List<EnteDTO> getPortfolioRateByClientId(Integer customer);

}
