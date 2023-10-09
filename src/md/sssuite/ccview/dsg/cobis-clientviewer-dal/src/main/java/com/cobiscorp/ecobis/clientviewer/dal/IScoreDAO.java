package com.cobiscorp.ecobis.clientviewer.dal;

import com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;

public interface IScoreDAO {

	/**
	 * @author aandy
	 * @param key
	 * @return
	 */
	
	public ScoreDTO getScoreCustomer(Integer aIdCustomer);
	
	
	public ClienteCalificacionDTO getPunctuationCustomer(Integer aIdCustomer);
	
}
