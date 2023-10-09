package cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto;

/**
 * Created by pclavijo on 27/06/2017.
 */
public class DisbursementResponse {
    private String recordType;
    private String sequenceNumber;
    private String transactionCode;
    private String currencyCode;
    private String transferDate;
    private String hostBank;
    private String recipientBank;
    private String amount;
    private String cCEN;
    private String transactionType;
    private String implementationDate;
    private String payerAccountType;
    private String payerAccountNumber;
    private String payerName;
    private String payerRFC;
    private String payeeAccountType;
    private String payeeAccountNumber;
    private String payeeName;
    private String payeeRFC;
    private String serviceReference;
    private String serviceOwnerName;
    private String taxAmount;
    private String payerReferenceNumber;
    private String payerReferenceLegend;
    private String traceKey;
    private String refundReason;
    private String initialPresentationDate;
    private String futureUse;
    private String customerReference;
    private String paymentReferenceDescription;
    private String payeeEmail;
    private String detentionLine;

    public String getRecordType() {
        return recordType;
    }

    public void setRecordType(String recordType) {
        this.recordType = recordType;
    }

    public String getSequenceNumber() {
        return sequenceNumber;
    }

    public void setSequenceNumber(String sequenceNumber) {
        this.sequenceNumber = sequenceNumber;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getTransferDate() {
        return transferDate;
    }

    public void setTransferDate(String transferDate) {
        this.transferDate = transferDate;
    }

    public String getHostBank() {
        return hostBank;
    }

    public void setHostBank(String hostBank) {
        this.hostBank = hostBank;
    }

    public String getRecipientBank() {
        return recipientBank;
    }

    public void setRecipientBank(String recipientBank) {
        this.recipientBank = recipientBank;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getcCEN() {
        return cCEN;
    }

    public void setcCEN(String cCEN) {
        this.cCEN = cCEN;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getImplementationDate() {
        return implementationDate;
    }

    public void setImplementationDate(String implementationDate) {
        this.implementationDate = implementationDate;
    }

    public String getPayerAccountType() {
        return payerAccountType;
    }

    public void setPayerAccountType(String payerAccountType) {
        this.payerAccountType = payerAccountType;
    }

    public String getPayerAccountNumber() {
        return payerAccountNumber;
    }

    public void setPayerAccountNumber(String payerAccountNumber) {
        this.payerAccountNumber = payerAccountNumber;
    }

    public String getPayerName() {
        return payerName;
    }

    public void setPayerName(String payerName) {
        this.payerName = payerName;
    }

    public String getPayerRFC() {
        return payerRFC;
    }

    public void setPayerRFC(String payerRFC) {
        this.payerRFC = payerRFC;
    }

    public String getPayeeAccountType() {
        return payeeAccountType;
    }

    public void setPayeeAccountType(String payeeAccountType) {
        this.payeeAccountType = payeeAccountType;
    }

    public String getPayeeAccountNumber() {
        return payeeAccountNumber;
    }

    public void setPayeeAccountNumber(String payeeAccountNumber) {
        this.payeeAccountNumber = payeeAccountNumber;
    }

    public String getPayeeName() {
        return payeeName;
    }

    public void setPayeeName(String payeeName) {
        this.payeeName = payeeName;
    }

    public String getPayeeRFC() {
        return payeeRFC;
    }

    public void setPayeeRFC(String payeeRFC) {
        this.payeeRFC = payeeRFC;
    }

    public String getServiceReference() {
        return serviceReference;
    }

    public void setServiceReference(String serviceReference) {
        this.serviceReference = serviceReference;
    }

    public String getServiceOwnerName() {
        return serviceOwnerName;
    }

    public void setServiceOwnerName(String serviceOwnerName) {
        this.serviceOwnerName = serviceOwnerName;
    }

    public String getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(String taxAmount) {
        this.taxAmount = taxAmount;
    }

    public String getPayerReferenceNumber() {
        return payerReferenceNumber;
    }

    public void setPayerReferenceNumber(String payerReferenceNumber) {
        this.payerReferenceNumber = payerReferenceNumber;
    }

    public String getPayerReferenceLegend() {
        return payerReferenceLegend;
    }

    public void setPayerReferenceLegend(String payerReferenceLegend) {
        this.payerReferenceLegend = payerReferenceLegend;
    }

    public String getTraceKey() {
        return traceKey;
    }

    public void setTraceKey(String traceKey) {
        this.traceKey = traceKey;
    }

    public String getRefundReason() {
        return refundReason;
    }

    public void setRefundReason(String refundReason) {
        this.refundReason = refundReason;
    }

    public String getInitialPresentationDate() {
        return initialPresentationDate;
    }

    public void setInitialPresentationDate(String initialPresentationDate) {
        this.initialPresentationDate = initialPresentationDate;
    }

    public String getFutureUse() {
        return futureUse;
    }

    public void setFutureUse(String futureUse) {
        this.futureUse = futureUse;
    }

    public String getCustomerReference() {
        return customerReference;
    }

    public void setCustomerReference(String customerReference) {
        this.customerReference = customerReference;
    }

    public String getPaymentReferenceDescription() {
        return paymentReferenceDescription;
    }

    public void setPaymentReferenceDescription(String paymentReferenceDescription) {
        this.paymentReferenceDescription = paymentReferenceDescription;
    }

    public String getPayeeEmail() {
        return payeeEmail;
    }

    public void setPayeeEmail(String payeeEmail) {
        this.payeeEmail = payeeEmail;
    }

    public String getDetentionLine() {
        return detentionLine;
    }

    public void setDetentionLine(String detentionLine) {
        this.detentionLine = detentionLine;
    }

    @Override
    public String toString() {
        return "DisbursementResponse{" +
                "recordType='" + recordType + '\'' +
                ", sequenceNumber='" + sequenceNumber + '\'' +
                ", transactionCode='" + transactionCode + '\'' +
                ", currencyCode='" + currencyCode + '\'' +
                ", transferDate='" + transferDate + '\'' +
                ", hostBank='" + hostBank + '\'' +
                ", recipientBank='" + recipientBank + '\'' +
                ", amount='" + amount + '\'' +
                ", cCEN='" + cCEN + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", implementationDate='" + implementationDate + '\'' +
                ", payerAccountType='" + payerAccountType + '\'' +
                ", payerAccountNumber='" + payerAccountNumber + '\'' +
                ", payerName='" + payerName + '\'' +
                ", payerRFC='" + payerRFC + '\'' +
                ", payeeAccountType='" + payeeAccountType + '\'' +
                ", payeeAccountNumber='" + payeeAccountNumber + '\'' +
                ", payeeName='" + payeeName + '\'' +
                ", payeeRFC='" + payeeRFC + '\'' +
                ", serviceReference='" + serviceReference + '\'' +
                ", serviceOwnerName='" + serviceOwnerName + '\'' +
                ", taxAmount='" + taxAmount + '\'' +
                ", payerReferenceNumber='" + payerReferenceNumber + '\'' +
                ", payerReferenceLegend='" + payerReferenceLegend + '\'' +
                ", traceKey='" + traceKey + '\'' +
                ", refundReason='" + refundReason + '\'' +
                ", initialPresentationDate='" + initialPresentationDate + '\'' +
                ", futureUse='" + futureUse + '\'' +
                ", customerReference='" + customerReference + '\'' +
                ", paymentReferenceDescription='" + paymentReferenceDescription + '\'' +
                ", payeeEmail='" + payeeEmail + '\'' +
                ", detentionLine='" + detentionLine + '\'' +
                '}';
    }
}
