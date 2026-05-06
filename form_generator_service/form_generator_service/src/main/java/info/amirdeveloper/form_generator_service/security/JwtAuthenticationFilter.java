package info.amirdeveloper.form_generator_service.security;

import info.amirdeveloper.form_generator_service.service.CustomUserDetailsService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * Filter کلاس برای احراز هویت درخواست‌های HTTP با استفاده از JWT
 * این filter برای هر درخواست اجرا می‌شود و بررسی می‌کند آیا توکن JWT معتبر است
 *
 * OncePerRequestFilter تضمین می‌کند که filter فقط یکبار برای هر request اجرا شود
 */
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    /** Service برای تأیید و استخراج اطلاعات از توکن‌های JWT */
    private final JwtService jwtService;

    /** Service برای لود اطلاعات کاربر از دیتابیس */
    private final CustomUserDetailsService userDetailsService;

    /**
     * متد اصلی filter که برای هر درخواست HTTP اجرا می‌شود
     *
     * عملیات:
     * 1. بررسی می‌کند آیا header Authorization وجود دارد یا نه
     * 2. اگر ندارد، درخواست را بدون تغییر ادامه می‌دهد
     * 3. اگر دارد، توکن JWT را استخراج می‌کند
     * 4. ایمیل را از توکن استخراج می‌کند
     * 5. اگر ایمیل معتبر باشد و توکن تأیید شده باشد:
     *    - اطلاعات کاربر را لود می‌کند
     *    - یک Authentication token ایجاد می‌کند
     *    - در Security Context ذخیره می‌کند
     * 6. درخواست را به filter بعدی منتقل می‌کند
     *
     * @param request درخواست HTTP
     * @param response پاسخ HTTP
     * @param filterChain زنجیره filter‌ها
     * @throws ServletException اگر خطای servlet رخ دهد
     * @throws IOException اگر خطای I/O رخ دهد
     */
    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

        // دریافت header Authorization از درخواست
        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final String email;

        // بررسی اینکه آیا Authorization header وجود دارد و با "Bearer " شروع می‌شود
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        // استخراج توکن JWT (حذف "Bearer " prefix)
        jwt = authHeader.substring(7);

        // استخراج ایمیل از توکن
        email = jwtService.extractEmail(jwt);

        // اگر ایمیل موجود باشد و هنوز احراز هویت نشده باشد
        if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {

            // لود اطلاعات کاربر از دیتابیس
            UserDetails userDetails = userDetailsService.loadUserByUsername(email);

            // فقط access token معتبر اجازه احراز هویت برای درخواست‌های محافظت‌شده دارد
            if (jwtService.isTokenValid(jwt) && !jwtService.isRefreshToken(jwt)) {

                // ایجاد Authentication token
                UsernamePasswordAuthenticationToken authToken =
                        new UsernamePasswordAuthenticationToken(
                                userDetails,
                                null,
                                userDetails.getAuthorities()
                        );

                // تنظیم جزئیات درخواست
                authToken.setDetails(
                        new WebAuthenticationDetailsSource().buildDetails(request)
                );

                // ذخیره در Security Context
                SecurityContextHolder.getContext().setAuthentication(authToken);
            }
        }

        // ادامه دادن درخواست به filter بعدی
        filterChain.doFilter(request, response);
    }
}
