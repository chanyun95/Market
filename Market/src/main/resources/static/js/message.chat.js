$(function(){
	let message_socket;
	
	/*---------------------
	 * 채팅 회원 저장
	 *---------------------*/
	let member_list = []; //회원을 저장하는 배열
	
	/*---------------------
	 * 채팅 웹소켓 연결
	 *---------------------*/
	function connectWebSocket(){
		message_socket = new WebSocket('ws://localhost:8000/message-ws');
		
		
	};
	
});