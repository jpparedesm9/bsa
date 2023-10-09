package com.cobiscorp.ecobis.busin.enums;

import com.cobiscorp.cobis.cts.domains.ICTSTypes;

public enum ParameterType {

	CHAR(ICTSTypes.SQLCHAR), VARCHAR(ICTSTypes.SQLVARCHAR), INT_2(ICTSTypes.SQLINT2), INT_4(ICTSTypes.SQLINT4), DECIMAL(ICTSTypes.SQLDECIMAL), DATETIME(
			ICTSTypes.SQLDATETIME);

	private ParameterType(int dataType) {
		this.dataType = dataType;
	}

	private int dataType;

	/**
	 * @return the dataType
	 */
	public int getDataType() {
		return dataType;
	}

	/**
	 * @param dataType
	 *            the dataType to set
	 */
	public void setDataType(int dataType) {
		this.dataType = dataType;
	}

}
