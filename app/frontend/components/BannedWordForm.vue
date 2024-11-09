<template>
  <form @submit.prevent="submitForm">
    <div v-for="field in schema.fields" :key="field.name">
      <label :for="field.name">{{ field.label }}</label>
      
      <input 
        v-if="getFieldType(field.type) === 'input'"
        :type="field.type"
        :id="field.name"
        :name="field.name"
        v-model.trim="formData[field.name]"
        :required="field.required"
        @input="logFormData"
      >
      
      <select
        v-else-if="getFieldType(field.type) === 'select'"
        :id="field.name"
        v-model="formData[field.name]"
        :name="field.name"
        :required="field.required"
      >
        <option value="">선택하세요</option>
        <option v-for="option in field.options" :key="option" :value="option">
          {{ option }}
        </option>
      </select>
      
      <textarea
        v-else-if="getFieldType(field.type) === 'textarea'"
        :id="field.name"
        v-model="formData[field.name]"
        :name="field.name"
        :required="field.required"
      ></textarea>
    </div>
    <button type="submit">저장</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      schema: { fields: [] },
      formData: {}
    };
  },
  async created() {
    try {
      const response = await axios.get('/banned-words/ui-schema');
      this.schema = response.data;
      this.initializeFormData();
    } catch (error) {
      console.error("Failed to load schema:", error);
    }
  },
  methods: {
    getFieldType(type) {
      const typeMap = {
        text: 'input',
        select: 'select',
        array: 'textarea'
      };
      return typeMap[type] || 'input';
    },
    initializeFormData() {
      this.formData = this.schema.fields.reduce((acc, field) => {
        acc[field.name] = field.initialValue || (field.type === "array" ? [] : '');
        return acc;
      }, {});
      console.log("초기화된 formData:", this.formData);
    },
    logFormData() {
      console.log("Updated formData:", JSON.stringify(this.formData, null, 2));
    },
    async submitForm() {
      if (!this.formData.word) {
        alert("금지 단어를 입력하세요.");
        return;
      }

      try {
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        
        const response = await axios.post('/banned-words', {
          banned_word: this.formData
        }, {
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          }
        });

        console.log("Submit response:", response.data);
        alert("저장되었습니다.");
        
        // 폼 초기화 (필요한 경우)
        this.initializeFormData();
      } catch (error) {
        console.error("Failed to save:", error);
        const errorMessage = error.response?.data?.errors?.join(", ") || "저장에 실패했습니다.";
        alert("Error: " + errorMessage);
      }
    }
  }
};
</script>