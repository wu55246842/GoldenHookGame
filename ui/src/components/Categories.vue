<template>

       
        <div class="widget">
            <div class="section-heading heading-dark">
                <h3 class="item-heading">CATEGORIES</h3>
            </div>
            <div class="widget-categories">
                <ul>
                    <li :key="i" v-for="(c,i) in categories">
                        <a href="#">{{c.value}}
                            <span>(35)</span>
                        </a>
                    </li>
       
                </ul>
            </div>
        </div>
        
</template>

<script>
    import commonMixin from "@/utils/commonMixin.js"
    import category from "@/config/category"

    export default {
        name: 'Categories',
        components: { },
        mixins:[commonMixin],
        props:{
      
        },
        data(){
            return{
                categories :category.categories,
            }
        },
        methods: {

        }
    }
</script>

<style scoped>

</style>