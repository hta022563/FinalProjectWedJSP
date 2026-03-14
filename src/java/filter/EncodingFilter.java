package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

// Dấu /* nghĩa là BẮT BUỘC MỌI REQUEST (User, Showroom, Cart...) đều phải qua đây
@WebFilter(filterName = "EncodingFilter", urlPatterns = {"/*"})
public class EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        
        // 1. Ép kiểu chuẩn cho Response
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        // 2. TẠO LỚP GIÁP TÀNG HÌNH (Ghi đè hoàn toàn cơ chế lấy Parameter)
        HttpServletRequestWrapper wrappedRequest = new HttpServletRequestWrapper(httpRequest) {
            @Override
            public String getParameter(String name) {
                String value = super.getParameter(name);
                if (value != null) {
                    try {
                        // Tự động "giặt sạch" dữ liệu từ ISO sang UTF-8 ngầm bên dưới
                        // Đây là cách né GlassFish triệt để nhất
                        return new String(value.getBytes("ISO-8859-1"), "UTF-8");
                    } catch (Exception e) {
                        return value;
                    }
                }
                return null;
            }
        };

        // 3. Đẩy gói hàng đã được "giặt sạch" đi tiếp vào MainController
        chain.doFilter(wrappedRequest, response);
    }

    @Override public void init(FilterConfig filterConfig) throws ServletException {}
    @Override public void destroy() {}
}