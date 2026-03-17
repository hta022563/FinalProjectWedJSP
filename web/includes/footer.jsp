<%-- File: web/includes/footer.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <style>
        /* CSS Dành riêng cho Footer F-AUTO */
        .f-auto-footer {
            background-color: #0d0d0d; /* Nền đen sâu thẳm */
            color: #a0a0a0;
            border-top: 1px solid rgba(212, 175, 55, 0.2); /* Viền trên màu vàng mờ */
            font-family: 'Montserrat', sans-serif;
        }
        .footer-heading {
            color: #fff;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            font-size: 1.1rem;
        }
        /* Gạch chân màu vàng dưới tiêu đề cột */
        .footer-heading::after {
            content: '';
            display: block;
            width: 40px;
            height: 3px;
            background-color: #D4AF37;
            margin-top: 10px;
            border-radius: 5px;
        }
        .footer-link {
            color: #a0a0a0;
            text-decoration: none;
            transition: all 0.3s ease;
            display: block;
            margin-bottom: 12px;
            font-size: 0.95rem;
        }
        /* Hiệu ứng mũi tên nhích nhẹ khi hover */
        .footer-link:hover {
            color: #D4AF37;
            transform: translateX(8px);
        }
        .footer-contact-info i {
            color: #D4AF37;
            width: 25px;
            font-size: 1.1rem;
        }
        .social-icon-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255,255,255,0.05);
            color: #fff;
            transition: all 0.4s ease;
            text-decoration: none;
            margin-right: 10px;
            border: 1px solid transparent;
        }
        .social-icon-btn:hover {
            background-color: transparent;
            border-color: #D4AF37;
            color: #D4AF37;
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        .footer-bottom {
            background-color: #050505;
            border-top: 1px solid rgba(255,255,255,0.05);
        }
      /* Form đăng ký nhận tin */
        .newsletter-input {
            background-color: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
        }

        /* -- THÊM ĐOẠN NÀY ĐỂ CHỮ PLACEHOLDER SÁNG LÊN NÈ -- */
        .newsletter-input::placeholder {
            color: rgba(255, 255, 255, 0.6) !important; /* Chữ xám sáng */
            font-size: 0.9rem;
            font-style: italic; /* In nghiêng nhẹ cho sang */
        }

        .newsletter-input:focus {
            background-color: rgba(255,255,255,0.1);
            border-color: #D4AF37;
            color: #fff;
            box-shadow: none;
        }
        .btn-newsletter {
            background-color: #D4AF37;
            color: #000;
            font-weight: bold;
            transition: 0.3s;
        }
        .btn-newsletter:hover {
            background-color: #FFD700;
        }
    </style>

    <footer class="f-auto-footer mt-auto pt-5">
        <div class="container pt-3">
            <div class="row mb-5">
                
                <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                    <a href="home.jsp" class="text-decoration-none">
                        <h2 class="luxury-logo mb-4" style="font-size: 1.8rem; display: inline-block;">F-AUTO</h2>
                    </a>
                    <p class="mb-4 pe-lg-4" style="line-height: 1.7; font-size: 0.95rem;">
                        Nhà phân phối siêu xe và xe sang đẳng cấp hàng đầu Việt Nam. Khẳng định vị thế và phong cách sống thượng lưu của riêng bạn qua từng vòng lăn bánh.
                    </p>
                    <div class="footer-contact-info">
                        <p class="mb-3 d-flex align-items-start"><i class="fa-solid fa-location-dot mt-1"></i> <span>TP.HCM</span></p>
                        <p class="mb-3"><i class="fa-solid fa-phone"></i> Hotline CSKH: <span class="text-white fw-bold">0909 090909</span></p>
                        <p class="mb-3"><i class="fa-solid fa-envelope"></i> Email: <span class="text-white">hta02256app@gmail.com</span></p>
                    </div>
                </div>

                <div class="col-lg-2 col-md-6 mb-4 mb-lg-0">
                    <h5 class="footer-heading">Khám Phá</h5>
                    <ul class="list-unstyled">
                        <li><a href="ProductController" class="footer-link">Bộ Sưu Tập Xe</a></li>
                        <li><a href="ProductController" class="footer-link">Phụ Tùng & Đồ Chơi</a></li>
                        <li><a href="NewsController" class="footer-link">Tin Tức & Sự Kiện</a></li>
                        <li><a href="#" class="footer-link">Chương Trình Khuyến Mãi</a></li>
                        <li><a href="#" class="footer-link">Về F-AUTO</a></li>
                    </ul>
                </div>

                <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                    <h5 class="footer-heading">Hỗ Trợ Khách Hàng</h5>
                   <!--<ul class="list-unstyled">
                        <li><a href="#" class="footer-link">Đăng Ký Lái Thử Cảm Nhận</a></li>
                        <li><a href="#" class="footer-link">Chính Sách Bảo Hành Cơ Bản</a></li>
                        <li><a href="#" class="footer-link">Hướng Dẫn Mua Xe Trả Góp</a></li>
                        <li><a href="#" class="footer-link">Bảo Mật Thông Tin Khách Hàng</a></li>
                        <li><a href="#" class="footer-link">Câu Hỏi Thường Gặp (FAQ)</a></li>
                    </ul>--> 
                </div>

                <div class="col-lg-3 col-md-6">
                    <h5 class="footer-heading">Bản Tin F-AUTO</h5>
                    <p style="font-size: 0.9rem; line-height: 1.6;" class="mb-4">
                        Đăng ký email để không bỏ lỡ các mẫu siêu xe mới nhất và những đặc quyền giới hạn dành riêng cho bạn.
                    </p>
                    <form action="" class="mb-4">
                        <div class="input-group">
                          
                            
                        </div>
                    </form><!-- <div class="social-icons mt-4">
                        <a href="#" class="social-icon-btn" title="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                        <a href="#" class="social-icon-btn" title="YouTube"><i class="fa-brands fa-youtube"></i></a>
                        <a href="#" class="social-icon-btn" title="Instagram"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#" class="social-icon-btn" title="TikTok"><i class="fa-brands fa-tiktok"></i></a>
                    </div>-->
                    
                </div>

            </div>
        </div>

       <div class="footer-bottom py-4">
            <div class="container">
                
                <%-- Khung cảnh báo mục đích học tập --%>
                <div class="row justify-content-center mb-4">
                    <div class="col-lg-10">
                        <div class="p-3" style="background-color: rgba(212, 175, 55, 0.05); border: 1px solid rgba(212, 175, 55, 0.3); border-radius: 8px; text-align: justify;">
                            <h6 style="color: #D4AF37; font-weight: 700; letter-spacing: 1px; margin-bottom: 10px;">
                                 DISCLAIMER
                            </h6>
                            <p style="color: #888; font-size: 0.8rem; line-height: 1.6; margin-bottom: 0;">
                                Website <strong>F-AUTO Showroom</strong> được xây dựng hoàn toàn phục vụ cho mục đích học tập, nghiên cứu và hoàn thành đồ án môn học. Chúng tôi <strong>không</strong> thực hiện bất kỳ hoạt động kinh doanh, mua bán, hay giao dịch thương mại thực tế nào trên nền tảng này. Mọi hình ảnh, logo, tên thương hiệu (như Mercedes-Benz, Audi, Porsche, Ford...) và thông số kỹ thuật xuất hiện trên website đều thuộc đặc quyền sở hữu của các nhà sản xuất tương ứng và chỉ được chúng tôi sử dụng nhằm mục đích mô phỏng giao diện học thuật. Nhóm phát triển không chịu trách nhiệm về tính chính xác của các dữ liệu và không đại diện cho bất kỳ thương hiệu ô tô nào.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <p class="mb-0" style="font-size: 0.9rem; color: #6c757d; letter-spacing: 0.5px;">
                        &copy; 2026 F-AUTO Showroom. Designed & Developed by <b>F-AUTO Team</b>. All rights reserved.
                    </p>
                </div>
                
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>