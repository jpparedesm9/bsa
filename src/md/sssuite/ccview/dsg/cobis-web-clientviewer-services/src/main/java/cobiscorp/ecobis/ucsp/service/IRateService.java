package cobiscorp.ecobis.ucsp.service;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public interface IRateService {

	public ServiceResponse getRateByClientId(Integer customer);

	public ServiceResponse getAsfiByClientId(Integer customer);

	public ServiceResponse getInfoCredByClientId(Integer customer);

	public ServiceResponse getPortfolioRateByClientId(Integer customer);

}
