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
                path: '/docs',
                name: 'docs',
                component: () => import('../views/Docs.vue'),
                meta: { title: 'docs', keepAlive: false }
            },
            {
                path: '/home',
                name: 'home',
                component: () => import('../views/Index.vue'),
                meta: { title: 'home', keepAlive: false }
            },
            {
                path: '/publish',
                name: 'publish',
                component: () => import('../views/Publish.vue'),
                meta: { title: 'publish', keepAlive: false }
            },
            {
                path: '/categories',
                name: 'Blog Categories',
                component: () => import('../views/Categories.vue'),
                meta: { title: 'Blog Categories', keepAlive: false }
            },
            {
                path: '/playground',
                name: 'Playground',
                component: () => import('../views/Playground.vue'),
                meta: { title: 'Playground', keepAlive: false }
            },
            {
                path: '/memmorial',
                name: 'PetsMemorial',
                component: () => import('../views/Memmorial.vue'),
                meta: { title: 'Pets Memorial', keepAlive: false }
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
    {
        path: "/",
        name: "Read",
        redirect: '/home',
        component: Container,
        children: [
          {
            path: '/read/:tokenId/:id',
            name: 'Detail',
            component: () => import('../views/Read.vue'),
            meta: { title: 'Blog Detail', keepAlive: false }
          }
        ]
    },
    // {
    //     path: "/",
    //     name: "Table",
    //     redirect: '/home',
    //     component: Container,
    //     children: [
    //       {
    //         path: '/table/:id',
    //         name: 'Table',
    //         component: () => import('../views/Table.vue'),
    //         meta: { title: 'Table', keepAlive: false }
    //       }
    //     ]
    // },
    // {
    //     path: "/",
    //     name: "Table",
    //     redirect: '/home',
    //     component: Container,
    //     children: [
    //       {
    //         path: '/table',
    //         name: 'Table',
    //         component: () => import('../views/Table.vue'),
    //         meta: { title: 'Table', keepAlive: false }
    //       }
    //     ]
    // },
    

]

const router = createRouter({
    // history: createWebHashHistory(),
    history: createWebHistory(),
    routes: routes
})
export default router
