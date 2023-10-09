package com.cobiscorp.ecobis.customer.services.test;

import java.util.List;
import java.util.Properties;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.ecobis.customer.bl.impl.PhoneManagerImpl;
import com.cobiscorp.ecobis.customer.dal.impl.PhoneDAOImpl;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;
import com.cobiscorp.ecobis.customer.services.impl.PhoneTxServiceImpl;

public class PhoneTestService {

private static ILogger logger = LogFactory.getLogger(PhoneTestService.class);
	
	static PhoneTxServiceImpl phone;
	static EntityManager em;
	
	//@Ignore
	@Test
	public void Test() {

		try {
			logger.logDebug("Inicio de Prueba");
			em.getTransaction().begin();
			CobisSession wCobisSession = new CobisSession("878889", "1","danipere", "3", "", "COBIS", "1", "termx", "CTSSSRV", "1");
			int ssn = (int) Math.abs(System.currentTimeMillis());
			Server wServer = new Server("CTSSRV", Integer.toString(ssn),"10/25/2013");
			CobisContext wCobisContext = new CobisContext(wCobisSession,wServer);
			System.out.println(wCobisContext);
			PhoneDataRequest request = new PhoneDataRequest();
			request.setAddressId(1);
			request.setCustomerID(76);
			System.out.println("***********INICIO BUSQUEDA DE TELEFONOS************");
			List<PhoneDataResponse> phoneResp = phone.getPhonebyCustomerAndAddress(request);
			for (PhoneDataResponse phoneDataResponse : phoneResp) {
				System.out.println(phoneDataResponse.getAddress());
				System.out.println(phoneDataResponse.getDateModified());
				
			}
		
			System.out.println("************FIN BUSQUEDA DE TELEFONOS**************");
			em.getTransaction().commit();
		} catch (Exception ex) {
			logger.logError(ex);
			em.getTransaction().rollback();
		}
	}
	
	@Before
	public void pseudoBlueprintContainerInit() {
		logger.logDebug("pseudoBlueprintContainerInit");
		phone = new PhoneTxServiceImpl();
		PhoneManagerImpl phoneManagerImpl = new PhoneManagerImpl();
		PhoneDAOImpl phoneDAOImpl = new PhoneDAOImpl();		
		phoneManagerImpl.setPhoneDAO(phoneDAOImpl);//INYECTA
		phone.setPhoneManager(phoneManagerImpl);	

		Properties props = new Properties();
		props.put("openjpa.Log", "DefaultLevel=WARN,SQL=TRACE");
		props.put("openjpa.ConnectionDriverName",
				"com.sybase.jdbc3.jdbc.SybDriver");
		props.put("openjpa.ConnectionURL",
				"jdbc:sybase:Tds:192.168.64.241:5000/cobis");
		props.put("openjpa.ConnectionUserName", "sa");
		props.put("openjpa.ConnectionPassword", "sybjfq2k14");
		props.put("openjpa.poolSize", "15");

		System.out.println("Realizo Conexion");
		EntityManagerFactory factory = Persistence.createEntityManagerFactory(
				"TestUnit", props);
		em = factory.createEntityManager();
		phoneDAOImpl.setEntityManager(em);
	}

	@After
	public void pseudoBlueprintContainerClose() {
		logger.logDebug("pseudoBlueprintContainerClose");
		em.close();
	}
	
}
