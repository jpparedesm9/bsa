package com.cobiscorp.ecobis.clientviewer.impl;

import com.cobiscorp.ecobis.clientviewer.IScoreServices;
import com.cobiscorp.ecobis.clientviewer.bl.IScoreManager;
import com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;

public class ScoreServiceImpl implements IScoreServices {

	private IScoreManager iScoreManager;

	public IScoreManager getiScoreManager() {
		return iScoreManager;
	}

	public void setiScoreManager(IScoreManager iScoreManager) {
		this.iScoreManager = iScoreManager;
	}

	@Override
	public ScoreDTO searchScoreCustomer(Integer idCustomer) {
		return iScoreManager.getScoreCustomer(idCustomer);
	}

	@Override
	public ClienteCalificacionDTO searchPunctuationCustomer(Integer idCustomer) {
		return iScoreManager.getPunctuationCustomer(idCustomer);
	}

}
