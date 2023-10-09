package com.cobiscorp.ecobis.cloud.service.util;

/**
 * Created by ntrujillo on 20/07/2017.
 */
public enum ParameterType {
    CHAR(47),
    VARCHAR(39),
    INT_2(52),
    INT_4(56),
    DECIMAL(106),
    DATETIME(61);

    private int dataType;

    private ParameterType(int dataType) {
        this.dataType = dataType;
    }

    public int getDataType() {
        return this.dataType;
    }

    public void setDataType(int dataType) {
        this.dataType = dataType;
    }
}