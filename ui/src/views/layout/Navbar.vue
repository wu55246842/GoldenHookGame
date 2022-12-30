<template>
    <header>
        

        <nav id="header-menu" class="navbar navbar-expand-lg bg--dark pr--30 pl--30 container-xl" style="padding-bottom:1.5rem">
            <div class="container d-flex align-items-center">


                <div class="logo-area col-lg-2 justify-content-start">
                    <a href="/home" class="temp-logo" id="temp-logo">
                        <img src="../../assets/img/laowudi_fish.png" alt="logo" class="img-fluid">
                    </a>
                </div>

                


                <nav class="collapse navbar-collapse template-main-menu col-lg-6" id="navbarSupportedContent">
                    
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/home">HOME</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="/playground">PLAYGROUND</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="/about">ABOUT</a>
                        </li>

                        

                    </ul>

                </nav>

                <div class="col-lg-4  d-flex justify-content-end" style="padding-top:1.8rem">
                    <div class="header-action-items">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"><i class="fa fa-bars" aria-hidden="true"></i></span>
                        </button>
                        
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
        </nav>

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


    </header>
</template>

<script>
    import SocialShareBlock from '../../components/SocialShare'
    import Wallet from '../../components/wallet'
    import TaskView from '@/components/task'
    import category from "@/config/category"




 export default {
        name: 'Header',
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
