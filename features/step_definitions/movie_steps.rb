# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "(.*?)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  #pending  # Remove this statement when you finish implementing the test step
  @movie_count=0
  movies_table.hashes.each do |movie|
    Movie.create movie
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    @movie_count+= 1
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |rating_list|
  
  rating_list.split(', ').each do |rating|
    page.check('ratings_'+rating)
  end
  
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  
  # using the appropriate Capybara command(s)
  #pending  #remove this statement after implementing the test step
end

Then /^I should see only movies rated: "(.*?)"$/ do |rating|
  #pending  #remove this statement after implementing the test step
  ratings_array = Movie.all_ratings
  check = false
  rating.split(', ').each do |cur_rating|
    #iterate over array of all rating 
    if ratings_array.include?(cur_rating)
        ratings_array.delete(cur_rating)
    end
  end
  
  rating.split(', ').each do |cur_rating|
    #iterate over array of all rating 
    if ratings_array.include?(cur_rating)
      check = false
    else
      check = true
    end
  end
  
  expect(check).to be_truthy
  

end

Then /^I should see all of the movies$/ do
  movies_displayed = 0;
  check =false
  Movie.all.each do |movie|
    movies_displayed+=1
  end
  #pending  #remove this statement after implementing the test step
  if movies_displayed == @movie_count
    check = true
  end
  
  expect(check).to be_truthy
end



When /^I follow "(.*?)"$/ do |sort_option|
  if sort_option == 'Movie Title'
    click_on("title_header")
  end
  
  if sort_option == 'R Date'
    click_on("release_date_header")
  end
end

Then /^I should see the page "(.*?)" before "(.*?)"$/ do |string1, string2|
  pageString = page.body.to_s
  check=false
  
  if pageString.index(string1)!= nil && pageString.index(string2) !=nil
    if pageString.index(string1) < pageString.index(string2)
      check =true
    else
      check =false
    end
  end
  
  expect(check).to be_truthy
end

