export default [
    {
        path: '/account',
        name: 'account',
        component: () => import('../views/account/account'),
        meta: {
            title: '我的'
        }
    },
    {
        path: '/account/user-setting',
        name: 'user-setting',
        component: () => import('../views/account/user-setting'),
        meta: {
            title: '账号修改'
        }
    }
];