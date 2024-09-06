package kr.spring.article.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ArticleVO {
   private long arti_num;
   @NotEmpty
   private String arti_category;
   @NotEmpty
   private String arti_name;
   @NotEmpty
   private String arti_content;
   @Min(10)
   private int arti_price;
   private byte[] arti_image;
   private Date arti_reg;
   private Date arti_modify;
   private int arti_hit;
   private char arti_sold;
   @NotEmpty
   private String arti_location;
   @NotEmpty
   private String arti_location2;
   
   //이미지 BLOB 처리
   public void setUpload(MultipartFile upload)throws IOException {
      //MultipartFile > byte[] 
      setArti_image(upload.getBytes());
   }
}
