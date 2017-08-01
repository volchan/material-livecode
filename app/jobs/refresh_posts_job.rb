class RefreshPostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    newstories_url = 'https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty'
    newstories_call = RestClient.get(newstories_url)
    parsed_newstories_call = JSON.parse(newstories_call).reverse

    parsed_newstories_call.each do |id|
      unless Post.find_by(hn_id: id)
        puts 'creating post...' * 20
        post_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json?print=pretty"
        post_call = RestClient.get(post_url)
        parsed_post_call = JSON.parse(post_call)

        url = parsed_post_call['url'] || "https://news.ycombinator.com/item?id=#{parsed_post_call['id']}"

        new_post = Post.create!(
          author: parsed_post_call['by'],
          score: parsed_post_call['score'],
          posted_at: parsed_post_call['time'],
          title: parsed_post_call['title'],
          category: parsed_post_call['type'],
          url: url,
          hn_id: parsed_post_call['id']
        )

        puts 'sending post...' * 20
        ActionCable.server.broadcast(
          "PostsChannel",
          html: ApplicationController.new.render_to_string(partial: 'pages/post_card', locals: { post: new_post }, layout: false)
        )
      end
    end
  end
end
