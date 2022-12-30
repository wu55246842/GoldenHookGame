<template>
     <div>
        <!-- Footer Area Start Here -->
        <footer class="footer-wrap-layout1">
            <div class="container">
                <div class="row d-flex align-items-center">
                    <div class="col-lg-4">
                        <div class="footer-box-layout1">
                            <div class="copyright">© 2022 LAOWD P2E. All Rights <a href="http://www.bootstrapmb.com/" title="bootstrapmb">Reserved</a>.</div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="footer-box-layout1">
                            <div class="footer-logo">
                                <a href="index.html"><img src="../../assets/img/laowudi_fish.png" alt="logo"></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="footer-box-layout1">
                            <ul class="footer-social">
                                <!-- <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                                <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
                                <li><a href="#"><i class="fab fa-pinterest"></i></a></li>
                                <li><a href="#"><i class="fab fa-github-alt"></i></a></li>
                                <li><a href="#"><i class="fas fa-rss"></i></a></li> -->
                                <social-share-block :horizontalOnly="true" :defaultSharing="true"></social-share-block>
                            </ul>
                        </div>
                        
                    </div>
                </div>
            </div>
        </footer>
        <!-- Footer Area End Here -->

    </div>
</template>

<script>
import SocialShareBlock from '../../components/SocialShare'
import CommonFunction from "@/utils/commonFunction";
export default {
    name: 'AppFooter',
    components: {
        SocialShareBlock
    },
    data(){
        return {
            CommonFunction,
            active: null,
            tabs:null,
        }
    },
    mounted(){
        this.changeTab()
    },
    methods: {
        changeTab(){
            if(this.tabs){
                for(let i in this.tabs){
                    if(this.tabs[i].to == this.$route.path){
                        this.active = parseInt(i)
                        break
                    }
                }
            }
        },
    }
}
</script>

<style lang="less" scoped>

</style>
