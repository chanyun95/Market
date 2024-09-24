package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ChatMemberVO {
	private long chatroom_num;
	private long mem_num;
	private String room_name;
	
	private String id;
}
