<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 지시자(directive) jsp 태그: jsp 페이지의 속성 및 정보, import 문을 표현할 때 사용합니다. -->
<%@ page import = com.jsp.entity.Dancer; %>
<%@ page import = com.jsp.repository.DancerRepository; %>


<%
    // 스크립틀릭(scriptlet)
    // jsp파일에서 자바 문법을 사용할 수 있게 해주는 jsp 태그.
    // jsp파일이 서블릿(클래스)으로 변환될 때, 스크립틀릿에 작성된 내용은 서블릿 메서드 바디로 적용됩니다.

    // POST방식에서 전달된 깨짐 방지 메서드
            req.setCharacterEncoding("UTF-8");

            // 제공된 form에 작성된 사용자의 입력값 가져오기
            String name = req.getParameter("name");
            String crewName = req.getParameter("crewName");
            String danceLevel = req.getParameter("danceLevel");
            // checkbox같이 여러 값을 전달받는 경우에는 getParameterValues를 사용합니다. -> String 배열로 리턴됩니다.
            String[] genres = req.getParameterValues("genres");


            // 얻어온 입력값을 save()에게 전달 -> 객채 생성 및 Map에 저장까지 일괄처리
            DancerRepository.save(name, crewName, danceLevel, genres);

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>jsp 버전 댄서 리스트</h1>
<ul>

      <%
        for (Dancer dancer : DancerRepository.findAll()) {
            // jsp 파일 내에서는 브라우저로 바로 출력을 담당하는 out 내장 객체의 writr()를 사용합니다.
            out.write(String.format("<li># 이름 : %s, 크루명: %s, 수준: %s, 공연당페이: %d원, 장르: %s</li>\n"
                    , dancer.getName(), dancer.getCrewName(),
                    dancer.getDanceLevel().getLevelDescription(),
                    dancer.getDanceLevel().getPayPerEvent(),
                    dancer.getGenres()));
        }
      %>

</ul>

<a href="/chap03/dancer/register">새로운 등록하기</a>


</body>
</html>