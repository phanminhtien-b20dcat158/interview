package org.mock.interview_managerment;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class InterviewManagermentApplication {
	public static void main(String[] args) {
		SpringApplication.run(InterviewManagermentApplication.class, args);
	}

}
