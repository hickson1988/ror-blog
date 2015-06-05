# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

article_text=' Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'

comments1=Comment.create([
  { commenter: 'Mike',body: 'Very good article.'},
  { commenter: 'John',body: 'Disagree'}])

comments2=Comment.create([
  { commenter: 'John',body: 'Just a comment.'},
  { commenter: 'Alice',body: 'Hello there'}])

comments3=Comment.create([
  { commenter: 'Mike',body: 'Olympus mathon 2015 :).'}])

articles1=Article.create([
  { title: 'Champions league finals',text: article_text, comments: comments2},
  { title: 'Super goal by Michael!',text: article_text},
  { title: 'Ski championship',text: article_text},
  { title: 'Olympus marathon',text: article_text, comments: comments3}])

articles2=Article.create([
  { title: 'New scientific discovery!',text: article_text, comments: comments1},
  { title: 'How to format a PC',text: article_text}])

Category.create(name: 'Sports', description: 'A category about sports', articles: articles1)
Category.create(name: 'Science', description: 'A category about science', articles: articles2)
