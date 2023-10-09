package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cloud.service.dto.agenda.Agenda;
import com.cobiscorp.ecobis.cloud.service.dto.agenda.AgendaData;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * Created by farid on 8/1/2017.
 */
@XmlRootElement(name = "agendaSynchronizedData")
public class AgendaSynchronizationData {
    private AgendaData agendaData;

    public AgendaSynchronizationData() {
    }

    public AgendaData getAgendaData() {
        return agendaData;
    }

    public void setAgendaData(AgendaData agendaData) {
        this.agendaData = agendaData;
    }
}
