package com.cobiscorp.ecobis.collateral.dto;

import java.io.Serializable;

public class GridColumn implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;
	private String title;
	private String field;
	private Boolean isMandatory;
	private int order;
	private Character type;
	private String width;
	private String style;
	private String format;

	public GridColumn() {
	}

	public GridColumn(String field, String title, String width, String format) {
		this.title = title;
		this.field = field;
		this.width = width;
		this.format = format;
	}

	public GridColumn(String id, String title, String field, Boolean isMandatory, Integer order, Character type, String width, String style, String format) {
		this.id = id;
		this.title = title;
		this.field = field;
		this.isMandatory = isMandatory;
		this.order = order;
		this.type = type;
		this.width = width;
		this.style = style;
		this.format = format;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public Boolean getIsMandatory() {
		return isMandatory;
	}

	public void setIsMandatory(Boolean isMandatory) {
		this.isMandatory = isMandatory;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

}