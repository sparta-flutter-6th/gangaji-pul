const {onDocumentCreated, onDocumentDeleted} =
 require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

initializeApp();
const db = getFirestore();

exports.incrementUserPostCount =
onDocumentCreated("/posts/{postId}", async (event) => {
  const uid = event.data.data().uid;
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
    topUsersByPostCount}, {merge: true});
});
// exports.decrementUserPostCount =
// onDocumentDeleted("/posts/{postId}", async (event) => {
//   const uid = event.data.data().uid;
//   const docRef = db.collection("users").doc(uid);
//   const doc = await docRef.get();
//   await docRef.update({
//     "postCount": doc.data().postCount - 1,
//   });
//   const snapshot = await db.collection("users")
//       .orderBy("postCount", "desc")
//       .limit(1)
//       .get();
//   const topUser = snapshot.docs[0].data();
//   await db.collection("topUsers").doc("1").set({
//     "topUser": topUser.uid}, {merge: true});
// });
exports.incrementUserlikeCount =
onDocumentCreated("/posts/{postId}/likes/{userId}", async (event)=>{
  const {postId} = event.params;
  const postRef = db.collection("posts").doc(postId);
  const post = await postRef.get();
  const uid = post.data().uid;
  const docRef = db.collection("users").doc(uid);
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
    topUsersBylikeCount}, {merge: true});
});

exports.decrementUserlikeCount =
onDocumentDeleted("/posts/{postId}/likes/{userId}", async (event)=>{
  const {postId} = event.params;
  const postRef = db.collection("posts").doc(postId);
  const post = await postRef.get();
  const uid = post.data().uid;
  const docRef = db.collection("users").doc(uid);
  const user = await docRef.get();
  await docRef.update({
    "likeCount": user.data().likeCount > 0 ? user.data().likeCount- 1 : 0,
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
    topUsersBylikeCount}, {merge: true});
});
