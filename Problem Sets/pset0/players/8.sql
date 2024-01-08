SELECT ROUND(AVG("height"), 2) AS 'Average Heigh', ROUND(AVG("weight"), 2) AS 'Average Weight' FROM "players"
WHERE "debut" > '1999-12-31';
