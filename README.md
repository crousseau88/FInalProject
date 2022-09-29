# MentorMe

<p align="center"><img src="" width="550"></p>

## Authors

<p align="left"><img src="media/AustinProf.png" width="105"> Austin Borck (Scrum Master, Developer) </p>
<p align="left"><img src="media/ChadProf2.png" width="105"> Chad Rousseau (Repo Owner, Developer) </p>
<p align="left"><img src="media/KenProf.png" width="105"> Ken Pederson (Database Administrator, Developer) </p>
<br>
<br>
<p align="center"><img src="https://media.giphy.com/media/eVqUIgL0IVcis0RA1t/giphy.gif" width="450" height="250" /></p>

## Overview

<strong><p align="center">Created by developers to lift up those who endeavor to become developers.</p></strong>

Breaking into the developer industry can be difficult, especially when you haven't built a network. Our application, MentorMe, solves this problem. Here, bootcamp graduates register as mentors, post their review of the bootcamp they attended, the advice they have for any prospective student and the tools they recommend that will help any cohort be successful. The real impact, however, comes from the interaction between mentor and mentee. Those interested in enrolling in a software developer bootcamp register as mentees and can search for bootcamps or languages they're interested in to find mentors they can interact with. 

A mentee has access to a mentors account page where they will be able to review everything the mentor has to share about their experience. Most importantly, the mentee can interact with the mentor through posting messages and replying to the mentors responses. Furthermore, these messages can then be marked as helpful or inappropriate so admins can determine whether or not they need to delete a post. Any user also has the option of deleting a comment they have posted should they choose to do so. 

<strong><p align="center">It doesn't stop there...</p></strong>

After graduation, new graduates can learn from their mentors on what to expect during the job search and the lessons they learned. Having a network is priceless. MentorMe... priceless. 

## Visit MentorMe!

If you would like to visit our site and take it for a test drive, see the link below. Any visitor can register a new account or utilize one of two accounts pre-built in the database...

* Mentee username: lightning, password: guest5
* Mentor username: splinter, password: mentor4  

<p align="center"><a href="http://184.169.170.189:8080/MentorMe/#/home">MentorMe</a></>

If you would like to test the backend of the application, reference the table within the "Testing With Postman" section below for example URI's you can use to interact with the applications functionality.

## Description

<p align="center"><img src="media/mentormeschema.png" width="500"></p>

When a user visits our site, there are 4 possible paths...

1. A visitor who has access to view bootcamps and their associated reviews and discussions. Furthermore, the user can perform a search from the home page for a specific bootcamp, different languages or tech they're interested in such as "Java" or "Angular". With this general access, the intent is to prove to the visitor that they will highly benefit from creating a personal account and thereby being able to ask their personal questions to mentor that helps them shape their approach to being successful in their future bootcamp environment. If the visitor is a prior bootcamp graduate, the site is designed to inspire them to register an account and become an additional mentor and add a new bootcamp to the pool. 

2. In addition to the access granted to a visitor, a mentee, once logged in, can actively engage with the MentorMe community via the post/reply system. Furthermore, they can choose to "follow" a mentor to add a convenient link to their account page for instant access back to the mentors account page. Additionally, a mentee can flag messages as being either helpful or inappropriate. Finally, the relationship between mentee and mentor culminates in the mentee reaching out to the mentor for job-search advice and networking.

3. A mentor posts their review, advice and tools for mentees to view and create a starting point to initiate a "mentoring" conversation with them. 

4. An administrator can ensure inappropriate activities are policed as well as add additional bootcamps as mentors register who have graduated from bootcamps not yet in the collection of bootcamps in the database. 


## Methodology

![Alt Text](https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif)

![Alt Text](https://media.giphy.com/media/v1qwIBdb0kZOkeEzYR/giphy.gif)

<img src="https://media.giphy.com/media/v1qwIBdb0kZOkeEzYR/giphy.gif" width="40" height="40" />

Teamwork. Full stop. 


The database was built using MySQL Workbench. As seen in the schema above, the teams approach was to keep the architecture as simple as possible to allow the most progress possible given our timeline of a 1-week sprint. The core backend was created using REST and thoroughly tested using Postman. The frontend has been built utilizing Angular and Bootstrap. 
## Testing the Backend With Postman

<p align="center"><img src="media/Postman.png" width="500"></p>

To test the backend of the application, a user may visit the <a href="https://www.postman.com/">Postman</a> site. Once set up, reference the table below for URI's testing the validity of the code once you've started up the program in the SpringToolSuite4 Boot Dashboard. For the URI's below to function, ensure the authorization type is set to basic. Set the username to "sage" and the password to "mentor". 

> For testing a non-deployed, local version of the application, each URI is preceded with "http://localhost:8090/api/"

| HTTP Verb | URI                        | Request Body | Response Body        | Functionality                                                              |
|:---------:|:---------------------------|:------------:|:---------------------|:---------------------------------------------------------------------------|
| GET       | 'account/grasshopper'      |              | Single user          | Return a user by their id                                                  |
| GET       | 'bootcamps'                |              | List of bootcamps    | Return a list of all bootcamps                                             |
| GET       | 'bootcamps/search/KEYWORD' |              | List of bootcamps    | Return a list of boot camps by searching their name or tech                |
| POST      | 'posts'                    |     JSON     | Created post message | Create a new message posting                                               |
| POST      | 'replies/1'                |     JSON     | Created Post reply   | Create a reply to a posted message                                         |
| PUT       | 'account'                  |     JSON     | Updated user account | Update a users account information                                         |
| DELETE    | 'posts/3'                  |              |                      | Delete a post belonging to the logged in user                              |

* Example code to use for POST routes below. Note that the date and subject may be omitted due to default values being set in the service file.

> {
        "text": "New Post text",
        "subject": "New Post Subject"
   }
   
* Example code to post a reply to a posted comment

> {   "text": "NEW REPLY TO THIS POST" }

* Example code to update a users account information

> {
    “username”: “New username”,
    “password”: “New password”,
    “firstName”: “New first name”,
    “lastName”: “New last name”,
    “email”: “New email”,
    “aboutMe”: “New aboout me”
}

## Lessons Learned

* 


## Technologies 

* Angular
* AWS- EC2
* Bootstrap
* Git
* GitHub
* Gradle
* Java 
* MySQL Workbench
* Postman
* RESTful Services
* SpringToolSuite4
* Spring Data JPA
* Spring Boot
* Spring MVC
* Terminal -zsh
* TypeScript

## A Few Screen Shots Of Code Taken During The Development Journey

* Code excerpt for adding a new Education Event in the database. Extra code was written to ensure default values for the subject being recorded and the date when the event occurred. By setting the subject to "Not Declared" the intent is to raise awareness to the user so they will update then event with the correct subject. The date is set to "now" as this will most likely be the case if the user is recording updates in real time. Regardless, it serves as a starting point.

 <p align="center"><img src="media/codeAddEvent.png" width="350"></p>
 
* Code excerpt of how an event is updated. Every field is verified through if/else logic.

 <p align="center"><img src="media/codeUpdateEvent.png" width="350"></p>
 
* Code excerpt of how an event is deleted and ensuring a 404 code is returned when the event being referred to no longer exists.

 <p align="center"><img src="media/codeControllerDelete.png" width="350"></p>
 
* Example code excerpt showing the verboseness of using vanilla Javascript to tie the backend to the frontend. This excerpt uses the DOM to populate the HTML file with a pre-populated form for the user to perform updates to a record and continues past what you see here. 

 <p align="center"><img src="media/vanillaJSExample.png" width="350"></p>
 
 * The very first iteration of the Angular/Bootstrap frontend. Not much to look at just yet but work has just begun!
 
 <p align="center"><img src="media/angularFirstPass.png" width="350"></p>