<template>
    <div>
        <div v-if="isForHomeBanner">
            <section class="tf-slider">
    
                <div class="slider">
                    <swiper
                    :slides-per-view="views"
                    :space-between="space"
                    navigation
                    :autoplay="{delay:5000}"
                    :pagination="{ clickable: true }"
                    @swiper="onSwiper"
                    @slideChange="onSlideChange"
                >
                        <swiper-slide>
                            <div class="slider-item">
                                <div class="overlay"></div>
                                <div class="slider-inner flex home-1">
                                    <div class="slider-content">
                                        <h1 class="heading">A Spiritual Ceremony</h1>
                                        <!-- <h1 class="heading">that Reflects the Family's Beliefs</h1> -->
                                    
                                        <!-- <p class="sub-heading">Quis autem vel eum iure reprehenderit qui in ea
                                            voluptates esse quam nihil molestiae consequatur veillum 
                                        </p> -->
                                        <div class="button-slider">
                                            <a href="explore-1.html" class="sc-button btn-bordered-white style letter "><span>Enter Dapp</span></a>
                                            <a href="create-item.html" class="sc-button btn-bordered-white style file"><span>About Us</span></a>
                                        </div>
                                    </div>
                                    <div class="slider-img">
                                        <div class="img-home-1">
                                            <!-- <img src="../assets/images/slider/img-slider-1.png" alt="Image"> -->
                                            <videoPlay 
                                                v-bind="options" 
                                                @play="onPlay"
                                                @pause="onPause" 
                                                @timeupdate="onTimeupdate" 
                                                @canplay="onCanplay" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </swiper-slide>
                        <swiper-slide>
                            <div class="slider-item ">
                                <div class="overlay "></div>
                                <div class="container">
                                    <div class="slider-inner style-2 home-1 flex">
                                    <div class="slider-content">
                                        <h1 class="heading">A Spiritual Ceremony</h1>
                                        <h1 class="heading">that Reflects the Family's Beliefs</h1>
                                        <p class="sub-heading">Quis autem vel eum iure reprehenderit qui in ea
                                            voluptates esse quam nihil molestiae consequatur veillum 
                                        </p>
                                        <div class="button-slider">
                                            <a href="explore-1.html" class="sc-button btn-bordered-white style letter "><span>Enter Dapp</span></a>
                                            <a href="create-item.html" class="sc-button btn-bordered-white style file"><span>About Us</span></a>
                                        </div>
                                    </div>
                                    <div class="slider-img flex">
                                        <div class="img-left">
                                            <div class="img-1"><img src="../assets/images/slider/flower1-200x230.png" alt="Image"></div>
                                            <div class="img-2"><img src="../assets/images/slider/flower2-200x230.png" alt="Image"></div>
                                        </div>
                                        <div class="img-right">
                                            <img src="../assets/images/slider/flower3-200x230.png" alt="Image">
                                        </div>
                                    </div>
                                    </div>
                                </div> 
                            </div>
                        </swiper-slide>
                    </swiper>
                </div>           
                
            </section>
        </div>
        <div v-else>
            <section class="tf-live-auctions tf-section bg-color-1">
                <div class="container">
                     <div class="row">
                        <div class="col-md-12">
                           <div class="sc-heading style-2 has-icon">
                              <div class="content-left">
                                 <div class="inner">
                                    <div class="group">
                                       <div class="icon"><i class="ripple"></i></div>
                                       <h3 class="mb-5">{{this.comTitle}}</h3>
                                    </div>
                                    <p class="desc">{{this.comDec}}</p>
                                 </div>
                              </div>
                           </div>
                        </div>

                        <div class="col-md-12">

                <div class="slider">
                    <swiper
                    :slides-per-view="views"
                    :space-between="space"
                    navigation
                    :autoplay="{delay:3000}"
                    :pagination="{ clickable: true }"
                    @swiper="onSwiper"
                    @slideChange="onSlideChange"
                    >

                    <swiper-slide :key="i" v-for="(s,i) in contents">
                            <div class="sc-product-item">
                                <div class="product-img ">
                                    <img :src="s.image" alt="Image" width="300" height="300" style="width:300px; height:300px">
                                </div>
                                <div class="blog-box-layout2" style="text-align:center">
                                    <base-blog-data :data="s"></base-blog-data>
                                </div>

                            </div>

                    </swiper-slide>
                
                    </swiper>

                </div>



                </div>
                </div>
                </div>

            </section>

        </div>
    </div>

     
</template>

<script>
    import commonMixin from "@/utils/commonMixin.js"
    import BaseBlogData from '../components/BaseBlogData'

    import SwiperCore, { Navigation, Pagination, A11y ,Autoplay} from "swiper";

    // Import Swiper Vue.js components
    import { Swiper, SwiperSlide } from "swiper/vue";

    // Import Swiper styles
    import "swiper/swiper.less";
    import "swiper/components/navigation/navigation.less";
    import "swiper/components/pagination/pagination.less";
import { integer } from "vue-types";

    // install Swiper components
    SwiperCore.use([Navigation, Pagination, A11y , Autoplay]);

    import 'vue3-video-play/dist/style.css'
    import { videoPlay } from 'vue3-video-play'

export default {
    name: 'SwiperSlider',
    components: {
      Swiper,
      SwiperSlide,
      videoPlay,
      BaseBlogData
    },
    mixins:[commonMixin],

    props:{
        views:{
            type:integer,
            required: false,
            default:4
        },
        space:{
            type:integer,
            required: false,
            default:50
        },

        isForHomeBanner:{
            type:Boolean,
            required: false,
            default:true
        },

        contents:{
            type:Array,
            required: false,
            default:function(){
                return []
            }
        },

        comTitle:{
            type:String,
            required: false,
            default:''
        },
        comDec:{
            type:String,
            required: false,
            default:''
        }
        
    },

    data(){
        return{
            options:{
                width: '800px', //播放器高度
                height: '450px', //播放器高度
                color: "#409eff", //主题色
                muted: false, //静音
                webFullScreen: false,
                speedRate: ["0.75", "1.0", "1.25", "1.5", "2.0"], //播放倍速
                autoPlay: false, //自动播放
                loop: false, //循环播放
                mirror: false, //镜像画面
                ligthOff: false,  //关灯模式
                volume: 0.3, //默认音量大小
                control: true, //是否显示控制器
                title: '', //视频名称
                src: "https://eniche.world/images/new.mp4", //视频源
                poster: '', //封面
            },


        }
    },

    methods: {
        onSwiper(swiper) {
        // console.log(swiper)
        },
        onSlideChange() {
        // console.log('slide change')
        },

        onPlay(ev){

        },
        onPause(ev){

        },
        onTimeupdate(ev){

        },
        onCanplay(ev){

        },

    },

}
</script>

<style scoped>
   
</style>