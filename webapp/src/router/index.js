import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld,
      redirect: 'Home',
    },
    {
      path: '/home',
      name: 'Home',
      // redirect: '/',
      component: () => import('../views/home')
    },
    {
      path: '/display',
      name: 'display',
      // redirect: '/',
      component: () => import('../views/display')
    },
    {
      path: '/account',
      name: 'account',
      // redirect: '/',
      component: () => import('../views/account/account')
    }
  ]
})
