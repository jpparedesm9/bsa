package cobiscorp.ecobis.ucsp.admin.service.impl;

import java.util.ArrayList;
import java.util.List;

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

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.ucsp.admin.service.IAdministrationService;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;

//@Path("/cobiscorp/ecobis/ucsp/admin/service/impl/AdministrationService")
@Path("/cobis/web/clientviewer/AdministrationService")
@Component
@Service({ IAdministrationService.class })
public class AdministrationService extends ServiceBase implements IAdministrationService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(AdministrationService.class);

	private static final String DEFAULTCONFIGURATIONVCC_SERVICE_ID = "UCSP.Admin.Administration.DefaultConfigurationVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * defaultConfigurationVCC()
	 */
	@Override
	@PUT
	@Path("/defaultConfigurationVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse defaultConfigurationVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("defaultConfigurationVCC start" + serviceIntegration + ", this: " + this);
			}

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			return this.execute(serviceIntegration, logger, DEFAULTCONFIGURATIONVCC_SERVICE_ID, serviceRequest);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String DELETECONFIGURATIONVCC_SERVICE_ID = "clientviewer.Administration.DeleteConfigurationVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * deleteConfigurationVCC(Integer roleCode)
	 */
	@Override
	@PUT
	@Path("/deleteConfigurationVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse deleteConfigurationVCC(Integer roleCode) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("deleteConfigurationVCC start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, DELETECONFIGURATIONVCC_SERVICE_ID, new Object[] { roleCode });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLROLEASSOCIATESVCC_SERVICE_ID = "UCSP.Admin.Administration.GetAllRoleAssociatesVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * getAllRoleAssociatesVCC()
	 */
	@Override
	@PUT
	@Path("/getAllRoleAssociatesVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllRoleAssociatesVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllRoleAssociatesVCC start" + serviceIntegration + ", this: " + this);
			}

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			return this.execute(serviceIntegration, logger, GETALLROLEASSOCIATESVCC_SERVICE_ID, serviceRequest);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLROLECONFIGURATIONVCC_SERVICE_ID = "clientviewer.Administration.GetAllRoleConfigurationVCC"; 

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * getAllRoleConfigurationVCC()
	 */
	@Override
	@PUT
	@Path("/getAllRoleConfigurationVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllRoleConfigurationVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllRoleConfigurationVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, GETALLROLECONFIGURATIONVCC_SERVICE_ID, new Object[] {});
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String INSERTCONFIGURATIONVCC_SERVICE_ID = "clientviewer.Administration.InsertConfigurationVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * insertConfigurationVCC(Integer IdRole,String nameRole)
	 */
	@Override
	@PUT
	@Path("/insertConfigurationVCC/{idRole}/{nameRole}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse insertConfigurationVCC(@PathParam("idRole") Integer IdRole, @PathParam("nameRole") String nameRole) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("insertConfigurationVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, INSERTCONFIGURATIONVCC_SERVICE_ID, new Object[] { IdRole, nameRole });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String QUERYCONFIGURATIONVCC_SERVICE_ID = "clientviewer.Administration.QueryConfigurationVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * queryConfigurationVCC(Integer roleCode)
	 */
	@Override
	@PUT
	@Path("/queryConfigurationVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse queryConfigurationVCC(Integer roleCode) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("queryConfigurationVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, QUERYCONFIGURATIONVCC_SERVICE_ID, new Object[] { roleCode });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String UPDATECONFIGURATIONVCC_SERVICE_ID = "clientviewer.Administration.UpdateConfigurationVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * updateConfigurationVCC(ProductAdministratorDTO
	 * updateProductAdministrator)
	 */
	@Override
	@PUT
	@Path("/updateConfigurationVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse updateConfigurationVCC(ProductAdministratorDTO updateProductAdministrator) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("updateConfigurationVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, UPDATECONFIGURATIONVCC_SERVICE_ID, new Object[] { updateProductAdministrator });
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		}
	}

	private static final String GETCONFIGURATIONSERVICEVCC_SERVICE_ID = "clientviewer.Administration.GetConfigurationServicesVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * updateConfigurationVCC(ProductAdministratorDTO
	 * updateProductAdministrator)
	 */
	@Override
	@PUT
	@Path("/getConfigurationServicesVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getConfigurationServicesVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getConfigurationServicesVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, GETCONFIGURATIONSERVICEVCC_SERVICE_ID, new Object[] {});
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getConfigurationServicesVCC");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLADMINISTRATORDEFAULT = "clientviewer.Administration.GetAllProductAdministratorDefaultVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * updateConfigurationVCC(ProductAdministratorDTO
	 * updateProductAdministrator)
	 */
	@Override
	@PUT
	@Path("/getAllProductAdministratorDefaultVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllProductAdministratorDefaultVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllProductAdministratorDefaultVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, GETALLADMINISTRATORDEFAULT, new Object[] {});
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getAllProductAdministratorDefaultVCC");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLMANAGEMENTCONTENTSECTION = "clientviewer.Administration.GetAllManagementContentSectionVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * getAllManagementContentSectionVCC()
	 */
	@Override
	@PUT
	@Path("/getAllManagementContentSectionVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllManagementContentSectionVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllManagementContentSectionVCC start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, GETALLMANAGEMENTCONTENTSECTION, new Object[] {});
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getAllManagementContentSectionVCC");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLMANAGEMENTCONTENTSECTIONROLE = "clientviewer.Administration.GetAllManagementContentSectionRole";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * getAllManagementContentSectionVCC()
	 */
	@Override
	@PUT
	@Path("/getAllManagementContentSectionRole")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllManagementContentSectionRole() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllManagementContentSectionRole start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, GETALLMANAGEMENTCONTENTSECTIONROLE, new Object[] {});
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getAllManagementContentSectionRole");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLMANAGEMENTCONTENTSECTIONROLBYROL = "clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * getManagementContentSectionRoleByRoleVCC(Integer roleCode)
	 */
	@Override
	@PUT
	@Path("/getManagementContentSectionRoleByRoleVCC")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getManagementContentSectionRoleByRoleVCC() {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getManagementContentSectionRoleByRoleVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, GETALLMANAGEMENTCONTENTSECTIONROLBYROL, new Object[] {});
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getManagementContentSectionRoleByRoleVCC");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLMANAGEMENTCONTENTSECTIONROLBYSECTION = "clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC";

	/*
	 * (non-Javadoc)
	 * 
	 * @see cobiscorp.ecobis.ucsp.admin.service.IAdministrationService#
	 * getManagementContentSectionRoleBySectionVCC(Integer manConSec)
	 */
	@Override
	@PUT
	@Path("/getManagementContentSectionRoleBySectionVCC/{idManConSec}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getManagementContentSectionRoleBySectionVCC(@PathParam("idManConSec") Integer idManConSec) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getManagementContentSectionRoleBySectionVCC start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, GETALLMANAGEMENTCONTENTSECTIONROLBYSECTION, new Object[] { idManConSec });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getManagementContentSectionRoleBySectionVCC");
			return this.manageException(ex, logger);
		}
	}

	private static final String DELETEMANAGEMENTCONTENTSECTIONBYID = "clientviewer.Administration.deleteManagementContentSectionById";

	@Override
	@PUT
	@Path("/deleteManagementContentSectionById/{code}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse deleteManagementContentSectionById(@PathParam("code") Integer code) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("deleteManagementContentSectionById start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, DELETEMANAGEMENTCONTENTSECTIONBYID, new Object[] { code });

		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio deleteManagementContentSectionById");
			return this.manageException(ex, logger);
		}
	}

	private static final String DELETEMANAGEMENTCONTENTSECTIONROLE = "clientviewer.Administration.deleteManagementContentSectionRole";

	@Override
	@PUT
	@Path("/deleteManagementContentSectionRole/{code}/{section}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse deleteManagementContentSectionRole(@PathParam("code") Integer code, @PathParam("section") Integer section) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("deleteManagementContentSectionRole start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, DELETEMANAGEMENTCONTENTSECTIONROLE, new Object[] { code, section });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio deleteManagementContentSectionRole");
			return this.manageException(ex, logger);
		}
	}

	private static final String DELETEMANAGEMENTCONTENTSECTIONROLEBYSECTION = "clientviewer.Administration.deleteManagementContentSectionRoleBySection";

	@Override
	@PUT
	@Path("/deleteManagementContentSectionRoleBySection/{code}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse deleteManagementContentSectionRoleBySection(@PathParam("code") Integer code) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("deleteManagementContentSectionRoleBySection start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, DELETEMANAGEMENTCONTENTSECTIONROLEBYSECTION, new Object[] { code });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio deleteManagementContentSectionRoleBySection");
			return this.manageException(ex, logger);
		}
	}

	private static final String UPDATEMANAGEMENTCONTENTSECTIONBYID = "clientviewer.Administration.updateManagementContentSectionById";

	@Override
	@PUT
	@Path("/updateManagementContentSectionById")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse updateManagementContentSectionById(ManagementContentSectionDTO entity) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("updateManagementContentSectionById start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, UPDATEMANAGEMENTCONTENTSECTIONBYID, new Object[] { entity });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio updateManagementContentSectionById");
			return this.manageException(ex, logger);
		}

	}

	private static final String INSERTMANAGEMENTCONTENTSECTION = "clientviewer.Administration.insertManagementContentSection";

	@Override
	@PUT
	@Path("/insertManagementContentSection")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse insertManagementContentSection(ManagementContentSectionDTO entity) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("insertManagementContentSection start" + serviceIntegration + ", this: " + this);
			}

			return this.execute(serviceIntegration, logger, INSERTMANAGEMENTCONTENTSECTION, new Object[] { entity });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio insertManagementContentSection");
			return this.manageException(ex, logger);
		}
	}

	private static final String INSERTMANAGEMENTCONTENTSECTIONROLE = "clientviewer.Administration.insertManagementContentSectionRole";

	@Override
	@PUT
	@Path("/insertManagementContentSectionRole")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse insertManagementContentSectionRole(ManagementContentSectionRoleDTO entity) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("insertManagementContentSectionRole start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, INSERTMANAGEMENTCONTENTSECTIONROLE, new Object[] { entity });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio insertManagementContentSectionRole");
			return this.manageException(ex, logger);
		}
	}

	private static final String DELETEDEFAULTPRODUCTADMINISTRATORBYID = "clientviewer.Administration.deleteDefaultProductAdministratorById";

	@Override
	@PUT
	@Path("/deleteDefaultProductAdministratorById/{code}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse deleteDefaultProductAdministratorById(@PathParam("code") Double code) {

		ServiceResponse serviceResponse = new ServiceResponse();

		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("deleteDefaultProductAdministratorById start" + serviceIntegration + ", this: " + this);
			}
			serviceResponse = this.execute(serviceIntegration, logger, DELETEDEFAULTPRODUCTADMINISTRATORBYID, new Object[] { code });

			Double response = (Double) serviceResponse.getData();

			if (response != null && response > 0) {
				serviceResponse.setResult(true);

			} else {
				serviceResponse.setResult(false);
			}

			return serviceResponse;

		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio deleteDefaultProductAdministratorById", ex);
			serviceResponse.setResult(false);

			List<MessageTO> messagesTO = new ArrayList<MessageTO>();
			MessageTO messageTO = new MessageTO();
			messageTO.setMessage(ex.getMessage());

			serviceResponse.addMessages(messagesTO);

			return serviceResponse;

		}

	}

	private static final String UPDATEDEFAULTPRODUCTADMINISTRATORBYID = "clientviewer.Administration.updateDefaultProductAdministratorById";

	@Override
	@PUT
	@Path("/updateDefaultProductAdministratorById")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse updateDefaultProductAdministratorById(DefaultProductAdministratorDTO entity) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("updateDefaultProductAdministratorById start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, UPDATEDEFAULTPRODUCTADMINISTRATORBYID, new Object[] { entity });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio updateDefaultProductAdministratorById");
			return this.manageException(ex, logger);
		}
	}

	private static final String INSERTDEFAULTPRODUCTADMINISTRATORBYID = "clientviewer.Administration.insertDefaultProductAdministrator";

	@Override
	@PUT
	@Path("/insertDefaultProductAdministrator")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse insertDefaultProductAdministrator(DefaultProductAdministratorDTO entity) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("insertDefaultProductAdministrator start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, INSERTDEFAULTPRODUCTADMINISTRATORBYID, new Object[] { entity });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio insertDefaultProductAdministrator");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLDEFAULTPRODUCTADMINISTRATORBYTYPE = "clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType";

	@Override
	@PUT
	@Path("/getAllProductAdministratorDefaultDinamicByType/{typeClient}/{typeClientParent}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllProductAdministratorDefaultDinamicByType(@PathParam("typeClient") String typeClient,
			@PathParam("typeClientParent") String typeClientParent) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllProductAdministratorDefaultDinamicByType start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, GETALLDEFAULTPRODUCTADMINISTRATORBYTYPE, new Object[] { typeClient, typeClientParent });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getAllProductAdministratorDefaultDinamicByType");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETPRODUCTADMINISTRATORDEFAULTDINAMICBYPARENT = "clientviewer.Administration.getProductAdministratorDefaultDinamicByParent";

	@Override
	@PUT
	@Path("/getProductAdministratorDefaultDinamicByParent/{parent}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getProductAdministratorDefaultDinamicByParent(@PathParam("parent") Double parent) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getProductAdministratorDefaultDinamicByParent start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, GETPRODUCTADMINISTRATORDEFAULTDINAMICBYPARENT, new Object[] { parent });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getProductAdministratorDefaultDinamicByParent");
			return this.manageException(ex, logger);
		}
	}

	private static final String GETALLDTOSBYPARENT = "clientviewer.Administration.getAllDtosByParent";

	@Override
	@PUT
	@Path("/getAllDtosByParent/{parent}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllDtosByParent(@PathParam("parent") Integer parent) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllDtosByParent start" + serviceIntegration + ", this: " + this);
			}
			return this.execute(serviceIntegration, logger, GETALLDTOSBYPARENT, new Object[] { parent });
		} catch (Exception ex) {
			logger.logError("Error en la ejecución del servicio getAllDtosByParent");
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
		logger.logInfo("binding service : " + serviceIntegration + ", this: " + this);
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
		logger.logInfo("unbinding service : " + serviceIntegration + ", this: " + this);
	}

}