// const { VantResolver } = require('unplugin-vue-components/resolvers');
const ComponentsPlugin = require('unplugin-vue-components/webpack');

const path = require('path')
const port = 81 // 端口配置

function resolve(dir) {
    return path.join(__dirname, dir)
}
  
const webpack = require("webpack");

module.exports = {
    publicPath:'./',
    lintOnSave : false,
    configureWebpack: {
        // plugins: [
        //     ComponentsPlugin({
        //         resolvers: [VantResolver()],
        //     }),
        // ],

        //支持jquery
        plugins: [
          new webpack.ProvidePlugin({
              $:"jquery",
              jQuery:"jquery",
              "windows.jQuery":"jquery"
          })
      ]
    },

    

    devServer: {
        host: '0.0.0.0',
        port: port,
        open: false,
        proxy: {
          [process.env.VUE_APP_BASE_API]: {
            target: `http://192.168.0.38/dev-api/`,
            changeOrigin: true,
            pathRewrite: {
              ['^' + process.env.VUE_APP_BASE_API]: ''
            }
          }
        },
        disableHostCheck: true
      },
}
