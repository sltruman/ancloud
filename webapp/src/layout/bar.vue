<template>
  <div class="overflow-hidden">
    <v-app-bar color="deep-purple" dark>
      <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>

      <v-toolbar-title>示例</v-toolbar-title>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" absolute temporary>
      <v-list nav dense>
        <v-list-item-group
          v-model="group"
          active-class="deep-purple--text text--accent-4"
        >
          <template v-for="(item, i) in menuList">
            <v-list-item @click="menuClick(item)" :key="i">
              <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-icon>
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item>
          </template>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>
<script>
export default {
  data: () => ({
    drawer: false,
    group: null,
    menuList: [
      {
        icon: "mdi-home",
        title: "Home",
        path: "home",
      },
      {
        icon: "mdi-account",
        title: "Account",
        path: "Account",
      },
    ],
  }),
  watch: {
    $route: "pathChange",
  },
  methods: {
    menuClick(data) {
      // todo 解决重复导航的问题
      this.$router.push({ path: data.path });
    },
    pathChange() {
      const nowPath = this.menuList.find(
        (a) => a.path === "/" + this.$route.path
      );
      if (nowPath) {
        this.group = this.menuList.indexValue(nowPath);
      } else {
        this.group = null;
      }
    },
  },
};
</script>