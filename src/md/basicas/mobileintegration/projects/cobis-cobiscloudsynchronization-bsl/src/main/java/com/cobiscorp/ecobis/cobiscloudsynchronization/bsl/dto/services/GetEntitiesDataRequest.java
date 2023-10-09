package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services;

/**
 * Created by farid on 7/20/2017.
 */
public class GetEntitiesDataRequest {
    private String entity;
    private Integer idSync;
    private Integer page;
    private Integer perPage;

    public GetEntitiesDataRequest() {
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public Integer getIdSync() {
        return idSync;
    }

    public void setIdSync(Integer idSync) {
        this.idSync = idSync;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPerPage() {
        return perPage;
    }

    public void setPerPage(Integer perPage) {
        this.perPage = perPage;
    }
}
