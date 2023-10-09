package com.cobiscorp.mobile.services.impl.security.dto;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;

import cobiscorp.ecobis.commons.dto.MessageTO;

/**
 * <p>Java class for CTSServiceResponseTO complex type.
 * <p>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;complexType name="CTSServiceResponseTO">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="success" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/>
 *         &lt;element name="messages" type="{http://dto2.commons.ecobis.cobiscorp}MessageTO" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CTSServiceResponseTO", namespace = "http://dto2.sdf.cts.cobis.cobiscorp.com", propOrder = {
        "success",
        "messages"
})
@XmlSeeAlso({
})
public class CTSServiceResponseTO
        implements Serializable {

    private final static long serialVersionUID = 1L;
    protected Boolean success;
    @XmlElement(nillable = true)
    protected MessageTO[] messages;

    /**
     * Gets the value of the success property.
     *
     * @return possible object is
     * {@link Boolean }
     */
    public Boolean isSuccess() {
        return success;
    }

    /**
     * Sets the value of the success property.
     *
     * @param value allowed object is
     *              {@link Boolean }
     */
    public void setSuccess(Boolean value) {
        this.success = value;
    }

    /**
     * @return array of
     * {@link MessageTO }
     */
    public MessageTO[] getMessages() {
        if (this.messages == null) {
            return new MessageTO[0];
        }
        MessageTO[] retVal = new MessageTO[this.messages.length];
        System.arraycopy(this.messages, 0, retVal, 0, this.messages.length);
        return (retVal);
    }

    /**
     * @return one of
     * {@link MessageTO }
     */
    public MessageTO getMessages(int idx) {
        if (this.messages == null) {
            throw new IndexOutOfBoundsException();
        }
        return this.messages[idx];
    }

    public int getMessagesLength() {
        if (this.messages == null) {
            return 0;
        }
        return this.messages.length;
    }

    /**
     * @param values allowed objects are
     *               {@link MessageTO }
     */
    public void setMessages(MessageTO[] values) {
        int len = values.length;
        this.messages = ((MessageTO[]) new MessageTO[len]);
        for (int i = 0; (i < len); i++) {
            this.messages[i] = values[i];
        }
    }

    /**
     * @param value allowed object is
     *              {@link MessageTO }
     */
    public MessageTO setMessages(int idx, MessageTO value) {
        return this.messages[idx] = value;
    }

}
