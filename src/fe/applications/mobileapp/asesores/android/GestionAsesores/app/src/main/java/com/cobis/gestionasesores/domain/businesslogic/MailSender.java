package com.cobis.gestionasesores.domain.businesslogic;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.data.models.Attachment;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

public final class MailSender {
    private String[] toList;
    private String[] ccList;
    private String[] bccList;
    private String subject;
    private String from;
    private String txtBody;
    private String htmlBody;
    private String[] replyToList;
    private ArrayList<Attachment> attachments;
    private boolean authenticationRequired = false;

    private String userName;
    private String password;

    public MailSender(String userName, String password, String from, String[] toList, String subject, String txtBody, String htmlBody,
                      Attachment attachment) {
        this.txtBody = txtBody;
        this.htmlBody = htmlBody;
        this.subject = subject;
        this.from = from;
        this.toList = toList;
        this.ccList = null;
        this.bccList = null;
        this.replyToList = null;
        if (StringUtils.isNotEmpty(userName) && StringUtils.isNotEmpty(password)) {
            this.authenticationRequired = true;
            this.userName = userName;
            this.password = password;
        } else {
            this.authenticationRequired = false;
        }
        this.attachments = new ArrayList<>();
        if (attachment != null) {
            this.attachments.add(attachment);
        }
    }

    /**
     * Send an e-mail
     *
     * @throws MessagingException
     * @throws Exception
     */
    public void send() throws Exception {
        Properties props = new Properties();

        // set the host smtp address
        props.put("mail.smtp.host", BuildConfig.SMTP_SERVER);
        props.put("mail.user", from);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "587");

        Session session;
        if (authenticationRequired) {
            Authenticator auth = new SMTPAuthenticator(userName, password);
            props.put("mail.smtp.auth", "true");
            session = Session.getDefaultInstance(props, auth);
        } else {
            session = Session.getDefaultInstance(props, null);
        }

        // get the default session
        session.setDebug(BuildConfig.DEBUG);

        // create message
        Message msg = new javax.mail.internet.MimeMessage(session);

        // set from and to address
        try {
            msg.setFrom(new InternetAddress(from, from));
            msg.setReplyTo(new InternetAddress[]{new InternetAddress(from, from)});
        } catch (Exception e) {
            msg.setFrom(new InternetAddress(from));
            msg.setReplyTo(new InternetAddress[]{new InternetAddress(from)});
        }

        // set send date
        msg.setSentDate(Calendar.getInstance().getTime());

        // parse the recipients TO
        javax.mail.internet.InternetAddress[] addressTo = new javax.mail.internet.InternetAddress[toList.length];
        for (int i = 0; i < toList.length; i++) {
            addressTo[i] = new javax.mail.internet.InternetAddress(toList[i]);
        }
        msg.setRecipients(javax.mail.Message.RecipientType.TO, addressTo);

        // parse the replyTo addresses
        if (replyToList != null && replyToList.length > 0) {
            javax.mail.internet.InternetAddress[] addressReplyTo = new javax.mail.internet.InternetAddress[replyToList.length];
            for (int i = 0; i < replyToList.length; i++) {
                addressReplyTo[i] = new javax.mail.internet.InternetAddress(replyToList[i]);
            }
            msg.setReplyTo(addressReplyTo);
        }

        // parse the recipients CC address
        if (ccList != null && ccList.length > 0) {
            javax.mail.internet.InternetAddress[] addressCC = new javax.mail.internet.InternetAddress[ccList.length];
            for (int i = 0; i < ccList.length; i++) {
                addressCC[i] = new javax.mail.internet.InternetAddress(ccList[i]);
            }
            msg.setRecipients(javax.mail.Message.RecipientType.CC, addressCC);
        }

        // parse the recipients BCC address
        if (bccList != null && bccList.length > 0) {
            javax.mail.internet.InternetAddress[] addressBCC = new javax.mail.internet.InternetAddress[bccList.length];
            for (int i = 0; i < bccList.length; i++) {
                addressBCC[i] = new javax.mail.internet.InternetAddress(bccList[i]);
            }
            msg.setRecipients(javax.mail.Message.RecipientType.BCC, addressBCC);
        }

        // set header
        msg.addHeader("X-Mailer", "BayteqMobileCore");
        msg.addHeader("Precedence", "bulk");
        // setting the subject and content type
        msg.setSubject(subject);

        Multipart mp = new MimeMultipart("related");

        // set body message
        MimeBodyPart bodyMsg = new MimeBodyPart();
        if (txtBody != null) {
            bodyMsg.setText(txtBody, "iso-8859-1");
        }
        if (htmlBody != null) {
            bodyMsg.setContent(htmlBody, "text/html; charset=utf-8");
        }
        mp.addBodyPart(bodyMsg);

        // set attachments if any
        if (attachments != null && attachments.size() > 0) {
            for (int i = 0; i < attachments.size(); i++) {
                Attachment a = attachments.get(i);
                BodyPart att = new MimeBodyPart();
                att.setDataHandler(new DataHandler(a.getDataSource()));
                att.setFileName(a.getFileName());
                att.setHeader("Content-ID", "<" + a.getFileName() + ">");
                mp.addBodyPart(att);
            }
        }
        msg.setContent(mp);

        // send it
        javax.mail.Transport.send(msg);
    }

    /**
     * SimpleAuthenticator is used to do simple authentication when the SMTP
     * server requires it.
     */
    private static class SMTPAuthenticator extends javax.mail.Authenticator {
        private String userName;
        private String password;

        public SMTPAuthenticator(String userName, String password) {
            this.userName = userName;
            this.password = password;
        }

        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(userName, password);
        }
    }


    public String[] getToList() {
        return toList;
    }

    public void setToList(String[] toList) {
        this.toList = toList;
    }

    public String[] getCcList() {
        return ccList;
    }

    public void setCcList(String[] ccList) {
        this.ccList = ccList;
    }

    public String[] getBccList() {
        return bccList;
    }

    public void setBccList(String[] bccList) {
        this.bccList = bccList;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public void setTxtBody(String body) {
        this.txtBody = body;
    }

    public void setHtmlBody(String body) {
        this.htmlBody = body;
    }

    public String[] getReplyToList() {
        return replyToList;
    }

    public void setReplyToList(String[] replyToList) {
        this.replyToList = replyToList;
    }

    public boolean isAuthenticationRequired() {
        return authenticationRequired;
    }

    public void setAuthenticationRequired(boolean authenticationRequired) {
        this.authenticationRequired = authenticationRequired;
    }
}