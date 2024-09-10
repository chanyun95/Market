<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<div class="container">
	<h2>��ǰ ���</h2>
	<div>
		<a href="artiList">��ü</a>
		<a href="artiList?arti_category='���ڱ��'">��ü</a>
		<a href="artiList?arti_category='���ڱ��'">���ڱ��</a>
		<a href="artiList?arti_category='������ǰ'">������ǰ</a>
		<a href="artiList?arti_category='����'">����</a>
		<a href="artiList?arti_category='�Ƿ�'">�Ƿ�</a>
		<a href="artiList?arti_category='�ڵ���'">�ڵ���</a>
		<a href="artiList?arti_category='������/����'">������/����</a>
		<a href="artiList?arti_category='������ǰ'">������ǰ</a>
		<a href="artiList?arti_category='����/����/��ȭ'">����/����/��ȭ</a>
		<a href="artiList?arti_category='����/�繫��ǰ'">����/�繫��ǰ</a>
		<a href="artiList?arti_category='�峭��'">�峭��</a>
		<a href="artiList?arti_category='��Ÿ'">��Ÿ</a>
	</div>
	<form action="artiList" id="search_form" method="get">
		<input type="hidden" name="arti_category" value="${param.arti_category}">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>��ǰ��</option>
					<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>����</option>
					<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>��ǰ��+����</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="ã��">
			</li>
		</ul>
		<div>
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>��ȸ��</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>���ݼ�</option>
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
				<input type="button" value="��ǰ ���" onclick="location.href='insertArticle'">
			</c:if>
		</div>
	</form>
	<c:if test="${count == 0}">
		<div>
			ǥ���� ��ǰ�� �����ϴ�.
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
							�ŷ��Ϸ�
						</div>
					</c:if>
					<div>
						<b>${article.arti_price}</b>��
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









