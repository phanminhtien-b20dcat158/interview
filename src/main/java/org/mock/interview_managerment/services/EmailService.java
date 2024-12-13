package org.mock.interview_managerment.services;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.entities.Offer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    private final JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;


    public EmailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public void sendPasswordCreate(String toEmail, String username, String password) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("no-reply-email-IMS-system <Account created>");
            helper.setText(String.format(
                    "<html>" +
                            "  <body>" +
                            "    <p>This email is from IMS system,</p>" +
                            "    <p>Your account has been created. Please use the following credential to login:</p>" +
                            "    <ul>" +
                            "      <li>User name: %s</li>" +
                            "      <li>Password: %s</li>" +
                            "    </ul>" +
                            "    <p>If anything wrong, please reach-out recruiter %s. We are so sorry for this inconvenience.</p>" +
                            "    <p>Thanks & Regards!</p>" +
                            "    <p>IMS Team.</p>" +
                            "  </body>" +
                            "</html>",
                    username, password, fromEmail
            ), true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void sendPasswordResetEmail(String toEmail, String resetPasswordUrl) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("Password Reset");
            helper.setText(String.format(
                    "<html>" +
                            "  <body>" +
                            "    <p>We have just received a password reset request for <b>%s</b>.</p>" +
                            "    <p>Please click <a href=\"%s\">here</a> to reset your password.</p>" +
                            "    <p>For your security, the link will expire in 24 hours or immediately after you reset your password.</p>" +
                            "    <p>Thanks & Regards!</p>" +
                            "    <p>IMS Team.</p>" +
                            "  </body>" +
                            "</html>",
                    toEmail, resetPasswordUrl
            ), true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void sendOfferEmail(String toEmail, Offer offer) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject("Offer Details from IMS System");
            helper.setText(String.format(
                    "<html>" +
                            "  <body>" +
                            "    <p>Dear %s,</p>" +
                            "    <p>We are pleased to extend an offer for the position of <b>%s</b>.</p>" +
                            "    <p>Details of the offer are as follows:</p>" +
                            "    <ul>" +
                            "      <li>Position: %s</li>" +
                            "      <li>Department: %s</li>" +
                            "      <li>Contract Type: %s</li>" +
                            "      <li>Salary: %s</li>" +
                            "      <li>Start Date: %s</li>" +
                            "    </ul>" +
                            "    <p>Please review the attached offer letter and respond at your earliest convenience.</p>" +
                            "    <p>Best Regards,</p>" +
                            "    <p>IMS Team</p>" +
                            "  </body>" +
                            "</html>",
                    offer.getCandidate().getName(),
                    offer.getPosition(),
                    offer.getPosition(),
                    offer.getDepartment(),
                    offer.getContractType(),
                    offer.getBasicSalary(),
                    offer.getStartContract()
            ), true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public void sendInterviewReminderForInterviewer(String toEmail, Interview interview) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject(String.format("no-reply-email-IMS-system %s", interview.getTitle()));
            helper.setText(String.format(
                    "<html>" +
                            "  <body>" +
                            "    <p>This email is from IMS system,</p>" +
                            "    <p>You have an interview schedule on <b>%s</b> from <b>%s</b> to <b>%s</b>.</p>" +
                            "    <p>With Candidate <b>%s</b> for the position of <b>%s</b>. The CV is attached with this email.</p>" +
                            "    <p>If anything is wrong, please refer to recruiter <b>%s</b> or visit our website <a href='http://localhost:8080/interview/details?interviewId=%d'>Interview Details</a>.</p>" +
                            "    <p>Please join the interview room with ID: <a href='%s'>Meeting ID</a>.</p>" +
                            "    <p>Thanks & Regards!</p>" +
                            "    <p>IMS Team.</p>" +
                            "    <p>Attachment: <a href='%s'>Candidate CV</a>.</p>" +
                            "  </body>" +
                            "</html>",
                    interview.getDate().toString(),
                    interview.getStartTime().toString(),
                    interview.getEndTime().toString(),
                    interview.getCandidate().getName(),
                    interview.getCandidate().getCurrentPosition(),
                    interview.getCandidate().getUser().getEmail(),
                    interview.getInterviewId(),
                    interview.getMeetingId(),
                    interview.getCandidate().getCvAttachmentLink()
            ), true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }


    public void sendInterviewReminderForCandidate(String toEmail, Interview interview) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail);
            helper.setTo(toEmail);
            helper.setSubject(String.format("no-reply-email-IMS-system %s", interview.getTitle()));
            helper.setText(String.format(
                    "<html>" +
                            "  <body>" +
                            "    <p>Dear %s,</p>" +
                            "    <p>We would like to remind you of your upcoming interview scheduled on <b>%s</b> from <b>%s</b> to <b>%s</b>.</p>" +
                            "    <p>Position: <b>%s</b></p>" +
                            "    <p>Please join the interview room with ID: <a href='%s'>Meeting ID</a>.</p>" +
                            "    <p>If anything is wrong, please refer to recruiter <b>%s</b> or visit our website <a href='http://localhost:8080/interview/details?interviewId=%d'>Interview Details</a>.</p>" +
                            "    <p>Thank you,</p>" +
                            "    <p>IMS Team</p>" +
                            "  </body>" +
                            "</html>",
                    interview.getCandidate().getName(),
                    interview.getDate().toString(),
                    interview.getStartTime().toString(),
                    interview.getEndTime().toString(),
                    interview.getCandidate().getCurrentPosition(),
                    interview.getMeetingId(),
                    interview.getCandidate().getUser().getEmail(),
                    interview.getInterviewId()
            ), true);

            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }




}
