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

//import com.cobiscorp.ecobis.ws.client.linkser.BICService;
//import com.cobiscorp.ecobis.ws.client.linkser.IIndividualReportServiceContract;

import com.cobiscorp.ecobis.businessprocess.connector.impl.InfocredSecurityHandler;
import com.cobiscorp.ecobis.businessprocess.connector.impl.MyConfigurationImpl;
import com.cobiscorp.ecobis.ws.client.linkser.ObjectFactory;
import com.cobiscorp.ecobis.ws.client.linkser.Service1;
import com.cobiscorp.ecobis.ws.client.linkser.IWSNet;
//import com.cobiscorp.ecobis.ws.client.linkser.Titular;
//import com.cobiscorp.ecobis.ws.client.linkser.Usuario;

import com.cobiscorp.ecobis.ws.client.linkser.LineaAprobada;
import com.cobiscorp.ecobis.ws.client.linkser.AumentoCupo;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.Exception;

import javax.xml.namespace.QName;
import javax.xml.ws.Binding;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.WebServiceException;
import javax.xml.ws.handler.Handler;
import javax.xml.ws.soap.SOAPFaultException;
import javax.xml.ws.WebServiceException;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;
import org.springframework.remoting.soap.SoapFaultException;

@Component(name = "CreditCardConnector", immediate = false)
@Service({com.cobiscorp.cobis.csp.services.ICSPExecutorConnector.class})
@Properties({
    @Property(name = "service.description", value = "CreditCardConnector"),
    @Property(name = "service.vendor", value = "COBISCORP"),
    @Property(name = "service.version", value = "1.0.0"),
    @Property(name = "service.identifier", value = "CreditCardConnector")
})
public class CreditCardConnector implements ICSPExecutorConnector {
	private static final ILogger logger = LogFactory.getLogger(CreditCardConnector.class);
	private static IWSNet iService = null;

	public void loadConfiguration(IConfigurationReader configurationReader) {
	}

	public IProcedureResponse transformAndSend(IProcedureRequest anOriginalRequest) {
		String xmlResponse = "";
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso de Tramite = [" + anOriginalRequest.readValueParam("@i_tramite") + "]");
			logger.logDebug("operacion = [" + anOriginalRequest.readValueParam("@i_operacion") + "]");
			logger.logDebug("numero de operacion = [" + anOriginalRequest.readValueParam("@i_numero_operacion") + "]");
			logger.logDebug("oficina= [" + anOriginalRequest.readValueParam("@i_oficina") + "]");
			logger.logDebug("moneda = [" + anOriginalRequest.readValueParam("@i_moneda") + "]");
			logger.logDebug("monto = [" + anOriginalRequest.readValueParam("@i_monto") + "]");
			logger.logDebug("identificacion = [" + anOriginalRequest.readValueParam("@i_titular_id") + "]");
			logger.logDebug("nombre = [" + anOriginalRequest.readValueParam("@i_titular_ente") + "]");
			logger.logDebug("titular = [" + anOriginalRequest.readValueParam("@i_titular_nombre") + "]");	
			logger.logDebug("evaluador = [" + anOriginalRequest.readValueParam("@i_oficial") + "]");
			logger.logDebug("actividad = [" + anOriginalRequest.readValueParam("@i_sector_cli") + "]");
			logger.logDebug("fecha = [" + anOriginalRequest.readValueParam("@i_fecha_aprob") + "]");
			
		}
		Map<Object, Object> resultados = new HashMap<Object, Object>();
		// Almaceno transaccion principal en bolsa
		resultados.put("anOriginalRequest", anOriginalRequest);
		
		ObjectFactory fact = new ObjectFactory();   
						
		LineaAprobada lineaAprobada = new LineaAprobada();	
		
		lineaAprobada.setPNroOperacion(fact.createLineaAprobadaPNroOperacion(anOriginalRequest.readValueParam("@i_numero_operacion")));		
		lineaAprobada.setPOficina(fact.createLineaAprobadaPOficina(anOriginalRequest.readValueParam("@i_oficina")));		
		lineaAprobada.setPMoneda(fact.createLineaAprobadaPMoneda(anOriginalRequest.readValueParam("@i_moneda")));
		lineaAprobada.setPMonto(fact.createLineaAprobadaPMonto(anOriginalRequest.readValueParam("@i_monto")));
		lineaAprobada.setPIdTitular(fact.createLineaAprobadaPIdTitular(anOriginalRequest.readValueParam("@i_titular_id")));
		lineaAprobada.setPCodigoCobis(fact.createLineaAprobadaPCodigoCobis(anOriginalRequest.readValueParam("@i_titular_ente")));
		lineaAprobada.setPNombreTitular(fact.createLineaAprobadaPNombreTitular(anOriginalRequest.readValueParam("@i_titular_nombre")));
		lineaAprobada.setPDireccion(fact.createLineaAprobadaPDireccion(anOriginalRequest.readValueParam("@i_titular_dir")));
		lineaAprobada.setPEvaluador(fact.createLineaAprobadaPEvaluador(anOriginalRequest.readValueParam("@i_oficial")));
		lineaAprobada.setPActividad(fact.createLineaAprobadaPActividad(anOriginalRequest.readValueParam("@i_sector_cli")));
		lineaAprobada.setPFechaAprobacion(fact.createLineaAprobadaPFechaAprobacion(anOriginalRequest.readValueParam("@i_fecha_aprob")));
		
		AumentoCupo aumentoCupo = new AumentoCupo();
		
		aumentoCupo.setPNroOperacion(fact.createLineaAprobadaPNroOperacion(anOriginalRequest.readValueParam("@i_numero_operacion")));		
		aumentoCupo.setPMonto(fact.createLineaAprobadaPMonto(anOriginalRequest.readValueParam("@i_monto")));
		aumentoCupo.setPIdTitular(fact.createLineaAprobadaPIdTitular(anOriginalRequest.readValueParam("@i_titular_id")));
		aumentoCupo.setPCodigoCobis(fact.createLineaAprobadaPCodigoCobis(anOriginalRequest.readValueParam("@i_titular_ente")));
		aumentoCupo.setPNombreTitular(fact.createLineaAprobadaPNombreTitular(anOriginalRequest.readValueParam("@i_titular_nombre")));
		aumentoCupo.setPDireccion(fact.createLineaAprobadaPDireccion(anOriginalRequest.readValueParam("@i_titular_dir")));
		aumentoCupo.setPEvaluador(fact.createLineaAprobadaPEvaluador(anOriginalRequest.readValueParam("@i_oficial")));
		aumentoCupo.setPActividad(fact.createLineaAprobadaPActividad(anOriginalRequest.readValueParam("@i_sector_cli")));
		aumentoCupo.setPFechaAprobacion(fact.createLineaAprobadaPFechaAprobacion(anOriginalRequest.readValueParam("@i_fecha_aprob")));
			
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
			if (anOriginalRequest.readValueParam("@i_operacion").equals("L")) {
				xmlResponse = iService.lineaAprobada(lineaAprobada.getPNroOperacion().getValue(),lineaAprobada.getPOficina().getValue(),lineaAprobada.getPMoneda().getValue(),
						                             lineaAprobada.getPMonto().getValue(), lineaAprobada.getPIdTitular().getValue(), lineaAprobada.getPCodigoCobis().getValue(),
						                             lineaAprobada.getPNombreTitular().getValue(),lineaAprobada.getPDireccion().getValue(),lineaAprobada.getPEvaluador().getValue(),
						                             lineaAprobada.getPActividad().getValue(),lineaAprobada.getPFechaAprobacion().getValue());

			} else if (anOriginalRequest.readValueParam("@i_operacion").equals("P")) {
				
				xmlResponse = iService.aumentoCupo(aumentoCupo.getPNroOperacion().getValue(),aumentoCupo.getPMonto().getValue(),aumentoCupo.getPIdTitular().getValue(),
                                                   aumentoCupo.getPCodigoCobis().getValue(), aumentoCupo.getPNombreTitular().getValue(),aumentoCupo.getPDireccion().getValue(),
                                                   aumentoCupo.getPEvaluador().getValue(),aumentoCupo.getPActividad().getValue(),aumentoCupo.getPFechaAprobacion().getValue());
                        
			}
		} catch (SoapFaultException e) {
			Thread.currentThread().setContextClassLoader(originalClassLoader);
			iService = null;
			logger.logDebug("-->> CREDITCARD-CONNECTOR => EXECUTION SOAPFaultException - Ejecución al host remoto - [" + anOriginalRequest.readValueParam("@i_operacion") + "]", e);
			resultados.put("returnCode", -2);
			resultados.put("returnMessage", "SOAPFaultException - '" + e.getFaultCode() + "' - " + e.getFaultString());
			return processResponseProvider(resultados, null);
		} catch (WebServiceException e) {
			Thread.currentThread().setContextClassLoader(originalClassLoader);
			iService = null;
			logger.logDebug("-->> CREDITCARD-CONNECTOR => EXECUTION WebServiceException - Ejecución al host remoto - [" + anOriginalRequest.readValueParam("@i_operacion") + "]", e);
			resultados.put("returnCode", -2);
			resultados.put("returnMessage", "WebServiceException - " + e.getMessage());
			return processResponseProvider(resultados, null);			
			
		} catch (Exception e) {	
			Thread.currentThread().setContextClassLoader(originalClassLoader);
			iService = null;
			logger.logDebug("-->> CREDITCARD-CONNECTOR => EXECUTION EXCEPTION - Ejecución al host remoto - [" + anOriginalRequest.readValueParam("@i_tipo_reporte") + "]", e);
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
			Service1 service = null;
			if (logger.isDebugEnabled()) {
				logger.logDebug("-->> CREDITCARD-CONNECTOR => CONEXION - wsUrl = [" + MyConfigurationImpl.getCreditCardUrl() + "]");
			}
			try {
				service = new Service1(new URL(MyConfigurationImpl.getCreditCardUrl()), new QName("http://tempuri.org/", "Service1"));
			} catch (SOAPFaultException e) {
				logger.logDebug("-->> INFOCRED-CONNECTOR => CONEXION SOAPFaultException - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "SOAPFaultException - '" + e.getFault().getFaultCode() + "' - " + e.getFault().getFaultString());
				return false;
			} catch (WebServiceException e) {
				logger.logDebug("-->> CREDITCARD-CONNECTOR => CONEXION WebServiceException - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "WebServiceException - " + e.getMessage());
				return false;
			} catch (MalformedURLException e) {
				logger.logDebug("-->> CREDITCARD-CONNECTOR => CONEXION MalformedURLException - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "MalformedURLException - " + e.getMessage());
				return false;
			} catch (Exception e) {
				logger.logDebug("-->> CREDITCARD-CONNECTOR => CONEXION Exception - Error al crear la conexión con el Host remoto", e);
				resultValues.put("ExceptionMessage", "Exception - " + e.getMessage());
				return false;
			}

			if (logger.isDebugEnabled()) {
				logger.logDebug("-->> CREDITCARD-CONNECTOR => CONEXION - Recuperar el EndPoint");
			}
			iService = service.getBasicHttpBindingIWSNet();

			/*if (logger.isDebugEnabled()) {
				logger.logDebug("-->> CREDITCARD-CONNECTOR => CONEXION - Setear Seguridades");
			}
			Binding binding = ((BindingProvider) iService).getBinding();
			List<Handler> handlerList = binding.getHandlerChain();
			if (handlerList == null)
				handlerList = new ArrayList<Handler>();

			handlerList.add(new InfocredSecurityHandler());
			binding.setHandlerChain(handlerList);*/
		}
		return true;
	}

}