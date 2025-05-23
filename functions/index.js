const { onDocumentCreated, onDocumentDeleted } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
const { getFirestore } = require("firebase-admin/firestore");
admin.initializeApp();
const db = getFirestore();
exports.incrementUserPostCount =
  onDocumentCreated("/posts/{postId}", async (event) => {
    const uid = event.data.data().userId;
    const docRef = db.collection("users").doc(uid);
    const doc = await docRef.get();
    await docRef.update({
      "postCount": doc.data().postCount + 1,
    });
    const snapshot = await db.collection("users")
      .orderBy("postCount", "desc")
      .limit(3)
      .get();
    const topUsersByPostCount = snapshot.docs.map((doc) => ({
      uid: doc.id,
      ...doc.data(),
    }));
    await db.collection("topUsers").doc("topUsersByPostCount").set({
      "users": [...topUsersByPostCount]
    }, { merge: true });
  });
exports.decrementUserPostCount =
  onDocumentDeleted("/posts/{postId}", async (event) => {
    const uid = event.data.data().userId;
    const docRef = db.collection("users").doc(uid);
    const doc = await docRef.get();
    await docRef.update({
      "postCount": doc.data().postCount - 1,
    });
    const snapshot = await db.collection("users")
      .orderBy("postCount", "desc")
      .limit(3)
      .get();
    const topUsersByPostCount = snapshot.docs.map((doc) => ({
      uid: doc.id,
      ...doc.data(),
    }));
    await db.collection("topUsers").doc("topUsersByPostCount").set({
      "users": [...topUsersByPostCount]
    }, { merge: true });
  });
exports.incrementUserlikeCount =
  onDocumentCreated("/posts/{postId}/likes/{userId}", async (event) => {
    const { postId } = event.params;
    const postRef = await db.collection("posts").doc(postId).get();
    const userId = postRef.data().userId;
    const docRef = db.collection("users").doc(userId);
    const user = await docRef.get();
    await docRef.update({
      "likeCount": user.data().likeCount + 1,
    });
    const snapshot = await db.collection("users")
      .orderBy("likeCount", "desc")
      .limit(3)
      .get();
    const topUsersBylikeCount = snapshot.docs.map((doc) => ({
      uid: doc.id,
      ...doc.data(),
    }));
    await db.collection("topUsers").doc("topUsersBylikeCount").set({
      "users": [...topUsersBylikeCount]
    }, { merge: true });
  });
exports.decrementUserlikeCount =
  onDocumentDeleted("/posts/{postId}/likes/{userId}", async (event) => {
    const { postId } = event.params;
    const postRef = await db.collection("posts").doc(postId).get();
    const userId = postRef.data().userId;
    const docRef = db.collection("users").doc(userId);
    const user = await docRef.get();
    await docRef.update({
      "likeCount": user.data().likeCount > 0 ? user.data().likeCount - 1 : 0,
    });
    const snapshot = await db.collection("users")
      .orderBy("likeCount", "desc")
      .limit(3)
      .get();
    const topUsersBylikeCount = snapshot.docs.map((doc) => ({
      uid: doc.id,
      ...doc.data(),
    }));
    await db.collection("topUsers").doc("topUsersBylikeCount").set({
      "users": [...topUsersBylikeCount]
    }, { merge: true });
  });
exports.incrementUserChatCount =
  onDocumentCreated("/chats/{chatId}", async (event) => {
    const chatData = event.data?.data();
    if (!chatData) return;
    const userPath = chatData.user;
    const userId = userPath.id; // 안전한 접근 방식
    console.log("유저 ID:", userId);
    const docRef = db.collection("users").doc(userId);
    const user = await docRef.get();
    await docRef.update({
      "chatCount": user.data().chatCount + 1,
    });
    const snapshot = await db.collection("users")
      .orderBy("chatCount", "desc")
      .limit(3)
      .get();
    const topUsersByChatCount = snapshot.docs.map((doc) => ({
      uid: doc.id,
      ...doc.data(),
    }));
    await db.collection("topUsers").doc("topUsersByChatCount").set({
      "users": [...topUsersByChatCount]
    }, { merge: true });
  });