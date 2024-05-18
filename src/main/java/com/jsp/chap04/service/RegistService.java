package com.jsp.chap04.service;

import com.jsp.entity.Dancer;
import com.jsp.repository.DancerRepository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class RegistService implements IDancerService{
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // POST방식에서 전달된 깨짐 방지 메서드
        request.setCharacterEncoding("UTF-8");

        // 제공된 form에 작성된 사용자의 입력값 가져오기
        String name = request.getParameter("name");
        String crewName = request.getParameter("crewName");
        String danceLevel = request.getParameter("danceLevel");
        // checkbox같이 여러 값을 전달받는 경우에는 getParameterValues를 사용합니다. -> String 배열로 리턴됩니다.
        String[] genres = request.getParameterValues("genres");

        // 얻어온 입력값을 save()에게 전달 -> 객채 생성 및 Map에 저장까지 일괄처리
        DancerRepository.save(name, crewName, danceLevel, genres);

        ///////////////////// 등록은 여기까지 //////////////////////////////////////////////////////////////

        // 등록이 완료되었으므로, 지금까지 등록된 댄서의 목록을 화면에 보여주고 싶다.
        // MVC 구조에서 화면 응답은 VIEW가 전담하기 때문에, 서비스는 repository로부터 목록을 받아와서
        // View단으로 데이를 넘기겠다. (request에 담아서 전달하자)


        // 댄서 목록들 받아오기
        List<Dancer> dancerList = DancerRepository.findAll();

        // request에 담자
        // setAttribute("이름", 저장할 값) -> 이름을 통해 값을 얻을 수 있습니다.
        request.setAttribute("dl", dancerList);


        // 서비스의 역할은  여기까지 입니다.
        // 화면단 결정은 Controller의 몫입니다.



    }
}
