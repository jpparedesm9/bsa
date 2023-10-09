package com.cobiscorp.ecobis.clientviewer.impl;

import java.util.List;

import com.cobiscorp.ecobis.clientviewer.IRateServices;
import com.cobiscorp.ecobis.clientviewer.bl.IRateManager;
import com.cobiscorp.ecobis.clientviewer.dto.AsfiViewDTO;
import com.cobiscorp.ecobis.clientviewer.dto.EnteDTO;
import com.cobiscorp.ecobis.clientviewer.dto.InfoCredDTO;
import com.cobiscorp.ecobis.clientviewer.dto.RateDTO;

public class RateServiceImpl implements IRateServices {

	private IRateManager rateManager;

	@Override
	public List<RateDTO> getRateByCustomerId(Integer customer) {
		return rateManager.getRateByClientId(customer);
	}

	@Override
	public List<AsfiViewDTO> getAsfiByClientId(Integer customer) {
		return rateManager.getAsfiByClientId(customer);
	}

	@Override
	public List<InfoCredDTO> getInfoCredByClientId(Integer customer) {
		return rateManager.getInfoCredByClientId(customer);
	}

	@Override
	public List<EnteDTO> getPortfolioRateByClientId(Integer customer) {
		return rateManager.getPortfolioRateByClientId(customer);
	}

	public IRateManager getRateManager() {
		return rateManager;
	}

	public void setRateManager(IRateManager rateManager) {
		this.rateManager = rateManager;
	}

}
