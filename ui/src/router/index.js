import { createRouter, createWebHashHistory ,createWebHistory} from "vue-router"
import Container from '../views/layout/Container'

const routes = [
    {
        path: "/",
        name: "Home",
        redirect: '/home',
        component: Container,
        children: [
            {
                path: '/home',
                name: 'home',
                component: () => import('../views/Index.vue'),
                meta: { title: 'home', keepAlive: false }
            },
            {
                path: '/playground',
                name: 'Playground',
                component: () => import('../views/Playground.vue'),
                meta: { title: 'Playground', keepAlive: false }
            },
            {
                path: '/about',
                name: 'About',
                component: () => import('../views/About.vue'),
                meta: { title: 'About', keepAlive: false }
            },
            {
                path: '/table',
                name: 'Table',
                component: () => import('../views/Table.vue'),
                meta: { title: 'Table', keepAlive: false }
            }
        ]
    },

]

const router = createRouter({
    // history: createWebHashHistory(),
    history: createWebHistory(),
    routes: routes
})
export default router
