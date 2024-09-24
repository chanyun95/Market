<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!-- 채팅방 생성 -->
<div>
	<h2>채팅 생성</h2>
	<form action="chatRoomWrite" method="post" id="chat_form">
		<input type="hidden" name="members" id="user" data-id="${user.mem_id}" value="${user.mem_num}">
		<ul>
			<li>
				<label for="basic_name">채팅방</label>
				<input type="hidden" name="basic_name" id="basic_name">
				<span id="name_span"></span>
				<input type="checkbox" checked id="name_checked">(자동생성)
			</li>
		</ul>
	</form>
</div>