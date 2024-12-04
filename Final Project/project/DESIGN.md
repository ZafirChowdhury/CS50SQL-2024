# Design Document

By Zafir Hossain Chowdhury.

Video overview: <https://www.youtube.com/watch?v=mgr_kqa2uws>

## Scope

This Database is designed for a website where users get info on video games and organize and score video games on a personal video game list. This database can also handle user-user interactions and social features like video game clubs.
This database was inspired by [My Anime List](https://myanimelist.net/), a website for organizing and scoring anime.
Similar websites exist that use a Database like this like [Backloggd](https://backloggd.com/). 
This is my limited interpretation of what kind of database might  “My Game List” use.

Included in the databases scope is :
* Games include basic identifying information, release date, description, age rating, user rating(derived), alternative titles, genre,  cover photo, screenshots, promotional video, links to different store Pages(Steam, Epic, GOG) / Platform (PC, PS5, XBOX, Switch) and information on who made them. 
* Publishers include basic identifying information and information on if it is self published (Published by the developer) or not. 
* Developers (Studios/Teams)  include basic identifying information and information on the development studio. Like what kind of studio they are (AAA, AA or Indie) and how many developers they have.
* People (Individuals) (Dev, Composer, Director ect),  include basic identifying information, a description on them IE what are they best known for, history on their careers, a link to external resources related to them, what games they worked on, what they did on each project. 
* Users include basic identifying information for the database. It also includes stuff like username, email, password hash, location, about me and date of birth, links(Links to other store/gaming sites (Steam, Nintendo Network, PlayStation Network)  if I decide to use the database for a webapp.
* Reviews include basic identifying information, contents of the review and if the user recommended the game or not.
* Friends includes basic identifying information and the date they became friends.
* Messages are messages between users. They include basic identifying information, time the message was sent and the content of the massage. 
* A users per game status is the most important feature/table. It includes basic identifying information, what game a user is tracking (Playing, Completed, On Hold, Dropped, Plans to Play), rating given by the user and time spent on that game. 
* Clubs include basic identifying information, name, type(private/public) and what the club is about (topic, genre, game). 
* Club Post are posts made in clubs and they have basic identifying information and content of the post.
* Club Post Media are links to media that a user might want to include, it includes basic identifying information, the link to the media and type to indentify what kind of media it is.
* Post comments are comments on the club post they have basic identifying information and content of the comment.
* Club group chat include basic identifying information and messages sent in the chat.

Out of scope are elements are buying, selling games, multiple cover arts, user submitted games and posts outside of club posts.
Stuff like witch publisher ows witch devolopers and revenue of the games are also out of scope.

## Functional Requirements

* CRUD operations for all the tables.
* Database for "My Game List" website.
* Could be used as a standalone database but not intuitive as the main gole of the database is to show the users "My Game List".

## Representation

Entities are captured in SQLite tables with the following schema.

### Entities

### Publishers
The `publishers` table includes:
* `publisher_id`, An `INTEGER` representing the unique identifier for each publisher. This column serves as the `PRIMARY KEY`.
* `name`, A `TEXT` field representing the name of the publisher, marked as `NOT NULL`.
* `self_published`, An `INTEGER` field indicating whether the game is self-published, with a `DEFAULT` value of `0` (False). This is marked as `NOT NULL`.

### Developers
The `developers` table includes:
* `developer_id`, An `INTEGER` serving as the unique identifier for each developer. This column is designated as the `PRIMARY KEY`.
* `name`, A `TEXT` field indicating the name of the developer, marked as `NOT NULL`.
* `type`, A `TEXT` field specifying the type of the developer (Indie, AAA, AA), marked as `NOT NULL` with a `CHECK` constraint.
* `developer_count` An `INTEGER` field indicating the count of developers in the studio.

### Games
The `games` table includes:
* `game_id`, An `INTEGER` serving as a unique identifier for each game, designated as the `PRIMARY KEY`.
* `title`, A `TEXT` field representing the title of the game, marked as `NOT NULL` and set to be `UNIQUE` to avoid updating issues using title.
* `initial_release_date`, A `TEXT` field indicating the initial release date of the game in `"YYYY-MM-DD"` format.
* `description`, A `TEXT` field providing a description of the game.
* `pg_rating`, A `TEXT` field representing the PG rating of the game.
* `cover_photo_link`, A `TEXT` field containing the link to the cover photo of the game.
* `publisher_id`, An `INTEGER`field linking to the `publisher_id` column in the `publishers` table as a `FOREIGN KEY`.
* `developer_id`, An `INTEGER` field linking to the `developer_id` column in the `developers` table as a `FOREIGN KEY`.

### Game-Game Relation
The game_game_relation table includes:
* `game_game_relation_id`, An `INTEGER` serving as the unique identifier for each relation, designated as the `PRIMARY KEY`.
* `game_1`, An `INTEGER` field representing one of the games in the relation.
* `game_2`, An `INTEGER` field representing the other game in the relation.
* `relation_type`, A `TEXT` field indicating the type of relation between the two games, with a `CHECK` constraint to ensure valid values ("S" for sequel, "P" for prequel, "RMK" for remake, "RMS" for remaster, "A" for games set in the same world).

### Alternative Titles
The alternative_title table includes:
* `alternative_title_id`, An `INTEGER` serving as the unique identifier for each alternative title, designated as the `PRIMARY KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the `games` table as a `FOREIGN KEY`.
* `title`, A `TEXT` field representing an alternative title for the associated game, marked as `NOT NULL`.

### Screenshots
The `screenshots` table includes:
* `screenshot_id`, An `INTEGER` serving as the unique identifier for each screenshot, designated as the `PRIMARY KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the games table as a `FOREIGN KEY`.
* `title`, A `TEXT` field representing the title of the screenshot.
* `link`, A `TEXT` field containing the link to the screenshot, marked as `NOT NULL`.

### Promotional Videos
The `promotional_video` table includes:
* `promotional_video_id`, An `INTEGER` serving as the unique identifier for each promotional video, designated as the `PRIMARY KEY`.
* `title`, A `TEXT` field representing the title of the promotional video, marked as `NOT NULL`.
* `link`, A `TEXT` field containing the link to the promotional video, marked as `NOT NULL`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the games table as a `FOREIGN KEY`.

### Genres
The `genres` table includes:
* `genre_id`, An `INTEGER` serving as the unique identifier for each genre, designated as the `PRIMARY KEY`.
* `name`, A `TEXT` field representing the name of the genre, marked as `NOT NULL` and set to be `UNIQUE`.

### Genre-Game Relation
The `genre_game` table includes:
* `genre_game_id`, An `INTEGER` serving as the unique identifier for each genre-game relation, designated as the `PRIMARY KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id column` in the `games` table as a `FOREIGN KEY`.
* `genre_id`, An `INTEGER` field linking to the `genre_id column` in the `genres` table as a `FOREIGN KEY`.

### People
The `people` table includes:
* `people_id`, An `INTEGER` serving as the unique identifier for each individual associated with the game, designated as the `PRIMARY KEY`.
* `people_description`, A `TEXT` field providing additional information about the person.
* `name`, A `TEXT` field representing the name of the individual, marked as `NOT NULL`.
* `profile_link`, A `TEXT` field containing external links related to the individual.

### People In
The `people_in` table includes:
* `people_in`, An `INTEGER` serving as the unique identifier for each person-game relation, designated as the `PRIMARY KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the `games` table as a `FOREIGN KEY`.
* `developer_id`, An `INTEGER` field linking to the `developer_id` column in the `developers` table as a `FOREIGN KEY`.
* `people_id`, An `INTEGER` field linking to the `people_id` column in the `people` table as a `FOREIGN KEY`.
* `position`, A `TEXT` field indicating the role of the individual in the game, marked as `NOT NULL`.
* `position_description`, A `TEXT` field describing the specific contributions of the individual in the given position.
* `freelancer`, An `INTEGER` field denoting whether the individual worked as a freelancer (0 for False, 1 for True), with a `DEFAULT` value of `0`.

### Game Links
The `game_link` table includes:
* `game_link_id`, An `INTEGER` serving as the unique identifier for each game link, designated as the `PRIMARY KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the `games` table as a `FOREIGN KEY`.
* `link`, A `TEXT` field containing the link to the game.
* `platform`, A `TEXT` field indicating the platform associated with the game link, marked as `NOT NULL`.

### Users
The `users` table includes:
* `user_id`, An `INTEGER` serving as the unique identifier for each user, designated as the `PRIMARY KEY`.
* `user_name`, A `TEXT` field representing the unique username of the user, marked as `NOT NULL` and set to be `UNIQUE`.
* `email`, A `TEXT` field representing the email address of the user, marked as `NOT NULL` and set to be `UNIQUE`.
* `password_hash`, A `TEXT` field storing the hashed password of the user, marked as `NOT NULL`.
* `location`, A `TEXT` field that can be used to derive the local time of the user.  
* `about_me`, A `TEXT` field allowing users to provide information about themselves.
* `date_of_birth`, A `TEXT` field representing the date of birth of the user in `"YYYY-MM-DD"` format.

### User Links
The `user_links` table includes:
* `user_link_id`, An `INTEGER` serving as the unique identifier for each user link, designated as the `PRIMARY KEY`.
* `user_id`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `link`, A `TEXT` field containing the link to an external profile.
* `platform`, A `TEXT` field indicating the platform associated with the user link, marked as `NOT NULL`.

### Friendship
The `friendship` table includes:
* `friendship_id`, An `INTEGER` serving as the unique identifier for each friendship, designated as the `PRIMARY KEY`.
* `user_1`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `user_2`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `date`, A `TEXT` field indicating the date since which the friendship exists, with a `DEFAULT` value of the `CURRENT_TIMESTAMP`.

### Messages
The `messages` table includes:
* `message_id`, An `INTEGER` serving as the unique identifier for each message, designated as the `PRIMARY KEY`.
* `sender`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `receiver`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `content`, A `TEXT` field containing the content of the message.
* `time_sent`, A `TEXT` field indicating the timestamp when the message was sent, with a `DEFAULT` value of the `CURRENT_TIMESTAMP`.

### User Game Status
The `user_game_status` table includes:
* `user_game_status_id`, An `INTEGER` serving as the unique identifier for each user-game status, designated as the `PRIMARY KEY`.
* `user_id`,  An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the `games` table as a `FOREIGN KEY`.
* `status`, A `TEXT` field indicating the user's status for the game, with a `DEFULT` value of `P` (Playing).
* `rating`, An `INTEGER` field representing the user's rating for the game, constrained to be between `0` and `100`.
* `time_spent`, A `REAL` field indicating the time spent by the user on the game.

### User Review
The `user_review` table includes:
* `user_review_id`, An `INTEGER` serving as the unique identifier for each user review, designated as the `PRIMARY KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the `games` table as a `FOREIGN KEY`.
* `user_id`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `review`, A `TEXT` field containing the user's review for the game.
* `recommended`, An `INTEGER` field indicating whether the user recommends the game (0 for Not Recommended, 1 for Recommended).

### Clubs
The `clubs` table includes:
* `club_id`, An `INTEGER` serving as the unique identifier for each club, designated as the `PRIMARY KEY`.
* `owner`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `name`, A `TEXT` field representing the name of the club, marked as `NOT NULL` and set to be `UNIQUE`.
* `description`, A `TEXT` field providing a description of the club, marked as `NOT NULL`.
* `public`, An `INTEGER` field indicating whether the club is public (1) or private (0), with a `DEFULT` value of `0`.

### Topics
The `topics` table includes:
* `topic_id`, An `INTEGER` serving as the unique identifier for each topic, designated as the `PRIMARY KEY`.
* `name`, A `TEXT` field representing the name of the topic, marked as `NOT NULL` and set to be `UNIQUE`.
* `description`, A `TEXT` field providing additional.

### Club-Topic Relation
The `club_topic` table includes:
* `club_topic_id`, An `INTEGER` serving as the unique identifier for each club-topic relation, designated as the `PRIMARY KEY`.
* `club_id`, An `INTEGER` field linking to the `club_id` column in the `clubs` table as a `FOREIGN KEY`.
* `topic_id`, An `INTEGER` field linking to the `topic_id` column in the `topics` table as a `FOREIGN KEY`.

### Club-Genre Relation
The `club_genre` table includes:
* `club_genre_id`, An `INTEGER` serving as the unique identifier for each club-genre relation, designated as the `PRIMARY KEY`.
* `club_id`, An `INTEGER` field linking to the `club_id` column in the `clubs` table as a `FOREIGN KEY`.
* `genre_id`, An `INTEGER` field linking to the `genre_id` column in the `genres` table as a `FOREIGN KEY`.

### Club-Game Relation
The `club_game` table includes:
* `club_game_id`, An `INTEGER` serving as the unique identifier for each club-game relation, designated as the `PRIMARY KEY`.
* `club_id`, An `INTEGER` field linking to the `club_id` column in the `clubs` table as a `FOREIGN KEY`.
* `game_id`, An `INTEGER` field linking to the `game_id` column in the `games` table as a `FOREIGN KEY`.

### Club-Member Relation
The `club_member` table includes:
* `club_member_id`, An `INTEGER` serving as the unique identifier for each club-member relation, designated as the `PRIMARY KEY`.
* `user_id`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `club_id`, An `INTEGER` field linking to the `club_id` column in the `clubs` table as a `FOREIGN KEY`.
* `type`, A `TEXT` field indicating the role of the user in the club (M for Member, A for Admin, O for Other), marked as `NOT NULL` with a `CHECK` constraint.

### Club Posts
The `club_posts` table includes:
* `club_post_id`, An `INTEGER` serving as the unique identifier for each club post, designated as the `PRIMARY KEY`.
* `user_id`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `club_id`, An `INTEGER` field linking to the `club_id` column in the `clubs` table as a `FOREIGN KEY`.
* `title`, A `TEXT` field containing the title of the club post, marked as `NOT NULL`.
* `content`, A `TEXT` field containing the content of the club post, marked as `NOT NULL`.

### Club Post Media
The `club_post_media` table includes:
* `club_post_media_id`, An `INTEGER` serving as the unique identifier for each club post media, designated as the `PRIMARY KEY`.
* `club_post_id`, An `INTEGER` field linking to the `club_post_id` column in the `club_posts` table as a `FOREIGN KEY`.
* `link`, A `TEXT` field containing the link to the media, marked as `NOT NULL`.
* `type`, A `TEXT` field indicating the type of media (I for Image, V for Video, L for Link), marked as `NOT NULL` with a `CHECK` constraint.

### Club Post Comments
The `club_post_comment` table includes:
* `club_post_comment_id`, An `INTEGER` serving as the unique identifier for each club post comment, designated as the `PRIMARY KEY`.
* `club_post_id`, An `INTEGER` field linking to the `club_post_id` column in the `club_posts` table as a `FOREIGN KEY`.
* `user_id`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `time`, A `TEXT` field indicating the timestamp when the comment was posted, with a `DEFULT` value of the `CURRENT_TIMESTAM`.
* `content`, A `TEXT` field containing the content of the comment, marked as `NOT NULL`.

### Club Group Chat
The `club_group_chat` table includes:
* `club_group_chat_id`, An `INTEGER` serving as the unique identifier for each club group chat entry, designated as the `PRIMARY KEY`.
* `club_id`, An `INTEGER` field linking to the `club_id` column in the `clubs` table as a `FOREIGN KEY`.
* `user_id`, An `INTEGER` field linking to the `user_id` column in the `users` table as a `FOREIGN KEY`.
* `time`, A `TEXT` field indicating the timestamp when the message was sent, with a `DEFULT` value of the `CURRENT_TIMESTAM`.
* `message`, A `TEXT` field containing the content of the group chat message, marked as `NOT NULL`.

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](erd.png) 

As detailed by the diagram:

* A GAME must have a DEVELOPER and a PUBLISHER. DEVELOPER and PUBLISHER can have multiple games or no games at all.
* People work in DEVELOPER(development studio) associated to a GAME. Many people can work in a game. People can work in many games. A game can have multiple people working on it.
* A USER has only 1 GAME_LIST. A GAME_LIST belongs to only 1 USER.
* A GAME_LIST can have multiple GAME and a GAME can be in multiple GAME_LIST.
* A CLUB can have multiple USERS. A USER can be in multiple CLUBS.
* A CLUB can have only 1 GROUP_CHAT. All USERS in the CLUB is a part of the GROUP_CHAT.
* A CLUB can have multiple POST. A POST belongs to a single CLUB. A POST is made by a single USER for a CLUB. A USER can make multiple POST.
* A POST have multiple COMMENT. A COMMENT is made by a USER for a POST. A USER can make multiple COMMENTS.
* USER can be friends with another USER.
* USER can send message to another USER. 

## Optimizations

* The query to load a game and all related data should have been a very costly query but it uses "sqlite_autoindex" and a bunch of AUTOMATIC COVERING INDEX to search so its already optimized.
* Created "user_game_status_index" witch indexs "game_id" and "user_id" column from the "user_game_status" table. Indexing "game_id" lets us find avrage rating of a game really fast witch is relly useful as it will be used every time data for a game is loaded, and the "user_id" lets us find all the game_status of a specific user really fast, witch is necessary as we have to search using "user_id" every time a user loads his game_list
* The rest of the query mostly uses PK's to find data so its auto indexed by defult

## Limitations

In this section you should answer the following questions:

* As this database is inspired by MAL(My Anime List). In MAL you can set how many times you rewatched an anime and also have more  detailed ways to track anime. This Database is not that detailed. MAL Clubs has more stuff that is not represented in this database TLDR its a very simplified Database of what a MAL for video games(My Game List) would look like.

* A bit oversite at my part, games can have multiple studios working on it but my database dose not represent that. In this database a game can only have 1 stdio working on it.
