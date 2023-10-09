package com.cobiscorp.mobile.model;

import java.util.Objects;

public class SecurityImageItem {

	private String imgData;
	private int imgId;
	private String imgAlias;
	private String imgLegend;

	public SecurityImageItem() {
		super();
	}

	public String getImgData() {
		return imgData;
	}

	public void setImgData(String imgData) {
		this.imgData = imgData;
	}

	public int getImgId() {
		return imgId;
	}

	public void setImgId(int imgId) {
		this.imgId = imgId;
	}

	public String getImgAlias() {
		return imgAlias;
	}

	public void setImgAlias(String imgAlias) {
		this.imgAlias = imgAlias;
	}	

	public String getImgLegend() {
		return imgLegend;
	}

	public void setImgLegend(String imgLegend) {
		this.imgLegend = imgLegend;
	}

	@Override
	public int hashCode() {
		return Objects.hash(imgData, imgId, imgAlias);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SecurityImageItem other = (SecurityImageItem) obj;
		return Objects.equals(this.imgAlias, other.imgAlias) && Objects.equals(this.imgData, other.imgData)
				&& Objects.equals(this.imgId, other.imgId);
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("class SecurityImageItem {\n");
		sb.append("    imgId: ").append(toIndentedString(imgId)).append("\n");
		sb.append("    imgData: ").append(toIndentedString(imgData)).append("\n");
		sb.append("    imgAlias: ").append(toIndentedString(imgAlias)).append("\n");
		sb.append("}");
		return sb.toString();
	}

	/**
	 * Convert the given object to string with each line indented by 4 spaces
	 * (except the first line).
	 */
	private String toIndentedString(java.lang.Object o) {
		if (o == null) {
			return "null";
		}
		return o.toString().replace("\n", "\n    ");
	}

}
