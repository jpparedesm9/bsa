package com.cobis.tuiiob2c.data.models.responses;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.CommissionTable;

public class ParametersResponse extends BaseModel {

    private CommissionTable data;

    public ParametersResponse() {
    }

    public ParametersResponse(CommissionTable data) {
        this.data = data;
    }

    public CommissionTable getData() {
        return data;
    }

    public void setData(CommissionTable data) {
        this.data = data;
    }
}
