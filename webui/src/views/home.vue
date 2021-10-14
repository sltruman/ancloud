<template>
  <div>
    <video controls :width="videoWidth" :height="videoHeight"></video>
  </div>
</template>

<script>
export default {
  name: "home",
  data() {
    return {
      videoWidth: 800,
      videoHeight: 600,
    }
  }, created() {
    this.loadVideo();
  },
  methods: {
    async loadVideo() {
      let videoStream = await navigator.mediaDevices.getDisplayMedia({video: true, audio: true});
      document.querySelector('video').srcObject = videoStream;
    }
  }
}
</script>

<style scoped>

</style>
