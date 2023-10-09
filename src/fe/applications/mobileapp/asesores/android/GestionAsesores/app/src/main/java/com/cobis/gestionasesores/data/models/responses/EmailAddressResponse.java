package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.EmailAddress;

/**
 * Created by bqtdesa02 on 7/28/2017.
 */

public class EmailAddressResponse extends GenericResponse {

    private EmailAddress data;

    public EmailAddress getData() {
        return data;
    }

    public void setData(EmailAddress data) {
        this.data = data;
    }
}
