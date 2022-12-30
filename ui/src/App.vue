<template>
    <router-view></router-view>
</template>

<script>

    import WOW from "wow.js";

    export default {
        name: 'App',

        mounted(){
            var wow = new WOW({
            boxClass: "wow", // animated element css class (default is wow)
            animateClass: "animated", // animation css class (default is animated)
            offset: 0, // distance to the element when triggering the animation (default is 0)
            mobile: true, // trigger animations on mobile devices (default is true)
            live: true, // act on asynchronously loaded content (default is true)
            callback: function (box) {
                // the callback is fired every time an animation is started
                // the argument that is passed in is the DOM node being animated
            },
            scrollContainer: null, // optional scroll container selector, otherwise use window,
            resetAnimation: true, // reset animation on end (default is true)
            });
            wow.init();     
        }
    }
</script> 

<style>

    @import url("./assets/css/main.css");
    @import url("./assets/css/bootstrap.min.css");
    @import url("./assets/css/fontawesome-all.min.css");
    @import url("./assets/font/flaticon.css");
    @import url("./assets/css/animate.min.css");
    @import url("./assets/css/meanmenu.min.css");
    /* @import url("./assets/css/responsive.css"); */
    /* @import url("./assets/css/shortcodes.css"); */
    @import url("./assets/vendor/OwlCarousel/owl.carousel.min.css");
    @import url("./assets/vendor/OwlCarousel/owl.theme.default.min.css");


    @import "./assets/css/style.css";  

</style>
 