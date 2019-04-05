# Listing 12.11  A specification for the Post class

{describe, it} = require 'chromic'
{Post} = require '../../app/models/post'

describe 'Post', ->
  post = new Post 'A post', 'with contents'
  another = new Post 'Another post', 'with contents'

  it 'should return all posts', ->
    Post.all().length.shouldBe 2

  it 'should return a specific post', ->
    Post.get(post.slug).shouldBe 'a-post'
