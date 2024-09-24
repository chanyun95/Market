package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ChatRoomVO {
	private long chatroom_num;
	private String basic_name;
	private String chatroom_date;
	
	private long[] members;
	private long mem_num;
	private int room_cnt;
	
	private ChatVO chatVO;
	private ChatMemberVO chatMemberVO;
}
