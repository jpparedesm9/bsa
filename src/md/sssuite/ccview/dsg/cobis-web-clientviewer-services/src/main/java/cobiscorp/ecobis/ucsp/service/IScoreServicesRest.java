package cobiscorp.ecobis.ucsp.service;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;


public interface IScoreServicesRest {

	public ServiceResponse searchScoreCustomer(Integer idCustomer);
	
	public ServiceResponse searchPunctuationCustomer(Integer idCustomer);
	
}
