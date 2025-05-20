const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

initializeApp();

exports.countPost = onDocumentCreated("/posts/{postId}", async (event) => {
  const uid = event.data.data().uid;
  const docRef = getFirestore().collection("users").doc(uid);
  const doc = await docRef.get();
  docRef.update({
    "postCount": doc.data().postCount + 1,
  });
});
