package com.cobiscorp.ecobis.cloud.service.util;

import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class RestServiceBaseTest {

    @Test
    public void itShouldProcessTheMessagesWithCodes() {
        String spMessage = "[1009][sp_crear_integrante] Validar numero &apos; de integrantes  ";
        Message message = new Message();
        message.setMessage(spMessage);
        message.setCode("500000");

        RestServiceBase.processMessage(message);

        assertEquals("1009", message.getCode());
        assertEquals("Validar numero ' de integrantes", message.getMessage());
    }

    @Test
    public void itShouldProcessTheMessageWithouCodes() {
        String spMessage = " Validar numero &apos; de integrantes";
        Message message = new Message();
        message.setMessage(spMessage);
        message.setCode("500000");

        RestServiceBase.processMessage(message);

        assertEquals("500000", message.getCode());
        assertEquals("Validar numero ' de integrantes", message.getMessage());
    }

    @Test
    public void itShouldRemovePrintMessage() {
        List<Message> messages = new ArrayList<Message>();
        messages.add(createMessage("5000", "Message error 5000"));
        messages.add(createMessage("0", "Print message"));

        ServiceResponse response = new ServiceResponse();
        response.setMessages(messages);
        response.setResult(false);
        RestServiceBase.clearCodesInMessages(response);

        assertEquals(1, response.getMessages().size());
        assertEquals("5000", response.getMessages().get(0).getCode());
    }

    private Message createMessage(String code, String message) {
        Message object = new Message();
        object.setMessage(message);
        object.setCode(code);
        return object;
    }

}
