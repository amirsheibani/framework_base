package info.amirdeveloper.form_generator_service.service;

import info.amirdeveloper.form_generator_service.model.User;
import info.amirdeveloper.form_generator_service.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;

/**
 * Service کلاس برای لود اطلاعات کاربر در Spring Security
 * این کلاس UserDetailsService را پیاده‌سازی می‌کند
 * و برای احراز هویت استفاده می‌شود
 */
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    /** Repository برای دسترسی به داده‌های کاربران */
    private final UserRepository userRepository;

    /**
     * لود اطلاعات کاربر بر اساس نام کاربری (ایمیل) برای Spring Security
     *
     * عملیات:
     * 1. کاربری با ایمیل داده‌شده را جستجو می‌کند
     * 2. یک UserDetails object ایجاد می‌کند برای استفاده در احراز هویت
     * 3. اختیارات (authorities) را به عنوان "USER" تنظیم می‌کند
     *
     * @param email ایمیل کاربری که می‌خواهیم اطلاعات آن را لود کنیم
     * @return UserDetails شی شامل اطلاعات کاربر برای Spring Security
     * @throws UsernameNotFoundException اگر کاربر با ایمیل داده‌شده یافت نشود
     */
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        // جستجو برای کاربر در دیتابیس
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        // ایجاد و بازگشت UserDetails برای Spring Security
        return org.springframework.security.core.userdetails.User
                .withUsername(user.getEmail())
                .password(user.getPassword())
                .authorities("USER")
                .build();
    }
}