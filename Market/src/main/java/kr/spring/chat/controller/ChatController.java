package kr.spring.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

import kr.spring.util.PagingUtil;
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
	@GetMapping("/chat/chatRoom")
	public String chatRoom() {
		return "chatRoom";
	}
	/*====================
	 	채팅방 목록
	 =====================*/
	@GetMapping("/chat/chatList")
	public String chatList(@RequestParam(defaultValue="1") int pageNum,
										HttpSession session,Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("mem_num", user.getMem_num());
		
		int count = chatService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(null,null,pageNum,count,20,10,"chatList");
		
		List<ChatRoomVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = chatService.selectChatRoomList(map);
		}
		model.addAttribute("count",count);
		model.addAttribute("chatList",list);
		model.addAttribute("page",page.getPage());
		
		return "chatList";
	}
	
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
