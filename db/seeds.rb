Post.destroy_all
Comment.destroy_all

puts 'parsing top stories...'
newstories_url = 'https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty'
newstories_call = RestClient.get(newstories_url)
parsed_newstories_call = JSON.parse(newstories_call)
puts 'top stories parsed...'

puts 'looping through ids...'
parsed_newstories_call.each do |id|
  post_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json?print=pretty"
  post_call = RestClient.get(post_url)
  parsed_post_call = JSON.parse(post_call)
  new_post = Post.create!(
    author: parsed_post_call['by'],
    # descendants: parsed_post_call['descendants'],
    score: parsed_post_call['score'],
    posted_at: parsed_post_call['time'],
    title: parsed_post_call['title'],
    category: parsed_post_call['type'],
    url: parsed_post_call['url'],
    hn_id: parsed_post_call['id']
  )
  # print "#{new_post.title} created..."
  #
  # next if parsed_post_call['kids'].nil?
  # parsed_post_call['kids'].each do |comment_id|
  #   comment_url = "https://hacker-news.firebaseio.com/v0/item/#{comment_id}.json?print=pretty"
  #   comment_call = RestClient.get(comment_url)
  #   parsed_comment_call = JSON.parse(comment_call)
  #   new_comment = Comment.create!(
  #     author: parsed_comment_call['by'],
  #     text: parsed_comment_call['text'],
  #     posted_at: parsed_comment_call['time'],
  #     post: new_post
  #   )
  #   print 'comment created...'
  #
  #   next if parsed_comment_call['kids'].nil?
  #   parsed_comment_call['kids'].each do |sub_comment_id|
  #     sub_comment_url = "https://hacker-news.firebaseio.com/v0/item/#{sub_comment_id}.json?print=pretty"
  #     sub_comment_call = RestClient.get(sub_comment_url)
  #     parsed_sub_comment_call = JSON.parse(sub_comment_call)
  #     SubComment.create!(
  #       author: parsed_sub_comment_call['by'],
  #       text: parsed_sub_comment_call['text'],
  #       posted_at: parsed_sub_comment_call['time'],
  #       comment: new_comment
  #     )
  #     print 'sub comment created...'
  #   end
  # end
  puts "done creating #{new_post.title}."
end
puts 'seed done.'
