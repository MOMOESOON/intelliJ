<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache">
<title>우리 북카페</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/list.css?v=3">  
	<!-- ${pageContext.request.contextPath } 는 /jspBoard : 프로젝트이름, 웹서비스 이름-->
</head>
<body>
<main id="list">
<h3>북챗 :: 커뮤니티</h3>
<p>오늘 무슨 책을 읽으셨나요? </p>
<hr style="color:white;">
<div style="margin:auto;width:900px;">
<ul id="main">   <!-- 선택자 #list ul#main -->
	<li>
		<ul  class="row">   <!-- 선택자 #list ul.row -->
			<li>번호</li>
			<li>제목</li>
			<li>작성자</li>
			<li>조회수</li>
			<li>작성일</li>
		</ul>
	</li>
	
 	<th:block th:each="vo:${list}">
	<li>
		<ul  class="row">
			<li>
				<th:out value="${vo.r }"/>
			</li>
			<li><a href="read?idx=${vo.idx }&page=${paging.currentPage}" class="title">  
												<!-- 현재페이지 번호 전달 시작 -순서1) -->
					<th:out value="${vo.title }"/>
				</a>
		 		..<span style="color:orange;font-size: 80%;">(<th:out value="${vo.commentCount }"/>)
		 		</span></li>
			<li>
				<th:out value="${vo.writer }"/><%-- (<c:out value="${vo.ip }"/>) --%>
			</li>
			<li>
				<th:out value="${vo.readCount }"/>
			</li>
			<li>
			<!-- vo.createdAt 날짜 패턴을 적용한 결과 문자열을 createdAt 새로운 변수로 저장 -->
			<th:formatDate value="${vo.createdAt }" pattern="yyyy-MM-dd" var="createdAt"/>
			<!-- 오늘 작성한 글은 시간으로 표시 -->
			<th:if test='${createdAt == today}'>
				<fmt:formatDate value="${vo.createdAt }" type="time"/>
			</th:if>
			<!-- 오늘 이전에 작성한 글은 날짜로 표시 -->
			<th:if test='${createdAt != today}'>
				<fmt:formatDate value="${vo.createdAt }" pattern="yyyy-MM-dd"/>
			</th:if>
			</li>
			
		</ul>
	</li>
 	</th:block>
	</ul>
	<div style="float:right;margin:40px;">
		<%-- <a href="write.jsp?page=${paging.currentPage }" class="button" >글쓰기</a>   --%>
		<!-- 글쓰기 할때 로그인을 하도록 한다면 자바스크립트 함수로 로그인 여부 확인합니다. -->
		<a href="write" class="button">글쓰기</a>
		<a href="${pageContext.request.contextPath}" class="button" >홈</a>
		<!-- contextPath로 url 요청하면 웰컴리스트에 해당하는 index.jsp 로 알아서 요청/화면출력
			 ㄴ web.xml
		-->
	</div>
</div>
<script type="text/javascript"> /* javascript:write() */
if('${message}'.length !=0)
	alert('${message}');
	
	function write() {
		let yn
		if('${user.id}'==''){  /* 로그인여부 검사: user는 session 에 저장된 애트리뷰트 */
			yn=confirm('글쓰기는 로그인이 필요합니다. 로그인 하시겠습니까?')
			if(yn) location.href='../login?back=w'  // 로그인 후 글쓰기 url로 redirect 하기 위한 파라미터
		}else{
			location.href='write?page=${paging.currentPage }'
		}
	}
</script>

<!-- 페이지 버튼을 클릭하면  url은  http://localhost:8081/jspBoard/community/list.jsp 는 동일하고 
	 page 번호 파라미터만 변경됩니다.  이런 경우 앞의 부분 생략하고 ? 부터 작성.
-->
<div style="width:700px;margin: auto;padding: 10px;text-align: center;">
	전체 글 개수 : <c:out value="${paging.totalCount }"/> <br>
	<hr>
	<a class="pagenum" href="?page=1">&lt;&lt;</a>   <!--(1) 첫번째 페이지 1번으로 이동 -->
	
	<!--(2)  실행하면서 파악해보세요. --> <!-- 요청은 ListController가 받음.page파라미터 변경됨. -->
	<a class="pagenum" href="?page=${paging.startPage-1 }"      
			style='<c:if test="${paging.startPage==1 }">display:none;</c:if>' >&lt;</a>
	
	<!--(3) 페이지 범위 startPage 부터 endPage 까지 반복 -->
	<c:forEach var="i" begin="${paging.startPage }" end="${paging.endPage }">
		<a class="pagenum ieach" href="?page=${i }"><c:out value="${i }"/></a>
		<!-- 클래스이름 ieach는 자바스크립트에서 숫자 a 태그 요소만 가져가기 위해 붙인 이름 -->
	</c:forEach>
	
	<!--(4)  실행하면서 파악해보세요. -->
	<a class="pagenum" href="?page=${paging.endPage+1 }"
			style='<c:if test="${paging.endPage==paging.totalPage }">display:none;</c:if>'	>&gt;</a>
			<!-- paging.totalPage 는 마지막페이지 -->
	<a class="pagenum" href="?page=${paging.totalPage }">&gt;&gt;</a>  <!--(5) 가장 마지막 페이지로 이동 -->
</div>
</main>
<script type="text/javascript">
	const pnums = document.querySelectorAll('.ieach');
	pnums.forEach(function(item){   /* forEach로 숫자 a태그를 하나씩 item 에 저장 */
		console.log(item);
		/* item 번호가 현재 페이지 이면 글꼴 스타일을 다르게함. */
		if(item.innerHTML=='${paging.currentPage}') {     /* a태그의 숫자와 현재페이지가 같은지 검사 */
			item.style.color = 'black';
			item.style.fontWeight = 'bold';
		}else{
			item.style.color = '#37966f';
		}
	});
</script>
</body>
</html>













