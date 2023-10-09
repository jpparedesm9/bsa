/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.tuiiob2c.data.models.requests;

import java.io.Serializable;

public class MessageRequest implements Serializable {
    private int messageId;
    private String response;

    public MessageRequest() {
    }

    public MessageRequest(int messageId, String response) {
        this.messageId = messageId;
        this.response = response;
    }

    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }
}
