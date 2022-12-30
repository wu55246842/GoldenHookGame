<template>
    <div>
        

        <social-share-block v-if="subShowFlag" :horizontalOnly="false" :defaultSharing="false"></social-share-block>


        <donate-block v-if="donateShowFlag"></donate-block>

        <!-- <div class="widget" v-if="authorShowFlag">
            <div class="widget-about-2">
                <figure class="author-figure"><img src="../assets/img/figure/figure7.jpg" alt="about"></figure>
                <figure class="author-signature"><img src="../assets/img/figure/signature.png" alt="about"></figure>
                <p>Fusce mauris auctor iner hendrerit risus ollicituderty aeenean rauctor doloer.</p>
            </div>
        </div> -->

        <div class="widget" v-if="popularShowFlag">
            <!-- <div class="section-heading heading-dark">
                <h3 class="item-heading">POPULAR POSTS</h3>
            </div> -->
            <div class="widget-popular">
                <div class="post-box" v-if="(data,index) in dataList.splice(4)">
                    <div class="item-img">
                        <a href="single-blog.html"><img src="../assets/img/blog/blog117.jpg" alt="blog"></a>
                    </div>
                    <base-blog-data :data="data"></base-blog-data>
                </div>

            </div>
        </div>
        
        

        <ad-block v-if="adShowFlag"></ad-block>

        <div class="widget" v-if="istgmShowFlag">
            <div class="section-heading heading-dark">
                <h3 class="item-heading">INSTAGRAM</h3>
            </div>
            <div class="widget-instagram">
                <ul>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure56.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure62.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure57.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure58.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure59.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure60.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure61.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure62.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                    <li>
                        <div class="item-box">
                            <img src="../assets/img/social-figure/social-figure63.jpg" alt="Social Figure" class="img-fluid">
                            <a href="#" class="item-icon"><i class="fab fa-instagram"></i></a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>



<script>

import commonMixin from "@/utils/commonMixin.js"
import DonateBlock from './Donate.vue' 
import AdBlock from './Ad.vue'
import SocialShareBlock from "./SocialShare"
import BaseBlogData from './BaseBlogData'



export default {
    mixins:[commonMixin],
    components: {DonateBlock,AdBlock, BaseBlogData,SocialShareBlock},

    props:{
      
        dataList:{
            type:Object,
            required: true,
            default:function(){
                return []
            }
        },
        title:{
            type:String,
            require:false,
            default:function(){
                return ''
            }
        },
        subShowFlag:{
            type:Boolean,
            require:false,
            default:true
        },
         authorShowFlag:{
            type:Boolean,
            require:false,
            default:true
        },
         popularShowFlag:{
            type:Boolean,
            require:false,
            default:true
        },
        catShowFlag:{
            type:Boolean,
            require:false,
            default:true
        },
         donateShowFlag:{
            type:Boolean,
            require:false,
            default:true
        },
         adShowFlag:{
            type:Boolean,
            require:false,
            default:true
        },
         istgmShowFlag:{
            type:Boolean,
            require:false,
            default:false
        },

    },
    computed: {

    },
    data(){
        return {
            url: "https://github.com/mbj36"
        }
    },

    methods: {

    }
}
</script>
