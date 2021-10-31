<template>
  <!-- <div id="app">
  </div> -->
  <v-app>
    <!-- <v-app-bar color="deep-purple" dark>
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
      <v-toolbar-title>Title</v-toolbar-title>
    </v-app-bar> -->
    <bar />
    <v-main><router-view /> </v-main>
    <v-bottom-navigation>
      <v-btn>
        <span>Recents</span>

        <v-icon>mdi-history</v-icon>
      </v-btn>

      <v-btn>
        <span>Favorites</span>

        <v-icon>mdi-heart</v-icon>
      </v-btn>

      <v-btn>
        <span>Nearby</span>

        <v-icon>mdi-map-marker</v-icon>
      </v-btn>
    </v-bottom-navigation>
  </v-app>
</template>

<script>
import bar from "./layout/bar.vue";
export default {
  components: { bar },
  name: "App",
};
</script>

<style>
</style>
