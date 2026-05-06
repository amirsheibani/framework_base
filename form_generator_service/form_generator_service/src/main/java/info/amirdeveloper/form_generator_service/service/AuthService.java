package info.amirdeveloper.form_generator_service.service;

import info.amirdeveloper.form_generator_service.dto.auth.AuthResponse;
import info.amirdeveloper.form_generator_service.dto.auth.LoginRequest;
import info.amirdeveloper.form_generator_service.dto.auth.RefreshTokenRequest;
import info.amirdeveloper.form_generator_service.dto.auth.RegisterRequest;
import info.amirdeveloper.form_generator_service.model.User;
import info.amirdeveloper.form_generator_service.repository.UserRepository;
import info.amirdeveloper.form_generator_service.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * Service کلاس برای مدیریت احراز هویت (Authentication)
 * این کلاس عملیات ثبت‌نام و ورود کاربران را انجام می‌دهد
 * و توکن‌های JWT را برای احراز هویت تولید می‌کند
 */
@Service
@RequiredArgsConstructor
public class AuthService {

    /** Repository برای دسترسی به داده‌های کاربران */
    private final UserRepository userRepository;

    /** رمزگذار رمز عبور برای رمزنشانی امن کردن رمزعبورها */
    private final PasswordEncoder passwordEncoder;

    /** Service برای ایجاد و تأیید توکن‌های JWT */
    private final JwtService jwtService;

    /**
     * تابع ثبت‌نام کاربر جدید
     *
     * عملیات:
     * 1. بررسی می‌کند که آیا ایمیل قبلاً ثبت‌نام شده است
     * 2. یک کاربر جدید ایجاد می‌کند با رمزعبور رمزنشانی‌شده
     * 3. کاربر را در دیتابیس ذخیره می‌کند
     * 4. یک توکن JWT تولید می‌کند و بازگشت می‌دهد
     *
     * @param request درخواست ثبت‌نام شامل نام، ایمیل و رمز عبور
     * @return AuthResponse شامل توکن JWT
     * @throws RuntimeException اگر ایمیل قبلاً وجود داشته باشد
     */
    public AuthResponse register(RegisterRequest request) {

        // بررسی اінما اگر ایمیل قبلاً موجود است
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        // ایجاد کاربر جدید با رمزعبور رمزنشانی‌شده
        User user = User.builder()
                .name(request.getName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .build();

        // ذخیره کاربر در دیتابیس
        userRepository.save(user);

        // تولید access token (2 روز) و refresh token (7 روز)
        String accessToken = jwtService.generateToken(user.getEmail());
        String refreshToken = jwtService.generateRefreshToken(user.getEmail());

        return new AuthResponse(accessToken, refreshToken);
    }

    /**
     * تابع ورود کاربر
     *
     * عملیات:
     * 1. کاربری با ایمیل داده‌شده را جستجو می‌کند
     * 2. رمز عبور داده‌شده را با رمز ذخیره‌شده مقایسه می‌کند
     * 3. اگر رمز صحیح بود، توکن JWT تولید می‌کند
     *
     * @param request درخواست ورود شامل ایمیل و رمز عبور
     * @return AuthResponse شامل توکن JWT
     * @throws RuntimeException اگر کاربر یافت نشود یا رمز نادرست باشد
     */
    public AuthResponse login(LoginRequest request) {

        // جستجو برای کاربر با ایمیل داده‌شده
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // بررسی اینکه آیا رمز عبور صحیح است
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("Invalid password");
        }

        // تولید access token (2 روز) و refresh token (7 روز)
        String accessToken = jwtService.generateToken(user.getEmail());
        String refreshToken = jwtService.generateRefreshToken(user.getEmail());

        return new AuthResponse(accessToken, refreshToken);
    }

    /**
     * تابع رفرش توکن (تولید access token و refresh token جدید)
     *
     * عملیات:
     * 1. refresh token را دریافت می‌کند
     * 2. بررسی می‌کند که توکن از نوع refresh باشد
     * 3. اعتبار refresh token را بررسی می‌کند
     * 4. ایمیل را از refresh token استخراج می‌کند
     * 5. access token جدید (2 روز) و refresh token جدید (7 روز) تولید می‌کند
     *
     * نکته: فقط refresh token معتبر می‌تواند برای دریافت توکن‌های جدید استفاده شود
     *
     * @param request درخواست رفرش شامل refresh token
     * @return AuthResponse شامل access token و refresh token جدید
     * @throws RuntimeException اگر توکن نامعتبر یا منقضی شده باشد
     */
    public AuthResponse refreshToken(RefreshTokenRequest request) {

        // بررسی اینکه توکن خالی نیست
        if (request.getToken() == null || request.getToken().isEmpty()) {
            throw new RuntimeException("Refresh token is required");
        }

        String refreshToken = request.getToken();

        // بررسی اینکه توکن از نوع refresh است
        if (!jwtService.isRefreshToken(refreshToken)) {
            throw new RuntimeException("Invalid token type. Refresh token is required");
        }

        // بررسی اعتبار refresh token (نباید منقضی شده باشد)
        if (!jwtService.isTokenValid(refreshToken)) {
            throw new RuntimeException("Refresh token is expired or invalid");
        }

        // استخراج ایمیل از refresh token
        String email = jwtService.extractEmail(refreshToken);

        // اگر ایمیل خالی باشد
        if (email == null || email.isEmpty()) {
            throw new RuntimeException("Invalid token");
        }

        // بررسی اینکه کاربر هنوز در سیستم موجود است
        userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // تولید access token جدید (2 روز) و refresh token جدید (7 روز)
        String newAccessToken = jwtService.generateToken(email);
        String newRefreshToken = jwtService.generateRefreshToken(email);

        return new AuthResponse(newAccessToken, newRefreshToken);
    }
}