package com.cobiscorp.ecobis.businessprocess.connector.impl;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.csp.domains.ICSP;
import com.cobiscorp.cobis.csp.services.ICSPExecutorConnector;
import com.cobiscorp.cobis.csp.util.CSPUtil;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseWSAS;
import com.cobiscorp.ecobis.businessprocess.connector.Constants;
import com.cobiscorp.ecobis.ws.client.infocred.BICService;
import com.cobiscorp.ecobis.ws.client.infocred.IIndividualReportServiceContract;
import com.cobiscorp.ecobis.ws.client.infocred.Titular;
import com.cobiscorp.ecobis.ws.client.infocred.Usuario;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.xml.namespace.QName;
import javax.xml.ws.Binding;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.handler.Handler;
import javax.xml.ws.soap.SOAPFaultException;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

@Component(name = "InfocredConnector", immediate = false)
@Service({com.cobiscorp.cobis.csp.services.ICSPExecutorConnector.class})
@Properties({
    @Property(name = "service.description", value = "InfocredConnector"),
    @Property(name = "service.vendor", value = "COBISCORP"),
    @Property(name = "service.version", value = "1.0.0"),
    @Property(name = "service.identifier", value = "InfocredConnector")
})
public class InfocredConnector implements ICSPExecutorConnector {
	private static final ILogger logger = LogFactory.getLogger(InfocredConnector.class);
	private static IIndividualReportServiceContract iService = null;

	public void loadConfiguration(IConfigurationReader configurationReader) {
	}

	public IProcedureResponse transformAndSend(IProcedureRequest anOriginalRequest) {
		String xmlResponse = "";
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso reportConfidential - Customer = [" + anOriginalRequest.readValueParam("@i_documento_titular") + "]");
		}
		Map<Object, Object> resultados = new HashMap<Object, Object>();
		// Almaceno transaccion principal en bolsa
		resultados.put("anOriginalRequest", anOriginalRequest);

		// Preparar los DTOs que van al servicio
		Titular titular = new Titular();
		titular.setTipoDocumento(Integer.parseInt(anOriginalRequest.readValueParam("@i_tipo_documento_titular")));
		titular.setDocumento(anOriginalRequest.readValueParam("@i_documento_titular"));
		titular.setNombreCompleto(anOriginalRequest.readValueParam("@i_nombre_completo_titular"));

		Usuario usuario = new Usuario();
		usuario.setDocumento(anOriginalRequest.readValueParam("@i_documento_usuario"));
		usuario.setNombreCompleto(anOriginalRequest.readValueParam("@i_nombre_completo_usuario"));

		// OJO - ClassLoader para poder instanciar el WebService, caso contario da error
		ClassLoader bundleClassLoader = super.getClass().getClassLoader();
		ClassLoader originalClassLoader = Thread.currentThread().getContextClassLoader();
		Thread.currentThread().setContextClassLoader(bundleClassLoader);

		Map<Object, Object> resultValues = new HashMap<Object, Object>();
		if (!this.getConnection(resultValues)) {
			resultados.put("returnCode", -1);
			resultados.put("returnMessage", resultValues.get("ExceptionMessage").toString());
			return processResponseProvider(resultados, null);
		}

		try {
			if (anOriginalRequest.readValueParam("@i_tipo_reporte").equals(Constants.REPORT_GET_INDIVIDUALREPORT3)) {
				xmlResponse = iService.getIndividualReport3(titular, usuario);
			} else if (anOriginalRequest.readValueParam("@i_tipo_reporte").equals(Constants.REPORT_GET_TITULARLISTBYNAME)) {
				xmlResponse = iService.getTitularListByName(usuario, usuario.getNombreCompleto());
			}
		} catch (SOAPFaultException e) {
			Thread.currentThread().setContextClassLoader(originalClassLoader);
			iService = null;
			logger.logDebug("-->> INFOCRED-CONNECTOR => EXECUTION SOAPFaultException - Ejecución al host remoto - [" + anOriginalRequest.readValueParam("@i_tipo_reporte") + "]", e);
			resultados.put("returnCode", -2);
			resultados.put("returnMessage", "SOAPFaultException - '" + e.getFault().getFaultCode() + "' - " + e.getFault().getFaultString());
			return processResponseProvider(resultados, null);
		} catch (WebServiceException e) {
			Thread.currentThread().setContextClassLoader(originalClassLoader);
			iService = null;
			logger.logDebug("-->> INFOCRED-CONNECTOR => EXECUTION WebServiceException - Ejecución al host remoto - [" + anOriginalRequest.readValueParam("@i_tipo_reporte") + "]", e);
			resultados.put("returnCode", -2);
			resultados.put("returnMessage", "WebServiceException - " + e.getMessage());
			return processResponseProvider(resultados, null);
		} catch (Exception e) {
			Thread.currentThread().setContextClassLoader(originalClassLoader);
			iService = null;
			logger.logDebug("-->> INFOCRED-CONNECTOR => EXECUTION EXCEPTION - Ejecución al host remoto - [" + anOriginalRequest.readValueParam("@i_tipo_reporte") + "]", e);
			resultados.put("returnCode", -2);
			resultados.put("returnMessage", "WebServiceException - " + e.getMessage());
			return processResponseProvider(resultados, null);
		} finally {
			iService = null;
			// OJO - Se vuelve a setear el classloader original
			Thread.currentThread().setContextClassLoader(originalClassLoader);
		}

		// Almaceno respuesta de Infocred en bolsa
		resultados.put("returnCode", 0);
		resultados.put("returnMessage", xmlResponse);

		// Proceso y devuelvo respuesta
		return processResponseProvider(resultados, null);
	}

	@Override
	public IProcedureResponse processResponseProvider(Map<Object, Object> aBagSPJavaOrchestration, String arg1) {
		IProcedureResponse procedureResponse = new ProcedureResponseWSAS();

		// Copio parametros de cabecera desde procedureRequest a procedureResponse
		CSPUtil.copyHeaderFields((IProcedureRequest) aBagSPJavaOrchestration.get("anOriginalRequest"), procedureResponse);
		procedureResponse.addParam("@o_message", 39, 1, aBagSPJavaOrchestration.get("returnMessage").toString());
		procedureResponse.addParam("@o_return", 39, 1, aBagSPJavaOrchestration.get("returnCode").toString());

		procedureResponse.addFieldInHeader(ICSP.SERVICE_EXECUTION_RESULT, ICOBISTS.HEADER_STRING_TYPE, ICSP.SUCCESS);
		return procedureResponse;
	}

	@SuppressWarnings("rawtypes")
	private boolean getConnection(Map<Object, Object> resultValues) {
		if (iService == null) {
			BICService service = null;
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION - wsUrl = [" + MyConfigurationImpl.getInfocredUrl() + "]");
			}
			try {
				service = new BICService(new URL(MyConfigurationImpl.getInfocredUrl()), new QName("http://tempuri.org/", "BICService"));
			} catch (SOAPFaultException e) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION SOAPFaultException - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "SOAPFaultException - '" + e.getFault().getFaultCode() + "' - " + e.getFault().getFaultString());
				return false;
			} catch (WebServiceException e) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION WebServiceException - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "WebServiceException - " + e.getMessage());
				return false;
			} catch (MalformedURLException e) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION MalformedURLException - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "MalformedURLException - " + e.getMessage());
				return false;
			} catch (Exception e) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION Exception - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "Exception - " + e.getMessage());
				return false;
			}

			if (logger.isDebugEnabled()) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION - Recuperar el EndPoint");
			}
			iService = service.getBasicEndPoint();

			if (logger.isDebugEnabled()) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION - Setear Seguridades");
			}
			Binding binding = ((BindingProvider) iService).getBinding();
			List<Handler> handlerList = binding.getHandlerChain();
			if (handlerList == null)
				handlerList = new ArrayList<Handler>();

			handlerList.add(new InfocredSecurityHandler());
			binding.setHandlerChain(handlerList);
		}
		return true;
	}

}