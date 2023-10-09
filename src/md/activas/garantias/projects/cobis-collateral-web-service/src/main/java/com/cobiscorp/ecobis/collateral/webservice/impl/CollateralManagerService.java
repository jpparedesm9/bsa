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

package com.cobiscorp.ecobis.collateral.webservice.impl;

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

import cobiscorp.ecobis.collateral.dto.CollateralRequest;
import cobiscorp.ecobis.collateral.dto.CustodyInformation;
import cobiscorp.ecobis.collateral.dto.CustodyItemInformation;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.collateral.constants.RequestName;
import com.cobiscorp.ecobis.collateral.constants.ServiceId;
import com.cobiscorp.ecobis.collateral.dto.CollateralItemDTO;
import com.cobiscorp.ecobis.collateral.services.CollateralService;
import com.cobiscorp.ecobis.collateral.webservice.ICollateralManagerService;

@Path("/cobis/web/collateral/collateralServicesManager")
@Component
@Service({ CollateralManagerService.class })
public class CollateralManagerService extends ServiceBase implements ICollateralManagerService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(CollateralManagerService.class);

	@Override
	@PUT
	@Path("/searchCollateral/{guaranteeId}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse searchCollateral(@PathParam("guaranteeId") String guaranteeId) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("searchCollateral start");
			}

			CollateralRequest collateralRequest = new CollateralRequest();
			collateralRequest.setOperation('Q');
			collateralRequest.setExternalCode(guaranteeId);

			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue(RequestName.INCOLLATERALREQUEST, collateralRequest);

			return this.execute(serviceIntegration, logger, ServiceId.SEARCHCOLLATERAL_SERVICE_ID, serviceRequest);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	@Override
	@PUT
	@Path("/getCollateralItems/{collateralType}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCollateralItems(@PathParam("collateralType") String collateralType) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("searchCollateral start");
			}

			CollateralService collateralUtils = new CollateralService();
			ServiceResponse serviceResponse = new ServiceResponse();
			serviceResponse.setData(collateralUtils.getColumns(collateralType, serviceIntegration));
			serviceResponse.setResult(true);
			logger.logDebug("serviceResponse ---> getCollateralItems --->" + serviceResponse);
			return serviceResponse;
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	@Override
	@PUT
	@Path("/getSearchedCollateralItems/{collateralId}/{branchOffice}/{collateralType}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getSearchedCollateralItems(@PathParam("collateralId") Integer collateralId, @PathParam("branchOffice") Integer branchOffice,
			@PathParam("collateralType") String collateralType) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("searchCollateral start");
			}

			CollateralService collateralUtils = new CollateralService();
			ServiceResponse serviceResponse = new ServiceResponse();
			serviceResponse.setData(collateralUtils.getCollateralDataSource(collateralId, branchOffice, collateralType, serviceIntegration));
			serviceResponse.setResult(true);
			return serviceResponse;
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	@Override
	@PUT
	@Path("/getComposedCollateral/{externalCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getComposedCollateral(@PathParam("externalCode") String externalCode) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("searchCollateral start");
			}

			CustodyInformation custodyInformation = new CustodyInformation();
			custodyInformation.setCodeComposed(externalCode);
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue(RequestName.INCUSTODYINFORMATION, custodyInformation);

			return this.execute(serviceIntegration, logger, ServiceId.DECODINGCODECOMPOSEDOFGUARANTEE_SERVICE_ID, serviceRequest);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	@Override
	@PUT
	@Path("/insertOrUpdateCollateralItems")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse insertOrUpdateCollateralItems(CollateralItemDTO collateralItem) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("insertOrUpdateCollateralItems start");
			}

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			serviceRequest.addValue(RequestName.INCUSTODYINFORMATION, collateralItem.getCustodyInformation());
			serviceRequest.addValue(RequestName.INITEMSINFORMATION, collateralItem.getItemsInformation());

			if ("insert".equals(collateralItem.getMode())) {
				return this.execute(serviceIntegration, logger, ServiceId.INSERTNEWITEM_SERVICE_ID, serviceRequest);
			} else if ("update".equals(collateralItem.getMode())) {
				return this.execute(serviceIntegration, logger, ServiceId.UPDATEITEM_SERVICE_ID, serviceRequest);
			}
			return null;
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	@Override
	@PUT
	@Path("/deleteCollateralItems/{collateralId}/{collateralType}/{secuential}/{branchOffice}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse deleteCollateralItems(@PathParam("collateralId") Integer collateralId, @PathParam("collateralType") String collateralType,
			@PathParam("secuential") Integer sequential, @PathParam("branchOffice") Integer branchOffice) {

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("deleteCollateralItems start");
			}

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			CustodyItemInformation custodyItemInformation = new CustodyItemInformation();
			custodyItemInformation.setBranchOffice(branchOffice);
			custodyItemInformation.setSubsidiary(1);
			custodyItemInformation.setCustodyType(collateralType);
			custodyItemInformation.setCustody(collateralId);
			custodyItemInformation.setSequential(sequential);
			serviceRequest.addValue(RequestName.INCUSTODYITEMINFORMATION, custodyItemInformation);

			return this.execute(serviceIntegration, logger, ServiceId.DELETEITEM_SERVICE_ID, serviceRequest);

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