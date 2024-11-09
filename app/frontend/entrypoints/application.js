import { createApp } from "vue";
import BannedWordForm from "../components/BannedWordForm.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(BannedWordForm);
  app.mount("#app");
});
