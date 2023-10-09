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
import com.cobiscorp.ecobis.customer.bl.impl.POBoxManagerImpl;
import com.cobiscorp.ecobis.customer.dal.impl.POBoxDAOImpl;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;
import com.cobiscorp.ecobis.customer.services.impl.POBoxTxServiceImpl;

public class POBoxTest {
	private static ILogger logger = LogFactory.getLogger(CustomerTest.class);

	static POBoxTxServiceImpl customer;
	static EntityManager em;

	//@Ignore
	@Test
	public void test1() {

		try {
			logger.logDebug("test1");
			em.getTransaction().begin();
			CobisSession wCobisSession = new CobisSession("878889", "1","danipere", "3", "", "COBIS", "1", "termx", "CTSSSRV", "1");
			int ssn = (int) Math.abs(System.currentTimeMillis());
			Server wServer = new Server("CTSSRV", Integer.toString(ssn),"10/25/2013");
			CobisContext wCobisContext = new CobisContext(wCobisSession,wServer);
			//
			CustomerDataRequest request = new CustomerDataRequest();
			request.setCustomerId(1);
			List<POBoxDataResponse> poBoxes = customer.getAllPOBOX(request);
			System.out.println("****************INICIO CONSULTA DE PO BOX*****************");
			for (POBoxDataResponse poBoxResponse : poBoxes) {
				System.out.println("ente: "+poBoxResponse.getEntity());
				System.out.println("Casilla: "+poBoxResponse.getBox());
			}

			em.getTransaction().commit();
		} catch (Exception ex) {
			logger.logError(ex);
			em.getTransaction().rollback();
		}

	}

	@Before
	public void pseudoBlueprintContainerInit() {
		logger.logDebug("pseudoBlueprintContainerInit");

		customer = new POBoxTxServiceImpl();
		POBoxManagerImpl poBoxMaImpl = new POBoxManagerImpl();
		POBoxDAOImpl poBDaoImpl = new POBoxDAOImpl();
		poBoxMaImpl.setPoBoxDAO(poBDaoImpl);
		customer.setPoBoxManager(poBoxMaImpl);
		//
		Properties props = new Properties();
		props.put("openjpa.Log", "DefaultLevel=WARN,SQL=TRACE");
		props.put("openjpa.ConnectionDriverName",
				"com.sybase.jdbc3.jdbc.SybDriver");
		props.put("openjpa.ConnectionURL",
				"jdbc:sybase:Tds:192.168.64.241:5000/cobis");
		props.put("openjpa.ConnectionUserName", "sa");
		props.put("openjpa.ConnectionPassword", "sybjfq2k14");
		props.put("openjpa.poolSize", "15");
		// <property name="poolSize" value="15" />

		System.out.println("Realizo Conexion");
		EntityManagerFactory factory = Persistence.createEntityManagerFactory(
				"TestUnit", props);
		em = factory.createEntityManager();
		poBDaoImpl.setEntityManager(em);
	}

	@After
	public void pseudoBlueprintContainerClose() {
		logger.logDebug("pseudoBlueprintContainerClose");
		em.close();
	}
}
