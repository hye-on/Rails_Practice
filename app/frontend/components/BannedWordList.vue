<template>
  <div>
    <table class="w-full">
      <thead>
        <tr>
          <th v-for="field in schema.fields" 
              :key="field.name"
              class="p-2 text-left border-b">
            {{ field.label }}
            <span v-if="field.required" class="text-red-500">*</span>
          </th>
          <th class="p-2 text-left border-b">Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in bannedWords" :key="item.id">
          <td v-for="field in schema.fields" 
              :key="field.name"
              class="p-2 border-b">
            <template v-if="field.type === 'select'">
              <span :class="getDisplayClass(field.name, item[field.name])">
                {{ item[field.name] }}
              </span>
            </template>
            <template v-else>
              {{ item[field.name] }}
            </template>
          </td>
          <td class="p-2 border-b">
            <button 
              @click="deleteWord(item.id)"
              class="px-3 py-1 rounded text-white bg-red-500 hover:bg-red-600 text-sm">
              삭제
            </button>
            <button 
              @click="editWord(item.id)"
              class="px-3 py-1 ml-2 rounded text-white bg-blue-500 hover:bg-blue-600 text-sm">
              수정
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      schema: {
        fields: []
      },
      bannedWords: []
    }
  },

  async created() {
    await this.loadSchema()
    await this.loadBannedWords()
  },

  methods: {
    async loadSchema() {
      try {
        const response = await axios.get('/banned-words/ui-schema/list')
        this.schema = response.data
      } catch (error) {
        console.error('스키마 로드 실패:', error)
      }
    },

    async loadBannedWords() {
      try {
        const response = await axios.get('/banned-words/index-json')
        this.bannedWords = response.data
      } catch (error) {
        console.error('금지어 목록 로드 실패:', error)
      }
    },

    getDisplayClass(fieldName, value) {
      if (fieldName === 'policy') {
        return {
          'px-2 py-1 rounded text-sm': true,
          'bg-red-500 text-white': value === 'ban',
          'bg-yellow-500 text-white': value === 'warn'
        }
      }
      return ''
    },

    async deleteWord(id) {
      if (!confirm('정말 삭제하시겠습니까?')) {
        return
      }

      try {
        const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')

        await axios.delete(`/banned-words/${id}`, {
          headers: {
            'X-CSRF-Token': csrfToken,
            'Accept': 'application/json'
          }
        })

        this.bannedWords = this.bannedWords.filter(word => word.id !== id)
        alert('삭제되었습니다.')
      } catch (error) {
        if (error.response?.status === 404) {
          console.warn('이미 삭제된 항목입니다.')
        } else {
          console.error('삭제 실패:', error)
          alert('삭제에 실패했습니다.')
        }
      }
    },
    editWord(id) {
      
      window.location.href = `/banned-words/${id}/edit`
    }
  }
}
</script>

<style scoped>
.match-target {
  @apply text-sm text-gray-600;
}
</style>

<!-- <template>
  <div>
    <table>
      <thead>
        <tr>
          <th v-for="field in schema.fields" :key="field.name">{{ field.label }}</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="word in bannedWords" :key="word.id">
          <td v-for="field in schema.fields" :key="field.name">
            {{ word[field.name] }}
          </td>
          <td>
            <button @click="deleteWord(word.id)">삭제</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      schema: { fields: [] },
      bannedWords: []
    };
  },
  async created() {
    await this.loadSchema();
    await this.loadBannedWords();
  },
  methods: {
    async loadSchema() {
      try {
        const response = await axios.get('/banned-words/ui-schema/list');
        this.schema = response.data;
      } catch (error) {
        console.error("UI 가져오기 실패:", error);
      }
    },
    async loadBannedWords() {
      try {
        const response = await axios.get('/banned-words/index_json');
        this.bannedWords = response.data;
      } catch (error) {
        console.error("금지 단어 가져오기 실패", error);
      }
    },
    async deleteWord(id) {
      try {
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        await axios.delete(`/banned-words/${id}`, {
          headers: {
            'X-CSRF-Token': csrfToken,
            'Accept': 'application/json'
          }
        });
        this.bannedWords = this.bannedWords.filter(word => word.id !== id);
        alert("삭제되었습니다.");
      } catch (error) {
        if (error.response && error.response.status === 404) {
          console.warn("이미 삭제된 항목입니다.");
        } else {
          console.error("Failed to delete:", error);
          alert("삭제 실패");
        }
      }
    }
  }
};
</script>
 -->