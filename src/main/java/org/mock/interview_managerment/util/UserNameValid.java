package org.mock.interview_managerment.util;

public class UserNameValid {

    public static String genUserName(String fullName, Long id) {
        String[] nameParts = fullName.split("\s+");

        String firstName = nameParts[nameParts.length-1];

        StringBuilder initials = new StringBuilder();
        for (int i = 0; i < nameParts.length-1; i++) {
            initials.append(nameParts[i].charAt(0));
        }

        return firstName + initials + id;
    }

}
