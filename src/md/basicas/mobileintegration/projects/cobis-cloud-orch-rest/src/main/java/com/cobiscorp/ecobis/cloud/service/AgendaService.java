package com.cobiscorp.ecobis.cloud.service;

import com.cobiscorp.ecobis.cloud.service.dto.agenda.AgendaDataRequest;

import javax.ws.rs.core.Response;

/**
 * Created by farid on 8/2/2017.
 */
public interface AgendaService {
    Response updateAgendaStatus(AgendaDataRequest agendaDataRequest);

}
