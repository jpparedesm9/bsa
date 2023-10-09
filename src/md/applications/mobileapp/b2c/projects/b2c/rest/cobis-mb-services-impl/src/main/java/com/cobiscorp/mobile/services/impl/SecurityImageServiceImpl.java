package com.cobiscorp.mobile.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.Message;
import com.cobiscorp.mobile.model.SecurityImageItem;
import com.cobiscorp.mobile.model.SecurityImageRequest;
import com.cobiscorp.mobile.model.SecurityImageResponse;
import com.cobiscorp.mobile.service.interfaces.ISecurityImageService;
import com.cobiscorp.mobile.services.impl.utils.Activator;
import com.cobiscorp.mobile.services.impl.utils.KeepSecurity;
import com.cobiscorp.mobile.services.impl.utils.ManagerException;
import com.cobiscorp.mobile.services.impl.utils.MessagesUtil;

import cobiscorp.ecobis.businesstoconsumer.dto.Entity;
import cobiscorp.ecobis.businesstoconsumer.dto.LoginImage;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ ISecurityImageService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class SecurityImageServiceImpl extends ServiceBase implements ISecurityImageService {
	/** Class name. */
	private static final String CLASS_NAME = " [---> MB --->] ";
	private static final ILogger logger = LogFactory.getLogger(SecurityImageServiceImpl.class);

	private static final String MSG_NULL_OBJECT = "El objeto request es nulo";

	// SERVICIOS
	private static final String SRV_QUERY_LOGIN_IMAGE_UX = "InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX";
	private static final String SRV_LOGIN_IMAGE = "InternetBanking.WebApp.Security.Service.Security.InsertLoginImage";
	private static final String SRV_QUERY_LOGIN_IMAGE = "InternetBanking.WebApp.Security.Service.Security.QueryLoginImage";
	private static final String SRV_UPDATE_LOGIN_IMAGE = "BusinessToConsumer.ImageManagement.UpdateLoginImage";

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.OPTIONAL_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setAdminTokenUser", unbind = "unsetAdminTokenUser", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IAdminTokenUser adminTokenUser;

	public void setAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = adminTokenUser;
	}

	public void unsetAdminTokenUser(IAdminTokenUser adminTokenUser) {
		this.adminTokenUser = null;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public SecurityImageResponse getRandomImages(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Inicia getRandomImages");
		}

		SecurityImageResponse response = new SecurityImageResponse();
		try {
			response = this.getRandomImagesInternal(request, cobisSessionId);
		} catch (Exception e) {
			ManagerException.manageException(e, request, response);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASS_NAME + " Finaliza getRandomImages");
			}
		}
		return response;
	}

	/**
	 * Permite ejecutar el servicio para obtener imagenes
	 * 
	 * @param request
	 * @return
	 * @throws com.cobiscorp.mobile.exception.MobileServiceException
	 * @throws Exception
	 */
	public SecurityImageResponse getRandomImagesInternal(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Inicia getRandomImagesInternal");
		}

		SecurityImageResponse response = new SecurityImageResponse();
		ServiceRequestTO requestTO = new ServiceRequestTO();

		Entity entity = new Entity();
		entity.setUserName("");
		entity.setId(1);
		requestTO.addValue("inEntity", entity);
		try {

			// ServiceResponseTO responseTO = execute(serviceIntegration, logger,
			// SRV_QUERY_LOGIN_IMAGE_UX, EMPTY_COBIS_SESSION_ID,requestTO);
			ServiceResponseTO responseTO = execute(serviceIntegration, logger, SRV_QUERY_LOGIN_IMAGE_UX,
					EMPTY_COBIS_SESSION_ID, requestTO);

			if (responseTO.isSuccess()) {
				response.setSuccess(true);

				LoginImage[] imageResponse = (LoginImage[]) responseTO.getValue("returnLoginImage");
				if (imageResponse != null && imageResponse.length > 0) {
					List<SecurityImageItem> imagesList = new ArrayList<SecurityImageItem>();
					for (LoginImage loginImage : imageResponse) {
						SecurityImageItem loginImagen = new SecurityImageItem();
						loginImagen.setImgId(loginImage.getId());
						loginImagen.setImgData(loginImage.getImagen());
						imagesList.add(loginImagen);
					}
					response.setSecurityImageItems(imagesList);
				}
			} else {
				manageResponseError(responseTO, logger);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASS_NAME + " Finaliza getRandomImagesInternal");
			}
		}
		return response;
	}

	@Override
	public SecurityImageResponse insertLoginImage(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + " Inicia getRandomAswersQuestions");
		}

		SecurityImageResponse response = new SecurityImageResponse();

		response = this.insertLoginImageInternal(request, cobisSessionId);

		return response;
	}

	private SecurityImageResponse insertLoginImageInternal(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Inicia insertLoginImage");
		}

		if (request == null) {
			throw new MobileServiceException(MSG_NULL_OBJECT);
		}

		if (request.getMode() != null && request.getMode().equals("U")) {
			KeepSecurity keepSecurity = new KeepSecurity(null, Activator.getPrivateKey().toString().toCharArray());
			String decryptedPass = keepSecurity.decrypt(request.getOtp());
			boolean isValidPassword = adminTokenUser.isValidPasword(request.getCustomerId(), decryptedPass,
					request.getLogin(), Constants.CHANNEL);

			if (!isValidPassword) {
				throw new MobileServiceException("La clave es incorrecta");
			}
		}

		SecurityImageResponse response = new SecurityImageResponse();
		ServiceRequestTO requestTO = new ServiceRequestTO();

		LoginImage inLoginImage = new LoginImage();
		inLoginImage.setAlias(request.getAlias());
		inLoginImage.setLogin(request.getLogin());
		inLoginImage.setImagen(request.getImageId());
		inLoginImage.setFirstTime(1);
		inLoginImage.setEntityType("BM");
		requestTO.addValue("inLoginImage", inLoginImage);

		ServiceResponseTO responseTO = execute(serviceIntegration, logger, SRV_LOGIN_IMAGE, EMPTY_COBIS_SESSION_ID,
				requestTO);
		response.setSuccess(responseTO.isSuccess());

		if (!responseTO.isSuccess()) {
			manageResponseError(responseTO, logger);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Finaliza insertLoginImage");
		}
		return response;
	}

	@Override
	public SecurityImageResponse getImageLogin(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Inicia getImageLogin");
		}

		SecurityImageResponse response = new SecurityImageResponse();
		try {
			response = this.getImageLoginInternal(request, cobisSessionId);
		} catch (Exception e) {
			ManagerException.manageException(e, request, response);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASS_NAME + " Finaliza getImageLogin");
			}
		}
		return response;
	}

	/**
	 * Permite ejecutar el servicio para obtener la imagen de acuerdo al login
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public SecurityImageResponse getImageLoginInternal(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Inicia getImageLoginInternal");
		}

		if (request == null) {
			throw new MobileServiceException("El objeto request es nulo");
		}

		SecurityImageResponse response = new SecurityImageResponse();
		ServiceRequestTO requestTO = new ServiceRequestTO();

		logger.logInfo(CLASS_NAME + "request.getLogin() " + request.getLogin());
		Entity entity = new Entity();
		entity.setUserName(request.getLogin());
		requestTO.addValue("inEntity", entity);

		ServiceResponseTO responseTO = execute(serviceIntegration, logger, SRV_QUERY_LOGIN_IMAGE,
				EMPTY_COBIS_SESSION_ID, requestTO);

		if (responseTO.isSuccess()) {
			response.setSuccess(true);

			LoginImage[] imageResponse = (LoginImage[]) responseTO.getValue("returnLoginImage");
			if (imageResponse != null && imageResponse.length > 0) {
				List<SecurityImageItem> imagesList = new ArrayList<SecurityImageItem>();
				for (LoginImage loginImage : imageResponse) {
					SecurityImageItem loginImagen = new SecurityImageItem();
					loginImagen.setImgData(loginImage.getImagen());
					loginImagen.setImgAlias(loginImage.getAlias());
					loginImagen.setImgLegend(loginImage.getLegend());
					imagesList.add(loginImagen);
				}
				response.setSecurityImageItems(imagesList);
			}
		} else {
			Message msg = MessagesUtil.getMessage(responseTO, request.getCulture());
			response.setSuccess(false);
			response.setMessage(msg);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Finaliza getImageLoginInternal");
		}
		return response;
	}

	@Override
	public SecurityImageResponse updateImageLogin(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {
		if (logger.isInfoEnabled()) {
			logger.logInfo(CLASS_NAME + " Inicia updateImageLogin");
		}

		SecurityImageResponse response = new SecurityImageResponse();
		try {
			response = this.updateLoginImageInternal(request, cobisSessionId);

		} catch (Exception e) {
			ManagerException.manageException(e, request, response);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASS_NAME + " Finaliza updateImageLogin");
			}
		}
		return response;
	}

	private SecurityImageResponse updateLoginImageInternal(SecurityImageRequest request, String cobisSessionId)
			throws MobileServiceException {

		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Inicia updateLoginImageInternal");
		}

		if (request == null) {
			throw new MobileServiceException("El objeto request es nulo");
		}
		SecurityImageResponse response = new SecurityImageResponse();
		ServiceRequestTO requestTO = new ServiceRequestTO();

		LoginImage inLoginImage = new LoginImage();
		inLoginImage.setAlias(request.getAlias());
		inLoginImage.setLogin(request.getLogin());
		inLoginImage.setImagen(request.getImageId());
		inLoginImage.setFirstTime(1);
		inLoginImage.setEntityType("BM");
		requestTO.addValue("inLoginImage", inLoginImage);

		ServiceResponseTO responseTO = execute(serviceIntegration, logger, SRV_UPDATE_LOGIN_IMAGE, cobisSessionId,
				requestTO);
		response.setSuccess(responseTO.isSuccess());

		if (!responseTO.isSuccess()) {
			manageResponseError(responseTO, logger);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(CLASS_NAME + " Finaliza insertLoginImage");
		}
		return response;

	}
}
