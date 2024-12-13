package org.mock.interview_managerment.services;

import org.mock.interview_managerment.entities.PasswordResetToken;
import org.mock.interview_managerment.repository.PasswordResetTokenRepository;
import org.springframework.stereotype.Service;

@Service
public class PasswordResetTokenService {

    private final PasswordResetTokenRepository passwordResetTokenRepository;

    public PasswordResetTokenService(PasswordResetTokenRepository passwordResetTokenRepository) {
        this.passwordResetTokenRepository = passwordResetTokenRepository;
    }

    public PasswordResetToken handleSavePasswordResetToken(PasswordResetToken passwordResetToken) {
        return passwordResetTokenRepository.save(passwordResetToken);
    }

    public PasswordResetToken handleGetPasswordResetToken(String token) {
        return passwordResetTokenRepository.findByToken(token);
    }

    public void handleDeleteToken(PasswordResetToken passwordResetToken) {
        passwordResetTokenRepository.delete(passwordResetToken);
    }
}
