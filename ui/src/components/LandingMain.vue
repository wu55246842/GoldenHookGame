<template>
      <!-- Blog Area Start Here -->
        <section class="blog-wrap-layout16 container-xl">
            <div class="container">
                <div class="row gutters-50">
                    <div class="col-xl-9 col-lg-8">
                        <div class="row gutters-40">

                            <div class="col-md-4 col-12" :key="data.publicationDate" v-for="data in dataList">
                                <div class="blog-box-layout2">
                                    <div class="item-img">
                                        <a @click="goToReadBook(data)"><img :src="data.image" alt="blog"></a>
                                    </div>
                                    <base-blog-data :data="data"></base-blog-data>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-lg-4 sidebar-widget-area sidebar-break-md">
                        <right-widget :dataList="dataList" :authorShowFlag="false" :popularShowFlag="false"></right-widget>
                    </div>
                </div>
            </div>
        </section>
        <!-- Blog Area End Here -->
</template>

<script>

import commonMixin from "@/utils/commonMixin.js"
import RightWidget from './RightWidget' 
import BaseBlogData from '../components/BaseBlogData'

export default {
    mixins:[commonMixin],
    components: {RightWidget,BaseBlogData},
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
        }

        
    },
    computed: {

    },
    data(){
        return {

        }
    },

    methods: {

    }
}
</script>
