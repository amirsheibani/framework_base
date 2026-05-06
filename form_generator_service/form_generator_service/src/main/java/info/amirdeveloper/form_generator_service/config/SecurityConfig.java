package info.amirdeveloper.form_generator_service.config;

import info.amirdeveloper.form_generator_service.security.JwtAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Config کلاس برای تنظیمات امنیتی Spring Security
 * این کلاس تمام قوانین احراز هویت و مجوزهای دسترسی را تنظیم می‌کند
 */
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    /** JWT Authentication Filter برای بررسی توکن‌های JWT */
    private final JwtAuthenticationFilter jwtAuthFilter;

    /**
     * Bean برای تنظیم Security Filter Chain
     *
     * تنظیمات:
     * 1. CSRF protection را غیرفعال می‌کند (برای API REST)
     * 2. تمام endpoint‌های /api/auth/** و Swagger را عمومی می‌کند
     * 3. تمام endpoint‌های دیگر نیاز به احراز هویت دارند
     * 4. Session Management را Stateless تنظیم می‌کند (برای JWT)
     * 5. JWT Filter را قبل از UsernamePasswordAuthenticationFilter اضافه می‌کند
     *
     * @param http HttpSecurity برای تنظیم امنیت
     * @return SecurityFilterChain
     * @throws Exception اگر خطای تنظیم رخ دهد
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                // CSRF protection را برای API غیرفعال می‌کند
                .csrf(csrf -> csrf.disable())

                // تنظیم کردن مجوزهای دسترسی برای endpoint‌ها
                .authorizeHttpRequests(auth -> auth
                        // endpoint‌های عمومی (بدون احراز هویت)
                        .requestMatchers(
                                "/api/auth/**",           // تمام endpoint‌های احراز هویت
                                "/swagger-ui/**",         // Swagger UI
                                "/v3/api-docs/**"         // OpenAPI documentation
                        ).permitAll()
                        // تمام endpoint‌های دیگر نیاز به احراز هویت دارند
                        .anyRequest().authenticated()
                )

                // Session Management را Stateless تنظیم می‌کند
                // این بدان معناست که سرور session ایجاد نمی‌کند و فقط از JWT استفاده می‌کند
                .sessionManagement(session ->
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                // JWT Filter را قبل از UsernamePasswordAuthenticationFilter اضافه می‌کند
                .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    /**
     * Bean برای رمزگذار رمز عبور
     * BCryptPasswordEncoder برای رمزنشانی امن کردن رمزعبورها استفاده می‌شود
     *
     * @return PasswordEncoder (BCryptPasswordEncoder)
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * Bean برای AuthenticationManager
     * AuthenticationManager برای احراز هویت کاربران استفاده می‌شود
     *
     * @param config AuthenticationConfiguration
     * @return AuthenticationManager
     * @throws Exception اگر خطای تنظیم رخ دهد
     */
    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration config
    ) throws Exception {
        return config.getAuthenticationManager();
    }
}
