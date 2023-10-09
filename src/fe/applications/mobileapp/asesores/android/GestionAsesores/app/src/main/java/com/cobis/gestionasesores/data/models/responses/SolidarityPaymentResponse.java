package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 21/08/2017.
 */
public class SolidarityPaymentResponse extends GenericResponse{
    private List<SolidarityPaymentResponseItem> data;

    public List<SolidarityPaymentResponseItem> getData() {
        return data;
    }

    public SolidarityPaymentResponse setData(List<SolidarityPaymentResponseItem> data) {
        this.data = data;
        return this;
    }
}
