<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <%-- [R] READ: KHI CÓ DỮ LIỆU --%>
    <c:when test="${not empty listActivities}">
        <c:forEach items="${listActivities}" var="act">
            <%-- Giữ nguyên class để khớp với CSS ở trang Dashboard chính --%>
            <div class="d-flex align-items-center p-3 rounded-4 bg-white bg-opacity-5 mb-3 transition-all table-row-hover border border-white border-opacity-10">

                <%-- Phân loại Icon & Màu sắc --%>
                <c:choose>
                    <c:when test="${act.type == 'IMPORT'}">
                        <div class="p-3 bg-success bg-opacity-10 text-success rounded-circle me-3"><i class="fa-solid fa-check"></i></div>
                        <c:set var="titleColor" value="text-info" />
                        <c:set var="rightTag"><span class="text-info fw-bold small">#${act.referenceCode}</span></c:set>
                    </c:when>
                    <c:when test="${act.type == 'SECURITY'}">
                        <div class="p-3 bg-danger bg-opacity-10 text-danger rounded-circle me-3"><i class="fa-solid fa-shield-halved"></i></div>
                        <c:set var="titleColor" value="text-danger" />
                        <c:set var="rightTag"><span class="badge bg-danger text-white px-2 py-1 rounded-pill small">BLOCKED</span></c:set>
                    </c:when>
                    <c:when test="${act.type == 'ORDER'}">
                        <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-circle me-3"><i class="fa-solid fa-cart-shopping"></i></div>
                        <c:set var="titleColor" value="text-warning" />
                        <c:set var="rightTag"><span class="text-success fw-bold small">+ <fmt:formatNumber value="${act.amount}" type="currency" currencySymbol="đ"/></span></c:set>
                    </c:when>
                    <c:otherwise>
                        <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-circle me-3"><i class="fa-solid fa-terminal"></i></div>
                        <c:set var="titleColor" value="text-muted" />
                        <c:set var="rightTag"><span class="text-muted small">#${act.referenceCode}</span></c:set>
                    </c:otherwise>
                </c:choose>

                <%-- Nội dung hiển thị --%>
                <div class="flex-grow-1">
                    <h6 class="m-0 ${titleColor} fw-bold small">${act.title}</h6>
                    <small class="text-muted" style="font-size: 0.7rem;">Node: ${act.createdBy} | ${act.timeAgo}</small>
                </div>

                <%-- Bộ nút CRUD (Update & Delete) --%>
                <div class="d-flex align-items-center ms-2">
                    ${rightTag}

                    <button class="btn btn-link text-info ms-2 p-0 opacity-50 hover-opacity-100" 
                            data-bs-toggle="modal" 
                            data-bs-target="#editLogModal"
                            onclick="prepareEditModal('${act.logId}', '${act.title}', '${act.type}', '${act.referenceCode}', '${act.amount}')">
                        <i class="fa-solid fa-pen-to-square"></i>
                    </button>

                    <a href="DashboardController?action=deleteLog&id=${act.logId}" 
                       class="text-danger ms-2 opacity-50 hover-opacity-100" 
                       onclick="return confirm('Xác nhận xóa log?');">
                        <i class="fa-solid fa-trash-can"></i>
                    </a>
                </div>
            </div>
        </c:forEach>
    </c:when>

    <%-- KHI TRỐNG DỮ LIỆU --%>
    <c:otherwise>
        <div class="text-center p-4 mt-3 border border-danger border-opacity-25 rounded-4" style="background: rgba(220, 53, 69, 0.05);">
            <div class="p-4 bg-danger bg-opacity-10 rounded-circle d-inline-flex mb-3 shadow-sm">
                <i class="fa-solid fa-satellite-dish text-danger fs-1"></i>
            </div>
            <h5 class="text-danger fw-bold">Mất kết nối luồng dữ liệu</h5>
            <a href="DashboardController" class="btn btn-danger rounded-pill px-5 py-2 fw-bold shadow-lg small">KÍCH HOẠT</a>
        </div>
    </c:otherwise>
</c:choose>