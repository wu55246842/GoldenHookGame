<template>
    <div class="item-content">
        <h2 class="item-title"> <a @click="goToReadBook(data)">{{data.name}}</a></h2>
        <ul class="entry-meta meta-color-dark">
            <li :style="inlineFlag?'display:inline':'display:block'"><i class="fas fa-calendar-alt"></i>{{msToDate(data.startAt*1000)}}</li>
        </ul>
        <ul class="entry-meta meta-color-dark">
            <li :style="inlineFlag?'display:inline':'display:block'"><i class="fas fa-university"></i>{{formatString(data.creator, 4, 4)}}</li>
            <li :style="inlineFlag?'display:inline':'display:block'"><i class="fas fa-location-arrow"></i>{{data.isExist}}</li>
        </ul>
        
    </div>
</template>

<script>

import commonMixin from "../utils/commonMixin.js"


export default {
    mixins:[commonMixin],
    components: {},
    props:{
        data:{
            type:Object,
            required: true,
            default:function(){
                return {}
            }
        },
        decShowFlag:false,
        inlineFlag:false
     
    },
    computed: {

    },
    data(){
        return {

        }
    },

    methods: {
        formatString(str, first, last, replace){
            if(!str || str.length < first + last){
                return str;
            }
            replace = replace ? replace : '...'
            return str.substring(0, first) + replace +  str.substring(str.length-last)
        }
    }
}
</script>
