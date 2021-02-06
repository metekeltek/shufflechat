import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp(functions.config().firebase)


export const onCreateShuffleUser = 
functions.region('europe-west3').firestore.
document('shuffleUser/{id}').onCreate(async (snap, context) => { 
    try {
        //get
        const firestore = admin.firestore();
        const shuffleUser = new ShuffleUser(snap);

        let shufflePartner = {} as ShuffleUser;
        //find ChatPartner
        await firestore
            .collection('shuffleUser')
            .where('shuffleUserId', '!=', shuffleUser.shuffleUserId)
            .get()
            .then((response) => {
                for (let item of response.docs) {
                    let possibleShufflePartner = new ShuffleUser(item);


                    if(shuffleUser.lastShuffle === possibleShufflePartner.shuffleUserId || possibleShufflePartner.lastShuffle === shuffleUser.shuffleUserId){
                        continue;
                    }

                    let matchingUser = HelperFunctions.matchingUser(shuffleUser, possibleShufflePartner);
                    if (matchingUser === true) {
                        shufflePartner = possibleShufflePartner;
                        return;
                    }
                } 
            }).catch(err => console.log('[find ChatPartner] error catch:' + err)).then((value)=> value);
        
        if(Object.entries(shufflePartner).length === 0){
            return;
        } 
        
        //delete ShuffleUser
        firestore
            .collection('shuffleUser')
            .doc(shuffleUser.shuffleUserId)
            .delete().catch(err => console.log('[delete ShuffleUser] error catch:' + err))
            .then(() => null)
            .catch(() => 'obligatory catch');
        //delete ShuffleUserChatPartner
        firestore
            .collection('shuffleUser')
            .doc(shufflePartner.shuffleUserId)
            .delete().catch(err => console.log('[delete ShuffleUserChatPartner] error catch:' + err))
            .then(() => null)
            .catch(() => 'obligatory catch');

        //create ChatRoom
        const docId = shuffleUser.shuffleUserId + '_' + shufflePartner.shuffleUserId;
        const users: Array<any> = [shuffleUser.shuffleUserId, shufflePartner.shuffleUserId];
        const usersTyping: Array<any> = [false, false];
        const chatRoom : ChatRoom = {
            users : users,
            usersTyping : usersTyping,
            chatRoomId : docId
        };
        firestore
            .collection('chatRoom')
            .doc(docId)
            .create(chatRoom).catch(err => console.log('[create ChatRoom] error catch:' + err))
            .then(() => null)
            .catch(() => 'obligatory catch');
      } catch (e) {
        console.log('Matching Error: ' + e);
      }
  
});

export const onDeleteChatRoom = 
functions.region('europe-west3').firestore.
document('chatRoom/{id}').onDelete(async (snap, context) => { 
    const firestore = admin.firestore();
    await firestore
            .collection('chatRoom')
            .doc(snap.id)
            .collection('chat')
            .get()
            .then((value) => value.docs.forEach( async (doc) => {
                await firestore
                .collection('chatRoom')
                .doc(snap.id)
                .collection('chat')
                .doc(doc.id).delete()
                .catch(err => console.log('[delete message] error catch:' + err)).then((value2)=> value2);
                console.log('deleted message');
            }
            ))
            .catch(err => console.log('[delete chat] error catch:' + err)).then((value3)=> value3);
            console.log('deleted chat');
});

  class ShuffleUser {
    public shuffleUserId: string;
    public lastShuffle: string;
    public userData: Array<any>;
    public filter: Array<any>;

    constructor(map:functions.firestore.QueryDocumentSnapshot){
        this.shuffleUserId = map.id;
        this.lastShuffle = map.get('lastShuffle');
        this.userData = map.get('userData')
        this.filter = map.get('filter')
    };
  }

  class HelperFunctions {
    static matchingUser(user: ShuffleUser, possibleUserPartner: ShuffleUser){
        const userGender = user.userData[0].toString();
        const userAge = user.userData[1].toString();
        const userIntrests = user.userData[2].toString();

        const userRequestedGender = user.filter[0].toString();
        const userRequestedAgeRange = user.filter[1].toString();
        const userRequestedIntrests = user.filter[2].toString();

        const partnerGender = possibleUserPartner.userData[0].toString();
        const partnerAge = possibleUserPartner.userData[1].toString();
        const partnerIntrests = possibleUserPartner.userData[2].toString();

        const partnerRequestedGender = possibleUserPartner.filter[0].toString();
        const partnerRequestedAgeRange = possibleUserPartner.filter[1].toString();
        const partnerRequestedIntrests = possibleUserPartner.filter[2].toString();

        if(userRequestedGender === 'any' && userRequestedAgeRange === 'any' && userRequestedIntrests === 'any' && partnerRequestedGender === 'any' && partnerRequestedAgeRange === 'any' && partnerRequestedIntrests === 'any') {
            return true;
        } 

        //Check if found partner matches userFilters
        if(userRequestedGender !== 'any'){
            if(userRequestedGender !== partnerGender){
                return false;
            }
        }

        if(userRequestedAgeRange !== 'any'){
            const ageRange = userRequestedAgeRange.split('-');
            try {
                const minAge = parseInt(ageRange[0]);
                const maxAge = parseInt(ageRange[1]);
                const partnerAgeInt = parseInt(partnerAge);

                if(partnerAgeInt < minAge || partnerAgeInt > maxAge){
                    return false;
                }
            } catch (error) {
                return false;
            }
        }

        if(userRequestedIntrests !== 'any'){
            let anyMatchingIntrest = false;
            const intrests = partnerIntrests.split(',');
            for(let intrest of intrests){
                if(userRequestedIntrests.includes(intrest)){
                    anyMatchingIntrest = true;
                    break;
                }
                
            }
            if(anyMatchingIntrest === false){
                return false;
            }
        }

        //Check if Filter of found partner matches user
        if(partnerRequestedGender !== 'any'){
            if(partnerRequestedGender !== userGender){
                return false;
            }
        }

        if(partnerRequestedAgeRange !== 'any'){
            const ageRange = partnerRequestedAgeRange.split('-');
            try {
                const minAge = parseInt(ageRange[0]);
                const maxAge = parseInt(ageRange[1]);
                const userAgeInt = parseInt(userAge);
                if(userAgeInt < minAge || userAgeInt > maxAge){
                    return false;
                }
            } catch (error) {
                return false;
            }
        }

        if(partnerRequestedIntrests !== 'any'){
            let anyMatchingIntrest = false;
            const intrests = userIntrests.split(',');
            for(let intrest of intrests){
                if(partnerRequestedIntrests.includes(intrest)){
                    anyMatchingIntrest = true;
                    break;
                }
                
            }
            if(anyMatchingIntrest === false){
                return false;
            }
        }
        console.log('{MATCH} (because ALL FILTERS MATCH)');
        return true;
    }
  }

class ChatRoom {
    users: Array<any>;
    usersTyping: Array<any>;
    chatRoomId: string;

    constructor(users: Array<any>, usersTyping: Array<any>, chatRoomId: string){
        this.users = users;
        this.usersTyping = usersTyping;
        this.chatRoomId = chatRoomId;
    }
  }

