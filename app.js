var config = {
  apiKey: "AIzaSyANBiSXpPN0AfkjbKR4aVgoSd34i4BSBHw",
  authDomain: "swish-1a360.firebaseapp.com",
  databaseURL: "https://swish-1a360.firebaseio.com",
  projectId: "swish-1a360",
  storageBucket: "swish-1a360.appspot.com",
  messagingSenderId: "98273451761"
};
firebase.initializeApp(config);
var firestore = firebase.firestore();
const docRef = firestore.collection("Lessons");
const loadButton = document.querySelector("#loadButton");


  // loadButton.addEventListener("click", function() {
  //  docRef.get().then(function(doc) {
  //    if (doc && doc.exists) {
  //      const myData = doc.data();
  //      console.log(myData);
  //      //alert("hello");
  //    }
  //  }).catch(function (error) {
  //    console.log(error);
  //  });
  // });

  loadButton.addEventListener("click", function() {
       docRef.get().then(function(querySnapshot) {
                  var lessonList = [];
                  querySnapshot.forEach(function(doc) {
                      // doc.data() is never undefined for query doc snapshots
                      console.log(doc.id);
                      console.log(typeof(doc.id));
                      lessonList.push(doc.id);
                  });
                  console.log(lessonList)
                  console.log(typeof(lessonList));
              });
      })
function loadLesson(){
       docRef.get().then(function(querySnapshot) {
                  var lessonList = [];
                  querySnapshot.forEach(function(doc) {
                      // doc.data() is never undefined for query doc snapshots
                      console.log(doc.id);
                      console.log(typeof(doc.id));
                      lessonList.push(doc.id);
                  });
                  console.log(lessonList)
                  console.log(typeof(lessonList));
              });
 }
// buttonclicktest


loadButton.addEventListener("click", function(){
  alert("click");
});
