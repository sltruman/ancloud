<template>
  <div>
    <v-card style="width: 100%; height: 40%">
      <video
        controls
        :width="videoWidthPQ"
        :height="videoHeightPQ"
        autoplay
      ></video>
    </v-card>
  </div>
</template>

<script>
export default {
  name: "home",
  data() {
    return {
      videoWidthPQ: "1920",
      videoHeightPQ: "1080",
      videoW: "100%",
      videoH: "40%",
    };
  },
  created() {
    this.loadVideo();
  },
  methods: {
    async loadVideo() {
      let videoStream = await navigator.mediaDevices.getDisplayMedia({
        video: true,
        audio: true,
      });
      document.querySelector("video").srcObject = videoStream;
    },
  },
};
</script>

<style scoped>
</style>
