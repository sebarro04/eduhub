import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'login',
    component: () => import('../views/LoginPage.vue')
  },
  {
    path: '/files',
    name: 'files',
    component: () => import('../views/FilesPage.vue')
  },
  {
    path: '/files/history',
    name: 'file history',
    component: () => import('../views/FileHistoryPage.vue')
  },
  {
    path: '/files/upload',
    name: 'file upload',
    component: () => import('../views/UploadFilePage.vue')
  },
  {
    path: '/files/modify',
    name: 'file modify',
    component: () => import('../views/ModifyFilePage.vue')
  }  
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
