/**
 * Archivo: public class SynchronizeDataDetail
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto;

import java.util.Map;
import java.util.HashMap;


public class SynchronizeDataDetail {

    private String date;

    private String entity;

    private Integer entityId;

    private Integer id;

    private Integer idSync;

    private String state;

    private String xml;

    public SynchronizeDataDetail() {
        //Empty contructor in order to build basic DTO
    }

    public SynchronizeDataDetail(Map objectMap) {

        String wDate = (String) objectMap.get("date");
        setDate(wDate);

        String wEntity = (String) objectMap.get("entity");
        setEntity(wEntity);

        Integer wEntityId = (Integer) objectMap.get("entityId");
        setEntityId(wEntityId);

        Integer wId = (Integer) objectMap.get("id");
        setId(wId);

        Integer wIdSync = (Integer) objectMap.get("idSync");
        setIdSync(wIdSync);

        String wState = (String) objectMap.get("state");
        setState(wState);

        String wXml = (String) objectMap.get("xml");
        setXml(wXml);
    }


    public Map toMap() {
        Map objectMap = new HashMap();

        String wDate = getDate();
        objectMap.put("date", wDate);

        String wEntity = getEntity();
        objectMap.put("entity", wEntity);

        Integer wEntityId = getEntityId();
        objectMap.put("entityId", wEntityId);

        Integer wId = getId();
        objectMap.put("id", wId);

        Integer wIdSync = getIdSync();
        objectMap.put("idSync", wIdSync);

        String wState = getState();
        objectMap.put("state", wState);

        String wXml = getXml();
        objectMap.put("xml", wXml);
        return objectMap;
    }

    /**
     * returns  date
     */
    public String getDate() {
        return this.date;
    }

    /**
     * returns  entity
     */
    public String getEntity() {
        return this.entity;
    }

    /**
     * returns  entityId
     */
    public Integer getEntityId() {
        return this.entityId;
    }

    /**
     * returns  id
     */
    public Integer getId() {
        return this.id;
    }

    /**
     * returns  idSync
     */
    public Integer getIdSync() {
        return this.idSync;
    }

    /**
     * returns  state
     */
    public String getState() {
        return this.state;
    }

    /**
     * returns  xml
     */
    public String getXml() {
        return this.xml;
    }

    public void setDate(String aDate) {
        this.date = aDate;
    }

    public void setEntity(String aEntity) {
        this.entity = aEntity;
    }

    public void setEntityId(Integer aEntityId) {
        this.entityId = aEntityId;
    }

    public void setId(Integer aId) {
        this.id = aId;
    }

    public void setIdSync(Integer aIdSync) {
        this.idSync = aIdSync;
    }

    public void setState(String aState) {
        this.state = aState;
    }

    public void setXml(String aXml) {
        this.xml = aXml;
    }


    @Override
    public String toString() {
        return toMap().toString();
    }
}
