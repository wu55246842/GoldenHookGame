<template>
    <div class="page-container" :class="viewMode == 'dark' ? 'dark' : null">
       <navbar-block></navbar-block>
       <!-- <header-block></header-block> -->

        
       <div class="content-con" v-if="inited">
        
            <router-view v-slot="{ Component }">
                <transition>
                    <keep-alive v-if="$route.meta.keepAlive">
                        <component :is="Component" />
                    </keep-alive>
                    <component :is="Component" v-else />
                </transition>
            </router-view>
        </div>
        <div class="content-con" v-else>
            
            <router-view v-slot="{ Component }">
                <transition>
                    <keep-alive v-if="$route.meta.keepAlive">
                        <component :is="Component" />
                    </keep-alive>
                    <component :is="Component" v-else />
                </transition>
            </router-view>
        </div>

    

        <footer-block></footer-block>


        <div id="LoadingCon" style="display: none;">
            <div id="LoadingConMsg">Loading...</div>
        </div>
    </div>
</template>

<script>
import eventBus from '@/utils/eventBus'
import HeaderBlock from './Header'
import NavbarBlock from './Navbar'
import FooterBlock from './Footer'
import HomeBannerStaticBlock from '@/components/HomeBannerStatic';
import UI from "@/utils/ui";


export default {
    components: { HeaderBlock, NavbarBlock , FooterBlock ,HomeBannerStaticBlock},
    data () {
        return {
            UI,
            inited: false,
            viewMode: localStorage.getItem('VIEWMODE') ? localStorage.getItem('VIEWMODE') : 'light',
            dataList:[],
            dataListLast:[],
        }
    },
    created() {
        eventBus.$on('afterInit', () => {
            this.inited = true
        })
        eventBus.$on('ChangeViewMode', (mode) => {
            this.viewMode = mode
        })
        eventBus.$on('WALLET_DISCONNECTED', () => {
            this.inited = false
        })

        
    }
}
</script>

<style lang="less" scoped>
.page-container{
    background-color: transparent;
}
.loading-page{
    height: calc(100vh - 50px);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 50px;

    .loading-icon{
        width: 50px;
        height: 50px;
        background-image: url("../../assets/images/loading.png");
        background-size: 100% 100%;
        background-position: center center;
        -webkit-animation: rotate 1s linear infinite;
        animation: rotate 1s linear infinite;
        z-index: 1000;
    }
}
@keyframes rotate {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
        transition: all 5s;
    }
}
</style>
