<template>
    <div class="bg">

        <div class="loader" v-if="loading"></div>

    
        <section class="single-blog-wrap-layout1" v-if="cardCount>0">
            <div class="single-blog-banner-layout1">
                <!-- <div class="banner-img">
                    <img src="../assets/img/blog/blog208.jpg" alt="banner"/>
                </div> -->
                <div class="pt10" align="center">
                    <h3><span style="color: white;font-weight: bold;">Players Cards</span></h3>
                </div>

                <ul class="cards">
                    <li  class="card card--aoc" :data-attr="getContent(card)" style="margin: 0" :key="i+'_card'" v-for="card,i in cardSequences"></li>
                </ul>

                <div class="pt10" align="center" v-if="playerOwnCardsCounts.length>0">
                    <h3><span style="color: white;font-weight: bold;">Your Cards Total : {{ playerOwnCardsCounts.length }}</span></h3>
                </div>

                <ul class="cards" v-if="playerOwnCardsCounts.length>0">
                    <li class="card card--aod" :key="i+'_card_bg'" v-for="i in playerOwnCardsCounts" @click="playingCards">
                    </li>
                </ul>
                <div class="pt-5" align="center" v-else>
                    <h3 style="color:darkmagenta;font-weight: 600;">You do not own the car, please draw</h3>
                </div>

                <div class="pt-5" align="center">
                    <el-button type="primary" @click="openDialog">Draw</el-button>
                    <el-button type="primary" @click="playingCards">Playing Cards</el-button>
                    <el-button type="primary" @click="rewards">Rewards</el-button>
                    <el-button type="primary" @click="test">Test</el-button>
                </div>
                    
            </div>


            <el-dialog :title="title" v-model="dialogVisible" width="20%" height="25%" append-to-body   @close="closeDialog">
                <el-row>
                    <p style="font-size:1.2rem;color:red">Please notice after draw will wait for a while to retrieve the cards </p>
                </el-row>
                <el-row>
                    <span class="margin-right: 1rem">Number Want To Draw :</span>
                </el-row>
                <el-row>
                    <el-input-number v-model="numOfCards" @change="handleChange" :min="1" :max="30" placeholder="number of cards"></el-input-number>
                </el-row>
                <el-row>
                    <span class="margin-right: 1rem">You Need Pay : {{ unit }}</span>
                </el-row>
                <el-row>
                    <el-input v-model="cardsValue" :min="1" :max="30" placeholder="you need pay" :disabled="true">
                        <template slot="append">{{unit}}</template>
                    </el-input>
                </el-row>
                <div class="pt-5"></div>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisible = false">Cancel</el-button>
                    <el-button type="primary" @click="draw">Confirm</el-button>
                </span>
            </el-dialog>


            
        </section>

        
    </div>
    
</template>

<script>


import commonMixin from "@/utils/commonMixin.js"



export default({

    name:"Table",
    mixins:[commonMixin],
    
    data() {
        return{
            loading:true,
            unit:'ETH',
            playground:null,
            id:null,
            playerSequences:null,
            cardSequences:null,
            cardCount:0,
            playerOwnCardsCounts:[],
            numOfCards:1,
            cardsValue:0.001,
            title:'Draw Cards',
            dialogVisible:false,
        }
        
    },

     async created() {
        this.id = this.$route.query && this.$route.query.id;
        if(window.connectedAddress){
            this.playground = await Contract.Playground
            await this.init()
        }
    },

    computed:{
   
    },

    watch: {
      
    },

    mounted(){
        
    },
    
   
    
    methods: {

        getContent(val){
            return val;
        },

        async init(){
            if(this.playground && this.id){
                this.loading = true
                let c = await this.playground.playerOwnCardsCounts()
                console.log('-------------- playerOwnCardsCounts --------------',this.playerOwnCardsCounts)
                this.playerOwnCardsCounts = []
                for(let m =0;m<c;m++){
                    this.playerOwnCardsCounts.push(m+1)
                }

                this.cardCount = await this.playground.cardCount(this.id)
                let str = await this.playground.cardSequences(this.id) 
                this.cardSequences = []
                str = str+''

                console.log('-------------str--------------',str)

                for(let i = 0;i<this.cardCount;i++){

                    this.cardSequences.push(str.substr(i*2,2))
                }
                console.log('-------------cardSequences--------------',this.cardSequences)
                
                this.loading = false
            }
        },

        async playingCards(){
            if(this.playground && this.id){
                if(this.playerOwnCardsCounts.length>0){
                    await this.playground.methods.playingCard(this.id).send({from:window.connectedAddress})
                    this.init()
                }else{
                    this.dialogVisible = true
                }
                
            }
        },

        async draw(){
            if(this.playground){
                if(window.connectedAddress && window.web3.eth){
                    setTimeout(() => {
                        this.dialogVisible = false
                    }, 15000)
                    await this.playground.methods.buyCards2(this.numOfCards).send({from:window.connectedAddress})
                    let c = await this.playground.playerOwnCardsCounts()
                    this.playerOwnCardsCounts = []
                    for(let m =0;m<c;m++){
                        this.playerOwnCardsCounts.push(m+1)
                    }
                }
            }
        },

        async rewards(){
            let rewards = await this.playground.playerReward(window.connectedAddress)
            console.log('------------rewards-----------',rewards)
        },

        openDialog(){
            this.dialogVisible = true
        },

        closeDialog(){
            this.dialogVisible = false
            this.numOfCards = 1
        },
        handleChange(){
            if(this.numOfCards>0){
                this.cardsValue = this.numOfCards*0.001
            }
        },



        async test(){
            if(this.playground){
                let result1 = await this.playground.methods.testMsgSender().call({from:window.connectedAddress})
                console.log('----------testMsgSender-------------',result1)

                let result2 = await this.playground.testMsgSender()
                console.log('----------testMsgSender-------------',result2)

                console.log('----------this.playground-------------',this.playground)
            }
        }

    }
})
</script>

<style scoped>

    .el-dialog-div{
        height: 260vh;
        overflow: auto;
    }
    .content{
        margin: 5rem;
    }

    .pt10{
        padding-top:10rem
    }

    .bg{
        box-sizing: border-box;
        background: #6e7750;
        overflow: hidden;
    }

    .cards {
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        -webkit-box-align: end;
        -ms-flex-align: end;
        align-items: flex-end;
    }
    .cards,.card {
        margin: 0;
        padding: 0;
        list-style-type: none;
    }
    .card {
        font-size: 10vw;
        margin: 0 -0.26em;
        position: relative;
        cursor: pointer;
        color: #292A18;
        /* Uncomment these lines to see the target areas for the hovering */
        /*
        background: rgba(255,255,255,0.5);
        outline: solid 5px red;
        */
        
        --s: 0;
        --spread: 0;
        --spreadAbs: 0;
    }
    .card:before,
    .card:after {
        content: '';
        display: block;
        pointer-events: none;
    }
    .card:before {
        position: absolute;
        top: 5%;
        right: 0;
        bottom: -5%;
        left: 0;
        margin: auto;
        background: #000;
        -webkit-filter: blur(10px);
        filter: blur(10px);
        opacity: 0;
        -webkit-transition: opacity 0.35s linear;
        transition: opacity 0.35s linear;
    }
    .card:after {
        position: relative;
        width: 1em;
        height: 1.1em;
        border-radius: 0.1em;
        background: #EEE;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        text-align: center;
        padding: 0.1em 0;
        line-height: 1;
        -webkit-transform-origin: center bottom;
        transform-origin: center bottom;
        -webkit-transition: -webkit-transform 0.4s cubic-bezier(0.46, 0.01, 0.3, 0.98);
        transition: -webkit-transform 0.4s cubic-bezier(0.46, 0.01, 0.3, 0.98);
        transition: transform 0.4s cubic-bezier(0.46, 0.01, 0.3, 0.98);
        transition: transform 0.4s cubic-bezier(0.46, 0.01, 0.3, 0.98), -webkit-transform 0.4s cubic-bezier(0.46, 0.01, 0.3, 0.98);
        -webkit-transition-timing-function: cubic-bezier(0.1, 0.98, 0.47, 0.99);
        transition-timing-function: cubic-bezier(0.1, 0.98, 0.47, 0.99);
    }

    @supports ( (--a: 0)) {
        .card:nth-child(n):before,
        .card:nth-child(n):after {
            -webkit-transform: rotate(calc( var(--spread) * 35deg)) translateY(calc( var(--spreadAbs) * 5%));
            transform: rotate(calc( var(--spread) * 35deg)) translateY(calc( var(--spreadAbs) * 5%));
            -webkit-transform-origin: var(--origin) 100%;
            transform-origin: var(--origin) 100%;
        }
    }
    .card:hover:before {
        opacity: 0.25;
        z-index: 2;
        -webkit-transition-duration: 0.2s;
        transition-duration: 0.2s;
    }
    .card:hover:after {
        z-index: 3;
        pointer-events: auto;
        -webkit-transition-duration: 0.25s;
        transition-duration: 0.25s;
        -webkit-transition-timing-function: cubic-bezier(0.37, -0.12, 0.32, 1.49);
        transition-timing-function: cubic-bezier(0.37, -0.12, 0.32, 1.49);
        -webkit-transform: translate(0%, -75%) scale(1.75);
        transform: translate(0%, -75%) scale(1.15);
        -webkit-transform: rotate(calc( var(--spread) * 25deg)) translate(0%, -45%) scale(1.75);
        transform: rotate(calc( var(--spread) * 25deg)) translate(0%, -45%) scale(1.15);
    }
    .card--aoc:after {
        content: attr(data-attr);
		width:15rem;
        height: 20rem;
        font-size: 10rem;
        text-align: center;
        line-height: 18rem;
       
    }
    .card--aoh:after {
        content: '\1F0B1';
    }
    .card--koh:after {
        content: '\1F0BE';
    }
    .card--aod:after {
        content: '\1F0A0';
    }
    .card--aos:after {
        content: '\1F0A1';
    }
    .card--kos:after {
        content: '\1F0AE';
    }
    .card--aoc,.card--aod,.card--aoh,.card--koh {
        color: #CC5840;
        background-color: transparent;
        border: none;
    }
</style>
