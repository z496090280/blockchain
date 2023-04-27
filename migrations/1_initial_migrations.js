/*
 * @Author: lee
 * @Date: 2023-04-27 15:13:17
 * @LastEditTime: 2023-04-27 16:21:36
 */
const Hello = artifacts.require('MyContract')

module.exports = function (deploy) {
  deploy.deploy(Hello)
}