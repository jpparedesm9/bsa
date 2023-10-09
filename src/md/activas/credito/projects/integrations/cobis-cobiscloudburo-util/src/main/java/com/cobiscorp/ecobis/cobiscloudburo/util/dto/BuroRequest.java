package com.cobiscorp.ecobis.cobiscloudburo.util.dto;

import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Name;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Residence;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.ServerAddress;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class BuroRequest {
    private Name name;
    private Header header;
    private Residence residence;
    private ServerAddress serverAddress;

    public BuroRequest() {
    }

    public Name getName() {
        return name;
    }

    public void setName(Name name) {
        this.name = name;
    }

    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }

    public Residence getResidence() {
        return residence;
    }

    public void setResidence(Residence residence) {
        this.residence = residence;
    }

    public ServerAddress getServerAddress() {
        return serverAddress;
    }

    public void setServerAddress(ServerAddress serverAddress) {
        this.serverAddress = serverAddress;
    }

    @Override
    public String toString() {
        return "BuroRequest{" +
                "name=" + name +
                ", header=" + header +
                ", residence=" + residence +
                ", serverAddress=" + serverAddress +
                '}';
    }
}
