const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.onPostCreate = functions.firestore
    .document("posts/{postId}")
    .onCreate((snap, context) => {
        const newPost = snap.data();
        const uid = newPost.uid;
        console.log("새 게시물 작성자 UID:", uid);

        // 예: 알림 보내기, 로깅, 다른 문서 업데이트 등 가능
        return null;
    });

exports.onPostDelete = functions.firestore
    .document('posts/{postId}')
    .onDelete((snap, context) => {
        const deletedPost = snap.data();
        const uid = deletedPost.uid;
        console.log('삭제된 게시물 작성자 UID:', uid);

        // 삭제 후 처리할 작업 추가 가능 (예: 통계 감소, 알림 등)

        return null;
    });