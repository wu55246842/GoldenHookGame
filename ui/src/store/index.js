import { createStore } from 'vuex'

export default createStore({
    state: {
        currentAccount: null,
        sharing:{
            url: window.location.href,
            title: 'LAOWD :Pure Web3 Blog System',
            description: 'Tribute to the future',
            quote: '',
            hashtags: 'Web3',
            twitterUser: 'Leon_invincible'
        },
    },
    mutations: {
        setSharingDo(state,s){
            state.sharing=s;
        },
    },
    actions: {
        setCurrentAccount({commit,state}, val){
            state.currentAccount = val
        },
        setSharing(content,s){
            content.commit('setSharingDo',s);
        }
    },
    modules: {
    }
})
