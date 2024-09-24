package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import kr.spring.chat.vo.ChatMemberVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;

public interface ChatService {
	
	//채팅방 생성
	public void insertChatRoom(ChatRoomVO chatRoomVO);
	//채팅방 멤버 읽기
	public List<ChatMemberVO> selectChatMember(Long chatroom_num);
	//채팅 메시지 등록
	public void insertChat(ChatVO chatVO);
	//채팅방 목록
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	//메시시 읽기
	public List<ChatVO> selectChatDetail(Map<String, Long> map);

	
}
