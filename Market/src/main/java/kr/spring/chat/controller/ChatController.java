package kr.spring.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.member.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;
	@Autowired
	private MemberService memberService;
	
	/*====================
	 	채팅방 생성
	 =====================*/
	@GetMapping("/chat/chatRoomWrite")
	public String chatRoomWrite() {
		return "chatRoomWrite";
	}
	
	
	/*====================
	 	채팅방 목록
	 =====================*/
	
	/*====================
	 	메시지 처리
	 =====================*/
	
	/*====================
	 	채팅 회원 검색
	 =====================*/
	
	/*====================
	 	채팅 메시지 전송
	 =====================*/
	
	/*====================
	 	채팅 메시지 읽기
	 =====================*/
	
	/*====================
	 	초대한 회원 id 구하기
	 =====================*/
}
