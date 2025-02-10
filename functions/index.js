const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore, FieldValue } = require("firebase-admin/firestore");

// Firebase Admin SDK 初期化
initializeApp();
const db = getFirestore();

exports.incrementStockScore = onDocumentCreated(
  "users/hogehoge/stocks/{stockId}",
  async (event) => {
    const userRef = db.collection("users").doc("hogehoge");

    try {
      await userRef.update({
        stockScore: FieldValue.increment(5),
      });
      console.log(`Stock score incremented by 5 for user ${userId}`);
    } catch (error) {
      console.error("Error incrementing stock score:", error);
    }
  }
);
