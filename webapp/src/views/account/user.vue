<template>
  <div>
    <v-card>
      <v-list-item class="grow">
        <v-avatar style="margin-right: 1rem">
          <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John" />
        </v-avatar>
        <v-list-item-content>
          <div>
            <span>1号用户</span>
          </div>
          <v-list-item-title>
            <v-chip label color="orange" text-color="white" x-small>
              会员123
            </v-chip>
          </v-list-item-title>

          <v-list-item-title>
            <v-chip class="ma-2" color="orange" x-small text-color="white">
              Premium
              <v-icon right> mdi-star </v-icon>
            </v-chip>
          </v-list-item-title>
        </v-list-item-content>

        <v-row align="center" justify="end">
          <v-icon class="mr-1"> mdi-heart </v-icon>
          <span class="subheading mr-2">256</span>
          <span class="mr-1">·</span>
          <v-icon class="mr-1"> mdi-share-variant </v-icon>
          <span class="subheading">45</span>
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
  methods: {},
};
</script>
