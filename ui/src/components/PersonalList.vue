<template>
    <!-- Blog Area Start Here -->
      <section class="blog-wrap-layout16 container-xl">
          <div class="container" v-if="dataList && dataList.length>0">
              <div class="row gutters-50">
                  <div class="col-xl-9 col-lg-8">
                      <div class="row gutters-40">
                          <div class="col-xl-3  col-sm-6 col-12" :key="index+data.startAt" v-for="(data,index) in dataList">
                              <div class="blog-box-layout3">
                                  <div class="item-img">
                                      <a  @click="goToTable(index+1)">
                                      <!-- <router-link :to="'/table/'+(index+1)"> -->
                                      <!-- <router-link to="/table"> -->
                                          <div class="counter">
                                              <div class="counter-content">
                                                  <div class="counter-icon"><i class="fa fa-globe"></i></div>
                                                  <span class="counter-value">Table:{{ index+1 }}</span>
                                              </div>
                                              <h3>Golden Hook</h3>
                                              <base-blog-data :inlineFlag="true" :data="data" :decShowFlag="true"></base-blog-data>
                                          </div>
                                      </a>
                                      <!-- </router-link> -->
                                  </div>
                                  
                              </div>
                          </div>
                      </div>
                      <!-- <div class="pagination-layout1">
                          <ul>
                              <li class="active"><a href="#">1</a></li>
                              <li><a href="#">2</a></li>
                              <li><a href="#">3</a></li>
                          </ul>
                      </div> -->
                     
                  </div>




                  <div class="col-xl-3 col-lg-4 sidebar-widget-area sidebar-break-md">
                      <right-widget :dataList="dataList"></right-widget>
                  </div>
              </div>

              <div class="row pt-2 pb-5">
                  <el-divider>
                      <i class="fas fa-bell"></i>
                  </el-divider>
              </div>

              <div class="row gutters-50">

                  

              </div>
          </div>
      </section>
      <!-- Blog Area End Here -->
</template>

<script>

import commonMixin from "@/utils/commonMixin.js"
import RightWidget from './RightWidget.vue' 
import BaseBlogData from './BaseBlogData'

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


<style scoped>
.counter{
  font-family: 'Dosis', sans-serif;
  text-align: center;
}
.counter .counter-content{
  color: #fff;
  background: linear-gradient(45deg,#E72652,#F1669C);
  width: 170px;
  padding: 18px 10px;
  margin: 0 auto 12px;
  border-radius: 100px/50px;
  box-shadow: 0 0 15px rgba(0,0,0,0.2);
  outline: 4px solid #fff;
  outline-offset: -8px;
}
.counter .counter-icon{
  font-size: 35px;
  margin: 0 0 5px;
}
.counter .counter-value{
  font-size: 30px;
  font-weight: 700;
  letter-spacing: 1.5px;
  display: block;
}
.counter h3{
  color: #333;
  font-size: 18px;
  font-weight: 700;
  font-style: italic;
  letter-spacing: 0.5px;
  text-transform: capitalize;
  margin: 0;
}
.counter.purple{
  --color1: #97308F;
  --color2: #d664b9;
}
.counter.blue{
  --color1: #0771B8;
  --color2: #0584D2;
}
.counter.green{
  --color1: #6b970a;
  --color2: #a5db32;
}
@media screen and (max-width:990px){
  .counter{ margin-bottom: 40px; }
}   
</style>