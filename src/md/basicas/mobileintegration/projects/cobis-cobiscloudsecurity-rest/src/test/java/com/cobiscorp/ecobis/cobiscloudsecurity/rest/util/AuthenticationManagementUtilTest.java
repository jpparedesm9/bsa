package com.cobiscorp.ecobis.cobiscloudsecurity.rest.util;

import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.cts.webtoken.impl.Activator;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceStatus;
import com.cobiscorp.ecobis.cobiscloudsecurity.rest.dto.common.AuthenticationStatus;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.Response;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class AuthenticationManagementUtilTest {
    Map<String, Object> loginRequest;
    ICobisParameter cobisParameter;
    HttpSession session;
    HttpServletRequest httpRequest;
    ServiceResponse serviceResponse;
    @Before
    public void setup() {
        System.setProperty("COBIS_HOME", "COBIS_HOME");
        Activator.loadConfig();
        serviceResponse = new ServiceResponse();
        loginRequest = new HashMap<String, Object>();
        loginRequest.put("channel", 20);
        cobisParameter = mock(ICobisParameter.class);
        session = mock(HttpSession.class);

        httpRequest = mock(HttpServletRequest.class);
        when(session.getAttribute(AuthenticationManagementUtil.COBIS_SESSION_ID)).thenReturn("id1ofsession");
        when(httpRequest.getSession()).thenReturn(session);

        when(cobisParameter.getParameter(
                null, "ADM", "MOBIDT", Long.class)).thenReturn(700L);

    }

    @Test
    public void itShouldGetErrorGeneral() {
        Message message = new Message();
        message.setCode("80000");
        message.setMessage("El valor no está configurado para el número de parámetro 0");
        serviceResponse.setMessages(Arrays.asList(message));
        AuthenticationStatus authenticationStatus = AuthenticationManagementUtil.getResponseFromInitSession(serviceResponse);
        Assert.assertEquals(AuthenticationStatus.CREDENCIALES_INVALIDAS.getErrorCode(),
                authenticationStatus.getErrorCode());
        Assert.assertEquals(AuthenticationStatus.CREDENCIALES_INVALIDAS.getMessage(),
                authenticationStatus.getMessage());
    }

    @Test
    public void itShouldGetUsuarioEstaSiendoUtilizado() {
        Message message = new Message();
        message.setCode("80000");
        message.setMessage("Usuario: admuser fue registrado anteriormente en A.B");
        serviceResponse.setMessages(Arrays.asList(message));
        AuthenticationStatus authenticationStatus = AuthenticationManagementUtil.getResponseFromInitSession(serviceResponse);
        Assert.assertEquals(AuthenticationStatus.USUARIO_USADO_EN_OTRO_DISPOSITIVO.getErrorCode(),
                authenticationStatus.getErrorCode());
        Assert.assertEquals(AuthenticationStatus.USUARIO_USADO_EN_OTRO_DISPOSITIVO.getMessage(),
                authenticationStatus.getMessage());
    }

    @Test
    public void itShouldGetPasswordCaducado() {
        Message message = new Message();
        message.setCode("80000");
        message.setMessage("Usuario tiene password caducado");
        serviceResponse.setMessages(Arrays.asList(message));
        AuthenticationStatus authenticationStatus = AuthenticationManagementUtil.getResponseFromInitSession(serviceResponse);
        Assert.assertEquals(AuthenticationStatus.PASSWORD_CADUCADO.getErrorCode(),
                authenticationStatus.getErrorCode());
        Assert.assertEquals(AuthenticationStatus.PASSWORD_CADUCADO.getMessage(),
                authenticationStatus.getMessage());

    }

    @Test
    public void itShouldGetUsuarioBloqueado() {
        Message message = new Message();
        message.setCode("80000");
        message.setMessage("Usuario esta bloqueado. Solicite AUTORIZACION");
        serviceResponse.setMessages(Arrays.asList(message));
        AuthenticationStatus authenticationStatus = AuthenticationManagementUtil.getResponseFromInitSession(serviceResponse);
        Assert.assertEquals(AuthenticationStatus.USUARIO_BLOQUEADO.getErrorCode(),
                authenticationStatus.getErrorCode());
        Assert.assertEquals(AuthenticationStatus.USUARIO_BLOQUEADO.getMessage(),
                authenticationStatus.getMessage());

    }

    @Test
    public void itShouldGetSuccessResponse() {

        DeviceStatus deviceStatus = new DeviceStatus();
        deviceStatus.setStatus("R");
        deviceStatus.setLock(false);
        deviceStatus.setProceedToCompleteRegistration(false);
        serviceResponse.setData(deviceStatus);
        serviceResponse.setResult(true);

        Response response = AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse,
                 cobisParameter, httpRequest, loginRequest);
        ServiceResponse serviceResponseAuth = (ServiceResponse)response.getEntity();
        Map<String, Object> loginResponseResult = (Map<String, Object>) serviceResponseAuth.getData();
        Assert.assertEquals(700, loginResponseResult.get("idleTimeout"));
        Assert.assertNotNull(loginResponseResult.get("token"));
        Assert.assertFalse( (Boolean)loginResponseResult.get("proceedToCompleteRegistration"));
        Assert.assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
    }

    @Test
    public void itShouldGetErrorEnRegistro() {
        serviceResponse.setResult(false);
        Response response = AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse,
                cobisParameter, httpRequest, loginRequest);
        ServiceResponse serviceResponseAuth = (ServiceResponse)response.getEntity();
        Assert.assertFalse(serviceResponseAuth.isResult());
        Assert.assertNull(serviceResponseAuth.getData());
        Assert.assertEquals(Integer.toString(AuthenticationStatus.PROBLEMAS_AL_OBTENER_REGISTRO.getErrorCode() ),
                serviceResponseAuth.getMessages().get(0).getCode());
        Assert.assertEquals(Response.Status.UNAUTHORIZED.getStatusCode(), response.getStatus());
    }

    @Test
    public void itShouldGetSuccessResponseProceedToRegister() {
        DeviceStatus deviceStatus = new DeviceStatus();
        deviceStatus.setStatus(AuthenticationManagementUtil.PRE_REGISTERED);
        deviceStatus.setProceedToCompleteRegistration(true);
        deviceStatus.setLock(false);
        serviceResponse.setData(deviceStatus);
        serviceResponse.setResult(true);

        Response response = AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse,
                cobisParameter, httpRequest, loginRequest);
        ServiceResponse serviceResponseAuth = (ServiceResponse)response.getEntity();
        Map<String, Object> loginResponseResult = (Map<String, Object>) serviceResponseAuth.getData();
        Assert.assertEquals(700, loginResponseResult.get("idleTimeout"));
        Assert.assertTrue( (Boolean)loginResponseResult.get("proceedToCompleteRegistration"));
        Assert.assertNotNull(loginResponseResult.get("token"));
        Assert.assertEquals(Response.Status.OK.getStatusCode(), response.getStatus());
    }

    @Test
    public void itShouldGetErrorDispositivoNoRegistrado() {
        serviceResponse.setResult(true);
        serviceResponse.setData(null);
        Response response = AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse,
                cobisParameter, httpRequest, loginRequest);

        ServiceResponse serviceResponseAuth = (ServiceResponse)response.getEntity();
        Assert.assertFalse(serviceResponseAuth.isResult());
        Assert.assertNull(serviceResponseAuth.getData());
        Assert.assertEquals(Integer.toString(AuthenticationStatus.DISPOSITIVO_NO_REGISTRADO.getErrorCode() ),
                serviceResponseAuth.getMessages().get(0).getCode());
        Assert.assertEquals(Response.Status.UNAUTHORIZED.getStatusCode(), response.getStatus());
    }

    @Test
    public void itShouldGetErrorDispositivoBloqueado() {
        DeviceStatus deviceStatus = new DeviceStatus();
        deviceStatus.setStatus(AuthenticationManagementUtil.REGISTERED);
        deviceStatus.setLock(true);
        deviceStatus.setProceedToClearData(false);
        deviceStatus.setProceedToCompleteRegistration(false);

        serviceResponse.setResult(true);
        serviceResponse.setData(deviceStatus);
        Response response = AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse,
                cobisParameter, httpRequest, loginRequest);

        ServiceResponse serviceResponseAuth = (ServiceResponse)response.getEntity();
        Assert.assertFalse(serviceResponseAuth.isResult());
        Assert.assertNull(serviceResponseAuth.getData());
        Assert.assertEquals(Integer.toString(AuthenticationStatus.DISPOSITIVO_BLOQUEADO.getErrorCode() ),
                serviceResponseAuth.getMessages().get(0).getCode());
        Assert.assertEquals(Response.Status.UNAUTHORIZED.getStatusCode(), response.getStatus());
    }

    @Test
    public void itShouldGetErrorDispositivoBloqueadoLimpiarData() {
        DeviceStatus deviceStatus = new DeviceStatus();
        deviceStatus.setStatus(AuthenticationManagementUtil.REGISTERED);
        deviceStatus.setLock(true);
        deviceStatus.setProceedToClearData(true);
        deviceStatus.setProceedToCompleteRegistration(false);

        serviceResponse.setResult(true);
        serviceResponse.setData(deviceStatus);
        Response response = AuthenticationManagementUtil.getResponseFromDeviceStatus(serviceResponse,
                cobisParameter, httpRequest, loginRequest);

        ServiceResponse serviceResponseAuth = (ServiceResponse)response.getEntity();
        Assert.assertFalse(serviceResponseAuth.isResult());
        Assert.assertNull(serviceResponseAuth.getData());
        Assert.assertEquals(Integer.toString(
                AuthenticationStatus.DISPOSITIVO_BLOQUEADO_LIMPIAR_DATA.getErrorCode() ),
                serviceResponseAuth.getMessages().get(0).getCode());
        Assert.assertEquals(Response.Status.UNAUTHORIZED.getStatusCode(), response.getStatus());
    }

}