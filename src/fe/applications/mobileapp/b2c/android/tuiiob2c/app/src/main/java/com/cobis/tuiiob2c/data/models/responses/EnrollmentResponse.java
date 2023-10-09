package com.cobis.tuiiob2c.data.models.responses;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Enrollment;

public class EnrollmentResponse extends BaseModel {

    private Enrollment data;

    public EnrollmentResponse() {
    }

    public EnrollmentResponse(Enrollment data) {
        this.data = data;
    }

    public Enrollment getData() {
        return data;
    }

    public void setData(Enrollment data) {
        this.data = data;
    }
}
