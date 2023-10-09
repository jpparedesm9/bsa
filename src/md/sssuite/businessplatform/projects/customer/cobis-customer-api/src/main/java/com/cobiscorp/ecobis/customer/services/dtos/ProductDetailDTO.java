package com.cobiscorp.ecobis.customer.services.dtos;

import java.math.BigDecimal;
import java.util.Date;

public class ProductDetailDTO {
	private Integer code;
	private Integer subsidiary;
	private Integer office;
	private Integer product;
	private String type;
	private Integer currency;
	private Date date;
	private String comment;
	private BigDecimal amount;
	private Integer time;
	private String account;
	private String status;
	private Integer authorizing;
	private Integer	accountOfficer;
	private Integer client;
	private Integer address;
	private String description;
	private Date dateChange;
	private Date dateNextDue;	
	private Integer poBox;
	private Integer subType;

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public Integer getSubsidiary() {
		return subsidiary;
	}

	public void setSubsidiary(Integer subsidiary) {
		this.subsidiary = subsidiary;
	}

	public Integer getOffice() {
		return office;
	}

	public void setOffice(Integer office) {
		this.office = office;
	}

	public Integer getProduct() {
		return product;
	}

	public void setProduct(Integer product) {
		this.product = product;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Integer getTime() {
		return time;
	}

	public void setTime(Integer time) {
		this.time = time;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getAuthorizing() {
		return authorizing;
	}

	public void setAuthorizing(Integer authorizing) {
		this.authorizing = authorizing;
	}

	public Integer getAccountOfficer() {
		return accountOfficer;
	}

	public void setAccountOfficer(Integer accountOfficer) {
		this.accountOfficer = accountOfficer;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public Integer getAddress() {
		return address;
	}

	public void setAddress(Integer address) {
		this.address = address;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getDateChange() {
		return dateChange;
	}

	public void setDateChange(Date dateChange) {
		this.dateChange = dateChange;
	}

	public Date getDateNextDue() {
		return dateNextDue;
	}

	public void setDateNextDue(Date dateNextDue) {
		this.dateNextDue = dateNextDue;
	}

	public Integer getPoBox() {
		return poBox;
	}

	public void setPoBox(Integer poBox) {
		this.poBox = poBox;
	}

	public Integer getSubType() {
		return subType;
	}

	public void setSubType(Integer subType) {
		this.subType = subType;
	}
	

	public ProductDetailDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductDetailDTO(Integer code, Integer subsidiary, Integer office,
			Integer product, String type, Integer currency, Date date,
			String comment, BigDecimal amount, Integer time, String account,
			String status, Integer authorizing, Integer accountOfficer,
			Integer client, Integer address, String description,
			Date dateChange, Date dateNextDue, Integer poBox, Integer subType) {
		super();
		this.code = code;
		this.subsidiary = subsidiary;
		this.office = office;
		this.product = product;
		this.type = type;
		this.currency = currency;
		this.date = date;
		this.comment = comment;
		this.amount = amount;
		this.time = time;
		this.account = account;
		this.status = status;
		this.authorizing = authorizing;
		this.accountOfficer = accountOfficer;
		this.client = client;
		this.address = address;
		this.description = description;
		this.dateChange = dateChange;
		this.dateNextDue = dateNextDue;
		this.poBox = poBox;
		this.subType = subType;
	}

	
}
