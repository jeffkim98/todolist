package com.todolist.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SendMailService {

	@Value("${email.username}")
	private String username;
	@Value("${email.password}")
	private String password;
	
	
	public void sendMail(String emailAddr, String activeCode) throws AddressException, MessagingException, FileNotFoundException, IOException {
		
		String title = "안녕하세요. 회원가입을 위한 이메일 인증번호입니다.";
		
		
		Properties props = new Properties();
		
		// gmail smtp
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.starttls.required", "true");
//		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.auth", "true");

		getAccount();
		
		// 세션 생성
		Session mailSession = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		System.out.println(mailSession.toString());
		log.info("mailSession : {} ", mailSession);

		if (mailSession != null) {

			MimeMessage mime = new MimeMessage(mailSession);
			mime.setFrom(new InternetAddress(username)); // 보내는 사람의 메일 주소
			mime.addRecipient(RecipientType.TO, new InternetAddress(emailAddr)); // 받는 사람의 메일 주소

			log.info(emailAddr);
			
			mime.setSubject(title); // 메일 제목
					
			String html = "<h1>회원가입을 환영합니다!</h1>";
			html += "<h2>회원가입을 원하시면 아래에 인증번호를 입력하세요!</h2>";
			html += "<h3>인증 코드 : </h3>";
			html += "<h3>" + activeCode + "</h3>";
			mime.setText(html, "utf-8", "html");

			Transport.send(mime);
		}
		
	}
	
	// FileReader로 그 안에 있는 주소로 들어가 config.properties에 값을 불러온다.
	private void getAccount() throws FileNotFoundException, IOException {
		Properties props = new Properties();
		props.load(new FileReader("C:\\lecture\\spring\\Spring-mini-to-do-list\\src\\main\\resources\\config\\dbconfig.properties"));
		this.username = (String) props.get("email.username");
		this.password = (String) props.get("email.password");
	}
	
	public void sendReminder(String email, String message)
			throws AddressException, MessagingException, FileNotFoundException, IOException {

		Properties props = new Properties();
		getAccount();

		// gmail smtp
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.starttls.required", "true");
//		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		props.put("mail.smtp.auth", "true");

		// 세션 생성
		Session mailSession = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		if (mailSession != null) {
			MimeMessage mime = new MimeMessage(mailSession);
			mime.setFrom(new InternetAddress(username)); // 보내는 사람의 메일 주소
			mime.addRecipient(RecipientType.TO, new InternetAddress(email)); // 받는 사람의 메일 주소

			mime.setSubject("리마인더 "); // 메일 제목
//			mime.setText(message); // 메일 본문

			mime.setText(message, "utf-8", "html");

			Transport.send(mime);
		}

	}
	
}
