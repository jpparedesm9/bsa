package com.cobiscorp.ecobis.clientviewer.test.dal;

import javax.persistence.EntityManager;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.dal.IScoreDAO;
import com.cobiscorp.ecobis.clientviewer.dto.ScoreDTO;



@ContextConfiguration(locations= {"classpath:/META-INF/spring/dal-test-context.xml" })
@RunWith(SpringJUnit4ClassRunner.class)

public class TestSearchScoreClienteDAO {
	
	private static ILogger logger = LogFactory.getLogger(TestSearchScoreClienteDAO.class);
	
	
	public TestSearchScoreClienteDAO() {
		super();
	}

	@Autowired
	private IScoreDAO scoreDAOImpl;
	@Autowired
	private EntityManager entityManager;
	
	@Test
	public void testGetScoreCustomer() {
		try {
			logger.logDebug("testGetSalesApplicationData");
			ScoreDTO loanApplicationResponse = scoreDAOImpl.getScoreCustomer(10);					
			
			logger.logDebug(loanApplicationResponse);
			Assert.assertNotNull(loanApplicationResponse);
			Assert.assertTrue(loanApplicationResponse.getIdCustomer()!=null );
			Assert.assertTrue(loanApplicationResponse.getScoreHistory()!=null );
			
		} catch(Throwable ex) {
			logger.logError("ERR_TEST_GETAPPLICATION_DATABYID");
			logger.logError(ex.getMessage(),ex);
			Assert.assertTrue(false);
		}
	}
	
}
