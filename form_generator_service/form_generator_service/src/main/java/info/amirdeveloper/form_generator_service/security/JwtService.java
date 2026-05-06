package info.amirdeveloper.form_generator_service.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * Service کلاس برای مدیریت توکن‌های JWT (JSON Web Token)
 * این کلاس اجازه دهی ایجاد، تأیید و استخراج اطلاعات از توکن‌های JWT را فراهم می‌کند
نن  */
@Service
public class JwtService {

    /**
     * کلید محرمانه برای امضای توکن‌ها
     * نکته مهم: برای الگوریتم HS256، کلید باید حداقل 32 کاراکتر (256 بیت) باشد
     * این مقدار از application.properties خوانده می‌شود
     */
    @Value("${jwt.secret-key}")
    private String SECRET_KEY;

    /**
     * مدت زمان اعتبار Access Token به میلی‌ثانیه (پیش‌فرض: 2 روز)
     * این مقدار از application.properties خوانده می‌شود
     */
    @Value("${jwt.access-token.expiration}")
    private long ACCESS_TOKEN_EXPIRATION;

    /**
     * مدت زمان اعتبار Refresh Token به میلی‌ثانیه (پیش‌فرض: 7 روز)
     * این مقدار از application.properties خوانده می‌شود
     */
    @Value("${jwt.refresh-token.expiration}")
    private long REFRESH_TOKEN_EXPIRATION;

    /**
     * دریافت کلید امضا برای استفاده در الگوریتم HMAC SHA256
     * تبدیل رشته کلید به SecretKey برای الگوریتم رمزنگاری
     *
     * @return SecretKey برای امضای توکن‌ها
     */
    private SecretKey getSigningKey() {
        byte[] keyBytes = SECRET_KEY.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    /**
     * ایجاد یک Access Token JWT برای کاربر
     *
     * عملیات:
     * 1. Set کردن موضوع (subject) توکن به ایمیل کاربر
     * 2. Set کردن claim برای نوع توکن (access)
     * 3. Set کردن زمان ایجاد (issued at)
     * 4. Set کردن زمان انقضا (expiration) - 2 روز
     * 5. امضای توکن با کلید محرمانه و الگوریتم HS256
     * 6. تبدیل به رشته Compact
     *
     * @param email ایمیل کاربری که برای آن توکن ایجاد می‌کنیم
     * @return رشته Access Token JWT
     */
    public String generateToken(String email) {
        return Jwts.builder()
                .setSubject(email)
                .claim("type", "access")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + ACCESS_TOKEN_EXPIRATION))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * ایجاد یک Refresh Token JWT برای کاربر
     *
     * عملیات:
     * 1. Set کردن موضوع (subject) توکن به ایمیل کاربر
     * 2. Set کردن claim برای نوع توکن (refresh)
     * 3. Set کردن زمان ایجاد (issued at)
     * 4. Set کردن زمان انقضا (expiration) - 7 روز
     * 5. امضای توکن با کلید محرمانه و الگوریتم HS256
     * 6. تبدیل به رشته Compact
     *
     * @param email ایمیل کاربری که برای آن توکن ایجاد می‌کنیم
     * @return رشته Refresh Token JWT
     */
    public String generateRefreshToken(String email) {
        return Jwts.builder()
                .setSubject(email)
                .claim("type", "refresh")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + REFRESH_TOKEN_EXPIRATION))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * استخراج ایمیل (subject) از یک توکن JWT
     * 
     * عملیات:
     * 1. تأیید اعتبار امضای توکن
     * 2. استخراج claims (اطلاعات) از توکن
     * 3. بازگشت subject (ایمیل) از claims
     * 
     * نکته: این متد حتی برای توکن‌های منقضی‌شده هم کار می‌کند
     * (تا زمانی که فرمت و امضا درست باشند)
     * 
     * @param token رشته توکن JWT
     * @return ایمیل استخراج‌شده از توکن
     * @throws JwtException اگر توکن نامعتبر یا خراب باشد
     */
    public String extractEmail(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();
        } catch (ExpiredJwtException e) {
            // حتی اگر توکن منقضی شده باشد، ایمیل را استخراج می‌کنیم
            // این برای refresh token لازم است
            return e.getClaims().getSubject();
        }
    }

    /**
     * بررسی اعتبار یک توکن JWT
     *
     * عملیات:
     * 1. سعی می‌کند توکن را parse کند و اعتبار آن را تأیید کند
     * 2. اگر هی استثنایی رخ دهد، توکن نامعتبر است
     * 3. بازگشت true یا false
     *
     * @param token رشته توکن JWT
     * @return true اگر توکن معتبر باشد، false در غیر اینصورت
     */
    public boolean isTokenValid(String token) {
        try {
            Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            // توکن نامعتبر است
            return false;
        }
    }

    /**
     * بررسی نوع توکن (access یا refresh)
     *
     * @param token رشته توکن JWT
     * @return نوع توکن ("access" یا "refresh")
     * @throws JwtException اگر توکن نامعتبر باشد
     */
    public String getTokenType(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            return claims.get("type", String.class);
        } catch (ExpiredJwtException e) {
            // حتی اگر توکن منقضی شده باشد، نوع را استخراج می‌کنیم
            return e.getClaims().get("type", String.class);
        }
    }

    /**
     * بررسی اینکه آیا توکن یک Refresh Token است
     *
     * @param token رشته توکن JWT
     * @return true اگر توکن از نوع refresh باشد
     */
    public boolean isRefreshToken(String token) {
        String type = getTokenType(token);
        return "refresh".equals(type);
    }
}