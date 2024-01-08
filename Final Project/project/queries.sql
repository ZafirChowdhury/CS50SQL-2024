-- Adding a new publisher
INSERT INTO "publishers" ("name", "self_published") 
VALUES ("Larian Studios", 1);

-- Adding a new devlopers 
INSERT INTO "developers" ("name", "type", "developer_count") 
VALUES ("Larian Studios", "AA", 450);

-- Adding a new game
INSERT INTO "games" ("title", "initial_release_date", "publisher_id", "developer_id")
VALUES ("Baldur's Gate 3", "2023-08-31", 
    (SELECT "publisher_id" 
    FROM "publishers"
    WHERE "name" = "Larian Studios"), 
    
    (SELECT "developer_id"
    FROM "developers"
    WHERE "name" = "Larian Studios")
);

-- Adding a new genre
INSERT INTO "genres" (name)
VALUES ("Role Playing Game");

-- Adding genre to the game 
INSERT INTO "genre_game" ("game_id", "genre_id") 
VALUES (
    (SELECT "game_id" 
    FROM "games" 
    WHERE "title" = "Baldur's Gate 3"), 
    
    (SELECT "genre_id"
    FROM "genres"
    WHERE "name" = "Role Playing Game")
    );

-- Adding alternative title for a game ("baldur's gate 3" dosent have a alternative name, so I stole one from Reddit)
INSERT INTO "alternative_title" ("game_id", "title") 
VALUES (
    (SELECT "game_id"
    FROM "games"
    WHERE "title" = "Baldur's Gate 3"), 

    "Baldur's gate III Elistrae Bogaloo")

-- Relating one game to another
-- Baldur's gate 2 needs to be added before relating Baldur's gate 3 to Baldur's gate 2
-- Adding BG2 to relate to BG3
INSERT INTO "games" ("title", "initial_release_date", "publisher_id", "developer_id")
VALUES ("Baldur's Gate 2", "2000-09-21", 
    (SELECT "publisher_id" 
    FROM "publishers"
    WHERE "name" = "Larian Studios"), 
    
    (SELECT "developer_id"
    FROM "developers"
    WHERE "name" = "Larian Studios")
);
-- Making BG3 BG2's sequal by adding it to the game_game_relation table
INSERT INTO "game_game_relation" ("game_1", "game_2", "relation_type")
VALUES (
    (SELECT "game_id"
    FROM "games"
    WHERE "title" = "Baldur's Gate 3"), 
    
    (SELECT "game_id"
    FROM "games"
    WHERE "title" = "Baldur's Gate 2"), 
    
    "S"); -- "S" is to denotes "Sequal" (BG3 is a sequal to BG2)
-- Since we added BG3 as a sequal to BG2, We have to do vise-versa
-- We have to make BG2 a prequel of BG3, to make searching easier
INSERT INTO "game_game_relation" ("game_1", "game_2", "relation_type")
VALUES (
    (SELECT "game_id"
    FROM "games"
    WHERE "title" = "Baldur's Gate 2"), 
    
    (SELECT "game_id"
    FROM "games"
    WHERE "title" = "Baldur's Gate 3"), 
    
    "P"); -- "P" is to denotes "Prequel" (BG2 is a prequel to BG3)
-- This apporch takes up more space but it makes backed stuff easier imo

-- Adding cover art for a game
-- Cover art is added to the main table of the game as most games have a single over art and they want to show a spesific one if multiples exist
UPDATE "games" 
SET "cover_photo_link" = "https://upload.wikimedia.org/wikipedia/en/1/12/Baldur%27s_Gate_3_cover_art.jpg"
WHERE "title" = "Baldur's Gate 3";

-- Adding screenshorts, links and promotional video
-- Im going to direcly use game_id of "Baldur's Gate 3" to save time

-- Screenshorts 
INSERT INTO "screenshorts" ("game_id", "title", "link")
VALUES (1, "First Combat Encounter", "https://upload.wikimedia.org/wikipedia/en/8/87/Baldur%27s_Gate_3_first_combat_encounter.jpg");

-- Promotional Video 
INSERT INTO "promotional_video" ("game_id", "title", "link")
VALUES (1, "Baldur's Gate 3 Official Launch Trailer", "https://www.youtube.com/watch?v=1T22wNvoNiU"); 

-- Link
INSERT INTO "game_link" ("game_id", "platfrom", "link")
VALUES (1, "Steam", "https://store.steampowered.com/app/1086940/Baldurs_Gate_3/");

-- Insert people
INSERT INTO "people" ("name", "people_description", "profile_link")
VALUES ("Swen Vincke", 
"Swen Johan Vincke (/ˈsvɛn ˈvɪnkə/; born 30 May 1972) is a Belgian video game designer, programmer and director. He is the founder and CEO of the video game company Larian Studios, where he has led the development of the Divinity series and Baldur's Gate 3.", 
"https://en.wikipedia.org/wiki/Swen_Vincke");

-- Link game to people
-- Here "Swen Vincke" worked as the director for BG3
-- Since I added the entries, So im going to directly use there id's
INSERT INTO "people_in" ("game_id", "developer_id", "position", "people_id")
VALUES (1, 1, "Director", 1);

-- Inserting users info after a user has created a account
INSERT INTO "users" ("user_name", "email", "password_hash")
VALUES ("Zafir", "zafir@gmail.com", "really_strong_passsword");

-- Adding external links to user profile
INSERT INTO "user_links" ("user_id", "link", "platfrom")
VALUES (1, "www.steam.com/zafir69", "Steam");

-- Adding another user to add as friend
INSERT INTO "users" ("user_name", "email", "password_hash")
VALUES ("Poti", "polti@gmail.com", "really_strong_passsword");

-- 2 users becomes frinds (How? Depends on how its implimented in the backend)
INSERT INTO "friendship" ("user_1", "user_2")
VALUES (1, 2);

-- User 1 sends a message to user 2 
INSERT INTO "messages" ("sender", "reciver", "content")
VALUES (1, 2, "Hi!!");

-- User 1 reviews BG3 
INSERT INTO "user_review" ("game_id", "user_id", "review") 
VALUES (1, 1, "Best RPG game I have ever played. This sets a new stander for how games should be like.");

-- User 2 adds BG3 to his "Game List". By defult its set to "Playing"
INSERT INTO "user_game_status" ("user_id", "game_id") 
VALUES (2, 1);

-- User 2 marks BG3 as completed
UPDATE "user_game_status" 
SET "status" = "C"
WHERE "user_id" = 2 AND "game_id" = 1;

-- User 2 add BG2 his "Game List" and marks BG2 as "Planed to Play"
INSERT INTO "user_game_status" ("user_id", "game_id", "status") 
VALUES (2, 2, "PTP");

-- Users 1 makes a new public club 
INSERT INTO "clubs" ("owner", "name", "description","public")
VALUES (1, "DND Game Club", "A club for people who enjoy games set in the DND universe", 1);

-- The owner is also a member of tbe club, so we have to update it in the "club_member" table
INSERT INTO "club_memeber" ("user_id", "club_id", "type") 
VALUES (1, 1, "A"); 

-- Adding relating topics and games to the club 
-- Addign games (Adding BG3 and BG2 to the club)
INSERT INTO "club_game" ("club_id", "game_id") 
VALUES (1, 1), (1, 2);

-- Adding "Role Playing Game" Genre to the club
INSERT INTO "club_genres" ("club_id", "genre_id")
VALUES (1, 1);

-- Making a new Topic
INSERT INTO "topics" ("name") 
VALUES ("Dungeons & Dragons");

-- Adding topic to the club
INSERT INTO "club_topic" ("club_id", "topic_id")
VALUES (1, 1);

-- Another member joins the club (Defult is memebr)
INSERT INTO "club_member" ("club_id", "user_id")
VALUES (1, 2);

-- User 1 post in Club 1
INSERT INTO "club_post" ("user_id", "club_id", "content")
VALUES (1, 1, "New bigining of this Club!!")

-- User 2 sends a message in the "Club Group Chat"
INSERT INTO "club_group_chat" ("club_id", "user_id", "message")
VALUES (1, 2, "We should invite all our friends!")

-- When a user visits a page of a game (lets say he visits the pgae for BG3)
-- Selecting everyting related to a game, backend dev can filter through what the page needs
SELECT *
FROM "games"
JOIN "publishers" ON "games"."publisher_id" = "publishers"."publisher_id"                   -- To show the publisher of the game
JOIN "developers" ON  "games"."publisher_id" = "developers"."developer_id"                  -- To show the devolopers of the game
JOIN "alternative_title" ON "games"."game_id" = "alternative_title"."game_id"               -- To show the alternative titles of the game (if it has one)
JOIN "genre_game" ON "games"."game_id" = "genre_game"."game_id"                             -- To shows the genres of the game
JOIN "screenshots" ON "games"."game_id" = "screenshots"."game_id"                            -- To show the screenshors of the game
JOIN "promotional_video" ON "games"."game_id" = "promotional_video"."promotional_video_id"   -- To show the videos related to the game
JOIN "game_link" ON "games"."game_id" = "game_link"."game_id"                                -- To shows store page / official sites of the game
JOIN "game_game_relation" ON "games"."game_id" = "game_game_relation"."game_1"               -- To show all the games related to the game
JOIN "people_in" ON "games"."game_id" = "people_in"."game_id"                                -- To show all the people who worked in the game
JOIN "user_review" ON "games"."game_id" = "user_review"."game_id"                        -- Get all the user reviews of a game
WHERE "games"."title" = "Baldur's Gate 3";
-- After writing this long and ulgy query I realized I could have used "NATURAL JOIN" as all the tables has the column "game_id"
-- The query should be modified according to whats needed in the wab page

-- To get the avrage rating of a game
SELECT AVG("rating")
FROM "user_review"
WHERE "game_id" = 1;

-- To see top rated games 
SELECT "games"."title" AS "Game Title", AVG("user_game_status"."rating") AS "Rating"
FROM "games"
JOIN "user_game_status" 
ON "games"."game_id" = "user_game_status"."game_id"
GROUP BY "games"."game_id"
ORDER BY "Rating" DESC;

-- To see the webpgae/profile of a specific person working in a game
SELECT * FROM "people" 
WHERE "people_id" = 1;

-- To see a Users profile 
SELECT * FROM "users"
WHERE "user_id" = 1;

-- To see a users(user_id=1) friend list
SELECT "users"."user_name"
FROM "friendship"
JOIN "users" 
ON "friendship"."user_2" = "users"."user_id"
WHERE "friendship"."user_1" = 1;

-- To load all the messages recived by a user(user_id=1) 
SELECT *
FROM "messages"
WHERE "reciver" = 1
ORDER BY "time_sent" DESC; -- Newer messages come first

-- User(user_id=1) visits his game list
SELECT * 
FROM "user_game_status" 
JOIN "games" ON "user_game_status"."game_id" = "games"."game_id"
WHERE "user_id" = 1;

-- Club data for the club page also includes posts
SELECT *
FROM "clubs"
NATURAL JOIN "club_topic"
NATURAL JOIN "club_game"
NATURAL JOIN "club_member"      -- To see all the memebers (also cloud be filttred in the backend to show only active member)
NATURAL JOIN "club_posts"        -- Maybe to show all the title of the post (depends on the page layout)
JOIN "club_post_media" ON "club_posts"."club_post_id" = "club_post_media"."club_post_media_id"   -- If any media needs to be shown
JOIN "club_post_comment" ON "club_posts"."club_post_id" = "club_post_comment"."club_post_comment"."club_post_comment_id" -- If any comments needs to be shown
WHERE "clubs"."club_id" = 1;

-- To see a specific post
SELECT * 
FROM "club_posts"
NATURAL JOIN "club_post_media"      -- To load all the media
NATURAL JOIN "club_post_comments"   -- To load all the comments of the post
WHERE "club_post_id" = 1;

-- To load the Club Group Chat
SELECT * 
FROM "club_group_chat"
WHERE "club_id" = 1
ORDER BY "time";   -- Newer massage loads last
