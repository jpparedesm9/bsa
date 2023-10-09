package com.cobiscorp.ecobis.customer.commons.web.services.test;

import java.util.Date;
import java.util.LinkedHashMap;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;

public class TestTest {
	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		System.out.println("LOGIN CTS: "+util.doLogin());
	}

	@Test
	@Ignore
	public void method1() {
		try{
			System.out.println("BUSQUEDA DE CLIENTE");
			SearchCustomerDTO searchCust=new SearchCustomerDTO();			
			searchCust.setMode(0);
			searchCust.setType(1);
			searchCust.setClientNumber(1);
			searchCust.setSubType("P");
			searchCust.setSize(10);
			
			String requestJSON =  util.serializeJson(searchCust);
	        System.out.println("TRAMA ENVIADA: "+searchCust);
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getCustomersByParameters", requestJSON);
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	@Test
	@Ignore
	public void getGroup() {
		try{
			System.out.println("BUSQUEDA DE GRUPO");
			SearchGroupDTO searchGrp=new SearchGroupDTO();			
			searchGrp.setGroupCode(17);
			searchGrp.setSearchMode(2);
			searchGrp.setTypeValue(1);
			
			String requestJSON =  util.serializeJson(searchGrp);
	        System.out.println("TRAMA ENVIADA: "+requestJSON);
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getGroup", requestJSON);
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	@Test
	@Ignore
	public void getClient() {
		try{
			System.out.println("BUSQUEDA DE CLIENTE");			
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getCustomer/"+1, "");
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	
	@Test
	@Ignore
	public void getGroupMembers() {
		try{
			System.out.println("MIEMBROS DE GRUPO ECO.");			
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getGroupMembers/"+17, "");
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	@Test
	@Ignore
	public void getCustomerType() {
		try{
			System.out.println("BUSQUEDA TIPO CLIENTE");			
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getCustomerType/"+1, "");
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	
	@Test
	@Ignore
	public void getCustomerRate() {
		try{
			System.out.println("BUSQUEDA DE CALIFICACION");			
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getCustomerRate/"+1, "");
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	@Test
	@Ignore
	public void getGroupDetail() {
		try{
			System.out.println("Detalle de Grupo");			
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getGroupDetail/"+17, "");
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}
	@Test
	@Ignore
	public void getLegalClient() {
		try{
			System.out.println("LEGAL CLIENT");			
	        
	        String responseJSON = util.sendHttpPut("CustomerCommons/getLegalCustomer/"+1, "");
	        
	        System.out.println("TRAMA RECIBIDA: "+responseJSON);
	        ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
	        Assert.assertNotNull(serviceResponse);	        	        
        } catch (Throwable ex) {                        
                System.out.println("Error al registrar la prueba");
                System.out.println("error:" + ex);
                Assert.assertTrue(false);
         }
	}

	@After
	public void tearDown() {

	}

}
