package com.cobiscorp.ecobis.htm.test.api.util.interfaces;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;

public interface DBManager {
	public IProcedureResponse executeStoredProcedure(IProcedureRequest request,
			DriverManagerDataSource dataSource);

	public IProcedureResponse executeStoredProcedure(IProcedureRequest request,
			IProcedureResponse response, DriverManagerDataSource dataSource);

	public String[][] MapArray(IResultSetBlock rsbo);
}
