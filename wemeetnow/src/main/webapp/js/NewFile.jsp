<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a id="kakao-link-btn" href="javascript:sendLink()">
  <img
    src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"
  />
</a>
<script type="text/javascript">
  function sendLink() {
    Kakao.Link.sendDefault({
      objectType: 'location',
      address: '경기 성남시 분당구 판교역로 235 에이치스퀘어 N동 8층',
      addressTitle: '카카오 판교오피스 카페톡',
      content: {
        title: '신메뉴 출시♥︎ 체리블라썸라떼',
        description: '이번 주는 체리블라썸라떼 1+1',
        imageUrl:
          'http://k.kakaocdn.net/dn/bSbH9w/btqgegaEDfW/vD9KKV0hEintg6bZT4v4WK/kakaolink40_original.png',
        link: {
          mobileWebUrl: 'https://developers.kakao.com',
          webUrl: 'https://developers.kakao.com',
        },
      },
      social: {
        likeCount: 286,
        commentCount: 45,
        sharedCount: 845,
      },
      buttons: [
        {
          title: '웹으로 보기',
          link: {
            mobileWebUrl: 'https://developers.kakao.com',
            webUrl: 'https://developers.kakao.com',
          },
        },
      ],
    })
  }
</script>
</body>
</html>