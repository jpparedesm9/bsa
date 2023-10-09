package com.cobiscorp.ecobis.clientviewer;

import com.cobiscorp.ecobis.clientviewer.dto.ClienteCalificacionDTO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;

public interface IScoreServices {

	public ScoreDTO searchScoreCustomer(Integer idCustomer);
	
	public ClienteCalificacionDTO searchPunctuationCustomer(Integer idCustomer);
	
}
