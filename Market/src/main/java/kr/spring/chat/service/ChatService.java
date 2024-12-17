package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import kr.spring.chat.vo.ChatVO;

public interface ChatService {
	

	//채팅 메시지 등록
	public void insertChat(ChatVO chatVO);

	//메시시 읽기
	public List<ChatVO> selectChatDetail(Map<String, Long> map);

	
}
