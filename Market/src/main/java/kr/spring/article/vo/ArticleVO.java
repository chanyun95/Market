package kr.spring.article.vo;

import java.sql.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ArticleVO {
   private long arti_num;
   private long mem_num;
   @NotEmpty(message = "카테고리는 필수 입력 항목입니다.")
   private String arti_category;
   
   @NotEmpty(message = "제목은 필수 입력 항목입니다.")
   private String arti_name;
   
   @NotEmpty(message = "내용은 필수 입력 항목입니다.")
   private String arti_content;
   
   @Min(value = 10, message = "가격은 최소 10 이상이어야 합니다.")
   private int arti_price;
   
   private MultipartFile arti_upload;
   private byte[] arti_image;
   
   private Date arti_reg;
   private Date arti_modify;
   
   private int arti_hit;
   
   @NotNull(message = "판매 여부는 필수 입력 항목입니다.")
   private Character arti_sold = 'N'; // 기본값 설정
   
   @NotEmpty(message = "거래 장소는 필수 입력 항목입니다.")
   private String arti_location;
   
   @NotEmpty(message = "장소명은 필수 입력 항목입니다.")
   private String arti_location2;
   
}

