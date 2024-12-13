package org.mock.interview_managerment.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class DateValid {

    public static LocalDate toLocalDate(String date) {
        // Định dạng chuỗi ngày: d/M/yyyy
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/M/yyyy");
        try {
            return LocalDate.parse(date, formatter);
        } catch (DateTimeParseException e) {
            // Xử lý ngoại lệ nếu định dạng không hợp lệ
            System.err.println("Invalid date format: " + date);
            return null;
        }
    }

}
