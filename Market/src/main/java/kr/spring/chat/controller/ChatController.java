package kr.spring.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
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
	@PostMapping("/chat/chatRoomWrite")
	public String chatRoomSubmit(ChatRoomVO vo,HttpSession session) {
		log.debug("<<채팅방 생성>> : "+vo);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		vo.setChatVO(new ChatVO());
		vo.getChatVO().setMem_num(user.getMem_num());
		
		chatService.insertChatRoom(vo);
		
		return "redirect:/chat/chatDetail";
	}
	
	
	
	/*====================
	 	채팅방 목록
	 =====================*/
	
	/*====================
	 	메시지 처리
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
	private String findMemberId(ChatRoomVO vo,MemberVO user) {
		String member_id = "";
		long[] members = vo.getMembers();
		for(int i=0;i<members.length;i++) {
			String temp_id = memberService.selectMember(members[i]).getMem_id();
			//채팅보낸 회원의 아이디 제외
			if(!user.getMem_id().equals(temp_id)) {
				member_id += temp_id;
				if(i < members.length-1) member_id += ", ";
			}
		}
		return member_id;
	}
}
