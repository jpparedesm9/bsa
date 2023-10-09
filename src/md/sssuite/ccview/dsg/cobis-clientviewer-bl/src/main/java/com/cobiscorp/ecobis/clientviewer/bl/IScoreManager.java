package com.cobiscorp.ecobis.clientviewer.bl;

import com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;

public interface IScoreManager {

	public ScoreDTO getScoreCustomer(Integer aIdCustomer);
	
	public ClienteCalificacionDTO getPunctuationCustomer(Integer aIdCustomer);
	
}
