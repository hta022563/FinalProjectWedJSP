<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${not empty listActivities}">
        <c:forEach items="${listActivities}" var="act">
            <div class="log-row d-flex align-items-center p-3 rounded-4 mb-3 position-relative">
                <%-- Cấu hình màu sắc & icon dựa trên Type --%>
                <c:choose>
                    <c:when test="${act.type == 'IMPORT'}">
                        <div class="d-flex align-items-center justify-content-center rounded-circle me-3 shadow-sm" style="width: 45px; height: 45px; background: rgba(16, 185, 129, 0.15); color: #10b981; border: 1px solid rgba(16,185,129,0.3);">
                            <i class="fa-solid fa-truck-ramp-box"></i>
                        </div>
                        <c:set var="titleColor" value="text-white" />
                        <c:set var="rightTag"><span class="badge bg-success bg-opacity-25 text-success border border-success border-opacity-50 px-2 py-1">#${act.referenceCode}</span></c:set>
                    </c:when>

                    <c:when test="${act.type == 'SECURITY'}">
                        <div class="d-flex align-items-center justify-content-center rounded-circle me-3 shadow-sm" style="width: 45px; height: 45px; background: rgba(239, 68, 68, 0.15); color: #ef4444; border: 1px solid rgba(239,68,68,0.3);">
                            <i class="fa-solid fa-shield-halved"></i>
                        </div>
                        <c:set var="titleColor" value="text-danger" />
                        <c:set var="rightTag"><span class="badge bg-danger text-white px-2 py-1 rounded-1 shadow-sm"><i class="fa-solid fa-ban me-1"></i>BLOCKED</span></c:set>
                    </c:when>

                    <c:when test="${act.type == 'ORDER'}">
                        <div class="d-flex align-items-center justify-content-center rounded-circle me-3 shadow-sm" style="width: 45px; height: 45px; background: rgba(251, 191, 36, 0.15); color: #fbbf24; border: 1px solid rgba(251,191,36,0.3);">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </div>
                        <c:set var="titleColor" value="text-warning" />
                        <c:set var="rightTag"><span class="text-success fw-bold fs-6">+ <fmt:formatNumber value="${act.amount}" type="number" pattern="#,###"/> ₫</span></c:set>
                    </c:when>

                    <c:otherwise>
                        <div class="d-flex align-items-center justify-content-center rounded-circle me-3 shadow-sm" style="width: 45px; height: 45px; background: rgba(56, 189, 248, 0.15); color: #38bdf8; border: 1px solid rgba(56,189,248,0.3);">
                            <i class="fa-solid fa-terminal"></i>
                        </div>
                        <c:set var="titleColor" value="text-info" />
                        <c:set var="rightTag"><span class="text-muted small font-monospace">#${act.referenceCode}</span></c:set>
                    </c:otherwise>
                </c:choose>

                <div class="flex-grow-1">
                    <h6 class="m-0 ${titleColor} fw-bold mb-1" style="font-size: 0.9rem;">${act.title}</h6>
                    <small class="text-white d-flex align-items-center" style="font-size: 0.75rem;">
                        <i class="fa-solid fa-network-wired me-1 opacity-50"></i> Node: ${act.createdBy} 
                        <span class="mx-2 opacity-25">|</span> 
                        <i class="fa-regular fa-clock me-1 opacity-50"></i> ${act.timeAgo}
                    </small>
                </div>

                <div class="d-flex flex-column align-items-end justify-content-center ms-3">
                    ${rightTag}
                    <div class="log-actions mt-2 d-flex gap-2">
                        <button class="btn btn-sm btn-outline-info rounded-circle d-flex align-items-center justify-content-center" style="width: 28px; height: 28px;" 
                                data-bs-toggle="modal" data-bs-target="#editLogModal"
                                onclick="prepareEditModal('${act.logId}', '${act.title}', '${act.type}', '${act.referenceCode}', '${act.amount}')">
                            <i class="fa-solid fa-pen" style="font-size: 0.7rem;"></i>
                        </button>
                        <a href="MainController?target=Dashboard&action=deleteLog&id=${act.logId}" 
                           class="btn btn-sm btn-outline-danger rounded-circle d-flex align-items-center justify-content-center" style="width: 28px; height: 28px;" 
                           onclick="return confirm('Cảnh báo: Xác nhận tiêu hủy dòng nhật ký hệ thống này?');">
                            <i class="fa-solid fa-trash" style="font-size: 0.7rem;"></i>
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>

    <c:otherwise>
        <div class="text-center p-5 mt-2 border border-danger border-opacity-50 rounded-4 position-relative overflow-hidden" style="background: rgba(220, 53, 69, 0.05);">
            <div class="position-absolute top-0 start-0 w-100 h-100 opacity-10" style="background: repeating-linear-gradient(45deg, transparent, transparent 10px, #dc3545 10px, #dc3545 20px);"></div>
            <div class="position-relative z-index-2">
                <div class="p-4 bg-danger bg-opacity-10 rounded-circle d-inline-flex mb-3 shadow-lg" style="border: 1px solid rgba(220, 53, 69, 0.3);">
                    <i class="fa-solid fa-satellite-dish text-danger fs-1 heartbeat-animation"></i>
                </div>
                <h5 class="text-danger fw-bold text-uppercase" style="letter-spacing: 2px;">Mất tín hiệu radar</h5>
                <p class="text-muted small mb-4">Hệ thống chưa ghi nhận giao dịch nào hoặc đường truyền bị gián đoạn.</p>
                <a href="MainController?target=Dashboard" class="btn btn-outline-danger rounded-pill px-5 py-2 fw-bold small">
                    <i class="fa-solid fa-plug me-2"></i> KÍCH HOẠT LẠI
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>