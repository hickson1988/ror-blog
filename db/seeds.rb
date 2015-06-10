# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



article_text='Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum'

comments1=Comment.create([
  { body: 'Very good article.'},
  { body: 'Disagree'}])

comments2=Comment.create([
  { body: 'Just a comment.'},
  { body: 'Hello there'}])

comments3=Comment.create([
  { body: 'Olympus mathon 2015'}])

articles1=Article.create([
  { title: 'Champions league finals',text: article_text, comments: comments2},
  { title: 'Super goal by Michael!',text: article_text},
  { title: 'Ski championship',text: article_text},
  { title: 'Olympus marathon',text: article_text, comments: comments3}])

articles2=Article.create([
  { title: 'New scientific discovery!',text: article_text, comments: comments1},
  { title: 'How to format a PC',text: article_text}])

category1=Category.create(name: 'Sports', description: 'A category about sports', articles: articles1)
category2=Category.create(name: 'Science', description: 'A category about science', articles: articles2)

user_admin=User.create(first_name: 'admin', last_name: 'admin', email: 'admin@test.com', password: 'admin')
user_admin.comments << comments1
user_admin.comments << comments2
user_admin.articles << articles1
user_admin.categories << category1


user_user=User.create(first_name: 'user1', last_name: 'user1', email: 'user1@test.com', password: 'user1')
user_user.comments << comments3
user_user.articles << articles2
user_user.categories << category2
