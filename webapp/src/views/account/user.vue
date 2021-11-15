<template>
  <div>
    <v-card>
      <v-list-item class="grow">
        <v-avatar style="margin-right: 1rem">
          <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John" />
        </v-avatar>
        <v-list-item-content>
          <span class="text-lg-h6">
            <label class="font-weight-black">用户1</label>
          </span>
          <v-list-item-title>
            <v-chip label color="orange" text-color="white" x-small>
              会员123
            </v-chip>
          </v-list-item-title>
          <v-list-item-title>
            <span class="text-caption">预留...</span>
          </v-list-item-title>
        </v-list-item-content>

        <v-row align="center" justify="end" @click="goUserSetting">
          <v-icon class="mr-1"> mdi-account-arrow-right-outline </v-icon>
        </v-row>
      </v-list-item>
    </v-card>
  </div>
</template>
<script>
export default {
  name: "user",
  data() {
    return {
      data: 123,
    };
  },
  created() {},
  methods: {
    goUserSetting() {
      this.$router.push({ name: "user-setting" });
    },
  },
};
</script>
