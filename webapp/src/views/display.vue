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
      videoWidthPQ: "400",
      videoHeightPQ: "600",
      videoW: "100%",
      videoH: "40%",
      rtcPC: null,
    };
  },
  created() {
    // this.loadVideo();
    let config = {
      sdpSemantics: 'unified-plan',
      iceServers: [{urls: ['stun:stun.l.google.com:19302']}]
    };
    this.rtcPC = new RTCPeerConnection(config);

    // document.querySelector("video").srcObject.getVideoTracks().forEach(track => {
    //       this.rtcPC.addtrack(track);
    //     }
    // )

    this.rtcPC.addEventListener('track', function (evt) {
      document.querySelector("video").srcObject = evt.streams[0];
    })

    this.negotiate();

  },
  methods: {
    async loadVideo() {
      let videoStream = await navigator.mediaDevices.getDisplayMedia({
        video: true,
        audio: true,
      });
      document.querySelector("video").srcObject = videoStream;
    },
    async negotiate() {
      return this.pc.createOffer().then(function (offer) {
        return this.pc.setLocalDescription(offer);
      }).then(function () {
        // wait for ICE gathering to complete
        return new Promise(function (resolve) {
          if (this.pc.iceGatheringState === 'complete') {
            resolve();
          } else {
            // eslint-disable-next-line no-inner-declarations
            function checkState() {
              if (this.pc.iceGatheringState === 'complete') {
                this.pc.removeEventListener('icegatheringstatechange', checkState);
                resolve();
              }
            }

            this.pc.addEventListener('icegatheringstatechange', checkState);
          }
        });
      }).then(function () {
        var offer = this.pc.localDescription;
        return fetch('/offer', {
          body: JSON.stringify({
            sdp: offer.sdp,
            type: offer.type,
          }),
          headers: {
            'Content-Type': 'application/json'
          },
          method: 'POST'
        });
      }).then(function (response) {
        return response.json();
      }).then(function (answer) {
        return this.pc.setRemoteDescription(answer);
      }).catch(function (e) {
        alert(e);
      });
    }
  },
};
</script>

<style scoped>
</style>
