package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.Date;

public class ReporteDTO {

	// Tabla Ingreso
	private String mnemonic;
	private String reportNameI;
	private Date generationDate;
	private Date genProcessDate;
	private Date uploadDate;
	private Date copyDate;
	private String status;
	// Tabla Principal
	private String workFolderP;
	private String sourceFolderP;
	/* INFORMACION PARA SFTP */
	private String username;
	private String password;
	private String host;
	private Integer port;
	private Integer timeout;
	private String keyPath;
	private String authenticationType;
	/**/
	private String typeP;
	// Tabla Detalle
	private String reportNameD;
	private String workFolderD;
	private String sourceFolderD;
	private String destinationFolder;
	/* INFORMACION PARA CARGA */
	private String uploadPath;
	private String fileNameUpload;
	private String remoteUploadPath;
	private String retryUpload;
	private String toUploadExtract;
	/* INFORMACION PARA DESCARGA */
	private String downloadPath;
	private String downloadFilePattern;
	private String remoteDownloadPath;
	private String remoteDownloadHistoryPath;
	private String retryDownload;
	private String toDownloadExtract;

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	public String getReportNameI() {
		return reportNameI;
	}

	public void setReportNameI(String reportNameI) {
		this.reportNameI = reportNameI;
	}

	public Date getGenerationDate() {
		return generationDate;
	}

	public void setGenerationDate(Date generationDate) {
		this.generationDate = generationDate;
	}

	public Date getGenProcessDate() {
		return genProcessDate;
	}

	public void setGenProcessDate(Date genProcessDate) {
		this.genProcessDate = genProcessDate;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public Date getCopyDate() {
		return copyDate;
	}

	public void setCopyDate(Date copyDate) {
		this.copyDate = copyDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getWorkFolderP() {
		return workFolderP;
	}

	public void setWorkFolderP(String workFolderP) {
		this.workFolderP = workFolderP;
	}

	public String getSourceFolderP() {
		return sourceFolderP;
	}

	public void setSourceFolderP(String sourceFolderP) {
		this.sourceFolderP = sourceFolderP;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public Integer getPort() {
		return port;
	}

	public void setPort(Integer port) {
		this.port = port;
	}

	public Integer getTimeout() {
		return timeout;
	}

	public void setTimeout(Integer timeout) {
		this.timeout = timeout;
	}

	public String getKeyPath() {
		return keyPath;
	}

	public void setKeyPath(String keyPath) {
		this.keyPath = keyPath;
	}

	public String getAuthenticationType() {
		return authenticationType;
	}

	public void setAuthenticationType(String authenticationType) {
		this.authenticationType = authenticationType;
	}

	public String getTypeP() {
		return typeP;
	}

	public void setTypeP(String typeP) {
		this.typeP = typeP;
	}

	public String getReportNameD() {
		return reportNameD;
	}

	public void setReportNameD(String reportNameD) {
		this.reportNameD = reportNameD;
	}

	public String getWorkFolderD() {
		return workFolderD;
	}

	public void setWorkFolderD(String workFolderD) {
		this.workFolderD = workFolderD;
	}

	public String getSourceFolderD() {
		return sourceFolderD;
	}

	public void setSourceFolderD(String sourceFolderD) {
		this.sourceFolderD = sourceFolderD;
	}

	public String getDestinationFolder() {
		return destinationFolder;
	}

	public void setDestinationFolder(String destinationFolder) {
		this.destinationFolder = destinationFolder;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getFileNameUpload() {
		return fileNameUpload;
	}

	public void setFileNameUpload(String fileNameUpload) {
		this.fileNameUpload = fileNameUpload;
	}

	public String getRemoteUploadPath() {
		return remoteUploadPath;
	}

	public void setRemoteUploadPath(String remoteUploadPath) {
		this.remoteUploadPath = remoteUploadPath;
	}

	public String getRetryUpload() {
		return retryUpload;
	}

	public void setRetryUpload(String retryUpload) {
		this.retryUpload = retryUpload;
	}

	public String getToUploadExtract() {
		return toUploadExtract;
	}

	public void setToUploadExtract(String toUploadExtract) {
		this.toUploadExtract = toUploadExtract;
	}

	public String getDownloadPath() {
		return downloadPath;
	}

	public void setDownloadPath(String downloadPath) {
		this.downloadPath = downloadPath;
	}

	public String getDownloadFilePattern() {
		return downloadFilePattern;
	}

	public void setDownloadFilePattern(String downloadFilePattern) {
		this.downloadFilePattern = downloadFilePattern;
	}

	public String getRemoteDownloadPath() {
		return remoteDownloadPath;
	}

	public void setRemoteDownloadPath(String remoteDownloadPath) {
		this.remoteDownloadPath = remoteDownloadPath;
	}

	public String getRemoteDownloadHistoryPath() {
		return remoteDownloadHistoryPath;
	}

	public void setRemoteDownloadHistoryPath(String remoteDownloadHistoryPath) {
		this.remoteDownloadHistoryPath = remoteDownloadHistoryPath;
	}

	public String getRetryDownload() {
		return retryDownload;
	}

	public void setRetryDownload(String retryDownload) {
		this.retryDownload = retryDownload;
	}

	public String getToDownloadExtract() {
		return toDownloadExtract;
	}

	public void setToDownloadExtract(String toDownloadExtract) {
		this.toDownloadExtract = toDownloadExtract;
	}

	@Override
	public String toString() {
		return "ReporteDTO [mnemonic=" + mnemonic + ", reportNameI=" + reportNameI + ", generationDate=" + generationDate + ", genProcessDate=" + genProcessDate + ", uploadDate="
				+ uploadDate + ", copyDate=" + copyDate + ", status=" + status + ", workFolderP=" + workFolderP + ", sourceFolderP=" + sourceFolderP + ", username=" + username
				+ ", password=" + password + ", host=" + host + ", port=" + port + ", timeout=" + timeout + ", keyPath=" + keyPath + ", authenticationType=" + authenticationType
				+ ", typeP=" + typeP + ", reportNameD=" + reportNameD + ", workFolderD=" + workFolderD + ", sourceFolderD=" + sourceFolderD + ", destinationFolder="
				+ destinationFolder + ", uploadPath=" + uploadPath + ", fileNameUpload=" + fileNameUpload + ", remoteUploadPath=" + remoteUploadPath + ", retryUpload="
				+ retryUpload + ", toUploadExtract=" + toUploadExtract + ", downloadPath=" + downloadPath + ", downloadFilePattern=" + downloadFilePattern + ", remoteDownloadPath="
				+ remoteDownloadPath + ", remoteDownloadHistoryPath=" + remoteDownloadHistoryPath + ", retryDownload=" + retryDownload + ", toDownloadExtract=" + toDownloadExtract
				+ "]";
	}

}
