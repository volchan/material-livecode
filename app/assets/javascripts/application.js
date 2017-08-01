//= require jquery
//= require jquery_ujs
//= require materialize
//= require_tree .

App.cable.subscriptions.create(
  {
    channel: "PostsChannel"
  },
  {
    connected: function(data) {
      console.log("[CONNECTED]");
    },
    received: function(data) {
      console.log(data);
      $newPost = $(data.html)
      $newPost.hide();
      $('#posts-container').prepend($newPost);
      $newPost.slideDown();
    }
  }
);
