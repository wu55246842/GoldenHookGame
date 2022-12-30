

export default{
   
    methods: {
   
      readBookUrl(file_url) {
        //可以是具体.txt也可以是接口返回的blob，或者web转换
        let xhr = new XMLHttpRequest();
        xhr.open("get", file_url, true);
        xhr.responseType = "blob";
        let self=this//onload this指向为window中转一下
        this.loading=true;
        xhr.onload = function () {
            if (this.status == 200) {
                self.loading=false;
                const reader = new FileReader()
                reader.onload = function () {
                    self.txtPre=reader.result//获取的数据data
                    this.bookContent = reader.result
                    self.dialogvisibleview=true
                    console.log('reader.result', reader.result)
                }
                reader.readAsText(this.response);
            }else{
                slef.loading=false;
            }
        };
        xhr.send();
       },

       sortByKey(array, key) {
            return array.sort(function(a, b) {
                var x = a[key]; 
                var y = b[key];
                //return((x<y)?-1:((x>y)?1:0));
                return((y<x)?-1:((y>x)?1:0));
            });
        },

        randomNum(minNum,maxNum){ 
            switch(arguments.length){ 
                case 1: 
                    return parseInt(Math.random()*minNum+1,10); 
                    break; 
                case 2: 
                    return parseInt(Math.random()*(maxNum-minNum+1)+minNum,10); 
                    break; 
                case 3: 
                    return parseInt(Math.random()*(maxNum-minNum+1)+minNum,100); 
                    break; 
                case 4: 
                    return parseInt(Math.random()*(maxNum-minNum+1)+minNum,1000); 
                    break;
                case 4: 
                    return parseInt(Math.random()*(maxNum-minNum+1)+minNum,10000); 
                    break;
                default: 
                    return 100; 
                    break; 
            } 
        } ,

        goToReadBook(data){
            // if(data && data.tokenId){
            //     this.$router.push("/read/" + data.tokenId);
            // }else if(data && data.id){
            //     this.$router.push({path: "/read/" + data.tokenId, query: {id:data.id}})
            //     //this.$router.push("/read/" + data.id);
            // }

            this.$router.push("/read/" + data.tokenId?data.tokenId:100000 + "/" + data.id?data.id:'xxxxx');
            
        },

        goToTable(id){
            // this.$router.push("/table/" + id);
            this.$router.push({
                name: 'Table',
                query: {
                  id: id
                }
              })
        },

        msToDate(ms){
            let d = new Date(ms)
            return d.toDateString()
        }

    },

    

  
  }