CREATE OR REPLACE TABLE `datatonbc-heimdall.learn_languages.wikiviews_20210601` AS (
--replace underscore with a space
--Deduplicate the titles
SELECT
     REGEXP_REPLACE(
        title,
        r"[_]+",
        " "
        ) AS title,
    SUM(views) AS views
FROM `bigquery-public-data.wikipedia.pageviews_2021`
WHERE
    DATE(datehour) = "2021-06-01"
    AND wiki='fr'
GROUP BY
    title
ORDER BY
    views DESC
)