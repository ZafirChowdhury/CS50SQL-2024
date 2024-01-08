-- Publishes of diffrente games
CREATE TABLE "publishers" (
    "publisher_id" INTEGER,
    "name" TEXT NOT NULL,
    "self_published" INTEGER NOT NULL DEFAULT "0", -- "0" = "False", "1" = "True"
    PRIMARY KEY("publisher_id")
); 

-- Devollopers who create the games (studios not individual people) (A studio can have only 1 person working)
CREATE TABLE "developers" (
    "developer_id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK ("type" IN ("Indie", "AAA", "AA")),
    "developer_count" INTEGER,
    PRIMARY KEY("developer_id")
);

-- Games
CREATE TABLE "games" (
    "game_id" INTEGER,
    "title" TEXT UNIQUE NOT NULL, -- Made the titles unique to avoid updating issus using title. We can add releace year or abbreviations to uniquely indentify games with same title
    "initial_release_date" TEXT, -- "YYYY-MM-DD"
    "description" TEXT,
    "pg_rating" TEXT,
    "cover_photo_link" TEXT,
    "publisher_id" INTEGER,
    "developer_id" INTEGER,
    PRIMARY KEY("game_id"),
    FOREIGN KEY("publisher_id") REFERENCES "publishers"("publisher_id"),
    FOREIGN KEY("developer_id") REFERENCES "developers"("developer_id")
);

-- Some games are related to each other (sequel("S"), prequel("S"), remake("RMK"), remaster("RMS") or set in the same world ("A"))
-- A table to track with games are related
CREATE TABLE "game_game_relation" (
    "game_game_relation_id" INTEGER,
    "game_1" INTEGER,
    "game_2" INTEGER,
    "relation_type" TEXT NOT NULL CHECK ("relation_type" IN ("S", "P", "RMK", "RMS", "A"))
);

-- Alternative titles for games
CREATE TABLE "alternative_title" (
    "alternative_title_id" INTEGER,
    "game_id" INTEGER,
    "title" TEXT NOT NULL,
    PRIMARY KEY("alternative_title_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("games_id")
); 

-- Screenshots (Games featue SS to show what the games looks like)
CREATE TABLE "screenshots" (
    "screenshot_id" INTEGER,
    "game_id" INTEGER,
    "title" TEXT,
    "link" TEXT NOT NULL,
    PRIMARY KEY("screenshot_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("game_id")
);

-- Trailers, Gameplay recordings for the game (links)
CREATE TABLE "promotional_video" (
    "promotional_video_id" INTEGER,
    "title" TEXT NOT NULL,
    "link" TEXT NOT NULL,
    "game_id" INTEGER,
    PRIMARY KEY("promotional_video_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("game_id")
);

-- Genres
CREATE TABLE "genres" (
    "genre_id" INTEGER,
    "name" TEXT UNIQUE NOT NULL,
    PRIMARY KEY("genre_id")
);

-- Games to genres relation table
CREATE TABLE "genre_game" (
    "genre_game_id" INTEGER,
    "game_id" INTEGER,
    "genre_id" INTEGER,
    PRIMARY KEY("genre_game_id")
    FOREIGN KEY("game_id") REFERENCES "games"("game_id"),
    FOREIGN KEY("genre_id") REFERENCES "genres"("genre_id")
);

-- Individua People who worked on these gamees (Dev, Composer, Director ect)
-- People can work on multiple games, a game may be devoloped by multiple people
-- People works in a devolopment team (devolopers) while making a game
-- Pople can not edit this only Admins and database maintainer can edit them
CREATE TABLE "people" (  -- Better name would be "person or devolopter" changing it seems tedious, have to come up with better names next time
    "people_id" INTEGER,
    "people_description" TEXT,
    "name" TEXT NOT NULL,
    "profile_link" TEXT, -- Extarnal links to there webside or other sites related to them
    PRIMARY KEY("people_id")
);

-- Game and people relation
CREATE TABLE "people_in" (
    "people_in" INTEGER,
    "game_id" INTEGER,
    "developer_id" INTEGER,
    "people_id" INTEGER,
    "position" TEXT NOT NULL,
    "position_description" TEXT, -- What they did as a dev in the game
    "freelancer" INTEGER NOT NULL DEFAULT 0 CHECK ("freelancer" IN (0, 1)), -- Used to denote if he worked from the stodio or he workd as a freelancer
    PRIMARY KEY("people_in"),                                               -- Can also be used to solf NULL devoloper as its  a FK 
    FOREIGN KEY("game_id") REFERENCES "games"("game_id"),
    FOREIGN KEY("developer_id") REFERENCES "developers"("developer_id"),
    FOREIGN KEY("people_id") REFERENCES "people"("people_id")
);

-- Links to store pages (Steam, Epic, GOG) / Platform (PC, PS5, XBOX, Switch)
CREATE TABLE "game_link" (
    "game_link_id" INTEGER,
    "game_id" INTEGER,
    "link" TEXT NOT NULL,
    "platfrom" TEXT NOT NULL,
    PRIMARY KEY("game_link_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("game_id")
);

-- Users who will use the site/database
CREATE TABLE "users" (
    "user_id" INTEGER,
    "user_name" TEXT UNIQUE NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "password_hash" TEXT NOT NULL,
    "location" TEXT, -- derive local time from this
    "about_me" TEXT,
    "date_of_birth" TEXT, -- "YYYY-MM-DD" -- Can be used to celebrate Birtdays
    PRIMARY KEY("user_id")
);

-- Users profile links (Links to other store/gaming sites (Steam, Nintendo Network, PlayStation Network))
CREATE TABLE "user_links" (
    "user_link_id" INTEGER,
    "user_id" INTEGER, 
    "link" TEXT NOT NULL,
    "platfrom" TEXT NOT NULL,
    PRIMARY KEY("user_link_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("user_id")
);

-- User to user relation
CREATE TABLE "friendship" (
    "friendship_id" INTEGER,
    "user_1" INTEGER,
    "user_2" INTEGER,
    "date" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, -- "YYYY-MM-DD" (Friend since)
    PRIMARY KEY("friendship_id"),
    FOREIGN KEY("user_1") REFERENCES "users"("user_id"),
    FOREIGN KEY("user_2") REFERENCES "users"("user_id")
);

-- User to user private masseging
CREATE TABLE "messages" (
    "message_id" INTEGER,
    "sender" INTEGER,
    "reciver" INTEGER,
    "content" TEXT,
    "time_sent" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, -- "YYYY-MM-DD HH:MM:SS"
    PRIMARY KEY("message_id"),
    FOREIGN KEY("sender") REFERENCES "user"("user_id"),
    FOREIGN KEY("reciver") REFERENCES "user"("user_id")
);

-- User status for each game
-- "P" = "Playing" (Defult)
-- "C" = "Completed"
-- "OH" = "On Hold"
-- "D" = "Dropped"
-- "PTP" = "Plan to Play" (user plans to play this game)
-- "OG" = "Live Service Game"/"Pure Online Games"
-- Users can drop or comlete "OG" games depending on there preferences
CREATE TABLE "user_game_status" (
    "user_game_status_id" INTEGER,
    "user_id" INTEGER,
    "game_id" INTEGER,
    "status" TEXT NOT NULL DEFAULT "P" CHECK ("status" IN ("P", "C", "OH", "D", "PTP", "OG")),
    "rating" INTEGER CHECK ("rating" BETWEEN 0 AND 100),
    "time_spent" REAL, -- User editable, Varification not requred
    PRIMARY KEY("user_game_status_id"),
    FOREIGN KEY("user_id") REFERENCES "user"("user_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("game_id")
);

-- User Reviews (diffrent from user rating for games is there list)
-- In recommended "0" = "Not Recommended" and "1" = "Recommended" 
CREATE TABLE "user_review" (
    "user_review_id" INTEGER,
    "game_id" INTEGER,
    "user_id" INTEGER,
    "review" TEXT NOT NULL,
    "recommended" INTEGER NOT NULL CHECK ("recommended" IN (0, 1))
);

-- Clubs
-- Clubs can have topics, genres and games 
CREATE TABLE "clubs" (
    "club_id" INTEGER,
    "owner" INTEGER, -- Person who made the club (founder)
    "name" TEXT UNIQUE NOT NULL,
    "description" TEXT NOT NULL,
    "public" INTEGER NOT NULL DEFAULT 0 CHECK ("public" IN (0, 1)), -- 1 = "The club is a public club" 2 = "The club is a private club"
    PRIMARY KEY("club_id"),
    FOREIGN KEY("owner") REFERENCES "users"("user_id")
);

-- Topics
CREATE TABLE "topics" (
    "topic_id" INTEGER,
    "name" INTEGER UNIQUE NOT NULL,
    "description" TEXT,
    PRIMARY KEY("topic_id")
);

-- Clubs could have multiple topics and genres and topics and genres could be in multiple clubs
CREATE TABLE "club_topic" (
    "club_topic_id" INTEGER,
    "club_id" INTEGER,
    "topic_id" INTEGER,
    PRIMARY KEY("club_topic_id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("club_id"),
    FOREIGN KEY("topic_id") REFERENCES "topic"("topic_id")
);

CREATE TABLE "club_genre" (
    "club_genre_id" INTEGER,
    "club_id" INTEGER,
    "genre_id" INTEGER,
    PRIMARY KEY("club_genre_id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("club_id"),
    FOREIGN KEY("genre_id") REFERENCES "genre"("genre_id")
);

CREATE TABLE "club_game" (
    "club_game_id" INTEGER,
    "club_id" INTEGER, 
    "game_id" INTEGER,
    PRIMARY KEY("club_game_id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("club_id"),
    FOREIGN KEY("game_id") REFERENCES "games"("game_id")
);

-- Club and user relation
CREATE TABLE "club_member" (
    "club_member_id" INTEGER,
    "user_id" INTEGER, 
    "club_id" INTEGER,
    "type" TEXT NOT NULL DEFAULT "M" CHECK ("type" IN ("M", "A", "O")), -- "M" = "Member", "A" = "Admin"
    PRIMARY KEY("club_member_id"),
    FOREIGN KEY("user_id") REFERENCES "user"("user_id"), 
    FOREIGN KEY("club_id") REFERENCES "clubs"("club_id")
);

-- Club post
CREATE TABLE "club_posts" (
    "club_post_id" INTEGER,
    "user_id" INTEGER,
    "club_id" INTEGER,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    PRIMARY KEY("club_post_id"),
    FOREIGN KEY("user_id") REFERENCES "users"("user_id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("club_id")
);

-- A club post can include a link to a media (image, video, arlicle etc)
-- The "type" can be used to properly show the media in the webpage
CREATE TABLE "club_post_media" (
    "club_post_media_id" INTEGER,
    "club_post_id" INTEGER,
    "link" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK ("type" IN ("I", "V", "L")), -- "I" = "Image", "V" = "Video", "L" = "Link"
    PRIMARY KEY("club_post_media_id"),
    FOREIGN KEY("club_post_id") REFERENCES "club_posts"("club_post_id")
);

-- Club post comments
CREATE TABLE "club_post_comment" (
    "club_post_comment_id" INTEGER,
    "club_post_id" INTEGER,
    "user_id" INTEGER,
    "time" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, -- "YYYY-MM-DD HH:MM:SS",
    "content" TEXT NOT NULL,
    PRIMARY KEY("club_post_comment_id"),
    FOREIGN KEY("club_post_id") REFERENCES "club_post"("club_post_id"),
    FOREIGN KEY("user_id") REFERENCES "user"("user_id")
);

-- Club group chat
CREATE TABLE "club_group_chat" (
    "club_group_chat_id" INTEGER,
    "club_id" INTEGER,
    "user_id" INTEGER,
    "time" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP, -- "YYYY-MM-DD HH:MM:SS"
    "message" TEXT NOT NULL,
    PRIMARY KEY("club_group_chat_id"),
    FOREIGN KEY("club_id") REFERENCES "clubs"("club_id"),
    FOREIGN KEY("user_id") REFERENCES "user"("user_id")
);


-- Optimizations

-- Index for "user_game_status"
CREATE INDEX "user_game_status_index" 
ON "user_game_status"("game_id", "user_id");
