<template>
    <div>
        <div style="height:5rem"></div>
        <personal-list-block :dataList="dataList"></personal-list-block>

    </div>


</template>

<script>
import commonMixin from "@/utils/commonMixin.js"
import { async } from "q"
import PersonalListBlock from '../components/PersonalList'

export default {
    mixins:[commonMixin],
    components: {PersonalListBlock},
    data() {
        return {
            currentAccount: window.connectedAddress,
            testResult: null,
            testResultSend: null,
            dataList:[],
        }
    },
    mounted(){
        this.initData()
    },
    methods: {
        async initData(){
            // TODO
            const playground = await Contract.Playground
            const GoldHookToken = await Contract.GoldHookToken

            if(playground && GoldHookToken){
            
                if(this.$store.state.currentAccount){
                    const bal = await GoldHookToken.balanceOf(this.$store.state.currentAccount)
                    console.log('---------- current user bal ---------',bal)
                }
                const tableId = await playground.tableId()
                console.log('---------- current game count ---------',tableId)

                let a = []
                for (var x=0 ; x<tableId; x++)
                { 
                    a.push(x+1)
                }

                console.log('---------a----------',a)
                a.forEach(async idx=>{
                    console.log('foreach',idx)
                    let game = await playground.allGames(idx)
                    this.dataList.push(game)  
                })

                console.log('---------------dataList-----------------',this.dataList)
            }
        },
    }
}
</script>

<style lang="less" scoped>
.page-con{
    padding: 65px 10px;
}
.title{
    font-size: 13px;
    margin-bottom: 5px;
    margin-top: 10px;
}
.code{
    font-size: 12px;
    font-weight: bold;
    background-color: #eee;
    border-radius: 5px;
    overflow-x: scroll;

    pre{
        margin: 10px 10px 0 10px;
        width: auto;
    }
}
.btn{
    line-height: 26px;
    background-color: #131629;
    width: 100px;
    text-align: center;
    border-radius: 5px;
    margin-top: 10px;
    color: #fff;
}
.result{
    background-color: #eee;
    padding: 10px 6px;
    border-radius: 5px;
    font-size: 13px;
    margin-top: 10px;
}
</style>
