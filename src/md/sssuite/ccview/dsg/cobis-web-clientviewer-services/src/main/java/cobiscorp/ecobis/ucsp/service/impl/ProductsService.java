/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de COBISCORP.                                */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de COBISCORP.                              */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las y por las convenciones              */
/*   internacionales de  propiedad intelectual. Su uso no   */
/*   autorizado dara  derecho a  COBISCORP para obtener     */
/*   ordenes de  secuestro o retencion y  para perseguir    */
/*   penalmente a los autores de cualquier infraccion.      */
/************************************************************/
/*   This code was generated by CEN-SG.                     */
/*   Changes to this file may cause incorrect behavior      */
/*   and will be lost if the code is regenerated.           */
/************************************************************/

package cobiscorp.ecobis.ucsp.service.impl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.OperationGuaranteesRequest;
import cobiscorp.ecobis.ucsp.service.IProductsService;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.g11n.bo.L10NInfo;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;

@Path("/cobis/web/clientviewer/ProductsService")
@Component
@Service({ IProductsService.class })
public class ProductsService extends ServiceBase implements IProductsService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(ProductsService.class);

	private static final String PREPAREPRODUCTSDATA_SERVICE_ID = "ClientViewer.Products.PrepareProductsData"; // "UCSP.Products.PrepareProductsData";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cobiscorp.ecobis.ucsp.service.IProductsService#prepareProductsData(com
	 * .cobiscorp.ecobis.customer.dto.SearchCustomerDTO)
	 */
	@Override
	@PUT
	@Path("/prepareProductsData/{customerCode}/{groupCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse prepareProductsData(
			@PathParam("customerCode") Integer customerCode,
			@PathParam("groupCode") Integer groupCode) {
		try {
			String dateFormat = "dd/MM/yyyy";
			Map<String, Object> session = SessionManager.getSession();
			if (logger.isDebugEnabled()) {
				logger.logDebug("prepareProductsData start"
						+ serviceIntegration + ", this: " + this);
			}
			if (serviceIntegration == null) {
				logger.logDebug("----------> serviceIntegration null");
			}

			L10NInfo clientLocalizationInformation = (L10NInfo) session
					.get(L10NInfo.CLIENT_LOCALIZATION_INFORMATION);

			if (clientLocalizationInformation != null) {
				dateFormat = clientLocalizationInformation.getDateFormat();
			}

			logger.logDebug("dateFormat ------>" + dateFormat);
			return this.execute(serviceIntegration, logger,
					PREPAREPRODUCTSDATA_SERVICE_ID, new Object[] {
							customerCode, groupCode, dateFormat });

		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String QUERYPRODUCTSBYCLIENTID_SERVICE_ID = "ClientViewer.Products.QueryProductsByClientId"; // "UCSP.Products.QueryProductsByClientId";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cobiscorp.ecobis.ucsp.service.IProductsService#queryProductsByClientId
	 * (java.lang.Integer, java.lang.Integer)
	 */
	@Override
	@PUT
	@Path("/queryProductsByClientId/{customerCode}/{documentId}/{spid}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse queryProductsByClientId(
			@PathParam("customerCode") Integer customerCode,
			@PathParam("documentId") String documentId,
			@PathParam("spid") Integer spid) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("queryProductsByClientId start"
						+ serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger,
					QUERYPRODUCTSBYCLIENTID_SERVICE_ID, new Object[] {
							customerCode, String.valueOf(documentId), spid });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String QUERYHISTORYPRODUCTSBYCLIENTID_SERVICE_ID = "ClientViewer.Products.QueryHistoryProductsByClientId"; // "UCSP.Products.QueryProductsByClientId";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cobiscorp.ecobis.ucsp.service.IProductsService#queryProductsByClientId
	 * (java.lang.Integer, java.lang.Integer)
	 */
	@Override
	@PUT
	@Path("/queryHistoryProductsByClientId/{customerCode}/{spid}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse queryHistoryProductsByClientId(
			@PathParam("customerCode") Integer customerCode,
			@PathParam("spid") Integer spid,
			@Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("queryHistoryProductsByClientId start");
			}
			ServiceResponse response = this.execute(serviceIntegration, logger,
					QUERYHISTORYPRODUCTSBYCLIENTID_SERVICE_ID, new Object[] {
							customerCode, spid });
			httpRequest.getSession().setAttribute("HistoryByClient", response);
			return response;
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String GET_OPERATION_GUARRANTIES_SERVICE_ID = "Loan.ReadOperationGuarantees.GetOperationGuarantees";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cobiscorp.ecobis.ucsp.service.IProductsService#getOperationGuarantees
	 * (java.lang.Integer, java.lang.Integer)
	 */
	@Override
	@PUT
	@Path("/getOperationGuarantees/{dtoCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponseTO getOperationGuarantees(
			@PathParam("dtoCode") String dtoCode) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getOperationGuarantees start"
						+ serviceIntegration + ", this: " + this);
			}
			logger.logInfo("Ejecuta servicio de garantías");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
			ServiceResponse serviceResponse = null;
			OperationGuaranteesRequest oGuarranties = new OperationGuaranteesRequest();
			oGuarranties.setGuaranteeNumber(dtoCode);
			serviceRequestTO.getData().put("inOperationGuaranteesRequest",
					oGuarranties);
			serviceResponse = execute(this.serviceIntegration, logger,
					GET_OPERATION_GUARRANTIES_SERVICE_ID, serviceRequestTO);
			serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO;
		} catch (Exception ex) {
			logger.logError("Error en getOperationGuarantees " + ex);
			return this.manageExceptionServiceResponseTO(ex, logger);
		}
	}
	
	
	
	private static final String GET_OPERATION_CHILDS_SERVICE_ID = "Loan.LoansQueries.GetIndividualOperationByOperationGroup";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cobiscorp.ecobis.ucsp.service.IProductsService#getOperationGuarantees
	 * (java.lang.Integer, java.lang.Integer)
	 */
	@Override
	@PUT
	@Path("/getDebtsChilds/{dtoCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponseTO getDebtsChilds(
			@PathParam("dtoCode") String dtoCode) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getDebtsChilds start"
						+ serviceIntegration + ", this: " + this);
			}
			logger.logInfo("Ejecuta servicio para obtener las operaciones hijas");
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
			ServiceResponse serviceResponse = null;
			LoanRequest operationId = new LoanRequest();
			operationId.setBank(dtoCode);
			serviceRequestTO.getData().put("inLoanRequest",
					operationId);
			serviceResponse = execute(this.serviceIntegration, logger,
					GET_OPERATION_CHILDS_SERVICE_ID, serviceRequestTO);
			serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO;
		} catch (Exception ex) {
			logger.logError("Error en getDebtsChilds " + ex);
			return this.manageExceptionServiceResponseTO(ex, logger);
		}
	}

	private static final String PREPAREPRODUCTSDATAHISTORY_SERVICE_ID = "ClientViewer.Products.PrepareProductsDataHistory"; // "UCSP.Products.PrepareProductsData";

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cobiscorp.ecobis.ucsp.service.IProductsService#prepareProductsData(com
	 * .cobiscorp.ecobis.customer.dto.SearchCustomerDTO)
	 */
	@Override
	@PUT
	@Path("/prepareProductsDataHistory/{customerCode}/{groupCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse prepareHistoryProductsData(
			@PathParam("customerCode") Integer customerCode,
			@PathParam("groupCode") Integer groupCode) {
		try {
			String dateFormat = "dd/MM/yyyy";
			Map<String, Object> session = SessionManager.getSession();
			if (logger.isDebugEnabled()) {
				logger.logDebug("prepareProductsDataHistory start");
			}

			L10NInfo clientLocalizationInformation = (L10NInfo) session
					.get(L10NInfo.CLIENT_LOCALIZATION_INFORMATION);

			if (clientLocalizationInformation != null) {
				dateFormat = clientLocalizationInformation.getDateFormat();
			}
			ServiceResponse response = this.execute(serviceIntegration, logger,
					PREPAREPRODUCTSDATAHISTORY_SERVICE_ID, new Object[] {
							customerCode, groupCode, dateFormat });
			return response;

		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
		logger.logInfo("binding service : " + serviceIntegration + ", this: "
				+ this);
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
		logger.logInfo("unbinding service : " + serviceIntegration + ", this: "
				+ this);
	}

}