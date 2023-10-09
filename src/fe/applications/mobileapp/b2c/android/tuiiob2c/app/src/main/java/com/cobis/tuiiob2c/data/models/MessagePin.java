/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.tuiiob2c.data.models;

import com.cobis.tuiiob2c.data.models.requests.MessageRequest;

import java.io.Serializable;

public class MessagePin extends MessageRequest implements Serializable {

    private String password;

    public MessagePin() {
    }

    public MessagePin(int messageId, String response, String password) {
        super(messageId, response);
        this.password = password;
    }

    public MessagePin(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
