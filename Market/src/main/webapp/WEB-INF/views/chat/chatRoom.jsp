<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<!-- 물품정보 -->
	<div>
		<div>
			<img src="${pageContext.request.contextPath}/upload/${article.arti_image}">
		</div>
		<div>
			${article.arti_name}<br>
			${article.arti_price}
		</div>
	</div>
	<!-- 채팅 바디 -->
	<div id="chat_message"></div>
	<!-- 채팅 전송 폼 -->
	<div>
		<form action="#" id="chat_write">
			<input type="hidden" name="chatroom_num" value="${chat.chatroom_num}">
			<textarea rows="5" cols="40" name="message" id="message"></textarea>
			<div>
				<input type="submit" value="전송">		
			</div>
		</form>
	</div>
</div>