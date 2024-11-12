import { createApp } from "vue";
import BannedWordForm from "../components/BannedWordForm.vue";
import BannedWordList from "../components/BannedWordList.vue"; // 새로 추가된 리스트 컴포넌트

document.addEventListener("DOMContentLoaded", () => {
 
  const bannedWordFormElement = document.getElementById("bannedWordForm");
  if (bannedWordFormElement) {
    createApp(BannedWordForm).mount("#bannedWordForm");
  }

 
  const bannedWordListElement = document.getElementById("bannedWordList");
  if (bannedWordListElement) {
    createApp(BannedWordList).mount("#bannedWordList");
  }
});
