<template>
  <el-button @click="editCropper()">Upload</el-button>
  <el-dialog :title="title" v-model="open" width="800px" append-to-body @opened="modalOpened"  @close="closeDialog">
    <el-row>
      <el-col :xs="24" :md="12" :style="{height: '350px'}">
        <vue-cropper
            ref="cropper"
            :img="options.img"
            :info="true"
            :autoCrop="options.autoCrop"
            :autoCropWidth="options.autoCropWidth"
            :autoCropHeight="options.autoCropHeight"
            :fixedBox="options.fixedBox"
            @realTime="realTime"
            v-if="visible"
        />
      </el-col>
      <!-- <el-col :xs="24" :md="12" :style="{height: '350px'}">
        <div class="avatar-upload-preview">
          <img :src="options.previews.url" :style="options.previews.img"/>
        </div>
      </el-col> -->
      <el-col :xs="24" :md="12">
        <div class="show-preview" :style="{'width': options.previews.w + 'px', 'height': options.previews.h + 'px',  
        'overflow': 'hidden','margin': '5px'}">
          <div :style="options.previews.div">
            <img :src="options.previews.url" :style="options.previews.img">
          </div>
        </div>
      </el-col>
    </el-row>
    <br/>
    <el-row>
      <el-col :lg="2" :md="2">
        <el-upload action="#" :http-request="requestUpload" :show-file-list="false" :before-upload="beforeUpload">
          <el-button>
            Select
            <el-icon class="el-icon--right"><Upload /></el-icon>
          </el-button>
        </el-upload>
      </el-col>
      <el-col :lg="{span: 1, offset: 2}" :md="2">
        <el-button icon="Plus" @click="changeScale(1)"></el-button>
      </el-col>
      <el-col :lg="{span: 1, offset: 1}" :md="2">
        <el-button icon="Minus" @click="changeScale(-1)"></el-button>
      </el-col>
      <el-col :lg="{span: 1, offset: 1}" :md="2">
        <el-button icon="RefreshLeft" @click="rotateLeft()"></el-button>
      </el-col>
      <el-col :lg="{span: 1, offset: 1}" :md="2">
        <el-button icon="RefreshRight" @click="rotateRight()"></el-button>
      </el-col>
      <el-col :lg="{span: 2, offset: 6}" :md="2">
        <el-button type="primary" @click="handleUploadImg()">Submit</el-button>
      </el-col>
    </el-row>
  </el-dialog>
  
</template>

<script setup>
import { getCurrentInstance, ref ,reactive ,defineEmits , defineProps} from 'vue';
import { ElMessageBox } from "element-plus";
import "vue-cropper/dist/index.css";
import { VueCropper } from "vue-cropper";
import { bool } from 'vue-types';

const props = defineProps({
      uploadedImgUrl: {
          type: String,
          required: false,
          default:''
      },
  })

const { proxy } = getCurrentInstance();

const open = ref(false);
const visible = ref(false);
const title = ref("Edit Or Crop Image");

const previewStyle1 = ref({})
const previewStyle2 = ref({})
const previewStyle3 = ref({})
const previewStyle4 = ref({})

const emit = defineEmits(['uploadImageData'])

//??????????????????
const options = reactive({
  img: '', // ?????????????????????
  autoCrop: true, // ???????????????????????????
  autoCropWidth: 300 , // ???????????????????????????
  autoCropHeight: 300, // ???????????????????????????
  fixedBox: true, // ????????????????????? ???????????????
  previews: {} //????????????
});

/** ???????????? */
function editCropper() {
  open.value = true;
};
/** ????????????????????????????????? */
function modalOpened() {
  visible.value = true;
};
/** ???????????????????????? */
function requestUpload() {
};
/** ???????????? */
function rotateLeft() {
  proxy.$refs.cropper.rotateLeft();
};
/** ???????????? */
function rotateRight() {
  proxy.$refs.cropper.rotateRight();
};
/** ???????????? */
function changeScale(num) {
  num = num || 1;
  proxy.$refs.cropper.changeScale(num);
};
/** ??????????????? */
function beforeUpload(file) {
  if (file.type.indexOf("image/") == -1) {
    proxy.$modal.msgError("??????????????????????????????????????????,??????JPG???PNG??????????????????");
  } else {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      options.img = reader.result;
    };
  }
};
/** ???????????? */
function handleUploadImg() {
  // proxy.$refs.cropper.getCropBlob(data => {
  //   // let formData = new FormData();
  //   // formData.append("avatarfile", data);
  //   emit('uploadImageData', data) 
  // });

  proxy.$refs.cropper.getCropData(data => {
    emit('uploadImageData', data) 
  });
};

function realTime(data) {
  var previews = data
  var h = 0.5
  var w = 0.2

  previewStyle1.value = {
    width: previews.w + "px",
    height: previews.h + "px",
    overflow: "hidden",
    margin: "0",
    zoom: h
  }

  previewStyle2.value = {
    width: previews.w + "px",
    height: previews.h + "px",
    overflow: "hidden",
    margin: "0",
    zoom: w
  }

  // ????????? 100 ??????
  previewStyle3.value = {
    width: previews.w + "px",
    height: previews.h + "px",
    overflow: "hidden",
    margin: "0",
    zoom: 100 / options.previews.w
  }

  // ????????? 100 ??????
  previewStyle4.value = {
    width: previews.w + "px",
    height: previews.h + "px",
    overflow: "hidden",
    margin: "0",
    zoom: 100 / options.previews.h
  }
  options.previews = data
}
/** ???????????? */
function closeDialog() {
  options.img = '';
  options.visible = false;
};
</script>

<style scoped>
.user-info-head {
  position: relative;
  display: inline-block;
  height: 120px;
}

.user-info-head:hover:after {
  content: "+";
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  color: #eee;
  background: rgba(0, 0, 0, 0.5);
  font-size: 24px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  cursor: pointer;
  line-height: 110px;
  border-radius: 50%;
}
.avatar-upload-preview {
	position: absolute;
	top: 50%;
	transform: translate(50%, -50%);
	width: 300px;
	height: 300px;
	border-radius: 1%;
	box-shadow: 0 0 4px #ccc;
	overflow: hidden;
}


</style>
