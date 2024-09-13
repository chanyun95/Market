<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="container">
	<h3>상품 상세</h3>
	<div>
		<c:if test="${fn:contains(article.arti_image, ',')}">
			<c:set var="imageList" value="${fn:split(article.arti_image, ',')}"/>
			<c:set var="firstImage" value="${imageList[0]}"/>
		</c:if>
		<c:if test="${!fn:contains(article.arti_image, ',')}">
			<c:set var="firstImage" value="${article.arti_image}"/>
		</c:if>
		<div id="artiImage">
			<div class="carousel-inner">
				<c:if test="${!empty article.arti_image}">
					<c:if test="${fn:contains(article.arti_image, ',')}">
						<c:forEach var="article" items="${artiList}" varStatus="sratus">
							<c:if test="${status.first}">
								<div class="carousel-item active">
									<img src="${pageContext.request.contextPath}/upload/${arti_image}">
								</div>
							</c:if>
							<c:if test="${!status.first}">
								<div class="carousel-item">
									<img src="${pageContext.request.contextPath}/upload/${arti_image}">
								</div>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${!fn:contains(article.arti_image, ',')}">
						<div class="carousel-item active">
							<img src="${pageContext.request.contextPath}/upload/${firstImage}">
						</div>
					</c:if>
				</c:if>
				<c:if test="${empty article.arti_image}">
					<div class="carousel-item active">
						<img src="${pageContext.request.contextPath}/images/logo.png">
					</div>
				</c:if>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#artiImage" data-bs-slide="prev">
		        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		        <span class="visually-hidden">이전</span>
		    </button>
		    <button class="carousel-control-next" type="button" data-bs-target="#artiImage" data-bs-slide="next">
		        <span class="carousel-control-next-icon" aria-hidden="true"></span>
		        <span class="visually-hidden">다음</span>
		    </button>
		</div>
	</div>
	<div>
		<c:if test="${user.mem_num == article.mem_num or user_auth == 9}">
			<input type="button" onclick="deleteArticle" value="물품 삭제" id="delete_btn">
			<script type="text/javascript">
				const delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick = function(){
					const choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('delete?arti_num=${article.arti_num}');
					}
				};
			</script>
		</c:if>
		<c:if test="${user.mem_num == article.mem_num}">
			<input type="button" onclick="updateSold_btn" value="판매 확정">
			<input type="button" onclick="location.href='update?arti_num=${article.arti_num}'" value="물품 정보 수정">
		</c:if>
	</div>
	<div>
		<div>
			<img src="${pageContext.request.contextPath}/member/memPhotoView" width="40" height="40" class="border rounded-circle">
		</div>
		<div>
			<div>${article.mem_id}</div>
			<div>${article.arti_location}</div>
		</div>
	</div>
	<hr size="1" noshade="noshade" style="width:90%;">
	<div>
		<div>
			<div>${article.arti_name}</div>
			<div><b>${article.arti_price}</b>원</div>
			<c:if test="${empty article.arti_modify}">
				<div>${article.arti_category} ∙ ${article.arti_reg}</div>	
			</c:if>
			<c:if test="${!empty article.arti_modify}">
				<div>${article.arti_category} ∙ ${article.arti_modify}</div>	
			</c:if>
		</div>
		<div>
			<div>${article.arti_content}</div>
		</div>
		<div>
			<div>∙ 조회 ${article.arti_hit}</div>
		</div>
	</div>
	<div>
		<c:if test="${user_num == article.mem_num}">
			<input type="button" value="나에게 온 채팅">
		</c:if>
		<c:if test="${user_num != article.mem_num}">
			<input type="button" value="채팅하기">
		</c:if>
	</div>
	<div>
		<h3>다른 물품 둘러보기</h3>
		<div>
			<c:forEach var="article" items="${artiList}" varStatus="loop">
				<c:if test="${fn:contains(article.arti_image, ',')}">
					<c:set var="imageList" value="${fn:split(article.arti_image, ',')}"/>
					<c:set var="firstImage" value="${imageList[0]}"/>
				</c:if>
				<c:if test="${!fn:contains(article.arti_image, ',')}">
					<c:set var="firstImage" value="${article.arti_image}"/>
				</c:if>
				<div>
					<div>
						<c:if test="${empty firstImage}">
							<a href="detail?arti_num=${article.arti_num}">
								<img src="${pageContext.request.contextPath}/images/logo.png" style="width:100px; height:100px">
							</a>
						</c:if>
						<c:if test="${!empty firstImage}">
							<a href="detail?arti_num=${article.arti_num}">
								<img src="${pageContext.request.contextPath}/upload/${firstImage}" style="width:100px; height:100px">
							</a>
						</c:if>
					</div>
					<div>
						<a href="detail?arti_num=${article.arti_num}">
							<div> ${article.arti_name} </div>	
							<div> ${article.arti_price} </div>
							<div> ${article.arti_location} </div>					
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>