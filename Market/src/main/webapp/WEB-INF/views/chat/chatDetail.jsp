<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 채팅 메시지 처리 시작 -->
<script src="${pageContext.request.contextPath}/js/message.talk.js"></script>
<div id="chatDetail" class="page-main">
	<h1 id="chatroom_title">
		<span id="chatroom_name">${room_name}</span> 채팅방
	</h1> 
	<div class="align-right">
	    <input type="button" value="목록" onclick="location.href='talkList'">
	</div>
	<div id="chatting_message"></div>
	<form id="detail_form">
		<input type="hidden" name="talkroom_num" id="talkroom_num" value="${param.talkroom_num}">	
	    <textarea rows="5" cols="40" name="message" id="message"></textarea>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>
</div>
<!-- 채팅 메시지 처리 끝 -->







