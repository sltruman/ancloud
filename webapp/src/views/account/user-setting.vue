<template>
  <div>
    <v-card>
      <v-list-item class="grow">
        <v-list-item-content>
          <v-list-item-title>
            <span class="text-caption">预留...</span>
          </v-list-item-title>
        </v-list-item-content>

        <v-row align="center" justify="end">
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
  methods: {},
};
</script>
