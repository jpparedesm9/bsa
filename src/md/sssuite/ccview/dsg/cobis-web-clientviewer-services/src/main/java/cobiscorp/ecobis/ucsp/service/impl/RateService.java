package cobiscorp.ecobis.ucsp.service.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.ucsp.service.IRateService;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;

@Path("/cobis/web/clientviewer/RateService")
@Component
@Service({ IRateService.class })
public class RateService extends ServiceBase implements IRateService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(RateService.class);

	private static final String SCORE_SERVICE_ID = "clientviewer.Rate.getRateByClientId";

	@PUT
	@Path("/getRateByClientId/{customer}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse getRateByClientId(@PathParam("customer") Integer customer) {
		return this.execute(serviceIntegration, logger, SCORE_SERVICE_ID, new Object[] { customer });

	}

	private static final String ASFI_SERVICE_ID = "clientviewer.Rate.getAsfiByClientId";

	@PUT
	@Path("/getAsfiByClientId/{customer}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse getAsfiByClientId(@PathParam("customer") Integer customer) {
		return this.execute(serviceIntegration, logger, ASFI_SERVICE_ID, new Object[] { customer });
	}

	private static final String INFOCRED_SERVICE_ID = "clientviewer.Rate.getInfoCredByClientId";

	@PUT
	@Path("/getInfoCredByClientId/{customer}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse getInfoCredByClientId(@PathParam("customer") Integer customer) {
		return this.execute(serviceIntegration, logger, INFOCRED_SERVICE_ID, new Object[] { customer });
	}

	private static final String PORTFOLIORATE_SERVICE_ID = "clientviewer.Rate.getPortfolioRateByClientId";

	@PUT
	@Path("/getPortfolioRateByClientId/{customer}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse getPortfolioRateByClientId(@PathParam("customer") Integer customer) {
		return this.execute(serviceIntegration, logger, PORTFOLIORATE_SERVICE_ID, new Object[] { customer });
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return serviceIntegration;
	}

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
