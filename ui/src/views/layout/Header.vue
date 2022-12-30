<template>
    <div>
    <!-- Navbar -->
        <!-- Header Area Start Here -->
        <header class="has-mobile-menu">
            <div id="rt-sticky-placeholder"></div>
            <div id="header-menu" class="header-menu menu-layout1 bg--dark pr--30 pl--30 container-xl">
                <div class="container">
                    <div class="row d-flex align-items-center">
                        <div class="col-lg-2 d-flex justify-content-start">
                            <div class="logo-area">
                                <a href="/home" class="temp-logo" id="temp-logo">
                                    <img src="../../assets/img/laowudi_fish.png" alt="logo" class="img-fluid">
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6 d-flex justify-content-end">
                            <nav id="dropdown" class="template-main-menu">
                                <ul>
                                    <li>
                                        <a href="/home">HOME</a>
                                    </li>

                                    <li>
                                        <a href="/playground">PLAYGROUND</a>
                                    </li>

                                    <li>
                                        <a href="/about">ABOUT</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <div class="col-lg-4 d-flex justify-content-end">
                            <div class="header-action-items">

                                <ul class="divider-style-border">
                                    <social-share-block :horizontalOnly="true" :defaultSharing="true"></social-share-block>
                                </ul>
                                <ul>
                                    <li class="header-search-box">
                                        <a title="Search" @click="handleShowSearch">
                                            <i class="flaticon-magnifying-glass"></i>
                                        </a>
                                    </li>
                                </ul>
                                <ul style="margin-left:10px">
                                    <li class="header-search-box">
                                        <!-- <a title="Search" @click="handleShowSearch">
                                            <i class="flaticon-magnifying-glass"></i>
                                        </a> -->
                                        <wallet></wallet>
                                    </li>
                                    <li>

                                        <div style="display: none;">
                                            <task-view></task-view>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Header Area End Here -->
        

        
        <!-- Search Box Start Here -->
        <div id="header-search" class="header-search" v-if="showSearch">
            <button type="button" class="close" @click="handleCloseSearch">×</button>
            <form class="header-search-form">
                <input type="search" value="" placeholder="Type here........" />
                <button type="submit" class="search-btn">
                    <i class="flaticon-magnifying-glass"></i>
                </button>
            </form>
        </div>
       
    </div>
</template>

<script>
    import SocialShareBlock from '../../components/SocialShare'
    import Wallet from '../../components/wallet'
    import TaskView from '@/components/task'
    import category from "@/config/category"

    export default {
        name: 'AppHeader',
        components: {
            SocialShareBlock,
            Wallet,
            TaskView
        },
        data() {
            return {
                showSearch: false,
                categories :category.categories,
            }
        },
        methods: {

            handleShowSearch(){
                this.showSearch = true
            },

            handleCloseSearch(){
                this.showSearch = false
            },

            divideEqually(originArr) {
                /*此函数用于，把数组平均分成4份。
                * originArr，带分割的数组。*/
                if (originArr.length >= 4) {
                    let arr1, arr2, arr3, arr4;
                    arr1 = originArr.slice(0, Math.round(originArr.length / 4));
                    arr2 = originArr.slice(Math.round(originArr.length / 4), Math.round(originArr.length / 4) * 2);
                    arr3 = originArr.slice(Math.round(originArr.length / 4) * 2, Math.round(originArr.length / 4) * 3);
                    arr4 = originArr.slice(Math.round(originArr.length / 4) * 3);

                    return [arr1, arr2, arr3, arr4];
                }
            },


        },
        mounted(){
            // let script = document.createElement('script');
            // script.type = 'text/javascript';
            // script.src = '../../assets/js/jquery.meanmenu.min.js';
            // document.body.appendChild(script);
            /*-------------------------------------
            On Scroll 
            -------------------------------------*/
            $(window).on('scroll', function () {
                // Back Top Button
                if ($(window).scrollTop() > 700) {
                    $('.scrollup').addClass('back-top');
                } else {
                    $('.scrollup').removeClass('back-top');
                }
                // if ($('body').hasClass('sticky-header')) {
                    var stickyPlaceHolder = $("#rt-sticky-placeholder"),
                        menu = $("#header-menu"),
                        menuH = menu.outerHeight(),
                        topHeaderH = $('#header-topbar').outerHeight() || 0,
                        middleHeaderH = $('#header-middlebar').outerHeight() || 0,
                        targrtScroll = topHeaderH + middleHeaderH;
                    if ($(window).scrollTop() > targrtScroll) {
                        menu.addClass('rt-sticky');
                        stickyPlaceHolder.height(menuH);
                    } else {
                        menu.removeClass('rt-sticky');
                        stickyPlaceHolder.height(0);
                    }
                //}
            });


        }
    }
</script>

<style lang="less" scoped>

    .navbar-dark .nav-item .nav-link {
    color: #fff;
    }

    .navbar-dark .nav-item .nav-link:hover {
    background-color: rgba(255, 255, 255, 0.1);
    transition: all 0.3s ease;
    border-radius: 0.25rem;
    color: #fff;
    }

    .fa-li {
    position: relative;
    left: 0;
    }

</style>
