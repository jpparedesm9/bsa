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

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.ucsp.service.IScoreServicesRest;

@Path("/cobis/web/IScoreServices")
@Component
@Service({ IScoreServicesRest.class })
public class ScoreServicesRest extends ServiceBase implements IScoreServicesRest {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(ScoreServicesRest.class);

	private static final String SCORE_SERVICE_ID = "clientviewer.Score.serchScoreCustomer"; // "ClientViewer.Score.serchScoreCustomer";

	@PUT
	@Path("/searchScoreCustomer/{idCustomer}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse searchScoreCustomer(@PathParam("idCustomer") Integer idCustomer) {

		return this.execute(serviceIntegration, logger,
		// "clientviewer/IScoreServices.searchScoreCustomer",
				SCORE_SERVICE_ID, new Object[] { idCustomer });
	}

	private static final String PUNCTUATION_SERVICE_ID = "clientviewer.Score.searchPunctuationCustomer";

	@PUT
	@Path("/searchPunctuationCustomer/{idCustomer}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse searchPunctuationCustomer(@PathParam("idCustomer") Integer idCustomer) {

		return this.execute(serviceIntegration, logger, PUNCTUATION_SERVICE_ID, new Object[] { idCustomer });
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
