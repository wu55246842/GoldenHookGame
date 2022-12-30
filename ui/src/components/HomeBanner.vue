<template>

         <!-- Blog Area Start Here -->
        <section class="blog-wrap-layout9">
            <div class="container">
                <div class="section-heading-3">
                    <h2>Web3 Creating Value In The Future Digital Economy</h2>
                    <p>Web3 is the third generation of the internet, and it's built on the philosophy that the internet should be a decentralized network of computers rather than a centralized one. This means that there is no single point of failure and no central authority controlling the flow of information.</p>
                </div>
                <div class="row gutters-40 menu-list" id="no-equal-gallery">
                    <div class="col-lg-4 col-md-6 col-sm-6 col-12 no-equal-item" :key="data.publicationDate" v-for="data in dataListLast">
                        <div class="blog-box-layout5">
                            <div class="item-img">
                                <a @click="goToReadBook(data)"><img :src="data.image" alt="Blog"></a>
                                <a class="hover-icon">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </a>
                            </div>

                            <base-blog-data :data="data"></base-blog-data>
                        </div>
                    </div>


                </div>
                <div class="loadmore-btn-layout1">
                    <a href="/blogs" class="item-btn">LOAD MORE</a>
                </div>
            </div>
        </section>
        <!-- Blog Area End Here -->
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
                required: true,
                default:function(){
                    return []
                }
            },
            
        },
        data(){
            return{
                tempImages:[
                    'https://images.pexels.com/photos/267569/pexels-photo-267569.jpeg?cs=srgb&dl=pexels-pixabay-267569.jpg&fm=jpg',
                    'https://images.pexels.com/photos/267569/pexels-photo-267569.jpeg?cs=srgb&dl=pexels-pixabay-267569.jpg&fm=jpg',
                    'https://images.pexels.com/photos/733856/pexels-photo-733856.jpeg?cs=srgb&dl=pexels-tirachard-kumtanom-733856.jpg&fm=jpg',
                    'https://images.pexels.com/photos/768474/pexels-photo-768474.jpeg?cs=srgb&dl=pexels-jess-bailey-designs-768474.jpg&fm=jpg',
                    'https://images.pexels.com/photos/965117/pexels-photo-965117.jpeg?cs=srgb&dl=pexels-jess-bailey-designs-965117.jpg&fm=jpg',
                    'https://images.pexels.com/photos/1228517/pexels-photo-1228517.jpeg?cs=srgb&dl=pexels-jess-bailey-designs-1228517.jpg&fm=jpg'
                ]
            }
        },
        methods: {
        }
    }
</script>

<style scoped>
    .ant-carousel :deep(.slick-slide) {
        text-align: center;
        height: 450px;
        line-height: 160px;
        background: #364d79;
        overflow: hidden;
        margin-bottom: 5rem;

    }

    .ant-carousel :deep(.slick-arrow.custom-slick-arrow) {
        width: 25px;
        height: 25px;
        font-size: 25px;
        color: #fff;
        /* background-color: rgba(31, 45, 61, 0.11); */
        background-color: transparent;
        opacity: 0.3;
        z-index: 1;
    }
    .ant-carousel :deep(.custom-slick-arrow:before) {
        display: none;
    }
    .ant-carousel :deep(.custom-slick-arrow:hover) {
        opacity: 0.5;
    }

    .ant-carousel :deep(.slick-slide h1) {
        color: #fff;
        z-index: 999;
    }

</style>