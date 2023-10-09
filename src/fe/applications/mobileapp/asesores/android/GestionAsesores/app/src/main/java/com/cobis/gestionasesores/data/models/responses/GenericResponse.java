package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.Constants;

import java.util.List;

public class GenericResponse {
    private boolean result;
    private List<Message> messages;

    public boolean isResult() {
        return result;
    }

    public void setResult(boolean result) {
        this.result = result;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    public Message getFirstMessage() {
        if (result) {
            if (messages == null || messages.isEmpty()) {
                return null;
            } else {
                Message message = messages.get(0);
                if (Constants.WARNING_SERVER_CODE.equalsIgnoreCase(message.getCode()))  {
                    return message;
                }
                return null;
            }
        } else {
            if (messages == null || messages.isEmpty()) {
                return null;
            } else {
                return messages.get(0);
            }
        }
    }
}
