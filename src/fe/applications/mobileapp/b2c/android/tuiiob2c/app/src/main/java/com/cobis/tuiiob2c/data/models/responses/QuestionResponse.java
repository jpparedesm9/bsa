package com.cobis.tuiiob2c.data.models.responses;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.Question;

import java.util.List;

public class QuestionResponse extends BaseModel {

    private List<Question> data;

    public QuestionResponse() {
    }

    public List<Question> getData() {
        return data;
    }

    public void setData(List<Question> data) {
        this.data = data;
    }
}
