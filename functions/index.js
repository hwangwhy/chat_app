const functions = require('firebase-functions/v2');
const admin = require('firebase-admin');

admin.initializeApp();

// Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
exports.myFunction = functions.firestore
  .onDocumentCreated('chat/{messageId}', async (snapshot, context) => {
    const message = {
      notification: {
        title: snapshot.data()['username'],
        body: snapshot.data()['text'],
      },
      data: {
        // Data payload to be sent to the device.
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
      topic: 'chat',
    };

    try {
      // Send the message using Firebase Cloud Messaging
      await admin.messaging().send(message);
      console.log('Notification sent successfully');
    } catch (error) {
      console.error('Error sending notification:', error);
    }
  });
