import * as functions from 'firebase-functions'
//import * as admin from 'firebase-admin'
//admin.initializeApp(functions.config().firebase)


export const onCreateShuffleUser = 
functions.region('europe-west3').firestore.
document('shuffleUser/{id}').onCreate(async (snap, context) => { 
    // try {
    //     //get
    //     const firestore = admin.firestore();
    //     const shuffleUser = ShuffleUser.fromMap(snap);
    //     //delete ShuffleUser
        
    //     firestore
    //         .collection('shuffleUser')
    //         .doc(shuffleUser.shuffleUserId)
    //         .delete().catch(err => null)
    //         .then(() => console.log('this will succeed'))
    //         .catch(() => 'obligatory catch');
    //     //find ChatPartner
    //     const shufflePartner = await firestore
    //         .collection('shuffleUser')
    //         .limit(1)
    //         .get()
    //         .then((value) =>
    //             ShuffleUser.fromMap(value.docs[0]));
    //     //delete ShuffleUserChatPartner
    //     firestore
    //         .collection('shuffleUser')
    //         .doc(shufflePartner.shuffleUserId)
    //         .delete().catch(err => null)
    //         .then(() => console.log('this will succeed'))
    //         .catch(() => 'obligatory catch');
    //     //create ChatRoom
    //     const docId = shuffleUser.shuffleUserId + '_' + shufflePartner.shuffleUserId;
    //     const chatRoom : ChatRoom = {
    //         user0 : shuffleUser.shuffleUserId,
    //         user1 : shufflePartner.shuffleUserId,
    //         user0Typing : false,
    //         user1Typing : false,
    //         chatRoomId : docId
    //     };
    //     firestore
    //         .collection('chatRoom')
    //         .doc(docId)
    //         .create(chatRoom).catch(err => null)
    //         .then(() => console.log('this will succeed'))
    //         .catch(() => 'obligatory catch');
    //   } catch (e) {
        
    //   }
  
});

// class ShuffleUser {
//     static shuffleUserId: string;
    
//     static fromMap(map:functions.firestore.QueryDocumentSnapshot) {
//         this.shuffleUserId = map.id;
//       return this;
//     }
//   }

// class ChatRoom {
//     user0: string;
//     user1: string;
//     user0Typing: boolean;
//     user1Typing: boolean;
//     chatRoomId: string;

//     constructor(user0: string, user1: string, user0Typing: boolean, user1Typing: boolean, chatRoomId: string){
//         this.user0 = user0;
//         this.user1 = user1;
//         this.user0Typing = user0Typing;
//         this.user1Typing = user1Typing;
//         this.chatRoomId = chatRoomId;
//     }
//   }
  