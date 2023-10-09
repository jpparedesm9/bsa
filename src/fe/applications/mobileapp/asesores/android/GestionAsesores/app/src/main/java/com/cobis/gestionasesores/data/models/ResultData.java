package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.responses.Message;

/**
 * Created by mnaunay on 26/07/2017.
 */

public class ResultData {
    @ResultType
    private int type;
    private Message error;
    private Object data;

    public ResultData(@ResultType int type, Message error) {
      this(type,error,null);
    }

    public ResultData(@ResultType int type, Message error, Object data) {
        this.type = type;
        this.error = error;
        this.data = data;
    }

    public @ResultType int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Message getError() {
        return error;
    }

    public String getErrorMessage(){
        if(error == null) return null;
        return error.getMessage();
    }

    public void setError(Message error) {
        this.error = error;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public void addError(Message error) {

    }
}
