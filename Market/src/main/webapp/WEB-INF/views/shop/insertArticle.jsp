<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="container">
	<h2>상품등록</h2>
	<form:form action="insertArticle" id="article_insert" enctype="multipart/form-data" modelAttribute="articleVO">
		<ul>
			<li>
				<input type="file" name="arti_upload" id="arti_upload">
			</li>
			<li>
			    <form:label path="arti_category">카테고리</form:label>
			    <form:select path="arti_category">
			        <option disabled="disabled" selected>선택하세요</option>
			        <form:option value="전자기기">전자기기</form:option>
			        <form:option value="가전제품">가전제품</form:option>
			        <form:option value="가구">가구</form:option>
			        <form:option value="의류">의류</form:option>
			        <form:option value="자동차">자동차</form:option>
			        <form:option value="스포츠/레저">스포츠/레저</form:option>
			        <form:option value="가정용품">가정용품</form:option>
			        <form:option value="도서/음악/영화">도서/음악/영화</form:option>
			        <form:option value="문구/사무용품">문구/사무용품</form:option>
			        <form:option value="장난감">장난감</form:option>
			        <form:option value="기타">기타</form:option>
			    </form:select>
			</li>
			<li>
				<form:label path="arti_name">제목</form:label>
				<form:input path="arti_name" placeholder="제목"/>
				<form:errors path="arti_name" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_price">가격</form:label>
				<form:input path="arti_price" placeholder="가격을 입력해주세요."/>
				<form:errors path="arti_price" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_content">자세한 설명</form:label>
				<form:input path="arti_content" placeholder="신뢰할 수 있는 거래를 위해 자세히 적어주세요.(판매금지 물품은 게시가 제한될 수 있습니다.)"/>
				<form:errors path="arti_content" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_location">거래 희망 장소</form:label>
				<form:input path="arti_location" placeholder="거래 주소"/>
				<input type="button" onclick="DaumPostcode()" value=">" class="default-btn">
				<form:errors path="arti_location" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_location2">선택한 주소의 장소명을 입력해주세요</form:label>
				<form:input path="arti_location2" placeholder="예) 강남역 1번 출구,교보타워 앞"/>
				<form:errors path="arti_location2" error="error-color"/>
			</li>
		</ul>
		<div class="button-insert">
			<input type="button" value="취소" id="reload_btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">		
			<form:button class="default-btn fw-7 fs-17">물품 등록</form:button>
		</div>
	</form:form>
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('mem_zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("arti_location").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("arti_location2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</div>