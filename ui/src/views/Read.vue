<template>
    <div>
        <div class="loader" v-if="loading"></div>
        <!-- Single Blog Banner Start Here -->
        <section class="single-blog-wrap-layout1" v-if="detail.publicationDate">
            <div class="single-blog-banner-layout1">
                <div class="banner-img">
                    <img src="../assets/img/blog/blog208.jpg" alt="blog">
                </div>
                <div class="banner-content">
                    <div class="container">
                        <ul class="entry-meta meta-color-light2">
                            <li><i class="fas fa-tag"></i>{{detail.category}}</li>
                            <li><i class="fas fa-calendar-alt"></i>{{msToDate(detail.publicationDate)}}</li>
                        </ul>
                        <h2 class="item-title">{{detail.name}}</h2>
                        <p class="item-title" style="font-size:medium">{{detail.description}}</p>


                        <ul class="item-social">
                            <social-share-block :horizontalOnly="true" :defaultSharing="false"></social-share-block>
                        </ul>
                        <!-- <ul class="response-area">
                            <li><a href="#"><i class="far fa-comment"></i>02</a></li>
                            <li><a href="#"><i class="far fa-eye"></i>105</a></li>
                            <li><a href="#"><i class="far fa-heart"></i>225</a></li>
                            <li><a href="#"><i class="fas fa-share"></i>302</a></li>
                        </ul> -->
                    </div>
                </div>
            </div>
            
            <div class="container">
                <div class="row gutters-150">
                    <div class="col-lg-8">
                        <div class="single-blog-box-layout1">
                            <div class="blog-details">
                                <span class="content" v-html="detail.content?detail.content:txtPre"></span>
                            </div>
                            <div class="blog-entry-meta">
                                <ul>
                                    <li class="item-tag"><i class="fas fa-bookmark"></i>
                                        <a>{{detail.category}}</a>
                                    </li>
                                    <li class="item-tag">
                                        <social-share-block :horizontalOnly="true" :defaultSharing="false"></social-share-block>
                                    </li>
                                </ul>

                            </div>
                            <!-- <div class="blog-author">
                                <div class="media media-none--xs">
                                    <img src="../assets/img/blog/blog212.jpg" alt="Author" class="media-img-auto">
                                    <div class="media-body">
                                        <h4 class="item-title">Lora Zaman</h4>
                                        <div class="item-subtitle">Author</div>
                                        <p>Dorem ipsum dolor sit amet, consectetuer adipiscing
                                            elit,sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna.</p>
                                        <ul class="item-social">
                                            <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                            <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                            <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                                            <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                                            <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div> -->


                            <!-- <div class="related-item">
                                <div class="section-heading-4 heading-dark">
                                    <h3 class="item-heading">YOU MAY ALSO LIKE</h3>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4 col-12">
                                        <div class="blog-box-layout1 text-left">
                                            <div class="item-img">
                                                <a href="single-blog.html"><img src="../assets/img/blog/blog213.jpg" alt="blog"></a>
                                            </div>
                                            <div class="item-content">
                                                <ul class="entry-meta meta-color-dark">
                                                    <li><i class="fas fa-tag"></i>Fashion</li>
                                                    <li><i class="fas fa-calendar-alt"></i>October 19, 2019</li>
                                                </ul>
                                                <h5 class="item-title"><a href="single-blog.html">How an Island Formsn
                                                        River
                                                        And Stones</a></h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-12">
                                        <div class="blog-box-layout1 text-left">
                                            <div class="item-img">
                                                <a href="single-blog.html"><img src="../assets/img/blog/blog214.jpg" alt="blog"></a>
                                            </div>
                                            <div class="item-content">
                                                <ul class="entry-meta meta-color-dark">
                                                    <li><i class="fas fa-tag"></i>Fashion</li>
                                                    <li><i class="fas fa-calendar-alt"></i>October 19, 2019</li>
                                                </ul>
                                                <h5 class="item-title"><a href="single-blog.html">How an Island Formsn
                                                        River
                                                        And Stones</a></h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-12">
                                        <div class="blog-box-layout1 text-left">
                                            <div class="item-img">
                                                <a href="single-blog.html"><img src="../assets/img/blog/blog215.jpg" alt="blog"></a>
                                            </div>
                                            <div class="item-content">
                                                <ul class="entry-meta meta-color-dark">
                                                    <li><i class="fas fa-tag"></i>Fashion</li>
                                                    <li><i class="fas fa-calendar-alt"></i>October 19, 2019</li>
                                                </ul>
                                                <h5 class="item-title"><a href="single-blog.html">How an Island Formsn
                                                        River
                                                        And Stones</a></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
                        </div>
                    </div>




                    <div class="col-lg-4 sidebar-widget-area sidebar-break-md pl--30">
                        <right-widget :dataList="dataList" :authorShowFlag="false" :popularShowFlag="false"></right-widget>
                    </div>


                </div>
            </div>
        </section>
        <!-- Single Blog Banner End Here -->
        
    </div>
    
</template>

<script>

import store from '../store'
import {request} from "@/utils/request"
import CategoriesWidget from '../components/Categories' 
import BaseBlogData from "../components/BaseBlogData"
import SocialShareBlock from '../components/SocialShare'
import RightWidget from '../components/RightWidget' 
import commonMixin from "@/utils/commonMixin.js"



export default({

    name:"Read",
    mixins:[commonMixin],
    components: {CategoriesWidget,SocialShareBlock,RightWidget,BaseBlogData},

    
    data() {
        return{
            loading:true,
            tokenId:null,
            id:null,
            txtPre:null,
            detail:{
                name : '',
                description : '',
                image : '',
                content : '',
                category:[],
                publicationDate : null,
                attributes : [
                    {
                        "trait_type": "Platform",
                        "value": "NFT Market"
                    }
                ],
                platform : 'Book NFT Market',
                
            },
        }
        
    },

     async created() {
        this.tokenId = this.$route.params && this.$route.params.tokenId;
        this.id = this.$route.params && this.$route.params.id;
        if(this.tokenId && this.tokenId!== 100000){
            const tokenInfor = await Contract.RKB.getInfo(this.tokenId)
            request({
                url:tokenInfor._tokenURI,
                methods:'Get'
            }).then(res=>{
                if(res.content.indexOf('https://')>-1){
                    this.detail = res
                    this.detail.content = this.readBookUrl(res.content)

                }else{
                    let Base64 = require('js-base64').Base64
                    this.detail = res
                    this.detail.content = Base64.decode(res.content)
                }

                store.dispatch('setSharing',{
                        url: window.location.href,
                        title: this.detail.name,
                        description: this.detail.description,
                        quote: '',
                        hashtags: this.detail.category.toString(),
                        twitterUser: 'Leon_invincible'
                    })
                this.loading = false
            }).catch(err=>{
                this.loading = false
            })

        }else if(this.id && this.id!=='xxxxx'){
            request({
                url:"https://ipfs.io/ipfs/" + this.id,
                methods:'Get'
            }).then(res=>{
                if(res.content.indexOf('https://')>-1){
                    this.detail = res
                    this.detail.content = this.readBookUrl(res.content)

                }else{
                    let Base64 = require('js-base64').Base64
                    this.detail = res
                    this.detail.content = Base64.decode(res.content)
                }
                store.dispatch('setSharing',{
                    url: window.location.href,
                    title: this.detail.name,
                    description: this.detail.description,
                    quote: '',
                    hashtags: this.detail.category.toString(),
                    twitterUser: 'Leon_invincible'
                })
                this.loading = false
            }).catch(err=>{
                console.log(err)
                this.loading = false
            })
        }
    
    },

    computed:{
   
    },

    watch: {
        // detail: {
        //     handler(val) {
        //         this.sharing={
        //             url: window.location.href,
        //             title: this.detail.name,
        //             description: this.detail.description,
        //             quote: '',
        //             hashtags: this.detail.category.toString(),
        //             twitterUser: 'Leon_invincible'
        //         }
        //     },
        //     deep: true
        // }
    },

    mounted(){
        
    },
    
   
    
    methods: {
        // msToDate(ms){
        //     let d = new Date(ms)
        //     return d.toDateString()
        // }
    }
})
</script>

<style scoped>
    .content{
        margin: 5rem;
    }
</style>
