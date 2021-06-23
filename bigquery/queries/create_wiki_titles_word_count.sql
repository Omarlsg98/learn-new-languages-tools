CREATE OR REPLACE TABLE `datatonbc-heimdall.learn_languages.wiki_title_word_count` AS (
WITH
--Remove special characters from title
--Put all the title in lower case
--Prepare the title to be split by spaces
titles_split AS (
SELECT
    SPLIT(
        LOWER(
            REGEXP_REPLACE(
                title,
                r"[^ \nA-Za-z0-9À-ÖØ-öø-ÿœ']+",
                " "
                )
            )
        ," "
        ) AS words,
        title AS origin_title,
        views AS origin_views
FROM
    `datatonbc-heimdall.learn_languages.wikiviews_20210601`
)
--Make the word count expanding the arrays of splitted titles
--Save at most the 100 most popular usages of the word (titles where the word can be seen)
SELECT
    word,
    COUNT(word) AS num_usages,
    ARRAY_AGG (
        STRUCT(
            ts.origin_title AS title,
            ts.origin_views AS views
        )
        ORDER BY ts.origin_views DESC
        LIMIT 100
    ) AS usages
FROM
    titles_split AS ts,
    UNNEST (ts.words) AS word
WHERE
    word != ''
GROUP BY
    word
ORDER BY
    num_usages DESC
)