// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require ('tax_profit/tax_calc')
// アプリ用に作成したjsを先ほど説明したapplication.jsに参照を追加する事でコンパイル対象にする。
// app/javascript以下の任意のディレクトリもしくは直下にjsを作成する。(packs以下に作らない事。)
// ここから
// window.addEventListener('load', () => {
//   console.log("OK");
// });ここまでのコードを作ったjsで打って適用したいページに行ってコンソール開いてok出るかな？確認！


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
