package com.cobis.tuiiob2c.data.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Commission {

    @SerializedName("max")
    @Expose
    private double max;
    @SerializedName("min")
    @Expose
    private double min;
    @SerializedName("comission")
    @Expose
    private double comission;

    /**
     * No args constructor for use in serialization
     *
     */
    public Commission() {
    }

    /**
     *
     * @param min
     * @param max
     * @param comission
     */
    public Commission(double max, double min, double comission) {
        super();
        this.max = max;
        this.min = min;
        this.comission = comission;
    }

    public double getMax() {
        return max;
    }

    public void setMax(double max) {
        this.max = max;
    }

    public double getMin() {
        return min;
    }

    public void setMin(double min) {
        this.min = min;
    }

    public double getComission() {
        return comission;
    }

    public void setComission(double comission) {
        this.comission = comission;
    }

}