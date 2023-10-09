package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.InvalidTokenException;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.b2c.jwt.TokenExpiredException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.request.DocumentUploadRequest;
import com.cobiscorp.mobile.rest.interfaces.IRestDocumentUpload;
import com.cobiscorp.mobile.service.interfaces.ICustomerEvaluation;
import com.cobiscorp.mobile.service.interfaces.IDocumentUpload;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestDocumentUpload.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class DocumentUploadImp extends RestServiceBase implements IRestDocumentUpload {

	private final ILogger logger = LogFactory.getLogger(DocumentUploadImp.class);

	// Referencias
	@Reference(bind = "setDocumentUpload", unbind = "unsetDocumentUpload", cardinality = ReferenceCardinality.MANDATORY_UNARY)

	private IDocumentUpload documentUpload;

	// deberia ser get y enviar los paramtros en la url
	@POST
	@Path("/customer/documentUpload")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response documentUpload(@Valid DocumentUploadRequest documentUploadRequest,
			@Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/documentUpload >> ");

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/documentUpload >> CobisJwt " + cobisJwt);

			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/documentUpload >> cobisSessionId " + cobisSessionId);

			// return
			// successResponse(documentUpload.documentUploadImp(documentUploadRequest),
			// cobisJwt);
			return successResponse(null, cobisJwt);

		} catch (TokenExpiredException e) {
			e.printStackTrace();
			logger.logDebug("error de TokenExpiredException");
			logger.logInfo(e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("error TokenExpiredException InvalidTokenException: " +e);
			return unauthorizedResponse(e.getMessage());
//		} catch (MobileServiceException e) {
//			return errorResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error en Carga de Documento");
		}
	}

	protected void setDocumentUpload(IDocumentUpload documentUpload) {
		this.documentUpload = documentUpload;
	}

	protected void unsetDocumentUpload(IDocumentUpload documentUpload) {
		this.documentUpload = null;
	}

}
