package com.cobiscorp.ecobis.bpl.dao.cobis;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.CobisTable;

public interface CobisTableDao {

	CobisTable findCobisTableByTableName(String tableName) throws Exception;

}
