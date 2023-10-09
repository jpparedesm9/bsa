package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by mnaunay on 08/06/2017.
 */

public class PostalCode {
    private int id;
    private int parent;
    private String name;
    private String postalCode;
    private String code;

    public PostalCode(int id, int parent, String name, String postalCode, String code) {
        this.id = id;
        this.parent = parent;
        this.name = name;
        this.postalCode = postalCode;
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public String getName() {
        return name;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        if (StringUtils.isEmpty(code)) return "";
        String[] split = code.split(",");
        return split[0];
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAdditionalCode() {
        if (StringUtils.isEmpty(code)) return "";
        String[] split = code.split(",");
        return split.length > 1 ? split[1] : "";
    }

    @Override
    public String toString() {
        return this.name;
    }
}
