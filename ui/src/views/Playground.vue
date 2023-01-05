<template>
    <div>
        <div style="height:5rem"></div>
        <personal-list-block :dataList="dataList"></personal-list-block>

    </div>


</template>

<script>
import commonMixin from "@/utils/commonMixin.js"
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
            playground:null
        }
    },
    mounted(){
        this.initData()
    },
    methods: {
        async initData(){
            // TODO
            this.playground = await Contract.Playground

            if(this.playground){
            
                const tableId = await this.playground.tableId()

                let a = []
                for (var x=0 ; x<tableId; x++)
                { 
                    a.push(x+1)
                }

                a.forEach(async idx=>{
                    let game = await this.playground.allGames(idx)
                    this.dataList.push(game)  
                })

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
