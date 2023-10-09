package com.cobiscorp.mobile.model.fingerid;

public class FingerResponseNode {
    private Response response;
    private Signature signature;
    private TimeStamp timeStamp;
    private String hash;

    public Response getResponse() {
        return response;
    }
    public void setResponse(Response response) {
        this.response = response;
    }

    public Signature getSignature() {
        return signature;
    }
    public void setSignature(Signature signature) {
        this.signature = signature;
    }

    public TimeStamp getTimeStamp() {
        return timeStamp;
    }
    public void setTimeStamp(TimeStamp timeStamp) {
        this.timeStamp = timeStamp;
    }

    public String getHash() {
        return hash;
    }
    public void setHash(String hash) {
        this.hash = hash;
    }

}
