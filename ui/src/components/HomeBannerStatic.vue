<template>
    <section class="tf-slider">
        <div class="swiper-container slider">
            <div class="swiper-wrapper"  aria-live="polite">
                <div class="swiper-slide">
                    <div class="slider-item">
                        <div class="overlay"></div>
                        <div class="slider-inner flex home-1">
                            
                            <div class="slider-img">
                                <!-- <div class="img-home-1"><img src="../assets/images/slider/img-slider-1.png" alt="Image"></div> -->
                                <div class="img-home-1"><img src="../assets/images/slider/pexels-borja-lopez-1346154.jpg" alt="Image"></div>
                                
                            </div>
                            <div class="slider-content">
                                <h1 class="heading">Web3 Play to Earn</h1>
                                <h1 class="heading">Carry your Web3 journey</h1>
                                <p class="sub-heading">i'm always waiting for you</p>
                                <div class="button-slider">
                                    <router-link to="/playground" class="sc-button"><span>Enter Dapp</span></router-link>
                                    <router-link to="/publish" class="sc-button"><span>About Us</span></router-link>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        
        </div>
        </section>
</template>

<script>
    import commonMixin from "@/utils/commonMixin.js"
    import BaseBlogData from '../components/BaseBlogData'


    export default {
        name: 'AppHomeBanner',
        components: {BaseBlogData},
        mixins:[commonMixin],
        props:{
            dataListLast:{
                type:Object,
                required: false,
                default:function(){
                    return []
                }
            },
            
        },
        data(){
            return{

            }
        },
        methods: {

        }
    }
</script>

<style>
    .tf-slider {
        background: #14141F;
        background-size: cover;
        position: relative;
        z-index: 2;
    }
    .slider .slider-item {
        background: #14141F;
        background-size: cover;
        position: relative;
        z-index: 2;
    }

    .slider .slider-item .flex {
        display: -webkit-box;
        display: -moz-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
    }

    .swiper-container-pointer-events {
        touch-action: pan-y;
    }

    .swiper-container {
        margin-left: auto;
        margin-right: auto;
        position: relative;
        overflow: hidden;
        list-style: none;
        padding: 0;
        z-index: 1;
    }

    .swiper-container-android .swiper-slide, .swiper-wrapper {
        transform: translate3d(0px,0,0);
    }

    .swiper-wrapper {
        position: relative;
        width: 100%;
        height: 100%;
        z-index: 1;
        display: flex;
        transition-property: transform;
        box-sizing: content-box;
    }

    .slider .swiper-slide{
        overflow: hidden;
    }

    .swiper-container-fade .swiper-slide {
        pointer-events: none;
        transition-property: opacity;
    }

    .swiper-slide {
        flex-shrink: 0;
        width: 100%;
        height: 100%;
        position: relative;
        transition-property: transform;
    }

    .slider .slider-item {
        background: var(--bg-slider);
        background-size: cover;
        position: relative;
        z-index: 2;
    }

    .slider .slider-item .overlay {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        background: url(../assets/images/background/bg-slider.png) center center no-repeat;
        z-index: -1;
    }

    .tf-slider .overlay {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        background: url(../assets/images/background/bg-slider.png) center center no-repeat;
        z-index: -1;
    }

    .slider-inner {
        justify-content: space-between;
        padding: 60px 10% 78px 10%;
    }

    .slider-inner .slider-content {
        padding-top: 15%;
    }

    @media only screen and (max-width: 1200px) {
        .slider-inner .slider-content {
            padding-top: 5%;
        }
    }

    .slider-inner .slider-content h1{
        font-size: 6rem !important;
        font-weight: 700 !important;
        text-rendering: optimizeLegibility;
        color: white;
        margin: 0;
        padding: 0;
        border: 0;
        outline: 0;
        font: inherit;
        vertical-align: baseline;
        line-height: 6.5rem;

    }


    .slider .swiper-slide .sub-heading{
        color:white !important ;
        margin-top: 1rem;
        margin-left: 1rem;
    }

     

    .slider .slider-img .img-home-1 > img {
        border-radius: 50px;
        height: auto;
        max-width: 100%;
        vertical-align: middle;
        -ms-interpolation-mode: bicubic;
    }

    @media only screen and (max-width: 980px) {
        .slider .slider-img {
            display: none;
        }
    }

    
    .swiper-container-fade .swiper-slide {
        pointer-events: none;
        transition-property: opacity;
    }
    .swiper-container {
        margin-left: auto;
        margin-right: auto;
        position: relative;
        overflow: hidden;
        list-style: none;
        padding: 0;
        z-index: 1;
    }

    .slider-inner .slider-content .button-slider {
        margin-top: 5rem;
        display: flex;
    }

    .slider-inner .slider-content .button-slider .swiper-container {
        margin-left: auto;
        margin-right: auto;
        position: relative;
        overflow: hidden;
        list-style: none;
        padding: 0;
        z-index: 1;
    }
   

    .slider-inner .slider-content .button-slider .sc-button {
        padding: 2rem 4rem !important;
        /* height: 5rem !important; */
        background: #fff;
        margin-right: 12px;
        color: coral;
        font-weight: 900;
        font-size: large !important;
        border-radius: 5rem;
        z-index: 999;
    }

    .slider-inner .slider-content .button-slider .sc-button :hover{
        background:burlywood;
    }


</style>