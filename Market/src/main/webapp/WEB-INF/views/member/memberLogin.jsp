<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
img{
  width: 100%;
}
.login-container {
     width: 800px;
     margin-left: auto;
     margin-right: auto;
     margin-bottom: 100px;
     padding-left: 15px;
     padding-right: 15px;
     padding-bottom:15px;
     position: relative;
     top:60px;
}
</style>
<div class="login-container">
	<section class="login">
		<div class="login_box">
			<div class="left">
				<div class="contact">		
				<form:form action="login" id="member_login" modelAttribute="memberVO">
					<ul>
						<li>
							<form:input path="mem_id" placeholder="아이디" autocomplete="off"/>
							<form:errors path="mem_id" cssClass="error-color"/>
						</li>
						<li>
							<form:password path="mem_passwd" placeholder="비밀번호"/>
							<form:errors path="mem_passwd" cssClass="error-color"/>
						</li>
					</ul>
					<div class="flame">
						<form:errors element="div" cssClass="error-color"/>
						<form:button style="display: block; margin: 0 auto;" class="submit custom-btn btn-15">로그인</form:button>
					</div>
					<div class="button-container">
						<label for="auto">
						<input type="checkbox" name="auto" id="auto">자동로그인</label>
						<input type="button" value="아이디 찾기" style="margin-right:10px; margin-left:80px;" onclick="location.href='memberFindId'">
						<input type="button" value="비밀번호 찾기" onclick="location.href='sendMemPassword'">
					</div>
				</form:form>
				</div>
			</div>
			<div class="right">
				<div class="right-text">
					<h2>Market</h2>
		      		<h5>중고거래</h5>
				</div>
			</div>
		</div>
	</section>
	
</div>
