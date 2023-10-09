package com.cobiscorp.ecobis.clientviewer.dal;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.dto.AsfiDTO;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO;
import com.cobiscorp.ecobis.clientviewer.dto.EnteDTO;
import com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RateDTO;

public interface RateDAO {

	/**
	 * Method used to counting rates.
	 * 
	 * @return the number of rates.
	 */
	public abstract Long countRates();

	/**
	 * Method used to get rates
	 * 
	 * @return objects with row
	 */
	public List<RateDTO> getRateByClientId(Integer customer);

	/**
	 * Method used to get ASFI
	 * 
	 * @return objects with row
	 */
	public List<AsfiViewDTO> getAsfiByClientId(Integer customer);

	/**
	 * Method used to get INFOCRED
	 * 
	 * @return objects with row
	 */
	public List<InfoCredDTO> getInfoCredByClientId(Integer customer);

	/**
	 * Method used to get CCA RATE
	 * 
	 * @return objects with row
	 */
	public List<EnteDTO> getPortfolioRateByClientId(Integer customer);

}
