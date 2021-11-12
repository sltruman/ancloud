<template>
  <div>
    <user />
  </div>
</template>
<script>
import user from "./user.vue";
export default {
  components: { user },
  name: "account",
  data() {
    return {
      data: 123,
    };
  },
  created() {},
  methods: {},
};
</script>
