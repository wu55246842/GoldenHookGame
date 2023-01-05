<template>
    <div class="bg">

        

    
        <section class="single-blog-wrap-layout1" v-if="cardCount>0">
            <div class="loader" v-if="loading"></div>
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
                    <h3><span class="h3span">Your Cards Total : {{ playerOwnCardsCounts.length }}</span></h3>
                </div>

                <ul class="cards" v-if="playerOwnCardsCounts.length>0">
                    <li class="card card--aod" :key="i+'_card_bg'" v-for="i in playerOwnCardsCounts" @click="playingCards">
                    </li>
                </ul>
                <div class="pt-5" align="center" v-else>
                    <h3 class="h3span">You do not own the car, please draw</h3>
                </div>

                <div class="pt-5" align="center">
                    <el-button type="primary" @click="openDialog">Draw</el-button>
                    <el-button type="primary" @click="playingCards">Playing Cards</el-button>
                    <el-button type="primary" @click="myRewards">My Rewards</el-button>
                    <el-button type="primary" @click="test">Test</el-button>
                </div>
                <div class="pt-3" align="center">
                    <h3><span class="h3span">My Rewards: {{rewards*unitValue}} {{ chainSymbol }}</span></h3>
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
                    <el-input-number v-model="numOfCards" @change="handleChange" :min="10" :max="30" placeholder="number of cards"></el-input-number>
                </el-row>
                <el-row>
                    <span class="margin-right: 1rem">You Need Pay : {{ chainSymbol }}</span>
                </el-row>
                <el-row>
                    <el-input v-model="cardsValue" :min="1" :max="30" placeholder="you need pay" :disabled="true">
                        <template slot="append">{{chainSymbol}}</template>
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
import CommonFunction from '../utils/commonFunction'


export default({

    name:"Table",
    mixins:[commonMixin],
    
    data() {
        return{
            loading:true,
            chainSymbol:'',
            rewards:0,
            playground:null,
            id:null,
            playerSequences:null,
            cardSequences:null,
            cardCount:0,
            playerOwnCardsCounts:[],
            numOfCards:10,
            cardsValue:null,
            title:'Draw Cards',
            dialogVisible:false,
            unitValue:null,
            minWithdrawValue:null,
            networkConfig:null
        }
        
    },

     async created() {
        this.id = this.$route.query && this.$route.query.id;
        if(window.connectedAddress){
            this.playground = await Contract.Playground
            await this.init()
            if(this.playground){
                this.unitValue = await this.playground.unitValue()
                this.minWithdrawValue = await this.playground.minWithdrawValue()
                this.networkConfig = await CommonFunction.getCurrentNetwork()
                this.chainSymbol = this.networkConfig.chainSymbol
                this.cardsValue = this.numOfCards*this.unitValue/1000000000000000000
            }
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
                this.playerOwnCardsCounts = []
                for(let m =0;m<c;m++){
                    this.playerOwnCardsCounts.push(m+1)
                }

                this.cardCount = await this.playground.cardCount(this.id)
                let str = await this.playground.cardSequences(this.id) 
                this.cardSequences = []
                str = str+''

                for(let i = 0;i<this.cardCount;i++){

                    this.cardSequences.push(str.substr(i*2,2))
                }

                this.myRewards()
                
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
                if(window.connectedAddress && this.unitValue){
                    setTimeout(() => {
                        this.dialogVisible = false
                    }, 15000)
                    //await this.playground.methods.buyCards2(this.numOfCards).send({from:window.connectedAddress})
                    await this.playground.methods.buyCards(this.numOfCards).send(
                        {
                            from:window.connectedAddress,
                            value:window.web3.utils.toWei((this.numOfCards*this.unitValue/1000000000000000000) + '', 'ether')
                        }
                    )
                    let c = await this.playground.playerOwnCardsCounts()
                    this.playerOwnCardsCounts = []
                    for(let m =0;m<c;m++){
                        this.playerOwnCardsCounts.push(m+1)
                    }
                }
            }
        },

        async myRewards(){
            this.rewards = await this.playground.playerReward(window.connectedAddress)
        },

        openDialog(){
            this.dialogVisible = true
        },

        closeDialog(){
            this.dialogVisible = false
            this.numOfCards = 10
        },
        handleChange(){
            console.log(this.unitValue)
            if(this.numOfCards>=10 && this.unitValue){
                this.cardsValue = this.numOfCards*this.unitValue/1000000000000000000
            }
        },



        async test(){
            if(this.playground){
                //await this.playground.methods.setUnitValue(1000000000000000).send({from:window.connectedAddress})
                //const val = await this.playground.getPlayerOwnCards()
                //console.log('----------getPlayerOwnCards----------',val)
                await this.playground.methods.withdraw().send({from:window.connectedAddress})
            }
        }

    }
})
</script>

<style scoped>
    .h3span{
        color: white;
        font-weight: bold;
    }

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
