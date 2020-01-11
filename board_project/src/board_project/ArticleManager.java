package board_project;

import java.sql.Date;
import java.util.ArrayList;

/**
 * 게시물 관리를 위한 객체. 게시물을 조회 등의 기능을 제공할 것.
 */
public class ArticleManager {
	
	
	// 1. 게시물을 저장할 저장소 만들기.(ArrayList)
	static ArrayList<Article> aList = new ArrayList<Article>();
		
	public void init() {
		// 2. 테스트 게시물 5개 정도 생성자를 이용해 저장소에 저장하기
		Article a1 = new Article();

		a1.setId(1);
		a1.setTitle("제목1");
		a1.setBody("내용1");
		a1.setNick("작성자1");
		a1.setRegDate("20190817");

		Article a2 = new Article();

		a2.setId(2);
		a2.setTitle("제목2");
		a2.setBody("내용2");
		a2.setNick("작성자2");
		a2.setRegDate("20190817");

		Article a3 = new Article();

		a3.setId(3);
		a3.setTitle("제목3");
		a3.setBody("내용3");
		a3.setNick("작성자3");
		a3.setRegDate("20190817");

		Article a4 = new Article();

		a4.setId(4);
		a4.setTitle("제목4");
		a4.setBody("내용4");
		a4.setNick("작성자4");
		a4.setRegDate("20190817");

		Article a5 = new Article();

		a5.setId(5);
		a5.setTitle("제목5");
		a5.setBody("내용5");
		a5.setNick("작성자5");
		a5.setRegDate("20190817");

		Article a6 = new Article();

		a6.setId(6);
		a6.setTitle("제목6");
		a6.setBody("내용6");
		a6.setNick("작성자6");
		a6.setRegDate("20190817");

		aList.add(a1);
		aList.add(a2);
		aList.add(a3);
		aList.add(a4);
		aList.add(a5);
		aList.add(a6);
	}
			

	// 3. 조회 메서드를 만들어 저장소에 있는 게시물 가져오기
	public ArrayList<Article> getAllArticles() {
		return this.aList;
	}

	// 4. 특정 아이디로 게시물 index 찾기
	public int getArticleIndexById(int id) {
		for (int i = 0; i < aList.size(); i++) {
			if (id == aList.get(i).getId()) {
				return i;
			}
		}
		return -1;
	}

	// 5. 게시물 등록하기
	public void insertArticle(Article a) {
		
		a.setId(getLastId());
		a.setRegDate("20200111");
		aList.add(a);
	}
	
	public int getLastId() {
		return aList.size()+1;
	}

	// 6. 특정 게시물 수정하기
	public void getArticleModifyById(int id, String title, String body) {
		for (int i = 0; i < aList.size(); i++) {
			if (id == aList.get(i).getId()) {
				aList.get(i).setTitle(title);
				aList.get(i).setBody(body);
			}
		}
	}

	// 7. 특정 아이디로 게시물 찾기
	public Article getArticleById(int id) {
		for (int i = 0; i < aList.size(); i++) {
			if (id == aList.get(i).getId()) {
				return aList.get(i);
			}
		}
		return setArticle(id);
	}
	public Article setArticle(int id) {
		Article tmp = new Article();
		tmp.setId(id);
		insertArticle(tmp);
		return tmp;
	}
}
