package com.cobiscorp.ecobis.htm.test.api.util;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.domains.ICTSMessage;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.htm.test.api.util.interfaces.DBManager;

public class SPOrchestrator2 implements ISPOrchestrator{

	private static ILogger logger = LogFactory.getLogger(SPOrchestrator2.class);

	private org.springframework.jdbc.datasource.DriverManagerDataSource dataSource2;

	private DBManager dbManager;

	public SPOrchestrator2() {
	}

	@Override
	public int getSource() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void initialize(ICTSMessage arg0, String arg1, String arg2) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setServerParameters(ICTSMessage arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub

	}

	@Override
	public void setServiceName(ICTSMessage arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setSessionParameters(ICTSMessage arg0)
			throws CTSInfrastructureException, CTSServiceException {
		// TODO Auto-generated method stub

	}

	@Override
	public void setTRole(ICTSMessage arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setTrn(ICTSMessage arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setTsn(ICTSMessage arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void verifyFaculty(ICTSMessage arg0)
			throws CTSInfrastructureException, CTSServiceException {
		// TODO Auto-generated method stub

	}

	@Override
	public void verifyLicense() throws CTSInfrastructureException,
			CTSServiceException {
		// TODO Auto-generated method stub

	}

	@Override
	public void loadConfiguration(IConfigurationReader arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public IProcedureResponse execute(ICTSMessage arg0, String arg1, String arg2) {
		// TODO Auto-generated method stub
		IProcedureResponse response = null;
		try {
			// Connection db = dataSource2.getConnection("username",
			// "password");
			IProcedureRequest procedureRequest = (IProcedureRequest) arg0;

			response = dbManager.executeStoredProcedure(procedureRequest,
					dataSource2);
		} catch (Exception e) {
			logger.logError("Error -> "+ e);
		}
		return response;
	}

	public IProcedureResponse execute(IProcedureRequest arg0, String arg1,
			String arg2) {

		return null;
	}

	@Override
	public IProcedureResponse execute(String arg0, String arg1, String arg2) {

		return null;
	}

	@Override
	public IProcedureResponse executeSP(IProcedureRequest arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public IProcedureResponse executeSpecialSP(IProcedureRequest arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void registerFinishFrameLo(IProcedureResponse arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub

	}

	@Override
	public void registerInitialFrameLo(IProcedureRequest arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub

	}

	@Override
	public void sendTRLoggerRequest(IProcedureRequest arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub

	}

	@Override
	public void sendTRLoggerResponse(IProcedureResponse arg0)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub

	}

	public void setDataSource2(
			org.springframework.jdbc.datasource.DriverManagerDataSource dataSource2) {
		this.dataSource2 = dataSource2;
	}

	public void setDbManager(DBManager dbManager) {
		this.dbManager = dbManager;
	}

}
