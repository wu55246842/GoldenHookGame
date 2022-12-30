<template>
    <div class="container p-5">
        <div class="loader" v-if="loading">
        </div>
        <a-card>
            
            <div id="axiosForm">
                
                <el-form
                    :model="formState"
                    name="mint_book"
                    v-bind="formItemLayout"
                    label-position="top"
                >

                    <el-col :xs="24" :md="24">
                        <el-form-item label="Dearly Deceased Pet" name="name">
                            <el-input
                                v-model="formState.name"
                                type="text"
                                size="large"
                                auto-complete="off"
                                placeholder="Dearly Deceased Pet"
                                >
                                </el-input>
                        </el-form-item>
                    </el-col>

                    <el-row :gutter="20">
                        <el-col :xs="24" :md="12">
                            <el-form-item prop="nDob" label="Date Of Birth">
                                <el-date-picker
                                    v-model="formState.nDob"
                                    type="date"
                                    placeholder="Date Of Birth"
                                    style="width: 100%"
                                    />
                            </el-form-item>
                        </el-col>


                        <el-col :xs="24" :md="12">
                            <el-form-item prop="nDod" label="Date Of Pass">
                                <el-date-picker
                                    v-model="formState.nDod"
                                    type="date"
                                    placeholder="Date Of Pass"
                                    style="width: 100%"
                                    />
                            </el-form-item>
                        </el-col>
                    </el-row>

                    <el-row :gutter="20">
                        <el-col :xs="24" :md="12">

                            <el-form-item prop="place" label="Final Resting Place">
                                <el-input
                                v-model="formState.place"
                                type="text"
                                size="large"
                                auto-complete="off"
                                placeholder="Final Resting Place"
                                >
                                </el-input>
                            </el-form-item>
                        </el-col>

                        <el-col :xs="24" :md="12">
                            <el-form-item label="Final Resting Country">
                                <el-select v-model="formState.nCountry" placeholder="Country" style="width: 100%">
                                    <el-option label="Singapore" value="Singapore" />
                                    <el-option label="Tailand" value="Tailand" />
                                </el-select>
                            </el-form-item>
                        </el-col>
                    </el-row>


                    <el-col :xs="24" :md="24">
                        <el-form-item name="description" label="Title">
                            <el-input
                                v-model="formState.description"
                                type="textarea"
                                size="large"
                                auto-complete="off"
                                placeholder="Description (notice: the length max limited characters is 100)"
                                maxlength="100"
                                >
                            </el-input>
                        </el-form-item>
                    </el-col>

                    <el-col :xs="24" :md="24">
                        <el-form-item name="cover" label="Image"> 
                            <el-row>
                                <crop-image-upload @uploadImageData="HandleUploadImageData"></crop-image-upload>
                            </el-row>
                        </el-form-item>
                    </el-col>
                    <el-col :xs="24" :md="24" v-if="formState.image">

                        <div class="show-preview">
                            <img :src="formState.image">
                        </div>
                    </el-col>

                    <el-col :xs="24" :md="24">
                        <el-form-item name="Content" label="Memories">
                            <Tinymce v-model:value="formState.content"  @change="handleChange" width="100%" />
                        </el-form-item>
                    </el-col>


                    <el-form-item :wrapper-col="{ span: 12, offset: 6 }">
                        <el-button type="primary" @click="handleMint()">Mint</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </a-card>
    </div>
</template>


<script>
    import { ElMessage, ElMessageBox } from "element-plus";
    import Tinymce from "@/components/Tinymce.vue";
    import category from "@/config/category"
    import IPFS from "@/utils/ipfs"
    import commonMixin from "@/utils/commonMixin.js"

    import 'viewerjs/dist/viewer.css'
    import { component as Viewer } from "v-viewer"

    import CropImageUpload from '@/components/CropImageUpload'


    

    export default {
        name: "Publish",
        mixins:[commonMixin],
        components: {
            Tinymce,
            Viewer,
            CropImageUpload
        },

        data() {
            return {
                loading :false,
                closeFlag:false,
                imageBase64:null,
                bookContentFile:[],
                bookImageCover:[],

                dataImages:[
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                ],
                 defaultOptions: {
                    'inline': false,
                    'button': true, //右上角按钮
                    "navbar": true, //底部缩略图
                    "title": false, //当前图片标题
                    "toolbar": true, //底部工具栏
                    "tooltip": true, //显示缩放百分比
                    "movable": true, //是否可以移动
                    "zoomable": true, //是否可以缩放
                    "rotatable": true, //是否可旋转
                    "scalable": false, //是否可翻转
                    "transition": true, //使用 CSS3 过度
                    "fullscreen": false, //播放时是否全屏
                    "keyboard": true, //是否支持键盘
                    "url": "data-source",
                },

                formState:{
                    name : '',
                    nDob:'',
                    nDod:'',
                    place:'',
                    nCountry:'',
                    description : '',
                    image : '',
                    content : '',
                    publicationDate : null,
                    attributes : [
                        {
                            "trait_type": "Platform",
                            "value": "NFT Market"
                        }
                    ],
                    platform : 'Book NFT Market',
                    
                },
                formItemLayout:{ 
                    labelCol: { span: 6 },
                    wrapperCol: { span: 14 }
                },


                categories :category.categories,

                showFlag:false,
                params: {
                    token: '123456798',
                    name: 'avatar'
                },
                headers: {
                    smail: '*_~'
                },
                imgDataUrl: '', // the datebase64 url of created image


            }
        },

        computed:{
        
        },

        watch: {

        },

        mounted(){
        },
        created() {
            //console.log('categories--------',categories)
            //this.categories = categories
        },
        methods: {

            
            async uploadImage(info) {
                this.loading = true
                //const res = await IPFS.saveToIPFS(info.file,'moralis')
                console.log(info.file)
                const res = await IPFS.saveToIPFS(info.file)
                console.log("res===================>",res)
                if(res &&  res.ipfsHash){
                    //this.formState.image = res.url
                    this.formState.image = 'https://ipfs.io/ipfs/' + res.ipfsHash.path
                }
                this.loading = false
                ElMessage({
                    message: 'Uploaded Successfully!',
                    type: 'success',
                })
                this.closeFlag = false

                // setTimeout(() => {
                //     this.loading = false
                // }, 5000);
            },

            async uploadFiles(info) {
                this.loading = true
                //const res = await IPFS.saveToIPFS(info.file,'moralis')
                const res = await IPFS.saveToIPFS(info.file)
                if(res &&  res.url){
                    this.formState.content = res.url
                }
                this.loading = false
                ElMessage({
                    message: 'Uploaded Successfully!',
                    type: 'success',
                })

            },
                /******************删除文件记录条目******************/
            deleteImageItem(img) {
                //找到当前文件所在列表的索引
                let index = this.bookImageCover.indexOf(img);
                //从列表中移除该文件
                this.bookImageCover.splice(index, 1);
                return true;
            },

            deleteFileItem(file) {
                //找到当前文件所在列表的索引
                let index = this.bookContentFile.indexOf(file);
                //从列表中移除该文件
                this.bookContentFile.splice(index, 1);
                return true;
            },

            async handleMint(){
                if(this.$store.state.currentAccount){
                    const result = await Contract.RKB.balanceOf(this.$store.state.currentAccount)
                    if(result > 0.0007){
                        if(this.formState && this.formState.image && this.formState.content 
                            && this.formState.name && this.formState.description){
                                this.loading = true
                                this.formState.publicationDate = new Date().getTime()
                                let Base64 = require('js-base64').Base64
                                this.formState.content =  Base64.encode(this.formState.content)
                                const res = await IPFS.saveToIPFS(this.formState)
                                if(res && res.ipfsHash){
                                    await Contract.RKB.createToken('https://ipfs.io/ipfs/'+res.ipfsHash.path)
                                    const result =  await Contract.RKB.lastTokenId()
                                    
                                    console.log('lastTokenId',result)
                                    this.loading = false
                                    ElMessage({
                                        message: 'Congratulation! Your NFT Minted Successfully!',
                                        type: 'success',
                                    })
                                    this.reset()
                                }
                        }
                    }else{

                        ElMessage({
                            message: 'Your wallet balance is not enough',
                            type: 'warning',
                        })
                    }

                    
                }else{
                    ElMessage({
                        message: 'Please connect to your wallet first',
                        type: 'warning',
                    })
                }

            },

            reset(){
                this.formState.name =''
                this.formState.description =''
                this.formState.image =''
                this.formState.content =''
                this.formState.category =[]
                this.formState.publicationDate =null
                this.formState.attributes = [
                        {
                            "trait_type": "Platform",
                            "value": "NFT Market"
                        }
                    ],
                this.formState.platform ='Book NFT Market'
            },

            handleChange (item) {

            },

            inited (viewer) {
                this.$viewer = viewer
            },
            selectImg () {
               this.formState.image = this.$viewer.image.src
            },
            show(e){
                //console.log(this.$viewer.sel)
                
            },  
            refreshImg(){
                this.dataImages = [
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                    "https://picsum.photos/id/"+this.randomNum(100,1000)+"/500",
                ]
            },

            toggleShow() {
                this.showFlag = !this.showFlag;
            },

            cropSuccess(imgDataUrl, field){
                console.log('-------- crop success --------');
                this.imgDataUrl = imgDataUrl;
            },

            cropUploadSuccess(jsonData, field){
                console.log('-------- upload success --------');
                console.log(jsonData);
                console.log('field: ' + field);
            },

            cropUploadFail(status, field){
                console.log('-------- upload fail --------');
                console.log(status);
                console.log('field: ' + field);
            },

            HandleUploadImageData(data){
            
                //this.uploadImage({file:data})
                this.formState.image = data
                this.imageBase64 = data
            }

        }
    }
</script>

<style lang="less" scoped>

    #axiosForm{  /* Components Root Element ID */
        position: relative;
    }

    .viewer img{
        width: 200px;
        height: 200px;
    }

    .showImg img{
        width: 299px;
        height: 299px;
    }

</style>
