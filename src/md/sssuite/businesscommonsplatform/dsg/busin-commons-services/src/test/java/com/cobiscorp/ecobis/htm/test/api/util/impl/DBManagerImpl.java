package com.cobiscorp.ecobis.htm.test.api.util.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Types;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureRequestParam;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRowColumnData;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetBlock;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetData;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetHeader;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetHeaderColumn;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetRow;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetRowColumnData;
import com.cobiscorp.ecobis.htm.test.api.util.dtos.SybTypes;
import com.cobiscorp.ecobis.htm.test.api.util.interfaces.DBManager;

public class DBManagerImpl implements DBManager {
	private static ILogger logger = LogFactory.getLogger(DBManagerImpl.class);
	public String[][] MapArray(IResultSetBlock rsbo) {
		IResultSetData rsd = rsbo.getData();
		List<IResultSetRow> rows = rsd.getRows();

		int rowNumber = rsd.getRowsNumber(), i = 0;
		int colNumber = rsbo.getMetaData().getColumnsNumber(), j = 0;

		String resp[][] = new String[colNumber][rowNumber];

		for (Object rw : rows) {
			IResultSetRow row = (IResultSetRow) rw;
			List<IResultSetRowColumnData> cols = row.getColumns();
			j = 0;
			for (Object col : cols) {
				IResultSetRowColumnData coldata = (IResultSetRowColumnData) col;
				resp[j][i] = coldata.getValue();
				j++;
			}
			i++;
		}
		return resp;
	}

	public IProcedureResponse executeStoredProcedure(IProcedureRequest request,
			DriverManagerDataSource dataSource) {
		IProcedureResponse resp = new ProcedureResponseAS();
		return executeStoredProcedure(request, resp, dataSource);
	}

	public IProcedureResponse executeStoredProcedure(IProcedureRequest request,
			IProcedureResponse response, DriverManagerDataSource dataSource) {
		DataSource ds;
		Connection con = null;

		try {
			con = dataSource.getConnection(dataSource.getUsername(), dataSource.getPassword());
		} catch (SQLException e1) {
			logger.logError("Error -> "+ e1);
		}

		ProcedureResponseAS resp;

		if (response == null)
			resp = new ProcedureResponseAS();
		else
			resp = (ProcedureResponseAS) response;

		boolean moreResults = false;

		CallableStatement cb = createCallableStatement(request, con, resp);

		if (cb == null) {
			resp.addMessage(9999, "Conection error");
			return resp;
		}

		try {
			moreResults = cb.execute();
			checkWarninig(resp, cb, null);
			processResultSets(moreResults, resp, cb);
		} catch (SQLException e) {
			logger.logError("Error -> "+ e);
			resp.addMessage(e.getErrorCode(), e.getMessage());
		}

		try {
			processOutputParams(resp, request, cb);
			resp.setReturnCode(cb.getInt(1));
			cb.close();
			con.close();
		} catch (SQLException e) {
			logger.logError("Error -> "+ e);
			resp.addMessage(e.getErrorCode(), e.getMessage());
		}
		return resp;
	}

	private CallableStatement createCallableStatement(
			IProcedureRequest request, Connection con, ProcedureResponseAS resp) {
		CallableStatement cb = null;
		StringBuffer statement = new StringBuffer(500);
		boolean firstParam = true;

		statement.append("{?=call ");
		statement.append(request.getSpName());

		if (request.getParams().size() > 0) {
			statement.append("(");
			for (Object param : request.getParams()) {
				IProcedureRequestParam par = (IProcedureRequestParam) param;

				if (!firstParam)
					statement.append(", ");
				else
					firstParam = false;

				if (par.getIOType() != 0)
					statement.append(par.getName() + "=? out");
				else
					statement.append(par.getName() + "=?");

			}
			statement.append(")");
		}
		statement.append("}");

		System.out.println("Stored procedure: " + statement.toString());

		try {
			cb = con.prepareCall(statement.toString(),
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);

			cb.registerOutParameter(1, Types.INTEGER);

			@SuppressWarnings("unchecked")
			Iterator<IProcedureRequestParam> it = request.getParams()
					.iterator();
			for (int i = 2; it.hasNext(); i++) {
				IProcedureRequestParam par = it.next();
				int type = SybTypes.mapSyb2JDBCTypes(par.getDataType());

				if (par.getValue() != null && par.getValue().length() != 0) {
					cb.setObject(i, par.getValue(), type);
				} else
					cb.setNull(i, type);

				if (par.getIOType() != 0) {
					cb.registerOutParameter(i,
							SybTypes.mapSyb2JDBCTypes(par.getDataType()));
				}
			}

		} catch (SQLException e) {
			logger.logError("Error -> "+ e);
			resp.addMessage(e.getErrorCode(), e.getMessage());
		}
		return cb;
	}

	private void checkWarninig(ProcedureResponseAS resp, CallableStatement cb,
			ResultSet rs) throws SQLException {
		if (cb == null)
			return;
		SQLWarning warning;

		if (cb != null) {
			warning = cb.getWarnings();
			if (warning != null)
				resp.addMessage(warning.getErrorCode(), warning.getMessage());
			cb.clearWarnings();
		}

		if (rs != null) {
			warning = rs.getWarnings();
			if (warning != null)
				resp.addMessage(warning.getErrorCode(), warning.getMessage());
			rs.clearWarnings();
		}

	}

	private void processOutputParams(ProcedureResponseAS resp,
			IProcedureRequest request, CallableStatement cb) {
		if (cb == null)
			return;
		@SuppressWarnings("unchecked")
		Iterator<IProcedureRequestParam> it = request.getParams().iterator();
		for (int i = 2; it.hasNext(); i++) {
			IProcedureRequestParam par = it.next();
			int type = par.getDataType();

			if (par.getIOType() != 0) {
				try {
					resp.addParam(par.getName(), type, par.getLen(),
							cb.getString(i));
				} catch (SQLException e) {
					logger.logError("Error -> "+ e);
					resp.addMessage(e.getErrorCode(), e.getMessage());
				}

			}

		}

	}

	private void processResultSets(boolean moreResults,
			ProcedureResponseAS resp, CallableStatement cb) {
		int updateCount = 0;

		if (cb == null)
			return;

		while (true) {
			try {
				if (!moreResults) {
					updateCount = cb.getUpdateCount();
					moreResults = cb.getMoreResults();
					checkWarninig(resp, cb, null);
				}

				// System.out.println("XX:" + moreResults+ ", "+updateCount);

				if (updateCount == -1)
					break;

				if (!moreResults)
					continue;

			} catch (SQLException e) {
				logger.logError("Error -> "+ e);
				resp.addMessage(e.getErrorCode(), e.getMessage());
				break;
			}

			try {
				ResultSet rs = cb.getResultSet();
				checkWarninig(resp, cb, rs);
				if (rs == null)
					return;
				ResultSetMetaData md = rs.getMetaData();

				ResultSetHeader rh = new ResultSetHeader();
				for (int i = 0; i < md.getColumnCount(); i++) {
					ResultSetHeaderColumn rhc = new ResultSetHeaderColumn(
							md.getColumnName(i + 1),
							SybTypes.mapJDBC2SybTypes(md.getColumnType(i + 1)),
							md.getColumnDisplaySize(i + 1));
					rh.addColumnMetaData(rhc);
				}

				ResultSetData rsd = new ResultSetData();
				while (rs.next()) {
					ResultSetRow rsrw = new ResultSetRow();
					for (int i = 0; i < md.getColumnCount(); i++) {
						ResultSetRowColumnData rscd = new ResultSetRowColumnData(
								false, rs.getString(i + 1));
						rsrw.addRowData(i + 1, rscd);
					}
					rsd.addRow(rsrw);
				}

				ResultSetBlock rsb = new ResultSetBlock(rh, rsd);
				resp.addResponseBlock(rsb);
				rs.close();

				while (true) {
					try {
						moreResults = cb.getMoreResults();
						break;
					} catch (SQLException e) {
						logger.logError("Error -> "+ e);
						resp.addMessage(e.getErrorCode(), e.getMessage());
					}
				}

			} catch (SQLException e) {
				logger.logError("Error -> "+ e);
				resp.addMessage(e.getErrorCode(), e.getMessage());
			}
		}
	}

}
