<template>
    <div class="widget">
        <div class="widget-newsletter-subscribe-dark">
            <h3>DONATE CRYPTO</h3>
            <p>system operation and maintenance</p>
            <form class="newsletter-subscribe-form">
                <!-- <div class="form-group">
                    <input type="text" placeholder="your e-mail address" class="form-control" name="email"
                        data-error="E-mail field is required" required>
                    <div class="help-block with-errors"></div>
                </div> -->
                <div class="form-group mb-none">
                    <button type="submit" class="item-btn">DONATE</button>
                </div>
            </form>
        </div>
    </div>
    
</template>

<script>
    import commonMixin from "@/utils/commonMixin.js"

    export default {
        name: 'Donate',
        components: { },
        mixins:[commonMixin],
        props:{
      
        },
        data(){
            return{
                
            }
        },
        methods: {

        }
    }
</script>

<style scoped>

</style>
