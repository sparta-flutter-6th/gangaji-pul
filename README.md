# 강아지풀 - 반려견 산책 인증 어플

<img src="https://github.com/user-attachments/assets/d69b7809-40be-45ea-b61c-e8dc3c2adef4"  width="200" height="200

 
## 📌 프로젝트 소개

강아지가 풀냄새를 맡으며 천천히 걷는 그 시간을 놓치지 않도록 도와주는 산책 유도 앱 입니다.

## 🌟 기획배경

바쁜 일상 속, 강아지 산책을 자꾸 미루게 되는 현실
하지만 강아지에게 산책은 단순한 운동이 아니라 ‘세상과의 소통’


특히 풀냄새를 맡는 건 스트레스 해소와 행복감을 높이는 중요한 시간


그래서 산책 알림, 산책 인증, 유저 간 공감을 통해
 “산책을 습관으로 만들고 싶은 보호자”를 위한 앱을 만들었어요


## 📱 스크린샷

![Screenshot_1747967064](https://github.com/user-attachments/assets/dbb74154-c7b0-4137-bf7c-8e3ac3045ce0)
![Screenshot_1747967060](https://github.com/user-attachments/assets/f0bef8a6-9c2e-42ed-849d-6f519d764d02)
![Screenshot_1747967021](https://github.com/user-attachments/assets/cd9728ae-4290-4392-b6c8-35e12b19dc58)
![Screenshot_1747967017](https://github.com/user-attachments/assets/3daf8462-dd19-4114-a52b-19c72c60c47b)
![Screenshot_1747967012](https://github.com/user-attachments/assets/49a6eed4-e7a2-4699-b3c7-4d4b07ea6f79)
![Screenshot_1747967003](https://github.com/user-attachments/assets/090af913-140c-4fb1-a285-7c195f05d9c6)
![Screenshot_1747966996](https://github.com/user-attachments/assets/6dc8a8a2-9113-411b-a750-ddd98ba97e60)


## 🎯 주요 기능

📸 산책 인증: 사진으로 산책 기록 남기기

🐾 발자국 트래킹: 산책할수록 마이페이지에 발자국 쌓임

⏰ 산책 알림: 설정한 시간에 알림 받기

🐶 강아지 감지: 사진 속 강아지 자동 인식

💬 소통 기능: 댓글과 좋아요로 응원 주고받기

🏆 유저 랭킹: 활동 많은 유저 순위 제공


## 📋 프로젝트 구조

```
lib
 ┣ const
 ┃ ┗ color_const.dart
 ┣ core
 ┃ ┗ banner_ad_unit_id.dart
 ┣ data
 ┃ ┣ data_source
 ┃ ┃ ┣ chat_data_source.dart
 ┃ ┃ ┣ chat_data_source_impl.dart
 ┃ ┃ ┣ like_data_source.dart
 ┃ ┃ ┣ like_data_source_impl.dart
 ┃ ┃ ┣ post_data_source.dart
 ┃ ┃ ┣ post_data_source_impl.dart
 ┃ ┃ ┣ rank_data_source.dart
 ┃ ┃ ┣ rank_data_source_impl.dart
 ┃ ┃ ┣ user_data_source.dart
 ┃ ┃ ┗ user_data_source_impl.dart
 ┃ ┣ dto
 ┃ ┃ ┣ chat_dto.dart
 ┃ ┃ ┣ comment_dto.dart
 ┃ ┃ ┗ post_dto.dart
 ┃ ┣ providers
 ┃ ┃ ┣ chat_data_source_provider.dart
 ┃ ┃ ┣ chat_repository_provider.dart
 ┃ ┃ ┣ post_data_source_provider.dart
 ┃ ┃ ┣ post_like_data_source_provider.dart
 ┃ ┃ ┣ post_like_repository_provider.dart
 ┃ ┃ ┣ post_repository_provider.dart
 ┃ ┃ ┣ post_submission_provider.dart
 ┃ ┃ ┣ rank_data_source_provider.dart
 ┃ ┃ ┣ rank_repository_provider.dart
 ┃ ┃ ┗ user_providers.dart
 ┃ ┗ repository
 ┃ ┃ ┣ chat_repository_impl.dart
 ┃ ┃ ┣ comment_repository_impl.dart
 ┃ ┃ ┣ post_like_repository_impl.dart
 ┃ ┃ ┣ post_repository_impl.dart
 ┃ ┃ ┣ rank_repository_impl.dart
 ┃ ┃ ┗ user_repository_impl.dart
 ┣ domain
 ┃ ┣ entity
 ┃ ┃ ┣ chat_entity.dart
 ┃ ┃ ┣ comment_entity.dart
 ┃ ┃ ┣ post_entity.dart
 ┃ ┃ ┣ post_view_entity.dart
 ┃ ┃ ┣ rank_entity.dart
 ┃ ┃ ┗ user_model.dart
 ┃ ┗ repository
 ┃ ┃ ┣ chat_repository.dart
 ┃ ┃ ┣ comment_repository.dart
 ┃ ┃ ┣ post_like_repository.dart
 ┃ ┃ ┣ post_repository.dart
 ┃ ┃ ┣ rank_repository.dart
 ┃ ┃ ┗ user_repository.dart
 ┣ presentation
 ┃ ┣ common
 ┃ ┃ ┗ custom_snackbar.dart
 ┃ ┣ providers
 ┃ ┃ ┣ auth_state_provider.dart
 ┃ ┃ ┣ chat_view_model_provider.dart
 ┃ ┃ ┣ comment_provider.dart
 ┃ ┃ ┣ post_like_view_model_provider.dart
 ┃ ┃ ┣ post_view_model_provider.dart
 ┃ ┃ ┗ rank_stream_provider.dart
 ┃ ┣ view
 ┃ ┃ ┣ board_page
 ┃ ┃ ┃ ┣ widget
 ┃ ┃ ┃ ┃ ┣ ad_banner_widget.dart
 ┃ ┃ ┃ ┃ ┣ chat_input.dart
 ┃ ┃ ┃ ┃ ┣ chat_list.dart
 ┃ ┃ ┃ ┃ ┣ ranking_board.dart
 ┃ ┃ ┃ ┃ ┗ ranking_profile.dart
 ┃ ┃ ┃ ┗ board_page.dart
 ┃ ┃ ┣ home_page
 ┃ ┃ ┃ ┣ widget
 ┃ ┃ ┃ ┃ ┣ comment_bottom_sheet.dart
 ┃ ┃ ┃ ┃ ┣ post_info_column.dart
 ┃ ┃ ┃ ┃ ┗ post_like_button.dart
 ┃ ┃ ┃ ┗ home_page.dart
 ┃ ┃ ┣ my_page
 ┃ ┃ ┃ ┣ widgets
 ┃ ┃ ┃ ┃ ┣ grass_board.dart
 ┃ ┃ ┃ ┃ ┣ guest_my_page.dart
 ┃ ┃ ┃ ┃ ┗ logged_in_my_page.dart
 ┃ ┃ ┃ ┗ my_page.dart
 ┃ ┃ ┣ splash_page
 ┃ ┃ ┃ ┗ splash.dart
 ┃ ┃ ┣ _widgets
 ┃ ┃ ┃ ┣ load_profile_image.dart
 ┃ ┃ ┃ ┗ walk_alarm_card.dart
 ┃ ┃ ┣ bottom_nav_bar.dart
 ┃ ┃ ┗ writing_page.dart
 ┃ ┗ view_model
 ┃ ┃ ┣ chat_view_model.dart
 ┃ ┃ ┣ comment_view_model.dart
 ┃ ┃ ┣ post_like_view_model.dart
 ┃ ┃ ┣ post_submission_view_model.dart
 ┃ ┃ ┣ post_view_model.dart
 ┃ ┃ ┣ user_view_model.dart
 ┃ ┃ ┗ yolo_view_model.dart
 ┣ service
 ┃ ┣ alarm
 ┃ ┃ ┗ notification_helper.dart
 ┃ ┣ provider
 ┃ ┃ ┗ analytics_service_provider.dart
 ┃ ┣ yolo
 ┃ ┃ ┗ yolo_detection.dart
 ┃ ┣ analytics_service.dart
 ┃ ┣ analytics_service_impl.dart
 ┃ ┣ auth_service.dart
 ┃ ┗ auth_service_impl.dart
 ┣ firebase_options.dart
 ┣ main.dart
 ┗ router.dart
```

## 📋 firebase 데이터 구조

###  users

```
users
 └─ {userId}
     ├─ name
     ├─ email
     ├─ profileImageUrl
     ├─ postCount
     ├─ likeCount
     └─ chatCount
```

###  chats
```
chats
 └─ {chatId}
     ├─ message
     ├─ user (DocumentReference)
     └─ createdAt
```

###  posts
```
posts
 └─ {postId}
     ├─ content
     ├─ userId
     ├─ createdAt
     ├─ updatedAt
     ├─ imageUrl
     ├─ tags
     ├─ likeCount
     ├─ commentCount
     ├─ comments (subcollection)
     │    └─ {commentId}
     │         ├─ text
     │         ├─ userId
     │         ├─ parentId
     │         └─ timestamp
     └─ likes (subcollection)
          └─ {userId}
               └─ likedAt
```

###  topUsers
```
topUsers
 └─ topUsersByChatCount
     └─ users: [
          { uid, name, count, ... },
          ...
        ]
 └─ topUsersByPostCount
     └─ users: [
          { uid, name, count, ... },
          ...
        ]
 └─ topUsersBylikeCount
     └─ users: [
          { uid, name, count, ... },
          ...
        ]
```


## 📋 firebase cloud function

- **incrementUserPostCount**: 게시글 작성 시 postCount 증가
- **decrementUserPostCount**: 게시글 삭제 시 postCount 감소
- **incrementUserlikeCount**: 좋아요 누를 때 likeCount 증가
- **decrementUserlikeCount**: 좋아요 취소 시 likeCount 감소
- **incrementUserChatCount**: 채팅 발생 시 chatCount 증가


## 📦 패키지

프로젝트에서 사용된 주요 패키지:

- **Riverpod**: 상태관리 및 의존성 주입
- **Google Sign In**: 로그인
- **Go Router**: 라우팅
- **TFLite Flutter**: 사진 물체 감지
- **Flutter Local Notifications**: 알림 
- **Sentry Flutter**: 모니터링 및 에러 추적
- **Google Mobile Ads**: 광고
- **Cloud Firestore**: 데이터베이스
- **Firebase Functions**: 백그라운드 이벤트

## 👥 팀원

| 이름                           | GitHub                                      |
| ------------------------------ | ------------------------------------------- |
| 유일송                          | [ilsong963](https://github.com/ilsong963)   |
| 김영우                          | [K-uz](https://github.com/K-uz)         |
| 김동연                          | [kdy5487](https://github.com/kdy5487)   |
| 전진주                          | [jinju9513](https://github.com/jinju9513)       |
