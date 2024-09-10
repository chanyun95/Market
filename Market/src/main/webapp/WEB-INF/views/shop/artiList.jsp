<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<div class="container">
	<h2>상품 목록</h2>
	<div>
		<a href="artiList">전체</a>
		<a href="artiList?arti_category='전자기기'">전체</a>
		<a href="artiList?arti_category='전자기기'">전자기기</a>
		<a href="artiList?arti_category='가전제품'">가전제품</a>
		<a href="artiList?arti_category='가구'">가구</a>
		<a href="artiList?arti_category='의류'">의류</a>
		<a href="artiList?arti_category='자동차'">자동차</a>
		<a href="artiList?arti_category='스포츠/레저'">스포츠/레저</a>
		<a href="artiList?arti_category='가정용품'">가정용품</a>
		<a href="artiList?arti_category='도서/음악/영화'">도서/음악/영화</a>
		<a href="artiList?arti_category='문구/사무용품'">문구/사무용품</a>
		<a href="artiList?arti_category='장난감'">장난감</a>
		<a href="artiList?arti_category='기타'">기타</a>
	</div>
	<form action="artiList" id="search_form" method="get">
		<input type="hidden" name="arti_category" value="${param.arti_category}">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>상품명</option>
					<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>상품명+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul>
		<div>
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>조회수</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>가격순</option>
			</select>
			<script type="text/javascript">
				$('#order').change(function(){
					location.href='list?arti_category=${param.arti_category}&keyfield='
													+$('#keyfield').val()+'&keyword=' 
													+$('#keyword').val()+'&order='
													+$('#order').val();
				});
			</script>
			<c:if test="${!empty user}">
				<input type="button" value="상품 등록" onclick="location.href='insertArticle'">
			</c:if>
		</div>
	</form>
	<c:if test="${count == 0}">
		<div>
			표시할 상품이 없습니다.
		</div>
	</c:if>
	<c:if test="${count > 0}">
		<div>
			<c:forEach var="article" items="${artiList}">
				<div style="border-bottom:1px solid black;">
					<div>
						<c:if test="${!empty article.arti_image}">
							<img width="80" height="80" src="${pageContext.request.contextPath}/upload/${article.arti_image}">
						</c:if>
					</div>
					<div>
						${article.arti_name}
					</div>
					<div>
						${article.arti_location}
					</div>
					<c:if test="${article.arti_sold == Y}">
						<div>
							거래완료
						</div>
					</c:if>
					<div>
						<b>${article.arti_price}</b>원
					</div>
					<div>
						${article.arti_hit}
					</div>
				</div>
			</c:forEach>
		</div>
		<div style="text-align:center;">${page}</div>
	</c:if>
</div>









