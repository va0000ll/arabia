// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
require('@popperjs/core/dist/umd/popper-lite');
require('bootstrap/dist/js/bootstrap.bundle');
require('arabic-timeago');
import Tribute from "tributejs";
import 'font-awesome/scss/font-awesome';
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

window.addEventListener('DOMContentLoaded', () => {
    var tribute = new Tribute({
        lookup: 'name',
        fillAttr: 'name',
        menuShowMinLength: 1,
        values: async (text, cb) => {
            return $.getJSON('/users.json', {q: text}, cb)
        }
    });
    if(document.getElementById("tweet_content")){
        tribute.attach(document.getElementById("tweet_content"));
    }
});