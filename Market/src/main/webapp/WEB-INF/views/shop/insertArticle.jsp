<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="container">
	<h2>��ǰ���</h2>
	<form:form action="insertArticle" id="article_insert" enctype="multipart/form-data" modelAttribute="articleVO">
		<ul>
			<li>
				<input type="file" name="arti_upload" id="arti_upload">
			</li>
			<li>
			    <form:label path="arti_category">ī�װ�</form:label>
			    <form:select path="arti_category">
			        <option disabled="disabled" selected>�����ϼ���</option>
			        <form:option value="���ڱ��">���ڱ��</form:option>
			        <form:option value="������ǰ">������ǰ</form:option>
			        <form:option value="����">����</form:option>
			        <form:option value="�Ƿ�">�Ƿ�</form:option>
			        <form:option value="�ڵ���">�ڵ���</form:option>
			        <form:option value="������/����">������/����</form:option>
			        <form:option value="������ǰ">������ǰ</form:option>
			        <form:option value="����/����/��ȭ">����/����/��ȭ</form:option>
			        <form:option value="����/�繫��ǰ">����/�繫��ǰ</form:option>
			        <form:option value="�峭��">�峭��</form:option>
			        <form:option value="��Ÿ">��Ÿ</form:option>
			    </form:select>
			</li>
			<li>
				<form:label path="arti_name">����</form:label>
				<form:input path="arti_name" placeholder="����"/>
				<form:errors path="arti_name" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_price">����</form:label>
				<form:input path="arti_price" placeholder="������ �Է����ּ���."/>
				<form:errors path="arti_price" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_content">�ڼ��� ����</form:label>
				<form:input path="arti_content" placeholder="�ŷ��� �� �ִ� �ŷ��� ���� �ڼ��� �����ּ���.(�Ǹű��� ��ǰ�� �Խð� ���ѵ� �� �ֽ��ϴ�.)"/>
				<form:errors path="arti_content" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_location">�ŷ� ��� ���</form:label>
				<form:input path="arti_location" placeholder="�ŷ� �ּ�"/>
				<input type="button" onclick="DaumPostcode()" value=">" class="default-btn">
				<form:errors path="arti_location" error="error-color"/>
			</li>
			<li>
				<form:label path="arti_location2">������ �ּ��� ��Ҹ��� �Է����ּ���</form:label>
				<form:input path="arti_location2" placeholder="��) ������ 1�� �ⱸ,����Ÿ�� ��"/>
				<form:errors path="arti_location2" error="error-color"/>
			</li>
		</ul>
		<div class="button-insert">
			<input type="button" value="���" id="reload_btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">		
			<form:button class="default-btn fw-7 fs-17">��ǰ ���</form:button>
		</div>
	</form:form>
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="�ݱ� ��ư">
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // �����ȣ ã�� ȭ���� ���� element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe�� ���� element�� �Ⱥ��̰� �Ѵ�.
        element_layer.style.display = 'none';
    }

    function DaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var addr = ''; // �ּ� ����
                var extraAddr = ''; // �����׸� ����

                //����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                    addr = data.roadAddress;
                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                    addr = data.jibunAddress;
                }

                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����׸��� �����Ѵ�.
                if(data.userSelectedType === 'R'){
                    // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
                    // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
                    if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(����)address1�� �����׸��� ���������� ����
                    // ���յ� �����׸��� �ش� �ʵ忡 �ִ´�.
                    //(����) document.getElementById("address2").value = extraAddr;
                
                } 
                //(����) else {
                //(����)    document.getElementById("address2").value = '';
                //(����) }

                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                //document.getElementById('mem_zipcode').value = data.zonecode;
                //(����) + extraAddr�� �߰��ؼ� address1�� �����׸��� ���������� ����
                document.getElementById("arti_location").value = addr + extraAddr;
                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
                document.getElementById("arti_location2").focus();

                // iframe�� ���� element�� �Ⱥ��̰� �Ѵ�.
                // (autoClose:false ����� �̿��Ѵٸ�, �Ʒ� �ڵ带 �����ؾ� ȭ�鿡�� ������� �ʴ´�.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe�� ���� element�� ���̰� �Ѵ�.
        element_layer.style.display = 'block';

        // iframe�� ���� element�� ��ġ�� ȭ���� ����� �̵���Ų��.
        initLayerPosition();
    }

    // �������� ũ�� ���濡 ���� ���̾ ����� �̵���Ű���� �ϽǶ�����
    // resize�̺�Ʈ��, orientationchange�̺�Ʈ�� �̿��Ͽ� ���� ����ɶ����� �Ʒ� �Լ��� ���� ���� �ֽðų�,
    // ���� element_layer�� top,left���� ������ �ֽø� �˴ϴ�.
    function initLayerPosition(){
        var width = 300; //�����ȣ���񽺰� �� element�� width
        var height = 400; //�����ȣ���񽺰� �� element�� height
        var borderWidth = 5; //���ÿ��� ����ϴ� border�� �β�

        // ������ ������ ������ ���� element�� �ִ´�.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // ����Ǵ� ������ ȭ�� �ʺ�� ���� ���� �����ͼ� �߾ӿ� �� �� �ֵ��� ��ġ�� ����Ѵ�.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</div>