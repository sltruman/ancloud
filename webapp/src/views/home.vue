<template>
  <v-container>
    <v-item-group multiple>
      <v-row>
        <v-col v-for="(item, i) in items" :key="i" cols="6" md="4">
          <v-item>
            <v-img
              @click="openDevice(item)"
              :src="`https://cdn.vuetifyjs.com/images/${item.src}`"
              height="150"
              class="text-right pa-2"
            >
            </v-img>
          </v-item>
          <div>地区 {{ i + 1 }} 号</div>
        </v-col>
      </v-row>
    </v-item-group>
  </v-container>
</template>

<script>
export default {
  name: "home",
  data() {
    return {
      items: [
        {
          src: "backgrounds/bg.jpg",
        },
        {
          src: "backgrounds/md.jpg",
        },
        {
          src: "backgrounds/bg-2.jpg",
        },
        {
          src: "backgrounds/md2.jpg",
        },
      ],
    };
  },
  created() {},
  methods: {
    openDevice(data) {
      this.$router.push({ path: "display" });
    },
  },
};
</script>

<style scoped>
</style>
