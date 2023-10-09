package com.cobis.cloud.sofom.service.seguros.dto;

import java.util.List;

public class CollectionResponse {

    public List<Collection> getPagos() {
	return pagos;
    }

    public void setPagos(List<Collection> pagos) {
	this.pagos = pagos;
    }

    private List<Collection> pagos;

    @Override
    public String toString() {
	return "CollectionResponse [pagos=" + pagos + "]";
    }

}
